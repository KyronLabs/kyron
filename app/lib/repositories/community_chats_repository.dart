// lib/repositories/community_chats_repository.dart
import '../models/community_chat.dart';
import '../services/api_client.dart';

/// Community chats, over the API.
///
/// Plain text both ways: these are not sealed, and this repository has no
/// access to the message vault. See docs/MESSAGING.md.
class CommunityChatsRepository {
  final ApiClient _api;

  CommunityChatsRepository(this._api);

  /// A community's chats. Members of the community only.
  Future<List<CommunityChat>> list(String slug) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/communities/$slug/chats',
    );
    return _chats(res.data?['items']);
  }

  /// Every chat the reader has joined, across their communities.
  Future<List<CommunityChat>> joined() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/community-chats/joined');
    return _chats(res.data?['items']);
  }

  Future<CommunityChat> create(
    String slug, {
    required String name,
    String? description,
    ChatWriters writers = ChatWriters.members,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/communities/$slug/chats',
      data: {
        'name': name,
        if (description != null && description.trim().isNotEmpty)
          'description': description.trim(),
        'writers': writers.wire,
      },
    );
    return CommunityChat.fromJson(res.data ?? const {});
  }

  Future<CommunityChat> get(String chatId) async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/community-chats/$chatId');
    return CommunityChat.fromJson(res.data ?? const {});
  }

  Future<CommunityChat> update(
    String chatId, {
    String? name,
    String? description,
    bool clearDescription = false,
    ChatWriters? writers,
    int? slowModeSeconds,
  }) async {
    final res = await _api.dio.patch<Map<String, dynamic>>(
      '/community-chats/$chatId',
      data: {
        if (name != null) 'name': name,
        if (clearDescription) 'description': null,
        if (!clearDescription && description != null)
          'description': description,
        if (writers != null) 'writers': writers.wire,
        if (slowModeSeconds != null) 'slowModeSeconds': slowModeSeconds,
      },
    );
    return CommunityChat.fromJson(res.data ?? const {});
  }

  Future<void> close(String chatId) =>
      _api.dio.delete<void>('/community-chats/$chatId');

  Future<CommunityChat> join(String chatId) async {
    final res = await _api.dio
        .put<Map<String, dynamic>>('/community-chats/$chatId/membership');
    return CommunityChat.fromJson(res.data ?? const {});
  }

  Future<void> leave(String chatId) =>
      _api.dio.delete<void>('/community-chats/$chatId/membership');

  Future<void> markRead(String chatId) =>
      _api.dio.put<void>('/community-chats/$chatId/read');

  Future<CommunityChat> pin(String chatId, String? messageId) async {
    final res = messageId == null
        ? await _api.dio
            .delete<Map<String, dynamic>>('/community-chats/$chatId/pin')
        : await _api.dio.put<Map<String, dynamic>>(
            '/community-chats/$chatId/pin',
            data: {'messageId': messageId},
          );
    return CommunityChat.fromJson(res.data ?? const {});
  }

  /// A page of a chat, newest first.
  Future<({List<CommunityChatMessage> items, String? nextCursor})> messages(
    String chatId, {
    String? cursor,
    int limit = 40,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/community-chats/$chatId/messages',
      queryParameters: {'limit': limit, if (cursor != null) 'cursor': cursor},
    );
    return (
      items: [
        for (final m in (res.data?['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          CommunityChatMessage.fromJson(m),
      ],
      nextCursor: res.data?['nextCursor'] as String?,
    );
  }

  Future<CommunityChatMessage> send(
    String chatId,
    String body, {
    String? replyToId,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/community-chats/$chatId/messages',
      data: {'body': body, if (replyToId != null) 'replyToId': replyToId},
    );
    return CommunityChatMessage.fromJson(res.data ?? const {});
  }

  Future<void> delete(String chatId, String messageId) =>
      _api.dio.delete<void>('/community-chats/$chatId/messages/$messageId');

  Future<void> react(String chatId, String messageId, String emoji) =>
      _api.dio.put<void>(
        '/community-chats/$chatId/messages/$messageId/reaction',
        data: {'emoji': emoji},
      );

  Future<void> unreact(String chatId, String messageId) => _api.dio
      .delete<void>('/community-chats/$chatId/messages/$messageId/reaction');

  static List<CommunityChat> _chats(Object? items) => [
        for (final c in (items as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          CommunityChat.fromJson(c),
      ];
}
