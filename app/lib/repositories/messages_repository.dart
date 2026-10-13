// lib/repositories/messages_repository.dart
import '../models/conversation.dart';
import '../services/api_client.dart';
import '../models/chat_wallpaper.dart';
import '../models/post_media.dart';

/// Which conversations a list shows.
enum ConversationFilter {
  all,

  /// Holding something the reader has not read.
  unread,

  /// Ending on the other person's word: waiting on a reply.
  unanswered,

  /// Removed from the list by the reader, to be put back or left.
  hidden,
}

class MessagesRepository {
  final ApiClient _api;

  MessagesRepository(this._api);

  /// The reader's conversations, whichever moved last at the top.
  Future<ConversationPage> conversations({
    String? cursor,
    int limit = 30,
    ConversationFilter filter = ConversationFilter.all,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
        if (filter != ConversationFilter.all) 'filter': filter.name,
        // What a server from before filters understood as the Unread tab.
        if (filter == ConversationFilter.unread) 'unreadOnly': true,
      },
    );
    return ConversationPage.fromJson(res.data ?? const {});
  }

  /// Puts a conversation the reader removed back in their list.
  Future<void> restore(String conversationId) =>
      _api.dio.put<void>('/messages/$conversationId/restore');

  /// Whether the reader shares read receipts.
  Future<bool> readReceipts() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/messages/settings');
    return res.data?['readReceipts'] != false;
  }

  Future<bool> setReadReceipts(bool on) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/messages/settings',
      data: {'readReceipts': on},
    );
    return res.data?['readReceipts'] != false;
  }

  /// Whether the reader shows the people they talk to when they are online.
  Future<bool> showOnline() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/messages/settings');
    return res.data?['showOnline'] != false;
  }

  Future<bool> setShowOnline(bool on) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/messages/settings',
      data: {'showOnline': on},
    );
    return res.data?['showOnline'] != false;
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
    String? linkCard,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages/$conversationId',
      data: {
        'body': body,
        // Sealed with the words when they are; see MessageLinkCard.
        if (linkCard != null) 'linkCard': linkCard,
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

  /// Every attachment in a conversation, newest first, for its info page.
  Future<SharedMediaPage> sharedMedia(
    String conversationId, {
    String? cursor,
    int limit = 30,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages/$conversationId/media',
      queryParameters: {'limit': limit, if (cursor != null) 'cursor': cursor},
    );
    return SharedMediaPage.fromJson(res.data ?? const {});
  }

  /// The images in the wallpapers folder, for a chat's wallpaper picker.
  Future<List<RemoteWallpaper>> wallpapers() async {
    final res = await _api.dio.get<List<dynamic>>('/messages/wallpapers');
    return (res.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(RemoteWallpaper.fromJson)
        .where((w) => w.url.isNotEmpty)
        .toList();
  }
}

/// One attachment from a conversation, with where and when it was sent.
class SharedMedia {
  final PostMedia media;
  final String messageId;
  final String? senderId;
  final DateTime createdAt;

  const SharedMedia({
    required this.media,
    required this.messageId,
    required this.createdAt,
    this.senderId,
  });

  factory SharedMedia.fromJson(Map<String, dynamic> json) => SharedMedia(
        media: PostMedia.fromJson(json),
        messageId: json['messageId'] as String? ?? '',
        senderId: json['senderId'] as String?,
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
      );
}

class SharedMediaPage {
  final List<SharedMedia> items;
  final String? nextCursor;

  const SharedMediaPage({required this.items, this.nextCursor});

  factory SharedMediaPage.fromJson(Map<String, dynamic> json) =>
      SharedMediaPage(
        items: ((json['items'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(SharedMedia.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
