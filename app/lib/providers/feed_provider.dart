import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/feed_post.dart';
import '../repositories/feed_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

final feedRepositoryProvider = Provider<FeedRepository>(
  (ref) => FeedRepository(ref.read(apiClientProvider)),
);

/// Which list of posts a [PostListNotifier] reads.
///
/// A value type rather than a bare string so a Riverpod family key cannot be
/// typo'd into a second, silently empty provider.
class PostListSource {
  final String kind;
  final String? userId;

  const PostListSource._(this.kind, [this.userId]);

  /// The main feed: everyone, newest first.
  static const recent = PostListSource._('recent');

  /// Posts you have liked.
  static const liked = PostListSource._('liked');

  /// Posts you have saved.
  static const saved = PostListSource._('saved');

  /// One account's posts, for a profile screen.
  factory PostListSource.author(String userId) =>
      PostListSource._('author', userId);

  /// Posts carrying a hashtag, given without its leading #.
  factory PostListSource.hashtag(String tag) =>
      PostListSource._('hashtag', tag.toLowerCase());

  @override
  bool operator ==(Object other) =>
      other is PostListSource && other.kind == kind && other.userId == userId;

  @override
  int get hashCode => Object.hash(kind, userId);
}

/// A list of posts, as a screen has to render it.
///
/// Every state is explicit. The screen this replaces had exactly one: twenty
/// hard-coded cards, which meant an empty feed, a failed request and a working
/// feed all looked identical.
class FeedState {
  final List<FeedPost> posts;
  final bool isLoadingFirstPage;
  final bool isLoadingMore;

  /// Set when the first page failed; the screen shows this with a retry.
  final String? error;

  /// Null once every page has been read.
  final String? nextCursor;

  const FeedState({
    this.posts = const [],
    this.isLoadingFirstPage = false,
    this.isLoadingMore = false,
    this.error,
    this.nextCursor,
  });

  bool get hasMore => nextCursor != null;

  /// True only once a load has actually finished and found nothing, so the
  /// empty state never flashes before the first page arrives.
  bool get isEmpty => posts.isEmpty && !isLoadingFirstPage && error == null;

  FeedState copyWith({
    List<FeedPost>? posts,
    bool? isLoadingFirstPage,
    bool? isLoadingMore,
    String? error,
    String? nextCursor,
    bool clearError = false,
    bool clearCursor = false,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : (error ?? this.error),
      nextCursor: clearCursor ? null : (nextCursor ?? this.nextCursor),
    );
  }
}

/// One list of posts, whichever list it is.
///
/// The feed, a profile's posts, your likes and your saves differ only in which
/// endpoint they read: same page size, same cursor rules, same states. Written
/// once so a fix to one is a fix to all.
class PostListNotifier extends StateNotifier<FeedState> {
  final Ref _ref;
  final PostListSource _source;

  PostListNotifier(this._ref, this._source) : super(const FeedState()) {
    refresh();
  }

  FeedRepository get _repo => _ref.read(feedRepositoryProvider);

  Future<FeedPage> _page({String? cursor}) {
    switch (_source.kind) {
      case 'liked':
        return _repo.liked(cursor: cursor);
      case 'saved':
        return _repo.saved(cursor: cursor);
      case 'author':
        return _repo.byAuthor(_source.userId!, cursor: cursor);
      case 'hashtag':
        return _repo.byHashtag(_source.userId!, cursor: cursor);
      default:
        return _repo.recent(cursor: cursor);
    }
  }

  /// Loads the first page, replacing whatever is held.
  Future<void> refresh() async {
    state = state.copyWith(isLoadingFirstPage: true, clearError: true);
    try {
      final page = await _page();
      state = FeedState(posts: page.items, nextCursor: page.nextCursor);
    } catch (e) {
      // The session is live here -- these screens are only reachable signed in
      // -- so a 401 is the server refusing a good token, not an expired one.
      state = FeedState(error: describeApiError(e, sessionIsLive: true));
    }
  }

