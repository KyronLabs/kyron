// lib/providers/explore_provider.dart
import 'package:flutter_riverpod/legacy.dart';

import '../models/explore_entry.dart';
import '../models/profile_summary.dart';
import '../repositories/feed_repository.dart';
import '../repositories/profile_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';
import 'feed_provider.dart';

/// A list that is read once and shown whole.
///
/// Every state is separate. The Explore page this replaces had none of them:
/// twenty numbered placeholders, which meant an empty network, a failed
/// request and a working one all looked the same.
class ExploreList<T> {
  final List<T> items;
  final bool loading;
  final String? error;

  const ExploreList({
    this.items = const [],
    this.loading = true,
    this.error,
  });

  bool get isEmpty => !loading && error == null && items.isEmpty;
}

/// The hashtags being used right now.
class TrendingNotifier extends StateNotifier<ExploreList<TrendingTag>> {
  final FeedRepository _repo;

  TrendingNotifier(this._repo) : super(const ExploreList()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const ExploreList();
    try {
      state = ExploreList(items: await _repo.trendingTags(), loading: false);
    } catch (error) {
      state = ExploreList(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }
}

final trendingProvider =
    StateNotifierProvider<TrendingNotifier, ExploreList<TrendingTag>>((ref) {
  return TrendingNotifier(ref.read(feedRepositoryProvider));
});

/// The topic catalogue, and which of them the reader is into.
class TopicsNotifier extends StateNotifier<ExploreList<Topic>> {
  final ProfileRepository _repo;

  TopicsNotifier(this._repo) : super(const ExploreList()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const ExploreList();
    try {
      state = ExploreList(items: await _repo.topics(), loading: false);
    } catch (error) {
      state = ExploreList(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Follows or unfollows one topic.
  ///
  /// Moved on screen first and put back if the request fails, so a tap is
  /// answered at once rather than after a round trip. Returns an error to show,
  /// or null.
  Future<String?> toggle(Topic topic) async {
    final next = !topic.following;
    _replace(
      topic.copyWith(
        following: next,
        people: (topic.people + (next ? 1 : -1)).clamp(0, 1 << 31),
      ),
    );

    try {
      final people = await _repo.setTopic(topic.slug, next);
      // The server's recount wins: other people are choosing topics too.
      final current = _find(topic.slug);
      if (current != null) _replace(current.copyWith(people: people));
      return null;
    } catch (error) {
      _replace(topic);
      return describeApiError(error, sessionIsLive: true);
    }
  }

  Topic? _find(String slug) {
    for (final topic in state.items) {
      if (topic.slug == slug) return topic;
    }
    return null;
  }

  void _replace(Topic topic) {
    state = ExploreList(
      items: [
        for (final existing in state.items)
          existing.slug == topic.slug ? topic : existing,
      ],
      loading: state.loading,
      error: state.error,
    );
  }
}

final topicsProvider =
    StateNotifierProvider<TopicsNotifier, ExploreList<Topic>>((ref) {
  return TopicsNotifier(ProfileRepository(ref.read(apiClientProvider)));
});

/// Accounts worth following, best match first.
class SuggestedPeopleState {
  final List<ProfileSummary> people;
  final int? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  const SuggestedPeopleState({
    this.people = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  bool get isEmpty => !loadingFirstPage && error == null && people.isEmpty;

  SuggestedPeopleState copyWith({
    List<ProfileSummary>? people,
    int? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
  }) =>
      SuggestedPeopleState(
        people: people ?? this.people,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

class SuggestedPeopleNotifier extends StateNotifier<SuggestedPeopleState> {
  final ProfileRepository _repo;

  SuggestedPeopleNotifier(this._repo) : super(const SuggestedPeopleState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const SuggestedPeopleState();
    try {
      final page = await _repo.suggested();
      state = SuggestedPeopleState(
        people: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = SuggestedPeopleState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.cursor;
    // Guarded on all three: the scroll listener fires on every frame near the
    // end, and without this each one asks for the same page again.
    if (cursor == null || state.loadingMore || state.loadingFirstPage) return;

    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.suggested(cursor: cursor);
      state = state.copyWith(
        people: [...state.people, ...page.items],
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

  /// Drops whoever has just been followed.
  ///
  /// A suggestion is an account the reader does not follow, so one they now do
  /// is not a suggestion any more. Leaving it in place with a Following button
  /// on it would be a list that never gets shorter however much you use it.
  void followed(ProfileSummary person) {
    state = state.copyWith(
      people: [
        for (final existing in state.people)
          if (existing.id != person.id) existing,
      ],
    );
  }
}

final suggestedPeopleProvider =
    StateNotifierProvider<SuggestedPeopleNotifier, SuggestedPeopleState>((ref) {
  return SuggestedPeopleNotifier(
      ProfileRepository(ref.read(apiClientProvider)));
});
