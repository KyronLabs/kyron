// lib/providers/community_chats_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/community_chat.dart';
import '../repositories/community_chats_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

final communityChatsRepositoryProvider = Provider<CommunityChatsRepository>(
  (ref) => CommunityChatsRepository(ref.read(apiClientProvider)),
);

/// A community's chats, for its page. Read only for members: anybody else
/// is refused by the server, and the page does not ask.
final communityChatsProvider =
    FutureProvider.autoDispose.family<List<CommunityChat>, String>(
  (ref, slug) => ref.read(communityChatsRepositoryProvider).list(slug),
);

/// One open chat.
class CommunityChatState {
  final CommunityChat? chat;

  /// Oldest first, the order a chat is read in.
  final List<CommunityChatMessage> messages;
  final String? cursor;
  final bool loading;
  final bool loadingMore;
  final String? error;

  /// The server has stopped showing it to the reader: removed from the
  /// community, or the chat closed. Said, rather than retried for ever.
  final bool shut;

  const CommunityChatState({
    this.chat,
    this.messages = const [],
    this.cursor,
    this.loading = true,
    this.loadingMore = false,
    this.error,
    this.shut = false,
  });

  CommunityChatState copyWith({
    CommunityChat? chat,
    List<CommunityChatMessage>? messages,
    String? cursor,
    bool clearCursor = false,
    bool? loading,
    bool? loadingMore,
    String? error,
    bool clearError = false,
    bool? shut,
  }) =>
      CommunityChatState(
        chat: chat ?? this.chat,
        messages: messages ?? this.messages,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loading: loading ?? this.loading,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
        shut: shut ?? this.shut,
      );

  /// The message [id] answers, when it is loaded.
  CommunityChatMessage? byId(String id) {
    for (final m in messages) {
      if (m.id == id) return m;
    }
    return null;
  }
}

class CommunityChatNotifier extends StateNotifier<CommunityChatState> {
  final CommunityChatsRepository _repo;
  final String chatId;

  /// Counts up so two messages sent in the same millisecond cannot share a
  /// placeholder id.
  int _pending = 0;

  /// Taken down while the screen was open. A page asked for just before the
  /// takedown can land just after it; this keeps the message from coming
  /// back with it.
  final Set<String> _gone = {};

