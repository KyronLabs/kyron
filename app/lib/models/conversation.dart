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
  });

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
      );

  DirectMessage copyWith({
    String? body,
    bool? sending,
    bool? failed,
    bool? seen,
    bool? encrypted,
    bool? unreadable,
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
      lastMessageAt: DateTime.tryParse(
            json['lastMessageAt'] as String? ?? '',
          )?.toLocal() ??
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

  const MessagePage({
    this.items = const [],
    this.nextCursor,
    this.people = const [],
    this.muted = false,
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
