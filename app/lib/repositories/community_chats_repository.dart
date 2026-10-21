// lib/repositories/community_chats_repository.dart
import 'package:dio/dio.dart';

import '../models/community_chat.dart';
import '../models/post_media.dart';
import '../services/api_client.dart';

/// Something sent to a chat, uploaded and waiting to go in a message: a
/// reference into the private bucket, never an address.
class ChatUpload {
  final String ref;
  final MediaKind kind;
  final int? width;
  final int? height;
  final Duration? duration;
  final List<int> waveform;

  const ChatUpload({
    required this.ref,
    required this.kind,
    this.width,
    this.height,
    this.duration,
    this.waveform = const [],
  });

  Map<String, dynamic> toJson() => {
        'ref': ref,
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (duration != null) 'durationMs': duration!.inMilliseconds,
        if (waveform.isNotEmpty) 'waveform': waveform,
      };
}

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

  /// Every chat the reader has joined, across their communities, the
  /// liveliest first.
  Future<List<CommunityChat>> joined() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/community-chats/joined');
    return _chats(res.data?['items']);
  }

  /// How many joined, unmuted chats have something new, for the Messages
  /// badge.
  Future<int> unreadChats() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/community-chats/unread');
    return (res.data?['chats'] as num?)?.toInt() ?? 0;
  }

  Future<void> setMuted(String chatId, bool muted) => muted
      ? _api.dio.put<void>('/community-chats/$chatId/mute')
      : _api.dio.delete<void>('/community-chats/$chatId/mute');

  /// Messages in a chat whose words hold [query], newest first.
  Future<List<CommunityChatMessage>> search(String chatId, String query) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/community-chats/$chatId/search',
      queryParameters: {'q': query},
    );
    return _messages(res.data?['items']);
  }

  /// Uploads a photo, clip or voice note for a chat, into the private
  /// bucket. Nothing about it is addressable until a message carries it, and
  /// then only by people who can read that chat.
  Future<ChatUpload> upload(PendingMedia pending) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        pending.path,
        filename: pending.path.split('/').last,
      ),
      if (pending.width != null) 'width': '${pending.width}',
      if (pending.height != null) 'height': '${pending.height}',
    });
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/media/chat',
      data: form,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    final data = res.data ?? const {};
    final ref = data['ref'] as String?;
    if (ref == null) throw StateError('The upload returned no reference.');
    return ChatUpload(
      ref: ref,
      kind: PostMedia.kindFromWire(data['kind']),
      width: (data['width'] as num?)?.toInt() ?? pending.width,
      height: (data['height'] as num?)?.toInt() ?? pending.height,
      // A clip's length is read off the file by the server; a voice note's
      // was measured while it was recorded.
      duration: data['durationMs'] is num
          ? Duration(milliseconds: (data['durationMs'] as num).toInt())
          : pending.duration,
      waveform: pending.waveform,
    );
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
      items: _messages(res.data?['items']),
      nextCursor: res.data?['nextCursor'] as String?,
    );
  }

  /// Says something: [body], with what was uploaded for it, or a poll with
  /// [body] as its question.
  Future<CommunityChatMessage> send(
    String chatId,
    String body, {
    String? replyToId,
    List<ChatUpload> media = const [],
    ({List<String> options, bool multiple})? poll,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/community-chats/$chatId/messages',
      data: {
        'body': body,
        if (replyToId != null) 'replyToId': replyToId,
        if (media.isNotEmpty) 'media': [for (final m in media) m.toJson()],
        if (poll != null)
          'poll': {'options': poll.options, 'multiple': poll.multiple},
      },
    );
    return CommunityChatMessage.fromJson(res.data ?? const {});
  }

  /// Changes the words of the reader's own message.
  Future<CommunityChatMessage> edit(
    String chatId,
    String messageId,
    String body,
  ) async {
    final res = await _api.dio.patch<Map<String, dynamic>>(
      '/community-chats/$chatId/messages/$messageId',
      data: {'body': body},
    );
    return CommunityChatMessage.fromJson(res.data ?? const {});
  }

  /// Answers a poll, in place of any earlier answer.
  Future<CommunityChatMessage> vote(
    String chatId,
    String messageId,
    List<String> optionIds,
  ) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/community-chats/$chatId/messages/$messageId/vote',
      data: {'optionIds': optionIds},
    );
    return CommunityChatMessage.fromJson(res.data ?? const {});
  }

  Future<void> unvote(String chatId, String messageId) => _api.dio
      .delete<void>('/community-chats/$chatId/messages/$messageId/vote');

  Future<void> closePoll(String chatId, String messageId) =>
      _api.dio.put<void>('/community-chats/$chatId/messages/$messageId/closed');

  Future<void> delete(String chatId, String messageId) =>
      _api.dio.delete<void>('/community-chats/$chatId/messages/$messageId');

  Future<void> react(String chatId, String messageId, String emoji) =>
      _api.dio.put<void>(
        '/community-chats/$chatId/messages/$messageId/reaction',
        data: {'emoji': emoji},
      );

  Future<void> unreact(String chatId, String messageId) => _api.dio
      .delete<void>('/community-chats/$chatId/messages/$messageId/reaction');

  static List<CommunityChatMessage> _messages(Object? items) => [
        for (final m in (items as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          CommunityChatMessage.fromJson(m),
      ];

  static List<CommunityChat> _chats(Object? items) => [
        for (final c in (items as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          CommunityChat.fromJson(c),
      ];
}
