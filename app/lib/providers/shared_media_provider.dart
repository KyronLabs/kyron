// lib/providers/shared_media_provider.dart
import 'package:flutter_riverpod/legacy.dart';

import '../repositories/messages_repository.dart';
import '../utils/api_error_message.dart';
import 'messages_provider.dart' show messagesRepositoryProvider;

/// The attachments in one conversation, newest first, a page at a time.
class SharedMediaState {
  final List<SharedMedia> items;
  final String? cursor;
  final bool loading;
  final String? error;

  const SharedMediaState({
    this.items = const [],
    this.cursor,
    this.loading = true,
    this.error,
  });

  bool get hasMore => cursor != null;

  /// What can be shown in the viewer: everything but voice notes.
  List<SharedMedia> get visual =>
      items.where((item) => item.media.isVisual).toList();

  List<SharedMedia> get voice =>
      items.where((item) => item.media.isVoice).toList();
}

class SharedMediaNotifier extends StateNotifier<SharedMediaState> {
  SharedMediaNotifier(this._repo, this._conversationId)
      : super(const SharedMediaState()) {
    refresh();
  }

  final MessagesRepository _repo;
  final String _conversationId;

  Future<void> refresh() async {
    state = const SharedMediaState();
    try {
      final page = await _repo.sharedMedia(_conversationId);
      if (!mounted) return;
      state = SharedMediaState(
        items: page.items,
        cursor: page.nextCursor,
        loading: false,
      );
    } catch (error) {
      if (!mounted) return;
      state = SharedMediaState(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.cursor;
    if (cursor == null || state.loading) return;
    state = SharedMediaState(items: state.items, cursor: cursor);
    try {
      final page = await _repo.sharedMedia(_conversationId, cursor: cursor);
      if (!mounted) return;
      state = SharedMediaState(
        items: [...state.items, ...page.items],
        cursor: page.nextCursor,
        loading: false,
      );
    } catch (error) {
      if (!mounted) return;
      state = SharedMediaState(
        items: state.items,
        cursor: cursor,
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }
}

final sharedMediaProvider = StateNotifierProvider.autoDispose
    .family<SharedMediaNotifier, SharedMediaState, String>(
  (ref, conversationId) => SharedMediaNotifier(
    ref.read(messagesRepositoryProvider),
    conversationId,
  ),
);
