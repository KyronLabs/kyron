import '../l10n/app_localizations.dart';

// lib/screens/communities_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../providers/current_user_provider.dart';
import '../providers/preferences_provider.dart';
import '../routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_v4.dart';
import '../widgets/community_cards.dart';
import '../widgets/empty_state.dart';
import '../widgets/list_controls.dart';
import 'community_composer_screen.dart';
import '../widgets/simple_app_bar.dart';

/// The communities the reader is in, one row each, the one with the newest
/// post at the top -- and the ones they could join, behind a chip.
///
/// Laid out like Messages, because it is the same kind of list: places where
/// something happens, each saying what happened last and how much is new. It
/// was two tabs of names and member counts, which read the same every time it
/// was opened, so nobody had a reason to open it.
///
/// No feed of posts here. Home already carries every post from the reader's
/// communities, and a second feed of the same posts would be Home with less
/// in it; each row says what is new and one tap reads it in its place.
class CommunitiesScreen extends ConsumerStatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double progress) onScrollProgress;

  const CommunitiesScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  ConsumerState<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends ConsumerState<CommunitiesScreen> {
  bool _hidden = false;

  /// Which of the reader's communities the list shows, from the filter menu.
  CommunityFilter _filter = CommunityFilter.all;

  /// Communities to join instead, from their own chip.
  bool _discovering = false;

  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _onScroll(UserScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification.direction == ScrollDirection.reverse && !_hidden) {
      _hidden = true;
      widget.onScrollProgress(1);
    } else if (notification.direction == ScrollDirection.forward && _hidden) {
      _hidden = false;
      widget.onScrollProgress(0);
    }
    return false;
  }

  Future<void> _chooseFilter(BuildContext chip) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showListFilterMenu<CommunityFilter>(
      context: context,
      anchor: chip,
      title: l10n.ui('ui_dm_filter', 'Filter'),
      options: CommunityFilter.values,
      current: _filter,
      label: (filter) => _filterName(l10n, filter),
      keyOf: (filter) => ValueKey('community-filter-${filter.name}'),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _filter = picked;
      _discovering = false;
    });
  }

  static String _filterName(AppLocalizations l10n, CommunityFilter f) =>
      switch (f) {
        CommunityFilter.all => l10n.ui('ui_dm_filter_all', 'All'),
        CommunityFilter.unread =>
          l10n.ui('ui_community_filter_new', 'New posts'),
        CommunityFilter.running =>
          l10n.ui('ui_community_filter_running', 'Yours to run'),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = _filter != CommunityFilter.all && !_discovering;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: l10n.communities,
            onAvatarTap: () => widget.drawerKey.currentState?.toggleDrawer(),
            actions: [
              SimpleBarAction(
                key: const ValueKey('communities-new'),
                icon: Iconsax.add_square_copy,
                tooltip: l10n.ui('ui_community_new', 'New community'),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.newCommunity),
              ),
              SimpleBarAction(
                key: const ValueKey('communities-settings'),
                icon: Iconsax.setting_2_copy,
                tooltip: l10n.ui(
                  'ui_community_settings_open',
                  'Community settings',
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.communitySettings),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space16,
            SpacingTokens.space4,
            SpacingTokens.space16,
            SpacingTokens.space8,
          ),
          child: ListSearchField(
            fieldKey: const ValueKey('communities-search'),
            controller: _search,
            hint: _discovering
                ? l10n.searchCommunities
                : l10n.ui('ui_share_search', 'Search'),
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            children: [
              Builder(
                builder: (chip) => ListChip(
                  key: const ValueKey('communities-filter'),
                  selected: filtered,
                  onTap: () => _chooseFilter(chip),
                  icon: Iconsax.filter_copy,
                  label: filtered ? _filterName(l10n, _filter) : null,
                  tooltip: l10n.ui('ui_dm_filter', 'Filter'),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              ListChip(
                key: const ValueKey('communities-discover'),
                selected: _discovering,
                onTap: () => setState(() => _discovering = !_discovering),
                label: l10n.ui('ui_community_discover', 'Discover'),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        Expanded(
          child: ColoredBox(
            color: communityPageColor(context),
            child: NotificationListener<UserScrollNotification>(
              onNotification: _onScroll,
              // The bar above is a sibling inside its own SafeArea, so the
              // status bar inset is still on the MediaQuery down here.
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: _discovering
                    ? _DiscoverList(query: _search.text.trim())
                    : _MyList(
                        key: ValueKey(_filter),
                        filter: _filter,
                        query: _search.text.trim(),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// How much room a list leaves under itself for the bottom bar.
double _listFootroom(BuildContext context) =>
    BottomNavV4.height +
    MediaQuery.paddingOf(context).bottom +
    SpacingTokens.space16;

/// The reader's own communities, narrowed by the search box.
class _MyList extends ConsumerStatefulWidget {
  final CommunityFilter filter;
  final String query;

  const _MyList({super.key, required this.filter, required this.query});

  @override
  ConsumerState<_MyList> createState() => _MyListState();
}

class _MyListState extends ConsumerState<_MyList> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 400) {
      ref.read(myCommunitiesProvider(widget.filter).notifier).loadMore();
    }
  }

  Future<void> _open(Community community) async {
    await Navigator.pushNamed(
      context,
      Routes.community,
      arguments: community.slug,
    );
    // Whatever was posted while it was open, by the reader or anybody else,
    // belongs at the top of the list now.
    if (mounted) await refreshMyCommunities(ref);
  }

  /// Straight to writing in it, from the card, without opening it first.
  Future<void> _write(Community community) async {
    final posted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CommunityComposerScreen(community: community),
      ),
    );
    if (posted == true && mounted) await refreshMyCommunities(ref);
  }

  bool _matches(Community community) {
    final query = widget.query.toLowerCase();
    if (query.isEmpty) return true;
    return community.name.toLowerCase().contains(query) ||
        community.slug.contains(query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(myCommunitiesProvider(widget.filter));
    final notifier = ref.read(myCommunitiesProvider(widget.filter).notifier);
    final me = ref.watch(currentUserProvider).asData?.value.id;
    final counts = ref.watch(preferencesProvider).communityCounts;

    if (state.loadingFirstPage) return const CommunityCardsSkeleton();

    final shown = state.items.where(_matches).toList();

    EmptyState empty() {
      if (state.error != null && state.items.isEmpty) {
        return EmptyState.failed(
          title: l10n.literalcouldNotLoadYourCommunities,
          detail: state.error,
          onAction: notifier.refresh,
        );
      }
      if (state.items.isNotEmpty) {
        return EmptyState(
          art: EmptyArt.noMatch,
          title: l10n.ui('ui_community_search_none', 'No communities match.'),
        );
      }
      return switch (widget.filter) {
        CommunityFilter.all => EmptyState(
            art: EmptyArt.communities,
            title: l10n.literalyouAreNotInAnyCommunities,
            detail: l10n.communitiesEmptyDetail,
            action: l10n.literalstartACommunity,
            onAction: () => Navigator.pushNamed(context, Routes.newCommunity),
          ),
        CommunityFilter.unread => EmptyState(
            art: EmptyArt.communities,
            title: l10n.ui('ui_community_new_none', 'Nothing new'),
            detail: l10n.ui(
              'ui_community_new_none_detail',
              'Every community is as you left it.',
            ),
          ),
        CommunityFilter.running => EmptyState(
            art: EmptyArt.communities,
            title: l10n.ui('ui_community_running_none', 'You run none yet'),
            detail: l10n.ui(
              'ui_community_running_none_detail',
              'Communities you start, or moderate, are listed here.',
            ),
          ),
      };
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: shown.isEmpty
          ? empty().scrollable
          : ListView.separated(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                SpacingTokens.space4,
                SpacingTokens.space16,
                _listFootroom(context),
              ),
              itemCount: shown.length + (state.loadingMore ? 1 : 0),
              separatorBuilder: (_, __) =>
                  const SizedBox(height: SpacingTokens.space12),
              itemBuilder: (context, index) {
                if (index >= shown.length) {
                  return const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final community = shown[index];
                return CommunityCard(
                  community: community,
                  mine: me != null && community.lastPost?.authorId == me,
                  showCount: counts,
                  onOpen: () => _open(community),
                  onWrite: () => _write(community),
                );
              },
            ),
    );
  }
}

/// Communities the reader is not in, busiest first, searched on the server
/// as the box is typed into.
class _DiscoverList extends ConsumerStatefulWidget {
  final String query;

  const _DiscoverList({required this.query});

  @override
  ConsumerState<_DiscoverList> createState() => _DiscoverListState();
}

class _DiscoverListState extends ConsumerState<_DiscoverList> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(discoverCommunitiesProvider.notifier);
    if (notifier.query != widget.query) {
      // After the first frame: a provider may not be changed while the
      // widget tree is being built.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) notifier.search(widget.query);
      });
    }
  }

  @override
  void didUpdateWidget(_DiscoverList old) {
    super.didUpdateWidget(old);
    if (old.query == widget.query) return;
    // Not a request per keystroke.
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        ref.read(discoverCommunitiesProvider.notifier).search(widget.query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(discoverCommunitiesProvider);
    final notifier = ref.read(discoverCommunitiesProvider.notifier);

    if (state.loadingFirstPage) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.items.isEmpty
          ? (state.error != null
                  ? EmptyState.failed(
                      title: l10n.literalcouldNotLoadCommunities,
                      detail: state.error,
                      onAction: notifier.refresh,
                    )
                  : EmptyState(
                      art: notifier.query.isEmpty
                          ? EmptyArt.communities
                          : EmptyArt.noMatch,
                      title: notifier.query.isEmpty
                          ? l10n.ui(
                              'ui_community_discover_none',
                              'Nothing left to join',
                            )
                          : l10n.ui(
                              'ui_community_search_none',
                              'No communities match.',
                            ),
                      detail: notifier.query.isEmpty
                          ? l10n.ui(
                              'ui_community_discover_none_detail',
                              'You are in every community on Kyron. Start '
                                  'another one.',
                            )
                          : l10n.ui(
                              'ui_community_discover_search_detail',
                              'Try a different word, or start a community by '
                                  'that name.',
                            ),
                      action: l10n.literalstartACommunity,
                      onAction: () =>
                          Navigator.pushNamed(context, Routes.newCommunity),
                    ))
              .scrollable
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                SpacingTokens.space4,
                SpacingTokens.space16,
                _listFootroom(context),
              ),
              itemCount: state.items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: SpacingTokens.space12),
              itemBuilder: (context, index) {
                final community = state.items[index];
                return DiscoverCommunityCard(
                  key: ValueKey('discover-${community.id}'),
                  community: community,
                  onOpen: () => Navigator.pushNamed(
                    context,
                    Routes.community,
                    arguments: community.slug,
                  ),
                  onJoined: (joined) {
                    notifier.joined(joined.id);
                    ref
                        .read(
                            myCommunitiesProvider(CommunityFilter.all).notifier)
                        .add(joined);
                  },
                );
              },
            ),
    );
  }
}
