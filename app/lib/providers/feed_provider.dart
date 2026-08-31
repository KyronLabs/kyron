import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/feed_post.dart';
import '../repositories/feed_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

final feedRepositoryProvider = Provider<FeedRepository>(
  (ref) => FeedRepository(ref.read(apiClientProvider)),
);

/// The feed, as a screen has to render it.
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

class FeedNotifier extends StateNotifier<FeedState> {
  final Ref _ref;

  FeedNotifier(this._ref) : super(const FeedState()) {
    refresh();
  }

  FeedRepository get _repo => _ref.read(feedRepositoryProvider);

  /// Loads the first page, replacing whatever is held.
  Future<void> refresh() async {
    state = state.copyWith(isLoadingFirstPage: true, clearError: true);
    try {
      final page = await _repo.recent();
      state = FeedState(
        posts: page.items,
        nextCursor: page.nextCursor,
      );
    } catch (e) {
      // The session is live here -- the screen is only reachable signed in --
      // so a 401 is the server refusing a good token, not an expired one.
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
      final page = await _repo.recent(cursor: cursor);
      state = state.copyWith(
        posts: [...state.posts, ...page.items],
        isLoadingMore: false,
        nextCursor: page.nextCursor,
        clearCursor: page.nextCursor == null,
      );
    } catch (_) {
      // A failed page is not a failed feed: keep what is on screen and stop
      // paging rather than replacing everything with an error. Scrolling up
      // and pulling to refresh recovers.
      state = state.copyWith(isLoadingMore: false);
    }
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>(
  (ref) => FeedNotifier(ref),
);
