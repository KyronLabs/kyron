// lib/providers/notifications_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/notification_model.dart';
import '../repositories/notifications_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.read(apiClientProvider)),
);

/// One tab's worth of notifications.
class NotificationListState {
  final List<NotificationModel> items;
  final String? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  const NotificationListState({
    this.items = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  bool get isEmpty => !loadingFirstPage && error == null && items.isEmpty;

  NotificationListState copyWith({
    List<NotificationModel>? items,
    String? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
  }) =>
      NotificationListState(
        items: items ?? this.items,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

class NotificationListNotifier extends StateNotifier<NotificationListState> {
  final NotificationsRepository _repo;

  /// Which tab this is. Null is All. Narrowed by the server rather than here,
  /// so a tab cannot look empty while there is more behind the cursor.
  final NotificationType? kind;

  NotificationListNotifier(this._repo, {required this.kind})
      : super(const NotificationListState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const NotificationListState();
    try {
      final page = await _repo.list(kind: kind);
      state = NotificationListState(
        items: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = NotificationListState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.cursor;
    if (cursor == null || state.loadingMore || state.loadingFirstPage) return;

    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.list(cursor: cursor, kind: kind);
      // The cursor is a timestamp, so a row already held could in principle
      // come back on the next page. Keyed by id rather than appended blindly.
      final seen = {for (final row in state.items) row.id};
      state = state.copyWith(
        items: [
          ...state.items,
          ...page.items.where((row) => !seen.contains(row.id)),
        ],
        cursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
        loadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        loadingMore: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }
}

/// One per tab, so switching back to a tab does not reload it.
final notificationListProvider = StateNotifierProvider.family<
    NotificationListNotifier, NotificationListState, NotificationType?>(
  (ref, kind) => NotificationListNotifier(
    ref.read(notificationsRepositoryProvider),
    kind: kind,
  ),
);

/// How many have arrived since the screen was last opened.
final unreadNotificationsProvider = FutureProvider<int>(
  (ref) => ref.read(notificationsRepositoryProvider).unreadCount(),
);