  CommunityChatNotifier(this._repo, this.chatId)
      : super(const CommunityChatState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final chat = await _repo.get(chatId);
      final page = await _repo.messages(chatId);
      if (!mounted) return;
      state = CommunityChatState(
        chat: chat,
        messages: _shown(page.items.reversed),
        cursor: page.nextCursor,
        loading: false,
      );
      await _markRead();
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
        shut: _refused(error),
      );
    }
  }

  /// Reads the chat's own details again: a rename, a pin, who may write.
  Future<void> refreshChat() async {
    try {
      final chat = await _repo.get(chatId);
      if (mounted) state = state.copyWith(chat: chat);
    } catch (error) {
      if (mounted && _refused(error)) state = state.copyWith(shut: true);
    }
  }

  /// Picks up what arrived while the screen was open, without blinking it:
  /// the newest page, merged, and reactions on what is held brought up to
  /// date.
  Future<void> pullNewest() async {
    if (state.loading || state.shut) return;
    try {
      final page = await _repo.messages(chatId);
      if (!mounted) return;
      final fresh = {for (final m in page.items) m.id: m};
      final held = {for (final m in state.messages) m.id};
      state = state.copyWith(
        messages: [
          for (final m in state.messages) fresh[m.id] ?? m,
          ..._shown(page.items.reversed.where((m) => !held.contains(m.id))),
        ],
      );
      await _markRead();
    } catch (error) {
      if (mounted && _refused(error)) state = state.copyWith(shut: true);
    }
  }

  /// Further back, above what is held.
  Future<void> loadMore() async {
    final cursor = state.cursor;
    if (cursor == null || state.loadingMore || state.loading) return;
    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.messages(chatId, cursor: cursor);
      if (!mounted) return;
      state = state.copyWith(
        messages: [..._shown(page.items.reversed), ...state.messages],
        cursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
        loadingMore: false,
      );
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(
        loadingMore: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Says something. On screen at once, replaced by the real row when the
  /// server answers, or marked as not sent with the reason.
  Future<String?> send(
    String text, {
    required ChatPerson me,
    CommunityChatMessage? replyingTo,
  }) async {
    final body = text.trim();
    if (body.isEmpty) return null;
    final placeholder = CommunityChatMessage(
      id: 'pending-${_pending++}',
      body: body,
      sender: me,
      createdAt: DateTime.now(),
      sending: true,
      replyTo: replyingTo == null
          ? null
          : ChatReply(
              id: replyingTo.id,
              senderName: replyingTo.sender.displayName,
              body: replyingTo.body,
            ),
    );
    state = state.copyWith(messages: [...state.messages, placeholder]);
    try {
      final sent = await _repo.send(chatId, body, replyToId: replyingTo?.id);
      if (!mounted) return null;
      _replace(placeholder.id, sent);
      return null;
    } catch (error) {
      if (!mounted) return null;
      _replace(
          placeholder.id, placeholder.copyWith(sending: false, failed: true));
      _resend[placeholder.id] = (body: body, replyingTo: replyingTo);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  final Map<String, ({String body, CommunityChatMessage? replyingTo})> _resend =
      {};

  Future<String?> retry(CommunityChatMessage failed, {required ChatPerson me}) {
    final again = _resend.remove(failed.id);
    _drop(failed.id);
    return send(
      again?.body ?? failed.body,
      me: me,
      replyingTo: again?.replyingTo,
    );
  }

  Future<String?> delete(CommunityChatMessage message) async {
    if (message.failed || message.sending) {
      _resend.remove(message.id);
      _drop(message.id);
      return null;
    }
    try {
      await _repo.delete(chatId, message.id);
      _gone.add(message.id);
      if (mounted) _drop(message.id);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Reacts with [emoji], or takes the reaction back when it is the one
  /// already there. The pill moves first; put back if the server refuses.
  Future<String?> toggleReaction(
    CommunityChatMessage message,
    String emoji,
  ) async {
    final taking = message.mine == emoji;
    _replace(message.id, message.withMine(taking ? null : emoji));
    try {
      if (taking) {
        await _repo.unreact(chatId, message.id);
      } else {
        await _repo.react(chatId, message.id, emoji);
      }
      return null;
    } catch (error) {
      if (mounted) _replace(message.id, message);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  Future<String?> join() async {
    try {
      final chat = await _repo.join(chatId);
      if (mounted) state = state.copyWith(chat: chat);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  Future<String?> leave() async {
    try {
      await _repo.leave(chatId);
      await refreshChat();
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  Future<String?> pin(CommunityChatMessage? message) async {
    try {
      final chat = await _repo.pin(chatId, message?.id);
      if (mounted) state = state.copyWith(chat: chat);
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// A message somebody took down, off the screen, and kept off it.
  void withdrawn(String messageId) {
    _gone.add(messageId);
    _drop(messageId);
  }

  List<CommunityChatMessage> _shown(Iterable<CommunityChatMessage> page) => [
        for (final m in page)
          if (!_gone.contains(m.id)) m,
      ];

  Future<void> _markRead() async {
    if (state.chat?.joined != true) return;
    try {
      await _repo.markRead(chatId);
    } catch (_) {
      // The count is stale for a moment; the next read puts it right.
    }
  }

  /// Refused because the reader may not see it any more, rather than a
  /// network that went away.
  static bool _refused(Object error) =>
      error is DioException &&
      (error.response?.statusCode == 403 || error.response?.statusCode == 404);

  void _replace(String id, CommunityChatMessage next) {
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

final communityChatProvider = StateNotifierProvider.autoDispose
    .family<CommunityChatNotifier, CommunityChatState, String>(
  (ref, chatId) => CommunityChatNotifier(
    ref.read(communityChatsRepositoryProvider),
    chatId,
  ),
);
