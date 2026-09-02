import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/feed_post.dart';
import '../models/profile_summary.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';
import 'feed_provider.dart';

/// Which kind of thing the results are.
enum SearchMode { people, posts }

/// The narrowing options behind the filter button.
///
/// Immutable, and compared by value, so the screen can tell whether anything
/// is actually set without each field being checked at every call site.
class SearchFilters {
  /// A handle, without its leading @. Posts by this account only.
  final String? from;

  /// Posted on or after this date, and before this one.
  final DateTime? after;
  final DateTime? before;

  /// `image`, `video`, `gif` or `link`.
  final String? has;

  const SearchFilters({this.from, this.after, this.before, this.has});

  bool get isEmpty =>
      from == null && after == null && before == null && has == null;

  /// How many are set, for the badge on the filter button.
  int get count => [from, after, before, has].where((f) => f != null).length;

  SearchFilters copyWith({
    String? from,
    DateTime? after,
    DateTime? before,
    String? has,
    bool clearFrom = false,
    bool clearAfter = false,
    bool clearBefore = false,
    bool clearHas = false,
  }) =>
      SearchFilters(
        from: clearFrom ? null : (from ?? this.from),
        after: clearAfter ? null : (after ?? this.after),
        before: clearBefore ? null : (before ?? this.before),
        has: clearHas ? null : (has ?? this.has),
      );

  @override
  bool operator ==(Object other) =>
      other is SearchFilters &&
      other.from == from &&
      other.after == after &&
      other.before == before &&
      other.has == has;

  @override
  int get hashCode => Object.hash(from, after, before, has);
}

/// What the search screen is showing right now.
class SearchState {
  /// The query these results belong to. Used to discard a slow response that
  /// arrived after the box moved on.
  final String query;
  final SearchMode mode;
  final SearchFilters filters;
  final List<ProfileSummary> results;
  final List<FeedPost> posts;
  final bool isSearching;
  final String? error;

  const SearchState({
    this.query = '',
    this.mode = SearchMode.people,
    this.filters = const SearchFilters(),
    this.results = const [],
    this.posts = const [],
    this.isSearching = false,
    this.error,
  });

  /// Below this the server will not search, and saying so beats an empty list.
  static const minimumQueryLength = 2;

  /// A post search can run on filters alone -- everything from one account in
  /// a date range is a complete query with no words in it.
  bool get _needsWords => mode == SearchMode.people || filters.from == null;

  bool get isTooShort =>
      _needsWords &&
      query.trim().length < minimumQueryLength &&
      query.trim().isNotEmpty;

  bool get isIdle => query.trim().isEmpty && (_needsWords || filters.isEmpty);

  bool get foundNothing =>
      !isSearching &&
      error == null &&
      !isIdle &&
      !isTooShort &&
      (mode == SearchMode.people ? results.isEmpty : posts.isEmpty);

  SearchState copyWith({
    String? query,
    SearchMode? mode,
    SearchFilters? filters,
    List<ProfileSummary>? results,
    List<FeedPost>? posts,
    bool? isSearching,
    String? error,
    bool clearError = false,
  }) =>
      SearchState(
        query: query ?? this.query,
        mode: mode ?? this.mode,
        filters: filters ?? this.filters,
        results: results ?? this.results,
        posts: posts ?? this.posts,
        isSearching: isSearching ?? this.isSearching,
        error: clearError ? null : (error ?? this.error),
      );
}

class SearchNotifier extends StateNotifier<SearchState> {
  final Ref _ref;
  Timer? _debounce;

  /// Bumped on every keystroke; a response whose token is stale is dropped.
  int _token = 0;

  SearchNotifier(this._ref) : super(const SearchState());

  /// How long to wait after typing stops. A request per keystroke would send
  /// six for "kyron", five of which are thrown away.
  static const _debounceDelay = Duration(milliseconds: 300);

  void query(String value) {
    state = state.copyWith(query: value);
    _schedule();
  }

  void setMode(SearchMode mode) {
    if (mode == state.mode) return;
    // Results are cleared rather than kept: people and posts are different
    // lists, and showing the previous tab's while the new one loads reads as
    // the switch having done nothing.
    state = state.copyWith(
      mode: mode,
      results: const [],
      posts: const [],
      clearError: true,
    );
    _schedule(immediate: true);
  }

  void setFilters(SearchFilters filters) {
    // Filters only narrow posts, so setting one moves to that tab rather than
    // being silently ignored on the people tab.
    state = state.copyWith(
      filters: filters,
      mode: filters.isEmpty ? state.mode : SearchMode.posts,
      posts: const [],
      clearError: true,
    );
    _schedule(immediate: true);
  }

  void _schedule({bool immediate = false}) {
    _debounce?.cancel();

    if (state.isIdle || state.isTooShort) {
      _token++;
      state = state.copyWith(isSearching: false, clearError: true);
      return;
    }

    state = state.copyWith(isSearching: true, clearError: true);
    final token = ++_token;

    if (immediate) {
      unawaited(_run(token));
    } else {
      _debounce = Timer(_debounceDelay, () => unawaited(_run(token)));
    }
  }

  Future<void> _run(int token) async {
    final snapshot = state;
    try {
      if (snapshot.mode == SearchMode.people) {
        final api = _ref.read(apiClientProvider);
        final res = await api.dio.get<Map<String, dynamic>>(
          '/profile/search',
          queryParameters: {'q': snapshot.query.trim(), 'limit': 30},
        );
        if (token != _token) return;

        final items = ((res.data?['items'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProfileSummary.fromJson)
            .toList();
        state = state.copyWith(results: items, isSearching: false);
      } else {
        final page = await _ref.read(feedRepositoryProvider).search(
              query: snapshot.query.trim(),
              from: snapshot.filters.from,
              after: snapshot.filters.after,
              before: snapshot.filters.before,
              has: snapshot.filters.has,
            );
        if (token != _token) return;
        state = state.copyWith(posts: page.items, isSearching: false);
      }
    } catch (e) {
      if (token != _token) return;
      state = state.copyWith(
        isSearching: false,
        error: describeApiError(e, sessionIsLive: true),
      );
    }
  }

  /// Re-runs the current query, for the retry button on a failed search.
  void retry() => _schedule(immediate: true);

  /// Swaps in a post after something on it changed, so a poll vote or a like
  /// from the results does not need the search re-running.
  void replacePost(FeedPost post) {
    state = state.copyWith(
      posts: [
        for (final existing in state.posts)
          existing.id == post.id ? post : existing,
      ],
    );
  }

  void clear() {
    _debounce?.cancel();
    _token++;
    state = SearchState(mode: state.mode);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(ref);
});
