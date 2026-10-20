import 'key_share.dart';
import 'message_link_card.dart';
import 'post_media.dart';

// lib/models/conversation.dart

/// Somebody in a conversation, as a row needs them.
class MessagePerson {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  /// Somebody on the Kyron team checked it is who it says it is.
  final bool verified;

  /// Online when the page this came on was read: the app open and in front,
  /// where both sides show it. Live changes come over the socket
  /// (presenceProvider), which wins once it has said anything.
  final bool online;

  const MessagePerson({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
    this.verified = false,
    this.online = false,
  });

  factory MessagePerson.fromJson(Map<String, dynamic> json) => MessagePerson(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        verified: json['verified'] == true,
        online: json['online'] == true,
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

/// What somebody may do in a group.
enum MemberRole {
  /// Everything, and the only one who makes or unmakes admins.
  owner,

  /// Adds, removes, renames, and moves people between member and spectator.
  admin,

  /// Writes.
  member,

  /// Reads and reacts, and raises a hand to ask to write.
  spectator;

  static MemberRole fromWire(Object? value) =>
      switch ((value as String?)?.toUpperCase()) {
        'OWNER' => MemberRole.owner,
        'ADMIN' => MemberRole.admin,
        'SPECTATOR' => MemberRole.spectator,
        _ => MemberRole.member,
      };

  String get wire => name.toUpperCase();

  bool get isAdmin => this == owner || this == admin;

  bool get canWrite => this != spectator;
}

/// A group's own details: what the list and the thread draw beside its
/// members. Null on a conversation between two people.
class GroupSummary {
  final String title;

  /// How many people are in it, the reader included.
  final int memberCount;

  /// What the reader may do in it.
  final MemberRole role;

  /// What somebody added to it starts as.
  final MemberRole joinRole;

  /// The reader is a spectator asking to write.
  final bool handRaised;

  /// How many spectators are asking to write. Counted for admins only.
  final int handsRaised;

  const GroupSummary({
    required this.title,
    this.memberCount = 1,
    this.role = MemberRole.member,
    this.joinRole = MemberRole.member,
    this.handRaised = false,
    this.handsRaised = 0,
  });

  static GroupSummary? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    return GroupSummary(
      title: json['title'] as String? ?? 'Group',
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
      role: MemberRole.fromWire(json['role']),
      joinRole: MemberRole.fromWire(json['joinRole']),
      handRaised: json['handRaised'] == true,
      handsRaised: (json['handsRaised'] as num?)?.toInt() ?? 0,
    );
  }

  GroupSummary copyWith({bool? handRaised}) => GroupSummary(
        title: title,
        memberCount: memberCount,
        role: role,
        joinRole: joinRole,
        handRaised: handRaised ?? this.handRaised,
        handsRaised: handsRaised,
      );
}

/// One person in a group, as its member list shows them.
class GroupMember {
  final MessagePerson person;
  final MemberRole role;

  /// A spectator asking to write. Shown to admins, and to themselves.
  final bool handRaised;

  const GroupMember({
    required this.person,
    this.role = MemberRole.member,
    this.handRaised = false,
  });

  String get id => person.id;

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
        person: MessagePerson.fromJson(json),
        role: MemberRole.fromWire(json['role']),
        handRaised: json['handRaised'] == true,
      );
}

/// A photo, clip or voice note that opens once for each person it went to,
/// and is deleted from the server after. See docs/MESSAGING.md.
class ViewOnce {
  final MediaKind kind;

  /// How long a clip or a voice note runs, when that is known.
  final Duration? duration;

  /// A voice note's loudness over time, for its placeholder.
  final List<int> waveform;

  /// The reader has opened it. Never true for whoever sent it.
  final bool opened;

  /// How many of the people it went to have opened it.
  final int openedCount;

  /// How many people it went to.
  final int recipients;

  /// Deleted, or too old to open. Nothing to open.
  final bool gone;

  const ViewOnce({
    required this.kind,
    this.duration,
    this.waveform = const [],
    this.opened = false,
    this.openedCount = 0,
    this.recipients = 1,
    this.gone = false,
  });