  /// Appends the next page. Safe to call repeatedly while scrolling: it is a
  /// no-op while one is in flight or once the end is reached.
  Future<void> loadMore() async {
    final cursor = state.nextCursor;
    if (cursor == null || state.isLoadingMore || state.isLoadingFirstPage) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    try {
      final page = await _page(cursor: cursor);
      state = state.copyWith(
        posts: <FeedPost>[...state.posts, ...page.items],
        isLoadingMore: false,
        nextCursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
      );
    } catch (_) {
      // A failed page is not a failed list: keep what is on screen and stop
      // paging rather than replacing everything with an error. Pulling to
      // refresh recovers.
      state = state.copyWith(isLoadingMore: false);
    }
  }

  /// Puts a newly written post at the top without a round trip for the page.
  void prepend(FeedPost post) {
    state = state.copyWith(posts: <FeedPost>[post, ...state.posts]);
  }

  /// Drops a post from this list.
  ///
  /// For hiding, muting and blocking: an action whose whole point is "stop
  /// showing me this" that leaves it on screen has not visibly done anything.
  void remove(String postId) {
    state = state.copyWith(
      posts: state.posts.where((p) => p.id != postId).toList(),
    );
  }

  /// Reposts or undoes it, moving the count immediately and putting it back if
  /// the request fails. Returns an error message to show, or null on success.
  Future<String?> toggleRepost(String postId) async {
    final post = _find(postId);
    if (post == null) return null;

    final next = !post.reposted;
    _replace(post.copyWith(
      reposted: next,
      reposts: (post.reposts + (next ? 1 : -1)).clamp(0, 1 << 31),
    ));

    try {
      final reposts = await _repo.setReposted(postId, next);
      final current = _find(postId);
      if (current != null) _replace(current.copyWith(reposts: reposts));
      return null;
    } catch (e) {
      _replace(post);
      return describeApiError(e, sessionIsLive: true);
    }
  }

  /// Likes or unlikes, moving the count immediately and putting it back if the
  /// request fails. Returns an error message to show, or null on success.
  Future<String?> toggleLike(String postId) async {
    final post = _find(postId);
    if (post == null) return null;

    final next = !post.liked;
    _replace(post.copyWith(
      liked: next,
      likes: (post.likes + (next ? 1 : -1)).clamp(0, 1 << 31),
    ));

    try {
      final likes = await _repo.setLiked(postId, next);
      // The server's recount wins: someone else may have liked it too.
      final current = _find(postId);
      if (current != null) _replace(current.copyWith(likes: likes));
      return null;
    } catch (e) {
      _replace(post);
      return describeApiError(e, sessionIsLive: true);
    }
  }

  /// Saves or unsaves. On the saved list an unsave also drops the post, since
  /// leaving it there would show a saved post that is no longer saved.
  Future<String?> toggleSave(String postId) async {
    final post = _find(postId);
    if (post == null) return null;

    final next = !post.saved;
    if (!next && _source.kind == 'saved') {
      state = state.copyWith(
        posts: state.posts.where((p) => p.id != postId).toList(),
      );
    } else {
      _replace(post.copyWith(saved: next));
    }

    try {
      await _repo.setSaved(postId, next);
      return null;
    } catch (e) {
      // Put it back where it was, in its original position on the saved list.
      if (!next && _source.kind == 'saved') {
        await refresh();
      } else {
        _replace(post);
      }
      return describeApiError(e, sessionIsLive: true);
    }
  }

  FeedPost? _find(String id) {
    for (final post in state.posts) {
      if (post.id == id) return post;
    }
    return null;
  }

  void _replace(FeedPost post) {
    state = state.copyWith(
      posts: [
        for (final p in state.posts) p.id == post.id ? post : p,
      ],
    );
  }
}

final postListProvider =
    StateNotifierProvider.family<PostListNotifier, FeedState, PostListSource>(
  (ref, source) => PostListNotifier(ref, source),
);
