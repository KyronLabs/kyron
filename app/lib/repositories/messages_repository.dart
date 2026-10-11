// lib/repositories/messages_repository.dart
import '../models/conversation.dart';
import '../services/api_client.dart';
import '../models/post_media.dart';

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

  Future<DirectMessage> send(
    String conversationId,
    String body, {
    List<PendingMedia> media = const [],
    String? replyToId,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages/$conversationId',
      data: {
        'body': body,
        // The id of what is being answered, and nothing else about it. The
        // server cannot read either message; the quote is drawn from the copy
        // this phone already decrypted.
        if (replyToId != null) 'replyToId': replyToId,
        if (media.isNotEmpty)
          'media':
              media.where((m) => m.isReady).map((m) => m.toJson()).toList(),
      },
    );
    return DirectMessage.fromJson(res.data ?? const {});
  }

  /// Silences a conversation for the reader. Their own setting, not the other
  /// side's -- muting somebody is not something they get to see or undo.
  Future<void> setMuted(String conversationId, bool muted) => muted
      ? _api.dio.put<void>('/messages/$conversationId/mute')
      : _api.dio.delete<void>('/messages/$conversationId/mute');

  /// Blocks the other person and takes the thread out of the reader's list.
  Future<void> blockOther(String conversationId) =>
      _api.dio.put<void>('/messages/$conversationId/block');

  Future<void> markRead(String conversationId) =>
      _api.dio.put<void>('/messages/$conversationId/read');

  /// Takes the thread out of the reader's list, not out of existence.
  Future<void> hide(String conversationId) =>
      _api.dio.delete<void>('/messages/$conversationId');

  Future<void> remove(String messageId) =>
      _api.dio.delete<void>('/messages/items/$messageId');

  /// Reacts to a message, replacing the reader's previous reaction to it.
  Future<void> react(String conversationId, String messageId, String emoji) =>
      _api.dio.put<void>(
        '/messages/$conversationId/items/$messageId/reaction',
        data: {'emoji': emoji},
      );

  Future<void> unreact(String conversationId, String messageId) =>
      _api.dio.delete<void>(
        '/messages/$conversationId/items/$messageId/reaction',
      );

  /// One message's reactions, after the socket said they changed. The event
  /// carries only ids; the emoji are read here, behind the same membership
  /// check as the thread.
  Future<List<MessageReaction>> reactions(
    String conversationId,
    String messageId,
  ) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages/$conversationId/items/$messageId/reactions',
    );
    return MessageReaction.listFrom(res.data?['reactions']);
  }

  /// "I'm writing" -- sent at most every few seconds while the box changes.
  Future<void> typing(String conversationId) =>
      _api.dio.post<void>('/messages/$conversationId/typing');
}
