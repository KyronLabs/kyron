// lib/repositories/notifications_repository.dart
import '../models/notification_model.dart';
import '../services/api_client.dart';

class NotificationsRepository {
  final ApiClient _api;

  NotificationsRepository(this._api);

  /// What other people did, newest first.
  Future<NotificationPage> list({
    String? cursor,
    int limit = 30,
    NotificationType? kind,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/notifications',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (kind != null) 'kind': kind.name,
      },
    );
    return NotificationPage.fromJson(res.data ?? const {});
  }

  /// How many have arrived since the screen was last opened.
  Future<int> unreadCount() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/notifications/unread');
    return (res.data?['count'] as num?)?.toInt() ?? 0;
  }

  /// Opening the screen clears the badge.
  Future<void> markSeen() => _api.dio.put<Map<String, dynamic>>(
        '/notifications/seen',
      );
}