  /// From a message that says it is one. Its attachment carries no address,
  /// only what it is.
  static ViewOnce? fromMessage(Map<String, dynamic> json) {
    if (json['viewOnce'] != true) return null;
    final media = json['media'];
    final first = media is List && media.isNotEmpty && media.first is Map
        ? media.first as Map<String, dynamic>
        : const <String, dynamic>{};
    final state = json['once'] is Map<String, dynamic>
        ? json['once'] as Map<String, dynamic>
        : const <String, dynamic>{};
    return ViewOnce(
      kind: PostMedia.kindFromWire(first['kind']),
      duration: first['durationMs'] is num
          ? Duration(milliseconds: (first['durationMs'] as num).toInt())
          : null,
      waveform: (first['waveform'] as List<dynamic>? ?? const [])
          .whereType<num>()
          .map((v) => v.toInt().clamp(0, 100))
          .toList(),
      opened: state['opened'] == true,
      openedCount: (state['openedCount'] as num?)?.toInt() ?? 0,
      recipients: (state['recipients'] as num?)?.toInt() ?? 1,
      gone: state['gone'] == true,
    );
  }

  /// Nobody it went to can still open it.
  bool get spent => gone || (recipients > 0 && openedCount >= recipients);

  ViewOnce copyWith({bool? opened, int? openedCount, bool? gone}) => ViewOnce(
        kind: kind,
        duration: duration,
        waveform: waveform,
        opened: opened ?? this.opened,
        openedCount: openedCount ?? this.openedCount,
        recipients: recipients,
        gone: gone ?? this.gone,
      );
}

/// A view-once attachment, opened: where to fetch it, for a few minutes.
class OpenedOnce {
  final String url;
  final DateTime expiresAt;
  final MediaKind kind;
  final int? width;
  final int? height;
  final Duration? duration;
  final List<int> waveform;

  const OpenedOnce({
    required this.url,
    required this.expiresAt,
    required this.kind,
    this.width,
    this.height,
    this.duration,
    this.waveform = const [],
  });

  factory OpenedOnce.fromJson(Map<String, dynamic> json) => OpenedOnce(
        url: json['url'] as String? ?? '',
        expiresAt:
            DateTime.tryParse(json['expiresAt'] as String? ?? '')?.toLocal() ??
                DateTime.now().add(const Duration(minutes: 2)),
        kind: PostMedia.kindFromWire(json['kind']),
        width: (json['width'] as num?)?.toInt(),
        height: (json['height'] as num?)?.toInt(),
        duration: json['durationMs'] is num
            ? Duration(milliseconds: (json['durationMs'] as num).toInt())
            : null,
        waveform: (json['waveform'] as List<dynamic>? ?? const [])
            .whereType<num>()
            .map((v) => v.toInt().clamp(0, 100))
            .toList(),
      );
}

/// What a line about a group says happened -- "Ada added Ben".
enum GroupEventType { created, renamed, added, removed, left, role, joinRole }

/// A line about the conversation rather than in it. Names are as they were
/// when it happened, so a line still reads after somebody leaves.
class GroupEvent {
  final GroupEventType type;
  final String actorId;
  final String actorName;

  /// Who it happened to, for added, removed and role.
  final List<({String id, String name})> users;

  /// The group's name, for created and renamed.
  final String? title;

  /// The role given, for role and joinRole.
  final MemberRole? role;

  const GroupEvent({
    required this.type,
    required this.actorId,
    required this.actorName,
    this.users = const [],
    this.title,
    this.role,
  });

