import 'message_link_card.dart';
import 'post_media.dart';

// lib/models/conversation.dart

/// Somebody in a conversation, as a row needs them.
class MessagePerson {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  const MessagePerson({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
  });

  factory MessagePerson.fromJson(Map<String, dynamic> json) => MessagePerson(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );

  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return 'Someone on Kyron';
  }

  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }
}

/// One message in a thread.
/// One person's reaction to a message: a single emoji.
///
/// Stored readable on the server, unlike the message itself -- a decided
/// trade, written down in docs/E2EE.md.
class MessageReaction {
  final String userId;
  final String emoji;

  const MessageReaction({required this.userId, required this.emoji});

  factory MessageReaction.fromJson(Map<String, dynamic> json) =>
      MessageReaction(
        userId: json['userId'] as String? ?? '',
        emoji: json['emoji'] as String? ?? '',
      );

  /// Whatever the server sent, skipping anything malformed rather than
  /// failing the whole thread over one bad reaction.
  static List<MessageReaction> listFrom(Object? json) => [
        if (json is List)
          for (final item in json.whereType<Map<String, dynamic>>())
            if ((item['emoji'] as String? ?? '').isNotEmpty)
              MessageReaction.fromJson(item),
      ];

  @override
  bool operator ==(Object other) =>
      other is MessageReaction &&
      other.userId == userId &&
      other.emoji == emoji;

  @override
  int get hashCode => Object.hash(userId, emoji);
}

class DirectMessage {
  final String id;
  final String body;
  final String senderId;
  final DateTime createdAt;

  /// Whether the other side has read past it. Only meaningful on your own.
  final bool seen;

  /// True while this is still on its way to the server.
  ///
  /// A message you have just sent is on screen before it exists anywhere else;
  /// without this the thread would sit still until the round trip came back,
  /// which is the one moment a chat has to feel immediate.
  final bool sending;

  /// Set when sending failed, so the bubble can offer to try again rather than
  /// quietly vanishing.
  final bool failed;

  /// Attachments, in the order they were picked.
  final List<PostMedia> media;

  /// Whether this arrived sealed, so the bubble can say the server could not
  /// read it. Never inferred from the text: a plain message that happens to
  /// look like ciphertext is still a plain message.
  final bool encrypted;

  /// Sealed, but not for any key this install holds -- a message written to
  /// another of your devices, or to a key you have since replaced. The body
  /// carries an explanation rather than the ciphertext.
  final bool unreadable;

  /// The message this one answers, if it answers one.
  ///
  /// An id, never a copy of the words. A direct message is sealed before it
  /// leaves the phone and the server stores ciphertext it cannot read -- so a
  /// reply that carried the quoted text would have written that text into the
  /// database in the clear. This screen already holds the thread decrypted, so
  /// it resolves the quote itself; see `ThreadState.answered`.
  final String? replyToId;

  /// Who reacted, and with what. One each at most.
  final List<MessageReaction> reactions;

  /// The link card as it arrived: sealed, like the body, until it is opened.
  final String? linkCardRaw;

  /// The card for the link in it, once opened and checked. Null when there
  /// is none, or it did not survive the checks in [MessageLinkCard.tryDecode].
  final MessageLinkCard? linkCard;

  const DirectMessage({
    required this.id,
    required this.body,
    required this.senderId,
    required this.createdAt,
    this.seen = false,
    this.sending = false,
    this.failed = false,
    this.media = const [],
    this.encrypted = false,
    this.unreadable = false,
    this.replyToId,
    this.reactions = const [],
    this.linkCardRaw,
    this.linkCard,
  });

  /// The emoji [userId] reacted with, or null.
  String? reactionOf(String userId) {
    for (final reaction in reactions) {
      if (reaction.userId == userId) return reaction.emoji;
    }
    return null;
  }

  /// A message with nothing in it is not a message, but a picture is.
  bool get isEmpty => body.trim().isEmpty && media.isEmpty;

