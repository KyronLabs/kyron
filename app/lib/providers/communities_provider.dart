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

/// The communities the reader is in.
class MyCommunitiesNotifier extends StateNotifier<CommunityListState> {
  final CommunitiesRepository _repo;

  MyCommunitiesNotifier(this._repo) : super(const CommunityListState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const CommunityListState();
    try {
      final page = await _repo.mine();
      state = CommunityListState(
        items: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = CommunityListState(
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
      final page = await _repo.mine(cursor: cursor);
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

  /// Puts one at the top after it has been joined or started, so the tab shows
  /// it without a round trip.
  void add(Community community) {
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
}

final myCommunitiesProvider =
    StateNotifierProvider<MyCommunitiesNotifier, CommunityListState>(
  (ref) => MyCommunitiesNotifier(ref.read(communitiesRepositoryProvider)),
);

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

  CommunityNotifier(this._repo, this._slug) : super(const CommunityState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const CommunityState();
    try {
      state = CommunityState(
        community: await _repo.bySlug(_slug),
        loading: false,
      );
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
  (ref, slug) =>
      CommunityNotifier(ref.read(communitiesRepositoryProvider), slug),
);