  static GroupEvent? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    final type =
        GroupEventType.values.where((t) => t.name == json['type']).firstOrNull;
    if (type == null) return null;
    final actor = json['actor'] is Map<String, dynamic>
        ? json['actor'] as Map<String, dynamic>
        : const <String, dynamic>{};
    return GroupEvent(
      type: type,
      actorId: actor['id'] as String? ?? '',
      actorName: _name(actor['name']),
      users: [
        for (final u in (json['users'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          (id: u['id'] as String? ?? '', name: _name(u['name'])),
      ],
      title: json['title'] as String?,
      role: json['role'] == null ? null : MemberRole.fromWire(json['role']),
    );
  }

  static String _name(Object? value) {
    final name = (value as String?)?.trim();
    return name == null || name.isEmpty ? 'Someone' : name;
  }
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

  /// Unreadable, and asked for: a device that can open it will seal its key
  /// for this one when it is next online (MessageVault.requestKeys).
  final bool awaitingKey;

  /// Its key, sealed again for this reader's devices it was not sealed for.
  final List<KeyShare> keyShares;

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

  /// Set when its one attachment opens once. Its [media] is then empty: the
  /// server sends no address for it.
  final ViewOnce? once;

  /// Set when this is a line about the group rather than something said.
  final GroupEvent? event;

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
    this.awaitingKey = false,
    this.keyShares = const [],
    this.replyToId,
    this.reactions = const [],
    this.linkCardRaw,
    this.linkCard,
    this.once,
    this.event,
  });

  bool get viewOnce => once != null;

  /// The emoji [userId] reacted with, or null.
  String? reactionOf(String userId) {
    for (final reaction in reactions) {
      if (reaction.userId == userId) return reaction.emoji;
    }
    return null;
  }

  /// A message with nothing in it is not a message, but a picture is.
  bool get isEmpty =>
      body.trim().isEmpty && media.isEmpty && once == null && event == null;

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
        keyShares: KeyShare.listFrom(json['keyShares']),
        once: ViewOnce.fromMessage(json),
        event: GroupEvent.fromJson(json['event']),
      );

  DirectMessage copyWith({
    String? body,
    bool? sending,
    bool? failed,
    bool? seen,
    bool? encrypted,
    bool? unreadable,
    bool? awaitingKey,
    String? replyToId,
    List<MessageReaction>? reactions,
    MessageLinkCard? linkCard,
    ViewOnce? once,
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
        awaitingKey: awaitingKey ?? this.awaitingKey,
        keyShares: keyShares,
        replyToId: replyToId ?? this.replyToId,
        reactions: reactions ?? this.reactions,
        linkCardRaw: linkCardRaw,
        linkCard: linkCard ?? this.linkCard,
        once: once ?? this.once,
        event: event,
      );
}

/// One conversation, as the list shows it.
class Conversation {
  final String id;

  /// Everyone in it but you: one person, or a group's other members.
  final List<MessagePerson> people;

  /// A group's own details. Null for a conversation between two people.
  final GroupSummary? group;

  final DirectMessage? lastMessage;

  /// Messages from the other side you have not read.
  final int unread;

  final DateTime lastMessageAt;

  const Conversation({
    required this.id,
    this.people = const [],
    this.group,
    this.lastMessage,
    this.unread = 0,
    required this.lastMessageAt,
  });

  bool get isGroup => group != null;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final last = json['lastMessage'];
    return Conversation(
      id: json['id'] as String? ?? '',
      people: (json['people'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MessagePerson.fromJson)
          .toList(),
      group: GroupSummary.fromJson(json['group']),
      lastMessage:
          last is Map<String, dynamic> ? DirectMessage.fromJson(last) : null,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      lastMessageAt: DateTime.tryParse(json['lastMessageAt'] as String? ?? '')
              ?.toLocal() ??
          DateTime.now(),
    );
  }

  /// What to call the thread: a group's name, or the other person's.
  String get title =>
      group?.title ??
      (people.isEmpty
          ? 'Empty conversation'
          : people.map((p) => p.displayName).join(', '));

  /// The other person in a conversation between two. Null in a group, where
  /// there is no one "other" to name, call or block.
  MessagePerson? get other => isGroup || people.isEmpty ? null : people.first;

  Conversation copyWith({DirectMessage? lastMessage, int? unread}) =>
      Conversation(
        id: id,
        people: people,
        group: group,
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

  /// A group's own details. Null for a conversation between two people.
  final GroupSummary? group;

  const MessagePage({
    this.items = const [],
    this.nextCursor,
    this.people = const [],
    this.muted = false,
    this.lastReadAt,
    this.group,
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
        group: GroupSummary.fromJson(json['group']),
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
