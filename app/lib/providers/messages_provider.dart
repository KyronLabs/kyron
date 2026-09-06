// lib/providers/messages_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/conversation.dart';
import '../repositories/messages_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

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
      final page =
          await _repo.conversations(cursor: cursor, unreadOnly: unreadOnly);
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

  const ThreadState({
    this.messages = const [],
    this.people = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  bool get isEmpty => !loadingFirstPage && error == null && messages.isEmpty;

  ThreadState copyWith({
    List<DirectMessage>? messages,
    List<MessagePerson>? people,
    String? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
  }) =>
      ThreadState(
        messages: messages ?? this.messages,
        people: people ?? this.people,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

class ThreadNotifier extends StateNotifier<ThreadState> {
  final MessagesRepository _repo;
  final String _conversationId;

  /// Counts up so two messages sent in the same millisecond cannot share a
  /// placeholder id.
  int _pending = 0;

  ThreadNotifier(this._repo, this._conversationId)
      : super(const ThreadState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const ThreadState();
    try {
      final page = await _repo.messages(_conversationId);
      state = ThreadState(
        // The server answers newest first, because that is what a cursor over
        // "most recent" has to do. The screen reads oldest first.
        messages: page.items.reversed.toList(),
        people: page.people,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
      await _markRead();
    } catch (error) {
      state = ThreadState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
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
        messages: [...page.items.reversed, ...state.messages],
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
  Future<void> send(String body, {required String senderId}) async {
    final text = body.trim();
    if (text.isEmpty) return;

    final placeholder = DirectMessage(
      id: 'pending-${_pending++}',
      body: text,
      senderId: senderId,
      createdAt: DateTime.now(),
      sending: true,
    );
    state = state.copyWith(messages: [...state.messages, placeholder]);

    try {
      final sent = await _repo.send(_conversationId, text);
      _replace(placeholder.id, sent);
    } catch (_) {
      _replace(
          placeholder.id, placeholder.copyWith(sending: false, failed: true));
    }
  }

  /// Sends a failed message again, from the bubble that says it failed.
  Future<void> retry(DirectMessage message) async {
    _drop(message.id);
    await send(message.body, senderId: message.senderId);
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
      messages: [
        for (final m in state.messages) m.id == id ? next : m,
      ],
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
    conversationId,
  ),
);
