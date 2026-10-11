// lib/providers/messages_provider.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/conversation.dart';
import '../models/post_media.dart';
import '../repositories/messages_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';
import '../services/message_crypto.dart';
import '../services/message_vault.dart';
import 'keys_provider.dart';

final messagesRepositoryProvider = Provider<MessagesRepository>(
  (ref) => MessagesRepository(ref.read(apiClientProvider)),
);

/// The reader's conversations, one tab's worth.
class ConversationListState {
  final List<Conversation> items;
  final String? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  const ConversationListState({
    this.items = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  bool get isEmpty => !loadingFirstPage && error == null && items.isEmpty;

  ConversationListState copyWith({
    List<Conversation>? items,
    String? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
  }) =>
      ConversationListState(
        items: items ?? this.items,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

class ConversationListNotifier extends StateNotifier<ConversationListState> {
  final MessagesRepository _repo;

  /// Whether this list is the Unread tab. Narrowed by the server rather than
  /// here: filtering a page after it arrives gives short pages and a tab that
  /// looks empty while there is more behind the cursor.
  final bool unreadOnly;

  ConversationListNotifier(this._repo, {required this.unreadOnly})
      : super(const ConversationListState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const ConversationListState();
    try {
      final page = await _repo.conversations(unreadOnly: unreadOnly);
      state = ConversationListState(
        items: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = ConversationListState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.cursor;
    if (cursor == null || state.loadingMore || state.loadingFirstPage) return;

    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.conversations(
        cursor: cursor,
        unreadOnly: unreadOnly,
      );
      state = state.copyWith(
        items: [...state.items, ...page.items],
        cursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
        loadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        loadingMore: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Drops a conversation the reader has removed from their list.
  ///
  /// Optimistic and not put back on failure: the request is a soft hide, the
  /// list is refreshed whenever the tab is opened, and a row springing back a
  /// second after it was swiped away is worse than one that reappears later.
  Future<String?> hide(Conversation conversation) async {
    state = state.copyWith(
      items: [
        for (final row in state.items)
          if (row.id != conversation.id) row,
      ],
    );
    try {
      await _repo.hide(conversation.id);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Clears the unread badge on one row, after it has been opened.
  void markRead(String conversationId) {
    state = state.copyWith(
      items: [
        for (final row in state.items)
          row.id == conversationId ? row.copyWith(unread: 0) : row,
      ],
    );
  }
}

/// One per tab, so All and Unread each keep their own page and cursor.
final conversationListProvider = StateNotifierProvider.family<
    ConversationListNotifier, ConversationListState, bool>((ref, unreadOnly) {
  return ConversationListNotifier(
    ref.read(messagesRepositoryProvider),
    unreadOnly: unreadOnly,
  );
});

/// Reloads both tabs, and the badge with them.
///
/// The two lists are separate notifiers that each load once, when their tab is
/// first looked at. That is what made a conversation appear under Unread and
/// not under All: Unread was fetched a minute later than All and had seen the
/// message that arrived in between. Nothing that changes what either list
/// should hold may refresh only the tab it happened on.
Future<void> refreshConversations(WidgetRef ref) async {
  await Future.wait([
    ref.read(conversationListProvider(false).notifier).refresh(),
    ref.read(conversationListProvider(true).notifier).refresh(),
  ]);
  ref.invalidate(unreadConversationsProvider);
}

/// How many conversations hold something unread. Drives the tab's badge.
final unreadConversationsProvider = FutureProvider<int>((ref) async {
  return ref.read(messagesRepositoryProvider).unreadCount();
});

/// One thread.
class ThreadState {
  /// Oldest last: a chat is drawn from the bottom up, so this is the order the
  /// reversed list wants and no screen has to reverse it again.
  final List<DirectMessage> messages;
  final List<MessagePerson> people;
  final String? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  /// Whether the reader has silenced this conversation.
  final bool muted;

  /// How far the reader had read when the thread was opened.
  ///
  /// Captured once, from the first page, and never moved while the screen is
  /// open: opening a thread marks it read, and a divider that chased the read
  /// mark would vanish the moment it appeared.
  final DateTime? readUpTo;

  /// Who is writing right now, if anyone. Lapses on its own -- see
  /// [ThreadNotifier.otherTyping].
  final String? typing;

  const ThreadState({
    this.messages = const [],
    this.people = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
    this.muted = false,
    this.readUpTo,
    this.typing,
  });

  /// The first message the reader had not seen when they opened the thread,
  /// which is where "New messages" goes; null when there is nowhere useful to
  /// put it.
  ///
  /// Only somebody else's messages count -- your own were never unread. And
  /// never the very first message loaded: a divider above everything says
  /// nothing that the thread being new does not already say.
  String? firstUnreadFor(String me) {
    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      if (message.senderId == me) continue;
      final unread = readUpTo == null || message.createdAt.isAfter(readUpTo!);
      if (!unread) continue;
      return i == 0 ? null : message.id;
    }
    return null;
  }

  bool get isEmpty => !loadingFirstPage && error == null && messages.isEmpty;

  /// The message [message] answers, or null.
  ///
  /// Resolved here rather than sent by the server, and that is the whole
  /// design: a direct message is sealed before it leaves the phone, so the
  /// server holds ciphertext and could not quote it even if it wanted to.
  /// This list is already decrypted.
  ///
  /// Null also covers a message older than the pages loaded so far. A quote
  /// this cannot resolve is drawn as a quiet placeholder rather than left
  /// blank, because a reply to nothing reads as a bug.
  DirectMessage? answered(DirectMessage message) {
    final id = message.replyToId;
    if (id == null) return null;
    for (final other in messages) {
      if (other.id == id) return other;
    }
    return null;
  }

  ThreadState copyWith({
    List<DirectMessage>? messages,
    List<MessagePerson>? people,
    String? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
    bool? muted,
    String? typing,
    bool clearTyping = false,
  }) =>
      ThreadState(
        messages: messages ?? this.messages,
        people: people ?? this.people,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
        muted: muted ?? this.muted,
        readUpTo: readUpTo,
        typing: clearTyping ? null : (typing ?? this.typing),
      );
}

class ThreadNotifier extends StateNotifier<ThreadState> {
  final MessagesRepository _repo;
  final MessageVault _vault;
  final String _conversationId;

  /// Counts up so two messages sent in the same millisecond cannot share a
  /// placeholder id.
  int _pending = 0;

  ThreadNotifier(this._repo, this._vault, this._conversationId)
      : super(const ThreadState()) {
    refresh();
  }

  /// Opens whatever in a page was sealed.
  ///
  /// Everything written before this existed, and everything from somebody
  /// whose app has no key yet, is plain and passes through unchanged. A
  /// message that is sealed and cannot be opened says so rather than showing
  /// its ciphertext, which is unreadable either way but frightening on top.
  Future<List<DirectMessage>> _open(List<DirectMessage> messages) async {
    final opened = <DirectMessage>[];
    for (final message in messages) {
      if (!SealedEnvelope.looksSealed(message.body)) {
        opened.add(message);
        continue;
      }
      final plain = await _vault.open(message.body, _conversationId);
      opened.add(
        message.copyWith(
          body: plain ?? 'This message cannot be read on this device.',
          encrypted: true,
          unreadable: plain == null,
        ),
      );
    }
    return opened;
  }

  Future<void> refresh() async {
    state = const ThreadState();
    try {
      final page = await _repo.messages(_conversationId);
      state = ThreadState(
        // The server answers newest first, because that is what a cursor over
        // "most recent" has to do. The screen reads oldest first.
        messages: await _open(page.items.reversed.toList()),
        people: page.people,
        cursor: page.nextCursor,
        loadingFirstPage: false,
        muted: page.muted,
        readUpTo: page.lastReadAt,
      );
      await _markRead();
    } catch (error) {
      state = ThreadState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Picks up whatever arrived while the screen was open.
  ///
  /// Not [refresh]: that empties the list and shows a spinner, which on a
  /// thread somebody is reading is a screen that blinks every time the other
  /// person types. This asks for the newest page and appends only what is not
  /// already held, so the view does not move and nothing is duplicated.
  Future<void> pullNewest() async {
    if (state.loadingFirstPage) return;
    try {
      final page = await _repo.messages(_conversationId);
      final known = {for (final m in state.messages) m.id};
      final fresh = await _open([
        for (final message in page.items.reversed)
          if (!known.contains(message.id)) message,
      ]);
      if (fresh.isEmpty) return;

      // Whoever was typing has sent it. The dots go now rather than lapsing a
      // few seconds after their message is already on screen.
      final typer = state.typing;
      final sent = typer != null && fresh.any((m) => m.senderId == typer);
      if (sent) _typingLapse?.cancel();
      state = state.copyWith(
        messages: [...state.messages, ...fresh],
        clearTyping: sent,
      );
      await _markRead();
    } catch (_) {
      // Nothing to say. The message is still on the server and the next
      // refresh or reopen will find it.
    }
  }

  /// Reads further back. In a thread that is upwards, not downwards.
  Future<void> loadMore() async {
    final cursor = state.cursor;
    if (cursor == null || state.loadingMore || state.loadingFirstPage) return;

    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.messages(_conversationId, cursor: cursor);
      state = state.copyWith(
        messages: [
          ...await _open(page.items.reversed.toList()),
          ...state.messages,
        ],
        cursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
        loadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        loadingMore: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Says something.
  ///
  /// On screen before it is anywhere else, and replaced by the real row when
  /// the server answers. A chat that sits still until a round trip completes
  /// is a chat that feels broken on a slow connection.
  Future<void> send(
    String body, {
    required String senderId,
    List<PendingMedia> media = const [],
    String? replyToId,
  }) async {
    final text = body.trim();
    // A picture with no words is a message; an empty box is not.
    if (text.isEmpty && media.isEmpty) return;

    final placeholder = DirectMessage(
      id: 'pending-${_pending++}',
      body: text,
      senderId: senderId,
      createdAt: DateTime.now(),
      sending: true,
      replyToId: replyToId,
      // Shown from the local file while it goes up, so the bubble is not an
      // empty box for the length of the upload.
      media: media.map((item) => item.asPlaceholder).toList(),
    );
    state = state.copyWith(messages: [...state.messages, placeholder]);

    try {
      // Sealed if both sides have published a key, and sent as it was written
      // if not. Never silently one when the reader was shown the other: the
      // bubble carries which it was.
      final sealed =
          text.isEmpty ? null : await _vault.seal(text, _conversationId);
      final sent = await _repo.send(
        _conversationId,
        sealed ?? text,
        media: media,
        replyToId: replyToId,
      );
      _replace(
        placeholder.id,
        sent.copyWith(body: text, encrypted: sealed != null),
      );
    } catch (_) {
      _replace(
        placeholder.id,
        placeholder.copyWith(sending: false, failed: true),
      );
    }
  }

  /// Sends a failed message again, from the bubble that says it failed.
  ///
  /// Text only: the attachments were uploaded against the failed attempt and
  /// their local files may be gone, so a retry that promised to resend them
  /// could silently drop them.
  Future<void> retry(DirectMessage message) async {
    _drop(message.id);
    // Still an answer to the same message. Without this a failed reply came
    // back as a loose remark, and the thread stopped making sense.
    await send(
      message.body,
      senderId: message.senderId,
      replyToId: message.replyToId,
    );
  }

  /// Fills in the ticks after the other side has read up to here.
  ///
  /// Local, and no fetch: the server already said what happened, and asking
  /// it again would empty the list and blink a thread somebody is reading.
  /// Only the reader's own bubbles change -- "seen" is about whether the
  /// other person has looked, and their own messages were never unseen.
  void markSeenByOther(String me) {
    if (!state.messages.any((m) => m.senderId == me && !m.seen)) return;
    state = state.copyWith(
      messages: [
        for (final message in state.messages)
          message.senderId == me && !message.seen
              ? message.copyWith(seen: true)
              : message,
      ],
    );
  }

  /// Takes a message the other side withdrew off the screen.
  ///
  /// Also local. A message that stays put until the thread is reopened was
  /// not really deleted.
  void withdrawn(String messageId) {
    if (!state.messages.any((m) => m.id == messageId)) return;
    _drop(messageId);
  }

  /// Silences this conversation, or unsilences it.
  Future<String?> setMuted(bool muted) async {
    try {
      await _repo.setMuted(_conversationId, muted);
      state = state.copyWith(muted: muted);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Blocks the other person. The server hides the thread with it.
  Future<String?> blockOther() async {
    try {
      await _repo.blockOther(_conversationId);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Removes one of the reader's own messages.
  Future<String?> remove(DirectMessage message) async {
    // A message that never reached the server is dropped rather than deleted.
    if (message.failed || message.sending) {
      _drop(message.id);
      return null;
    }
    final kept = state.messages;
    _drop(message.id);
    try {
      await _repo.remove(message.id);
      return null;
    } catch (error) {
      state = state.copyWith(messages: kept);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// How long "is typing" lasts after the last sign of it. The other side
  /// sends one every [typingEvery] while their box changes, so this outlives
  /// one gap and lapses after a pause, with no "stopped" message to lose.
  static const typingLapse = Duration(seconds: 6);

  /// The most often this reader tells the other side they are typing.
  static const typingEvery = Duration(seconds: 3);

  Timer? _typingLapse;
  DateTime? _lastTypingSent;

  /// The socket said [userId] is writing in this thread.
  void otherTyping(String userId) {
    _typingLapse?.cancel();
    state = state.copyWith(typing: userId);
    _typingLapse = Timer(typingLapse, () {
      if (mounted) state = state.copyWith(clearTyping: true);
    });
  }

  /// Tells the other side the reader is writing -- at most every
  /// [typingEvery], however fast they type. Fire and forget: a lost "is
  /// typing" is not worth a word to anybody.
  Future<void> sendTyping({DateTime? now}) async {
    final at = now ?? DateTime.now();
    final last = _lastTypingSent;
    if (last != null && at.difference(last) < typingEvery) return;
    _lastTypingSent = at;
    try {
      await _repo.typing(_conversationId);
    } catch (_) {}
  }

  /// Reacts to [message] with [emoji], replacing the reader's previous
  /// reaction to it. On screen at once and put back if the server refuses;
  /// returns what to tell the reader then, or null.
  Future<String?> react(
    DirectMessage message,
    String emoji, {
    required String me,
  }) async {
    if (message.sending || message.failed) return null;
    final before = _reactionsOf(message.id);
    if (before == null) return null;
    _setReactions(message.id, [
      for (final r in before)
        if (r.userId != me) r,
      MessageReaction(userId: me, emoji: emoji),
    ]);
    try {
      await _repo.react(_conversationId, message.id, emoji);
      return null;
    } catch (error) {
      _setReactions(message.id, before);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Takes the reader's reaction off [message].
  Future<String?> unreact(DirectMessage message, {required String me}) async {
    final before = _reactionsOf(message.id);
    if (before == null || !before.any((r) => r.userId == me)) return null;
    _setReactions(message.id, [
      for (final r in before)
        if (r.userId != me) r,
    ]);
    try {
      await _repo.unreact(_conversationId, message.id);
      return null;
    } catch (error) {
      _setReactions(message.id, before);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// A heart, or no heart: what a double tap on a message does.
  Future<String?> toggleHeart(DirectMessage message, {required String me}) {
    final current = _reactionsOf(message.id);
    final hearted = current != null &&
        current.any((r) => r.userId == me && r.emoji == '❤️');
    return hearted ? unreact(message, me: me) : react(message, '❤️', me: me);
  }

  /// The socket said a message's reactions changed. Reads them and applies
  /// them in place -- no page refetch, so the thread does not blink.
  Future<void> reactionsChanged(String messageId) async {
    if (_reactionsOf(messageId) == null) return;
    try {
      final reactions = await _repo.reactions(_conversationId, messageId);
      _setReactions(messageId, reactions);
    } catch (_) {
      // Stale until the thread is next read; not worth a word.
    }
  }

  List<MessageReaction>? _reactionsOf(String id) {
    for (final m in state.messages) {
      if (m.id == id) return m.reactions;
    }
    return null;
  }

  void _setReactions(String id, List<MessageReaction> reactions) {
    state = state.copyWith(
      messages: [
        for (final m in state.messages)
          m.id == id ? m.copyWith(reactions: reactions) : m,
      ],
    );
  }

  @override
  void dispose() {
    _typingLapse?.cancel();
    super.dispose();
  }

  Future<void> _markRead() async {
    try {
      await _repo.markRead(_conversationId);
    } catch (_) {
      // Not worth a message. The badge is stale for a moment and corrects
      // itself the next time the list is read.
    }
  }

  void _replace(String id, DirectMessage next) {
    state = state.copyWith(
      messages: [for (final m in state.messages) m.id == id ? next : m],
    );
  }

  void _drop(String id) {
    state = state.copyWith(
      messages: [
        for (final m in state.messages)
          if (m.id != id) m,
      ],
    );
  }
}

final threadProvider =
    StateNotifierProvider.family<ThreadNotifier, ThreadState, String>(
  (ref, conversationId) => ThreadNotifier(
    ref.read(messagesRepositoryProvider),
    ref.read(messageVaultProvider),
    conversationId,
  ),
);
