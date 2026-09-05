// lib/repositories/messages_repository.dart
import '../models/conversation.dart';
import '../services/api_client.dart';

class MessagesRepository {
  final ApiClient _api;

  MessagesRepository(this._api);

  /// The reader's conversations, whichever moved last at the top.
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    bool unreadOnly = false,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (unreadOnly) 'unreadOnly': true,
      },
    );
    return ConversationPage.fromJson(res.data ?? const {});
  }

  /// How many conversations hold something unread. Drives the tab badge.
  Future<int> unreadCount() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/messages/unread');
    return (res.data?['conversations'] as num?)?.toInt() ?? 0;
  }

  /// Opens the conversation with one person, or finds the existing one.
  Future<String> openWith(String userId) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages',
      data: {'userId': userId},
    );
    return res.data?['id'] as String? ?? '';
  }

  /// One thread's messages, newest first.
  Future<MessagePage> messages(
    String conversationId, {
    String? cursor,
    int limit = 40,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages/$conversationId',
      queryParameters: {'limit': limit, if (cursor != null) 'cursor': cursor},
    );
    return MessagePage.fromJson(res.data ?? const {});
  }

  Future<DirectMessage> send(String conversationId, String body) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages/$conversationId',
      data: {'body': body},
    );
    return DirectMessage.fromJson(res.data ?? const {});
  }

  Future<void> markRead(String conversationId) =>
      _api.dio.put<void>('/messages/$conversationId/read');

  /// Takes the thread out of the reader's list, not out of existence.
  Future<void> hide(String conversationId) =>
      _api.dio.delete<void>('/messages/$conversationId');

  Future<void> remove(String messageId) =>
      _api.dio.delete<void>('/messages/items/$messageId');
}
