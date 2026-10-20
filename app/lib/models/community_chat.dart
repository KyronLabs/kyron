// lib/models/community_chat.dart
import 'community.dart' show CommunityRole;

/// Who may write in a community chat. Every member of the community may read
/// it either way.
enum ChatWriters {
  members,

  /// The owner and moderators only: an announcements channel.
  moderators;

  static ChatWriters fromWire(Object? value) =>
      (value as String?)?.toUpperCase() == 'MODERATORS'
          ? ChatWriters.moderators
          : ChatWriters.members;

  String get wire => name.toUpperCase();
}

/// A chat room inside a community.
///
/// Not end-to-end encrypted -- the screen says so -- and on purpose nothing
/// to do with [DirectMessage]: a community chat's text is plain, and never
/// goes near the code that seals direct messages.
class CommunityChat {
  final String id;
  final String communityId;
  final String communitySlug;
  final String communityName;
  final String? communityAvatarUrl;
  final String name;
  final String? description;
  final ChatWriters writers;
  final int slowModeSeconds;
  final int joinedCount;

  /// The reader has joined it: it is in their list, and they may write.
  final bool joined;

  /// The reader may write in it now.
  final bool canWrite;

  /// The reader runs it: the community's owner or a moderator.
  final bool canModerate;

  /// The reader's place in the community.
  final CommunityRole myRole;

  final int unread;
  final DateTime? lastMessageAt;

  /// The one message held at the top, when there is one. Only on a chat read
  /// by itself, not in a list.
  final CommunityChatMessage? pinned;

  /// The newest message, for a row in a list of joined chats.
  final ({String? senderName, String body, bool mine})? lastMessage;

  const CommunityChat({
    required this.id,
    required this.communityId,
    required this.communitySlug,
    required this.communityName,
    required this.name,
    this.communityAvatarUrl,
    this.description,
    this.writers = ChatWriters.members,
    this.slowModeSeconds = 0,
    this.joinedCount = 0,
    this.joined = false,
    this.canWrite = false,
    this.canModerate = false,
    this.myRole = CommunityRole.member,
    this.unread = 0,
    this.lastMessageAt,
    this.pinned,
    this.lastMessage,
  });

  bool get announcements => writers == ChatWriters.moderators;

  factory CommunityChat.fromJson(Map<String, dynamic> json) {
    final community = json['community'] is Map<String, dynamic>
        ? json['community'] as Map<String, dynamic>
        : const <String, dynamic>{};
    final pinned = json['pinned'];
    final last = json['lastMessage'];
    return CommunityChat(
      id: json['id'] as String? ?? '',
      communityId: community['id'] as String? ?? '',
      communitySlug: community['slug'] as String? ?? '',
      communityName: community['name'] as String? ?? '',
      communityAvatarUrl: community['avatarUrl'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      writers: ChatWriters.fromWire(json['writers']),
      slowModeSeconds: (json['slowModeSeconds'] as num?)?.toInt() ?? 0,
      joinedCount: (json['joinedCount'] as num?)?.toInt() ?? 0,
      joined: json['joined'] == true,
      canWrite: json['canWrite'] == true,
      canModerate: json['canModerate'] == true,
      myRole: _role(json['role']) ?? CommunityRole.member,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      lastMessageAt:
          DateTime.tryParse(json['lastMessageAt'] as String? ?? '')?.toLocal(),
      pinned: pinned is Map<String, dynamic>
          ? CommunityChatMessage.fromJson(pinned)
          : null,
      lastMessage: last is Map<String, dynamic>
          ? (
              senderName: last['senderName'] as String?,
              body: last['body'] as String? ?? '',
              mine: last['mine'] == true,
            )
          : null,
    );
  }
}

/// Somebody who wrote in a community chat.
class ChatPerson {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;
  final bool verified;

  /// Their place in the community now; null once they have left it.
  final CommunityRole? role;

