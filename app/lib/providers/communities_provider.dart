// lib/providers/communities_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/community.dart';
import '../repositories/communities_repository.dart';
import '../utils/api_error_message.dart';
import 'api_client_provider.dart';

final communitiesRepositoryProvider = Provider<CommunitiesRepository>(
  (ref) => CommunitiesRepository(ref.read(apiClientProvider)),
);

class CommunityListState {
  final List<Community> items;
  final String? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  const CommunityListState({
    this.items = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  bool get isEmpty => !loadingFirstPage && error == null && items.isEmpty;

  CommunityListState copyWith({
    List<Community>? items,
    String? cursor,
    bool clearCursor = false,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
  }) =>
      CommunityListState(
        items: items ?? this.items,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

/// The communities the reader is in, the one with the newest post first --
/// all of them, or those with something new, or those they run.
class MyCommunitiesNotifier extends StateNotifier<CommunityListState> {
  final CommunitiesRepository _repo;
  final CommunityFilter filter;

  MyCommunitiesNotifier(this._repo, {this.filter = CommunityFilter.all})
      : super(const CommunityListState()) {
    refresh();
  }

  /// Reads the first page again. [quiet] keeps what is on screen while it
  /// does, for coming back to the list rather than opening it.
  Future<void> refresh({bool quiet = false}) async {
    if (!quiet || state.items.isEmpty) state = const CommunityListState();
    try {
      final page = await _repo.mine(filter: filter);
      state = CommunityListState(
        items: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = quiet && state.items.isNotEmpty
          ? state.copyWith(loadingFirstPage: false)
          : CommunityListState(
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
      final page = await _repo.mine(cursor: cursor, filter: filter);
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

  /// Puts one at the top after it has been joined or started, so the list
  /// shows it without a round trip.
  void add(Community community) {
    if (filter != CommunityFilter.all) return;
    if (state.items.any((c) => c.id == community.id)) return;
    state = state.copyWith(items: [community, ...state.items]);
  }

  void remove(String id) {
    state = state.copyWith(
      items: [
        for (final c in state.items)
          if (c.id != id) c,
      ],
    );
  }

  /// The reader has opened it: nothing in it is new any more. Off the
  /// Unread list altogether, since that list is what has something new.
  void seen(String id) {
    if (filter == CommunityFilter.unread) {
      remove(id);
      return;
    }
    state = state.copyWith(
      items: [
        for (final c in state.items) c.id == id ? c.copyWith(unread: 0) : c,
      ],
    );
  }
}

final myCommunitiesProvider = StateNotifierProvider.family<
    MyCommunitiesNotifier, CommunityListState, CommunityFilter>(
  (ref, filter) => MyCommunitiesNotifier(
    ref.read(communitiesRepositoryProvider),
    filter: filter,
  ),
);

/// Reads every list of the reader's communities again, quietly: All always,
/// and whichever filtered lists have been opened.
Future<void> refreshMyCommunities(WidgetRef ref) => Future.wait([
      for (final filter in CommunityFilter.values)
        if (filter == CommunityFilter.all ||
            ref.exists(myCommunitiesProvider(filter)))
          ref.read(myCommunitiesProvider(filter).notifier).refresh(quiet: true),
    ]);

/// Communities the reader is not in, busiest first, optionally searched.
class DiscoverCommunitiesNotifier extends StateNotifier<CommunityListState> {
  final CommunitiesRepository _repo;

  DiscoverCommunitiesNotifier(this._repo) : super(const CommunityListState()) {
    refresh();
  }

  String _query = '';

  String get query => _query;

  Future<void> search(String query) async {
    _query = query;
    await refresh();
  }

  Future<void> refresh() async {
    state = const CommunityListState();
    try {
      final page = await _repo.discover(query: _query);
      state = CommunityListState(items: page.items, loadingFirstPage: false);
    } catch (error) {
      state = CommunityListState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Drops one that has just been joined: Discover is what the reader is *not*
  /// in, so a joined community sitting there with a Joined button is a shelf
  /// that never gets shorter.
  void joined(String id) {
    state = state.copyWith(
      items: [
        for (final c in state.items)
          if (c.id != id) c,
      ],
    );
  }
}

final discoverCommunitiesProvider =
    StateNotifierProvider<DiscoverCommunitiesNotifier, CommunityListState>(
  (ref) => DiscoverCommunitiesNotifier(ref.read(communitiesRepositoryProvider)),
);

/// One community, for its own screen.
class CommunityState {
  final Community? community;
  final bool loading;
  final bool busy;
  final String? error;

  const CommunityState({
    this.community,
    this.loading = true,
    this.busy = false,
    this.error,
  });
}

class CommunityNotifier extends StateNotifier<CommunityState> {
  final CommunitiesRepository _repo;
  final String _slug;

  /// Told when a member has opened it, so their count of new posts can start
  /// again. Not for somebody who is not in it: they have no count.
  final void Function(Community community)? onOpened;

  CommunityNotifier(this._repo, this._slug, {this.onOpened})
      : super(const CommunityState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const CommunityState();
    try {
      final community = await _repo.bySlug(_slug);
      state = CommunityState(community: community, loading: false);
      if (community.joined) onOpened?.call(community);
    } catch (error) {
      state = CommunityState(
        loading: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  /// Joins or leaves. Returns an error to show, or null.
  Future<String?> toggleMembership() async {
    final current = state.community;
    if (current == null) return null;
    if (current.joined && !(current.role?.canLeave ?? true)) {
      return 'You started this community, so you cannot leave it.';
    }

    state = CommunityState(community: current, loading: false, busy: true);
    try {
      final next = await _repo.setMembership(_slug, !current.joined);
      state = CommunityState(community: next, loading: false);
      return null;
    } catch (error) {
      state = CommunityState(community: current, loading: false);
      return describeApiError(error, sessionIsLive: true);
    }
  }
}

final communityProvider =
    StateNotifierProvider.family<CommunityNotifier, CommunityState, String>(
  (ref, slug) {
    final repo = ref.read(communitiesRepositoryProvider);
    return CommunityNotifier(
      repo,
      slug,
      onOpened: (community) {
        // The count goes at once on every list that is showing it; the
        // server is told behind that, and a failure only means the count
        // comes back next time the list is read.
        for (final filter in CommunityFilter.values) {
          if (ref.exists(myCommunitiesProvider(filter))) {
            ref.read(myCommunitiesProvider(filter).notifier).seen(community.id);
          }
        }
        repo.markRead(community.slug).catchError((Object _) {});
      },
    );
  },
);
