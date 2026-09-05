// lib/screens/follow_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/api_client_provider.dart';
import '../repositories/profile_repository.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/list_message.dart';
import '../widgets/person_tile.dart';
import 'profile_screen.dart' show FollowListArgs;

/// One page of a follow list, plus where the next one starts.
class FollowListState {
  final List<ProfileSummary> people;
  final String? cursor;
  final bool loadingFirstPage;
  final bool loadingMore;
  final String? error;

  const FollowListState({
    this.people = const [],
    this.cursor,
    this.loadingFirstPage = true,
    this.loadingMore = false,
    this.error,
  });

  /// True once the server has answered without a cursor: there is no more.
  bool get atEnd => cursor == null && !loadingFirstPage;

  FollowListState copyWith({
    List<ProfileSummary>? people,
    String? cursor,
    bool? loadingFirstPage,
    bool? loadingMore,
    String? error,
    bool clearError = false,
    bool clearCursor = false,
  }) =>
      FollowListState(
        people: people ?? this.people,
        cursor: clearCursor ? null : (cursor ?? this.cursor),
        loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
        loadingMore: loadingMore ?? this.loadingMore,
        error: clearError ? null : (error ?? this.error),
      );
}

class FollowListNotifier extends StateNotifier<FollowListState> {
  final ProfileRepository _repo;
  final FollowListArgs _args;

  FollowListNotifier(this._repo, this._args) : super(const FollowListState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const FollowListState();
    try {
      final page = await _repo.follows(
        _args.userId,
        followers: _args.followers,
      );
      state = FollowListState(
        people: page.items,
        cursor: page.nextCursor,
        loadingFirstPage: false,
      );
    } catch (error) {
      state = FollowListState(
        loadingFirstPage: false,
        error: describeApiError(error, sessionIsLive: true),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.cursor;
    // Guarded on all three: the scroll listener fires on every frame near the
    // end, and without this each one starts another request for the same page.
    if (cursor == null || state.loadingMore || state.loadingFirstPage) return;

    state = state.copyWith(loadingMore: true);
    try {
      final page = await _repo.follows(
        _args.userId,
        followers: _args.followers,
        cursor: cursor,
      );
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

  /// Replaces one row after its Follow button has been used, so the list does
  /// not have to be reloaded to show the change.
  void replace(ProfileSummary person) {
    state = state.copyWith(
      people: [
        for (final existing in state.people)
          existing.id == person.id ? person : existing,
      ],
    );
  }
}

final followListProvider = StateNotifierProvider.family<FollowListNotifier,
    FollowListState, FollowListArgs>((ref, args) {
  return FollowListNotifier(
    ProfileRepository(ref.read(apiClientProvider)),
    args,
  );
});

/// Who follows an account, or who it follows.
class FollowListScreen extends ConsumerStatefulWidget {
  final FollowListArgs args;

  const FollowListScreen({super.key, required this.args});

  @override
  ConsumerState<FollowListScreen> createState() => _FollowListScreenState();
}

class _FollowListScreenState extends ConsumerState<FollowListScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_maybeLoadMore);
    _controller.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.maxScrollExtent - position.pixels > 400) return;
    ref.read(followListProvider(widget.args).notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(followListProvider(widget.args));
    final notifier = ref.read(followListProvider(widget.args).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(widget.args.followers ? 'Followers' : 'Following'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(
              left: SpacingTokens.space16,
              bottom: SpacingTokens.space8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.args.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: notifier.refresh,
        child: _body(state, notifier),
      ),
    );
  }

  Widget _body(FollowListState state, FollowListNotifier notifier) {
    if (state.loadingFirstPage) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.people.isEmpty) {
      final failed = state.error != null;
      // A ListView, not a bare Column: pull-to-refresh needs something
      // scrollable under it, and a centred column is not.
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ListMessage(
            icon: failed ? Iconsax.cloud_cross_copy : Iconsax.people_copy,
            title: state.error ??
                (widget.args.followers
                    ? 'Nobody is following this account yet.'
                    : 'This account is not following anyone yet.'),
            action: failed ? 'Try again' : null,
            onAction: failed ? notifier.refresh : null,
          ),
        ],
      );
    }

    return ListView.separated(
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.people.length + (state.loadingMore ? 1 : 0),
      separatorBuilder: (_, __) => Divider(
        height: 1,
        thickness: 0.5,
        indent: 72,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
      ),
      itemBuilder: (context, index) {
        if (index >= state.people.length) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final person = state.people[index];
        return PersonTile(
          person: person,
          onChanged: notifier.replace,
          onOpen: () => openProfile(
            context,
            username: person.username,
            userId: person.id,
          ),
        );
      },
    );
  }
}
