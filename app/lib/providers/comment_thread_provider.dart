// lib/providers/comment_thread_provider.dart
import 'package:flutter_riverpod/legacy.dart';

import '../models/post_comment.dart';
import '../repositories/feed_repository.dart';
import '../utils/api_error_message.dart';
import 'feed_provider.dart' show feedRepositoryProvider;

/// One comment, everything under it, and what is being done to it.
class CommentThreadState {
  final PostComment? root;

  /// Every descendant, flat. The screen threads them.
  final List<PostComment> replies;

  final String? postId;
  final bool loading;
  final String? error;

  /// Folded runs the reader has opened.
  final Set<String> expanded;

  const CommentThreadState({
    this.root,
    this.replies = const [],
    this.postId,
    this.loading = true,
    this.error,
    this.expanded = const {},
  });

  CommentThreadState copyWith({
    PostComment? root,
    List<PostComment>? replies,
    String? postId,
    bool? loading,
    String? error,
    bool clearError = false,
    Set<String>? expanded,
  }) =>
      CommentThreadState(
        root: root ?? this.root,
        replies: replies ?? this.replies,
        postId: postId ?? this.postId,
        loading: loading ?? this.loading,
        error: clearError ? null : (error ?? this.error),
        expanded: expanded ?? this.expanded,
      );
}

class CommentThreadNotifier extends StateNotifier<CommentThreadState> {
  final FeedRepository _repo;
  final String _commentId;

  CommentThreadNotifier(this._repo, this._commentId)
      : super(const CommentThreadState()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final thread = await _repo.commentThread(_commentId);
      state = CommentThreadState(
        root: thread.root,
        replies: thread.replies,
        postId: thread.postId,
        loading: false,
        expanded: state.expanded,
      );
    } catch (error) {
      state = state.copyWith(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  void toggleExpanded(String commentId) {
    final next = {...state.expanded};
    if (!next.remove(commentId)) next.add(commentId);
    state = state.copyWith(expanded: next);
  }

  /// Likes or unlikes, moving the count before the request lands.
  ///
  /// Put back on failure rather than left showing a like that did not happen:
  /// a heart that fills and stays filled while the server says otherwise is
  /// worse than one that flickers.
  Future<String?> toggleLike(PostComment comment) async {
    final wanted = !comment.liked;
    _replace(comment.copyWith(
      liked: wanted,
      likes: (comment.likes + (wanted ? 1 : -1)).clamp(0, 1 << 31),
    ));
    try {
      final likes = await _repo.setCommentLike(comment.id, wanted);
      _replace(comment.copyWith(liked: wanted, likes: likes));
      return null;
    } catch (error) {
      _replace(comment);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  Future<String?> delete(PostComment comment) async {
    try {
      await _repo.deleteComment(comment.id);
      if (comment.id == _commentId) {
        // The whole page is about this one. Nothing left to show.
        state = state.copyWith(root: null, replies: const []);
      } else {
        state = state.copyWith(
          replies: [
            for (final row in state.replies)
              if (row.id != comment.id) row,
          ],
        );
      }
      return null;
    } catch (error) {
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// Adds a freshly written reply without a round trip for the whole thread.
  void added(PostComment reply) {
    state = state.copyWith(
      replies: [...state.replies, reply],
      root: reply.parentId == state.root?.id
          ? state.root?.copyWith(replies: (state.root?.replies ?? 0) + 1)
          : state.root,
    );
  }

  void _replace(PostComment updated) {
    state = state.copyWith(
      root: state.root?.id == updated.id ? updated : state.root,
      replies: [
        for (final row in state.replies)
          if (row.id == updated.id) updated else row,
      ],
    );
  }
}

final commentThreadProvider = StateNotifierProvider.family<
    CommentThreadNotifier, CommentThreadState, String>(
  (ref, commentId) =>
      CommentThreadNotifier(ref.read(feedRepositoryProvider), commentId),
);
