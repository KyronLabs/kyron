import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:image_picker/image_picker.dart';

import '../models/feed_post.dart';
import '../models/post_comment.dart';
import '../models/post_media.dart';
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

  /// Which are still fetching their replies.
  ///
  /// Held apart from [expanded] on purpose. Marking a comment expanded the
  /// moment it was tapped took its "show replies" row away before the replies
  /// existed, so the branch showed nothing at all for the length of the
  /// request -- which reads as the thread having been deleted.
  final Set<String> loadingReplies;

  final bool isLoading;
  final bool isSending;

  /// Attachments on the comment being written.
  final List<PendingMedia> media;
  final String? error;
  final String? nextCursor;

  const PostDetailState({
    this.post,
    this.comments = const [],
    this.replies = const {},
    this.expanded = const {},
    this.loadingReplies = const {},
    this.isLoading = true,
    this.isSending = false,
    this.media = const [],
    this.error,
    this.nextCursor,
  });

  bool get hasMore => nextCursor != null;

  /// How many attachments one comment may carry, matching the server.
  static const maxMedia = 4;

  bool get canAttach => media.length < maxMedia;

  bool get isUploading => media.any((m) => m.isUploading);

  /// True only once a load has finished and found nothing, so the empty state
  /// never flashes before the thread arrives.
  bool get threadIsEmpty => comments.isEmpty && !isLoading && error == null;

  PostDetailState copyWith({
    FeedPost? post,
    List<PostComment>? comments,
    Map<String, List<PostComment>>? replies,
    Set<String>? expanded,
    Set<String>? loadingReplies,
    bool? isLoading,
    bool? isSending,
    List<PendingMedia>? media,
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
      loadingReplies: loadingReplies ?? this.loadingReplies,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      media: media ?? this.media,
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

    // Already fetched once: open it without asking again.
    if (state.replies.containsKey(commentId)) {
      state = state.copyWith(expanded: {...expanded, commentId});
      return;
    }

    // Expanded only once the replies are in hand. Setting it now would take
    // the "show replies" row away and put nothing in its place, so the branch
    // would be empty for the length of the request. The row stays, carrying a
    // spinner beside its faces.
    if (state.loadingReplies.contains(commentId)) return;
    state = state.copyWith(
      loadingReplies: {...state.loadingReplies, commentId},
    );

    try {
      final page = await _repo.replies(commentId);
      state = state.copyWith(
        replies: {...state.replies, commentId: page.items},
        expanded: {...state.expanded, commentId},
        loadingReplies: {...state.loadingReplies}..remove(commentId),
      );
    } catch (_) {
      // Opened and empty rather than left spinning: the reader asked, and a
      // row that spins forever is worse than one that shows nothing.
      state = state.copyWith(
        replies: {...state.replies, commentId: const []},
        expanded: {...state.expanded, commentId},
        loadingReplies: {...state.loadingReplies}..remove(commentId),
      );
    }
  }

  /// Likes a comment, or takes the like back.
  ///
  /// Moved before the request lands and put back if it fails: a heart that
  /// fills and stays filled while the server disagrees is worse than one that
  /// flickers.
  Future<String?> toggleCommentLike(PostComment comment) async {
    final wanted = !comment.liked;
    _replaceComment(comment.copyWith(
      liked: wanted,
      likes: (comment.likes + (wanted ? 1 : -1)).clamp(0, 1 << 31),
    ));
    try {
      final likes = await _repo.setCommentLike(comment.id, wanted);
      _replaceComment(comment.copyWith(liked: wanted, likes: likes));
      return null;
    } catch (error) {
      _replaceComment(comment);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  /// One comment by id, from wherever it is held.
  PostComment? _find(String id) {
    for (final row in state.comments) {
      if (row.id == id) return row;
    }
    for (final run in state.replies.values) {
      for (final row in run) {
        if (row.id == id) return row;
      }
    }
    return null;
  }

  /// Swaps one comment for an updated copy, wherever it is held -- the
  /// top-level list, or one of the fetched reply runs.
  void _replaceComment(PostComment updated) {
    state = state.copyWith(
      comments: [
        for (final row in state.comments)
          if (row.id == updated.id) updated else row,
      ],
      replies: {
        for (final entry in state.replies.entries)
          entry.key: [
            for (final row in entry.value)
              if (row.id == updated.id) updated else row,
          ],
      },
    );
  }

  // ---- Attachments --------------------------------------------------------

  /// Picks images or a clip for the comment and uploads them straight away, so
  /// a slow upload happens while the reply is still being written.
  Future<String?> attach({required bool video}) async {
    if (!state.canAttach) {
      return 'A comment can carry at most ${PostDetailState.maxMedia} attachments.';
    }

    final picker = ImagePicker();
    try {
      final List<XFile> picked;
      if (video) {
        final clip = await picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(minutes: 2),
        );
        picked = clip == null ? const [] : [clip];
      } else {
        picked = await picker.pickMultiImage(
          limit: PostDetailState.maxMedia - state.media.length,
        );
      }
      if (picked.isEmpty) return null;

      for (final file in picked.take(
        PostDetailState.maxMedia - state.media.length,
      )) {
        await _upload(
          PendingMedia(
            path: file.path,
            kind: video ? MediaKind.video : MediaKind.image,
          ),
        );
      }
      return null;
    } catch (_) {
      return 'Could not open your gallery.';
    }
  }

  Future<void> _upload(PendingMedia pending) async {
    state = state.copyWith(media: [...state.media, pending]);
    try {
      final uploaded = await _repo.uploadMedia(pending);
      _replaceMedia(pending.path, uploaded);
    } catch (e) {
      _replaceMedia(
        pending.path,
        pending.copyWith(error: describeApiError(e, sessionIsLive: true)),
      );
    }
  }

  void detach(String path) {
    state = state.copyWith(
      media: state.media.where((m) => m.path != path).toList(),
    );
  }

  Future<void> retryAttachment(String path) async {
    final failed = state.media.where((m) => m.path == path).firstOrNull;
    if (failed == null) return;
    detach(path);
    await _upload(failed.copyWith(clearError: true));
  }

  void describeAttachment(String path, String alt) {
    state = state.copyWith(
      media: [
        for (final m in state.media) m.path == path ? m.copyWith(alt: alt) : m,
      ],
    );
  }

  void _replaceMedia(String path, PendingMedia updated) {
    state = state.copyWith(
      media: [
        for (final m in state.media) m.path == path ? updated : m,
      ],
    );
  }

  /// Posts a comment, or a reply to [parentId]. Returns an error to show, or
  /// null on success.
  ///
  /// A comment carrying only a picture is a comment, which is what the server
  /// accepts too.
  Future<String?> comment(String content, {String? parentId}) async {
    final hasContent = content.trim().isNotEmpty || state.media.isNotEmpty;
    if (!hasContent || state.isSending || state.isUploading) return null;

    state = state.copyWith(isSending: true, clearError: true);
    try {
      final created = await _repo.addComment(
        _postId,
        content.trim(),
        parentId: parentId,
        media: state.media,
      );

      if (parentId == null) {
        // Oldest first, so a new comment goes at the end of the thread.
        state = state.copyWith(
          comments: [...state.comments, created],
          isSending: false,
          media: const [],
        );
      } else {
        state = state.copyWith(
          replies: {
            ...state.replies,
            parentId: [...(state.replies[parentId] ?? const []), created],
          },
          expanded: {...state.expanded, parentId},
          isSending: false,
          media: const [],
        );
        // The parent may be a reply itself, and its count lives wherever it
        // is held. Bumping only the top-level list left a nested comment
        // saying it had no answers while its answer was on screen under it.
        final parent = _find(parentId);
        if (parent != null) {
          _replaceComment(parent.copyWith(replies: parent.replies + 1));
        }
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

  Future<String?> toggleRepost() => _mutate((post) async {
        final next = !post.reposted;
        final reposts = await _repo.setReposted(post.id, next);
        return post.copyWith(reposted: next, reposts: reposts);
      });

  /// Takes the post as the server just returned it -- after a poll vote, say.
  void replacePost(FeedPost post) {
    state = state.copyWith(post: post);
  }

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
