import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/feed_post.dart';
import '../models/post_comment.dart';
import '../repositories/feed_repository.dart';
import '../utils/api_error_message.dart';
import 'feed_provider.dart';

/// One post and its thread.
class PostDetailState {
  final FeedPost? post;
  final List<PostComment> comments;

  /// Replies, keyed by the comment they hang off. Absent until expanded.
  final Map<String, List<PostComment>> replies;

  /// Which threads the reader has opened.
  final Set<String> expanded;

  final bool isLoading;
  final bool isSending;
  final String? error;
  final String? nextCursor;

  const PostDetailState({
    this.post,
    this.comments = const [],
    this.replies = const {},
    this.expanded = const {},
    this.isLoading = true,
    this.isSending = false,
    this.error,
    this.nextCursor,
  });

  bool get hasMore => nextCursor != null;

  /// True only once a load has finished and found nothing, so the empty state
  /// never flashes before the thread arrives.
  bool get threadIsEmpty => comments.isEmpty && !isLoading && error == null;

  PostDetailState copyWith({
    FeedPost? post,
    List<PostComment>? comments,
    Map<String, List<PostComment>>? replies,
    Set<String>? expanded,
    bool? isLoading,
    bool? isSending,
    String? error,
    String? nextCursor,
    bool clearError = false,
    bool clearCursor = false,
  }) {
    return PostDetailState(
      post: post ?? this.post,
      comments: comments ?? this.comments,
      replies: replies ?? this.replies,
      expanded: expanded ?? this.expanded,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: clearError ? null : (error ?? this.error),
      nextCursor: clearCursor ? null : (nextCursor ?? this.nextCursor),
    );
  }
}

final postDetailProvider =
    StateNotifierProvider.family<PostDetailNotifier, PostDetailState, String>(
  (ref, postId) => PostDetailNotifier(ref, postId),
);

class PostDetailNotifier extends StateNotifier<PostDetailState> {
  final Ref _ref;
  final String _postId;

  PostDetailNotifier(this._ref, this._postId) : super(const PostDetailState()) {
    load();
  }

  FeedRepository get _repo => _ref.read(feedRepositoryProvider);

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Both at once: the post is what the screen leads with and the thread is
      // the rest of it, so waiting for one and then the other shows half a
      // screen for a whole round trip.
      final results = await Future.wait([
        _repo.byId(_postId),
        _repo.comments(_postId),
      ]);

      final post = results[0] as FeedPost;
      final page = results[1] as CommentPage;

      state = PostDetailState(
        post: post,
        comments: page.items,
        nextCursor: page.nextCursor,
        isLoading: false,
      );

      // Recorded after the post is on screen, and never awaited by the render:
      // a reader should not wait on a counter.
      unawaited(_repo.recordView(_postId));
    } catch (e) {
      state = PostDetailState(
        isLoading: false,
        error: describeApiError(e, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.nextCursor;
    if (cursor == null || state.isLoading) return;

    try {
      final page = await _repo.comments(_postId, cursor: cursor);
      state = state.copyWith(
        comments: [...state.comments, ...page.items],
        nextCursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
      );
    } catch (_) {
      // A failed page is not a failed thread: keep what is on screen.
    }
  }

  /// Opens or closes one comment's replies, fetching them the first time.
  Future<void> toggleReplies(String commentId) async {
    final expanded = {...state.expanded};
    if (expanded.remove(commentId)) {
      state = state.copyWith(expanded: expanded);
      return;
    }

    expanded.add(commentId);
    state = state.copyWith(expanded: expanded);
    if (state.replies.containsKey(commentId)) return;

    try {
      final page = await _repo.replies(commentId);
      state = state.copyWith(
        replies: {...state.replies, commentId: page.items},
      );
    } catch (_) {
      // Leave it expanded and empty rather than collapsing under the reader.
      state = state.copyWith(
        replies: {...state.replies, commentId: const []},
      );
    }
  }

  /// Posts a comment, or a reply to [parentId]. Returns an error to show, or
  /// null on success.
  Future<String?> comment(String content, {String? parentId}) async {
    if (content.trim().isEmpty || state.isSending) return null;

    state = state.copyWith(isSending: true, clearError: true);
    try {
      final created =
          await _repo.addComment(_postId, content.trim(), parentId: parentId);

      if (parentId == null) {
        // Oldest first, so a new comment goes at the end of the thread.
        state = state.copyWith(
          comments: [...state.comments, created],
          isSending: false,
        );
      } else {
        state = state.copyWith(
          comments: [
            for (final c in state.comments)
              c.id == parentId ? c.copyWith(replies: c.replies + 1) : c,
          ],
          replies: {
            ...state.replies,
            parentId: [...(state.replies[parentId] ?? const []), created],
          },
          expanded: {...state.expanded, parentId},
          isSending: false,
        );
      }

      _bumpCommentCount(1);
      return null;
    } catch (e) {
      state = state.copyWith(isSending: false);
      return describeApiError(e, sessionIsLive: true);
    }
  }

  Future<String?> deleteComment(PostComment comment) async {
    final before = state;
    state = state.copyWith(
      comments: state.comments.where((c) => c.id != comment.id).toList(),
      replies: {
        for (final entry in state.replies.entries)
          entry.key: entry.value.where((c) => c.id != comment.id).toList(),
      },
    );

    try {
      await _repo.deleteComment(comment.id);
      _bumpCommentCount(-1);
      return null;
    } catch (e) {
      state = before;
      return describeApiError(e, sessionIsLive: true);
    }
  }

  Future<String?> toggleLike() => _mutate((post) async {
        final next = !post.liked;
        final likes = await _repo.setLiked(post.id, next);
        return post.copyWith(liked: next, likes: likes);
      });

  Future<String?> toggleSave() => _mutate((post) async {
        final next = !post.saved;
        await _repo.setSaved(post.id, next);
        return post.copyWith(saved: next);
      });

  Future<String?> _mutate(
    Future<FeedPost> Function(FeedPost post) change,
  ) async {
    final post = state.post;
    if (post == null) return null;

    try {
      state = state.copyWith(post: await change(post));
      // The feed is showing the same post; keep the two from disagreeing.
      _ref.read(postListProvider(PostListSource.recent).notifier).refresh();
      return null;
    } catch (e) {
      state = state.copyWith(post: post);
      return describeApiError(e, sessionIsLive: true);
    }
  }

  void _bumpCommentCount(int delta) {
    final post = state.post;
    if (post == null) return;
    state = state.copyWith(
      post: post.copyWith(comments: (post.comments + delta).clamp(0, 1 << 31)),
    );
  }
}

/// Fire-and-forget, without the analyzer warning about a dropped future.
void unawaited(Future<void> future) {
  future.then((_) {}, onError: (_) {});
}
