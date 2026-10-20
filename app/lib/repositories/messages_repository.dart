// lib/repositories/messages_repository.dart
import 'package:dio/dio.dart';

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
    OnceUpload? once,
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
        // A reference to a private upload, never an address: the server
        // turns it into a link for each person it went to, once.
        if (once != null) 'once': once.toJson(),
      },
    );
    return DirectMessage.fromJson(res.data ?? const {});
  }

  /// Uploads a photo, clip or voice note to be sent view once.
  ///
  /// Not [FeedRepository.uploadMedia]: that puts the file in the public
  /// bucket, at an address anybody holding it can open for good. This goes
  /// to a private one and answers with a reference only the API can turn
  /// into a link. See docs/MESSAGING.md.
  Future<OnceUpload> uploadOnce(PendingMedia pending) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        pending.path,
        filename: pending.path.split('/').last,
      ),
      if (pending.width != null) 'width': '${pending.width}',
      if (pending.height != null) 'height': '${pending.height}',
    });
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/media/once',
      data: form,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    final data = res.data ?? const {};
    final ref = data['ref'] as String?;
    if (ref == null) throw StateError('The upload returned no reference.');
    return OnceUpload(
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

  /// Opens a view-once message, once. The server records it and answers a
  /// link that stops working in minutes; asking again is refused.
  Future<OpenedOnce> openOnce(String conversationId, String messageId) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages/$conversationId/items/$messageId/open',
    );
    return OpenedOnce.fromJson(res.data ?? const {});
  }

  /// Starts a group with [userIds] and the reader as its owner, and answers
  /// its id.
  Future<String> createGroup(
    String title,
    List<String> userIds, {
    MemberRole joinRole = MemberRole.member,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/messages/groups',
      data: {'title': title, 'userIds': userIds, 'joinRole': joinRole.wire},
    );
    return res.data?['id'] as String? ?? '';
  }

  /// Renames a group, or changes what people added to it start as.
  Future<void> updateGroup(
    String conversationId, {
    String? title,
    MemberRole? joinRole,
  }) =>
      _api.dio.patch<void>(
        '/messages/$conversationId/group',
        data: {
          if (title != null) 'title': title,
          if (joinRole != null) 'joinRole': joinRole.wire,
        },
      );

  /// Everybody in a group, owner first.
  Future<List<GroupMember>> members(String conversationId) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/messages/$conversationId/members',
    );
    return (res.data?['items'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(GroupMember.fromJson)
        .toList();
  }

  Future<void> addMembers(String conversationId, List<String> userIds) =>
      _api.dio.post<void>(
        '/messages/$conversationId/members',
        data: {'userIds': userIds},
      );

  /// Takes somebody out of a group. The reader's own id leaves it.
  Future<void> removeMember(String conversationId, String userId) =>
      _api.dio.delete<void>('/messages/$conversationId/members/$userId');

  Future<void> setRole(String conversationId, String userId, MemberRole role) =>
      _api.dio.put<void>(
        '/messages/$conversationId/members/$userId/role',
        data: {'role': role.wire},
      );

  /// A spectator asks to write, or stops asking.
  Future<void> setHandRaised(String conversationId, bool raised) => raised
      ? _api.dio.put<void>('/messages/$conversationId/hand')
      : _api.dio.delete<void>('/messages/$conversationId/hand');

  /// An admin says no to somebody's raised hand.
  Future<void> dismissHand(String conversationId, String userId) =>
      _api.dio.delete<void>('/messages/$conversationId/members/$userId/hand');

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

/// A view-once attachment, uploaded and not yet sent.
class OnceUpload {
  final String ref;
  final MediaKind kind;
  final int? width;
  final int? height;
  final Duration? duration;
  final List<int> waveform;

  const OnceUpload({
    required this.ref,
    required this.kind,
    this.width,
    this.height,
    this.duration,
    this.waveform = const [],
  });

  Map<String, dynamic> toJson() => {
        'ref': ref,
        'kind': kind.name.toUpperCase(),
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (duration != null && duration!.inMilliseconds > 0)
          'durationMs': duration!.inMilliseconds,
        if (waveform.isNotEmpty) 'waveform': waveform,
      };
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
