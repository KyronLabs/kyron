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

  factory ServiceStatus.fromJson(
    Map<String, dynamic> json,
    Duration latency,
  ) {
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
      state = AsyncData(ServiceStatus.fromJson(
        res.data ?? const {},
        DateTime.now().difference(started),
      ));
    } catch (e, st) {
      state = AsyncError(describeApiError(e), st);
    }
  }
}
