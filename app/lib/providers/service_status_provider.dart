import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

/// What GET /health reports about the running API.
///
/// Read verbatim rather than summarised: the point of a status screen is to
/// show what the server actually said, including the parts that are wrong.
class ServiceStatus {
  final String status;
  final String database;
  final String? databaseDetail;
  final String mirrorTables;
  final Map<String, dynamic> auth;

  /// How long the request took. A slow answer is itself the news on a service
  /// that sleeps when idle.
  final Duration latency;

  const ServiceStatus({
    required this.status,
    required this.database,
    this.databaseDetail,
    required this.mirrorTables,
    required this.auth,
    required this.latency,
  });

  /// The API reports its database as `reachable` or `unreachable`, and its own
  /// status as `ok` or `degraded`. Comparing against "connected" -- a word the
  /// endpoint has never used -- made every healthy deployment show the red
  /// "something is not right" banner over four rows that all read fine.
  bool get isHealthy =>
      status == 'ok' && database == 'reachable' && mirrorTables == 'present';

  /// What is wrong, when something is. Null when everything checks out.
  String? get problem {
    if (database != 'reachable') {
      return databaseDetail ?? 'Kyron cannot reach its database.';
    }
    if (mirrorTables == 'missing') {
      return 'The database is missing tables this version needs.';
    }
    if (mirrorTables == 'unknown') {
      return 'Kyron could not check its database tables.';
    }
    if (status != 'ok') return 'Kyron reported itself as "$status".';
    return null;
  }

  factory ServiceStatus.fromJson(Map<String, dynamic> json, Duration latency) {
    return ServiceStatus(
      status: json['status'] as String? ?? 'unknown',
      database: json['database'] as String? ?? 'unknown',
      databaseDetail: json['databaseDetail'] as String?,
      mirrorTables: json['mirrorTables'] as String? ?? 'unknown',
      auth: (json['auth'] as Map<String, dynamic>?) ?? const {},
      latency: latency,
    );
  }
}

final serviceStatusProvider =
    StateNotifierProvider<ServiceStatusNotifier, AsyncValue<ServiceStatus>>(
  (ref) => ServiceStatusNotifier(ref),
);

class ServiceStatusNotifier extends StateNotifier<AsyncValue<ServiceStatus>> {
  final Ref _ref;

  ServiceStatusNotifier(this._ref) : super(const AsyncLoading()) {
    check();
  }

  Future<void> check() async {
    state = const AsyncLoading();
    final started = DateTime.now();
    try {
      final res =
          await _ref.read(apiClientProvider).dio.get<Map<String, dynamic>>(
                '/health',
                // The status screen is the one place a slow answer is the point,
                // so it reports rather than waits out a full cold start.
                options: Options(receiveTimeout: const Duration(seconds: 30)),
              );
      state = AsyncData(
        ServiceStatus.fromJson(
          res.data ?? const {},
          DateTime.now().difference(started),
        ),
      );
    } catch (e, st) {
      state = AsyncError(describeApiError(e), st);
    }
  }
}

/// One component's checks on one day.
class StatusDay {
  final int checks;
  final int failures;

  const StatusDay({required this.checks, required this.failures});

  /// The share of checks that failed, 0 to 1.
  double get failureRate => checks == 0 ? 0 : failures / checks;
}

/// One component's history: its uptime over the window, and its days.
class StatusComponent {
  /// `api`, `database` or `auth` -- named on screen by the app, in the
  /// reader's language.
  final String id;

  /// Percent of checks passed over the window; null when there were none.
  final double? uptime;

  /// Keyed by UTC calendar day, `YYYY-MM-DD`. A day not here had no checks.
  final Map<String, StatusDay> days;

  const StatusComponent({
    required this.id,
    required this.uptime,
    required this.days,
  });

  factory StatusComponent.fromJson(Map<String, dynamic> json) =>
      StatusComponent(
        id: json['id'] as String? ?? '',
        uptime: (json['uptime'] as num?)?.toDouble(),
        days: {
          for (final day in (json['days'] as List<dynamic>? ?? const [])
              .whereType<Map<String, dynamic>>())
            day['day'] as String? ?? '': StatusDay(
              checks: (day['checks'] as num?)?.toInt() ?? 0,
              failures: (day['failures'] as num?)?.toInt() ?? 0,
            ),
        },
      );
}

/// A stretch of time one component was failing its checks.
class StatusIncident {
  final String component;
  final DateTime startedAt;

  /// Null while it is still going on.
  final DateTime? endedAt;
  final String? detail;

  const StatusIncident({
    required this.component,
    required this.startedAt,
    this.endedAt,
    this.detail,
  });

  bool get ongoing => endedAt == null;

  factory StatusIncident.fromJson(Map<String, dynamic> json) => StatusIncident(
        component: json['component'] as String? ?? '',
        startedAt:
            DateTime.tryParse(json['startedAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        endedAt: DateTime.tryParse(json['endedAt'] as String? ?? '')?.toLocal(),
        detail: json['detail'] as String?,
      );
}

/// What GET /health/history says: how each part of the service has done
/// over the last [days] days, and what went wrong in them.
class ServiceHistory {
  final int days;

  /// How often the service checks itself.
  final int intervalMinutes;
  final List<StatusComponent> components;
  final List<StatusIncident> incidents;

  const ServiceHistory({
    required this.days,
    required this.intervalMinutes,
    required this.components,
    required this.incidents,
  });

  factory ServiceHistory.fromJson(Map<String, dynamic> json) => ServiceHistory(
        days: (json['days'] as num?)?.toInt() ?? 60,
        intervalMinutes: (json['intervalMinutes'] as num?)?.toInt() ?? 5,
        components: (json['components'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(StatusComponent.fromJson)
            .toList(),
        incidents: (json['incidents'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(StatusIncident.fromJson)
            .toList(),
      );
}

/// The last sixty days. Read again whenever the status screen is.
///
/// Null when the server has no history to give -- one deployed before the
/// endpoint existed answers 404 -- which the screen says plainly rather than
/// drawing sixty grey bars as if they meant something.
final serviceHistoryProvider =
    FutureProvider.autoDispose<ServiceHistory?>((ref) async {
  try {
    final res = await ref
        .read(apiClientProvider)
        .dio
        .get<Map<String, dynamic>>('/health/history', queryParameters: {
      'days': 60,
    });
    final data = res.data;
    return data == null ? null : ServiceHistory.fromJson(data);
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) return null;
    rethrow;
  }
});