  const ChatPerson({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
    this.verified = false,
    this.role,
  });

  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return 'Someone on Kyron';
  }

  factory ChatPerson.fromJson(Map<String, dynamic> json) => ChatPerson(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        verified: json['verified'] == true,
        role: _role(json['role']),
      );
}

/// What a message answers. [unavailable] when that message is gone, or is
/// by somebody the reader cannot see.
class ChatReply {
  final String id;
  final bool unavailable;
  final String? senderName;
  final String body;

  const ChatReply({
    required this.id,
    this.unavailable = false,
    this.senderName,
    this.body = '',
  });

  static ChatReply? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    return ChatReply(
      id: json['id'] as String? ?? '',
      unavailable: json['unavailable'] == true,
      senderName: json['senderName'] as String?,
      body: json['body'] as String? ?? '',
    );
  }
}

/// One message in a community chat.
class CommunityChatMessage {
  final String id;
  final String body;
  final ChatPerson sender;
  final ChatReply? replyTo;

  /// Each emoji and how many reacted with it. Counts, not names: in a room of
  /// strangers, who reacted is not the reader's to list.
  final List<({String emoji, int count})> reactions;

  /// The reader's own reaction.
  final String? mine;

  final DateTime createdAt;

  /// On its way to the server, or refused by it.
  final bool sending;
  final bool failed;

  const CommunityChatMessage({
    required this.id,
    required this.body,
    required this.sender,
    required this.createdAt,
    this.replyTo,
    this.reactions = const [],
    this.mine,
    this.sending = false,
    this.failed = false,
  });

  factory CommunityChatMessage.fromJson(Map<String, dynamic> json) =>
      CommunityChatMessage(
        id: json['id'] as String? ?? '',
        body: json['body'] as String? ?? '',
        sender: ChatPerson.fromJson(
          json['sender'] is Map<String, dynamic>
              ? json['sender'] as Map<String, dynamic>
              : const <String, dynamic>{},
        ),
        replyTo: ChatReply.fromJson(json['replyTo']),
        reactions: [
          for (final r in (json['reactions'] as List<dynamic>? ?? const [])
              .whereType<Map<String, dynamic>>())
            if ((r['emoji'] as String? ?? '').isNotEmpty)
              (
                emoji: r['emoji'] as String,
                count: (r['count'] as num?)?.toInt() ?? 0,
              ),
        ],
        mine: json['mine'] as String?,
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
      );

  /// The reader's reaction changed: [emoji], or none. Counts follow, so the
  /// pill moves before the server has answered.
  CommunityChatMessage withMine(String? emoji) {
    final counts = {for (final r in reactions) r.emoji: r.count};
    final before = mine;
    if (before != null) {
      final left = (counts[before] ?? 1) - 1;
      if (left <= 0) {
        counts.remove(before);
      } else {
        counts[before] = left;
      }
    }
    if (emoji != null) counts[emoji] = (counts[emoji] ?? 0) + 1;
    final next = [
      for (final e in counts.entries) (emoji: e.key, count: e.value),
    ]..sort((a, b) => b.count.compareTo(a.count));
    return CommunityChatMessage(
      id: id,
      body: body,
      sender: sender,
      createdAt: createdAt,
      replyTo: replyTo,
      reactions: next,
      mine: emoji,
      sending: sending,
      failed: failed,
    );
  }

  CommunityChatMessage copyWith({bool? sending, bool? failed}) =>
      CommunityChatMessage(
        id: id,
        body: body,
        sender: sender,
        createdAt: createdAt,
        replyTo: replyTo,
        reactions: reactions,
        mine: mine,
        sending: sending ?? this.sending,
        failed: failed ?? this.failed,
      );
}

CommunityRole? _role(Object? value) =>
    switch ((value as String?)?.toUpperCase()) {
      'OWNER' => CommunityRole.owner,
      'MODERATOR' => CommunityRole.moderator,
      'MEMBER' => CommunityRole.member,
      _ => null,
    };