  factory DirectMessage.fromJson(Map<String, dynamic> json) => DirectMessage(
        id: json['id'] as String? ?? '',
        body: json['body'] as String? ?? '',
        senderId: json['senderId'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        seen: json['seen'] == true,
        media: PostMedia.listFrom(json['media']),
        replyToId: json['replyToId'] as String?,
        reactions: MessageReaction.listFrom(json['reactions']),
        linkCardRaw: json['linkCard'] as String?,
      );

  DirectMessage copyWith({
    String? body,
    bool? sending,
    bool? failed,
    bool? seen,
    bool? encrypted,
    bool? unreadable,
    String? replyToId,
    List<MessageReaction>? reactions,
    MessageLinkCard? linkCard,
  }) =>
      DirectMessage(
        id: id,
        body: body ?? this.body,
        senderId: senderId,
        createdAt: createdAt,
        seen: seen ?? this.seen,
        sending: sending ?? this.sending,
        failed: failed ?? this.failed,
        media: media,
        encrypted: encrypted ?? this.encrypted,
        unreadable: unreadable ?? this.unreadable,
        replyToId: replyToId ?? this.replyToId,
        reactions: reactions ?? this.reactions,
        linkCardRaw: linkCardRaw,
        linkCard: linkCard ?? this.linkCard,
      );
}

/// One conversation, as the list shows it.
class Conversation {
  final String id;

  /// Everyone in it but you. One person today; a list so a group later does
  /// not change the shape every screen already renders.
  final List<MessagePerson> people;

  final DirectMessage? lastMessage;

  /// Messages from the other side you have not read.
  final int unread;

  final DateTime lastMessageAt;

  const Conversation({
    required this.id,
    this.people = const [],
    this.lastMessage,
    this.unread = 0,
    required this.lastMessageAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final last = json['lastMessage'];
    return Conversation(
      id: json['id'] as String? ?? '',
      people: (json['people'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MessagePerson.fromJson)
          .toList(),
      lastMessage:
          last is Map<String, dynamic> ? DirectMessage.fromJson(last) : null,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      lastMessageAt: DateTime.tryParse(json['lastMessageAt'] as String? ?? '')
              ?.toLocal() ??
          DateTime.now(),
    );
  }

  /// What to call the thread. A group would join the names; one person is
  /// their name.
  String get title => people.isEmpty
      ? 'Empty conversation'
      : people.map((p) => p.displayName).join(', ');

  MessagePerson? get other => people.isEmpty ? null : people.first;

  Conversation copyWith({DirectMessage? lastMessage, int? unread}) =>
      Conversation(
        id: id,
        people: people,
        lastMessage: lastMessage ?? this.lastMessage,
        unread: unread ?? this.unread,
        lastMessageAt: lastMessage?.createdAt ?? lastMessageAt,
      );
}

/// One page of a thread, with who is in it.
class MessagePage {
  final List<DirectMessage> items;
  final String? nextCursor;
  final List<MessagePerson> people;

  /// Whether the reader has silenced this conversation. Read from the server
  /// rather than guessed, so the menu offers Mute or Unmute and not both.
  final bool muted;

  /// How far the reader had read before opening this, or null for a thread
  /// they have never opened. What "New messages" is drawn above.
  final DateTime? lastReadAt;

  const MessagePage({
    this.items = const [],
    this.nextCursor,
    this.people = const [],
    this.muted = false,
    this.lastReadAt,
  });

  factory MessagePage.fromJson(Map<String, dynamic> json) => MessagePage(
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(DirectMessage.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
        people: (json['people'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(MessagePerson.fromJson)
            .toList(),
        muted: json['muted'] as bool? ?? false,
        lastReadAt: DateTime.tryParse(
          json['lastReadAt'] as String? ?? '',
        )?.toLocal(),
      );
}

/// One page of conversations.
class ConversationPage {
  final List<Conversation> items;
  final String? nextCursor;

  const ConversationPage({this.items = const [], this.nextCursor});

  factory ConversationPage.fromJson(Map<String, dynamic> json) =>
      ConversationPage(
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(Conversation.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
