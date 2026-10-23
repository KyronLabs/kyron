// lib/screens/explore_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart';
import '../models/explore_entry.dart';
import '../models/profile_summary.dart';
import '../providers/communities_provider.dart';
import '../providers/explore_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/profile_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_v4.dart';
import '../widgets/community_rows.dart';
import '../widgets/empty_state.dart';
import '../widgets/list_controls.dart';
import '../widgets/media_tile_grid.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/skeleton.dart';
import '../widgets/toast.dart';

/// What is on Kyron that the reader has not found yet, on one page.
///
/// It was three tabs -- trending hashtags, a topic catalogue, people -- and
/// all three were thin: the catalogue was empty, almost every "trending" tag
/// had been used once, and the people were a tab away. Meanwhile two posts in
/// three carry a picture or a clip, and Explore showed none of them.
///
/// So: a search box, because Explore is where people go looking; short
/// sideways strips of people and communities, because at this size finding
/// them is most of what discovery is; the tags actually being used, when
/// there are any; and under it all, an endless grid of what people post.
class ExploreScreen extends ConsumerStatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double progress) onScrollProgress;

  const ExploreScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final ScrollController _scroll = ScrollController();

  /// Whether the bottom bar has been hidden. Toggled rather than reported per
  /// frame: the container animates on the change, not on the offset.
  bool _hidden = false;

  static const _grid = PostListSource.explore;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScrolled);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScrolled);
    _scroll.dispose();
    super.dispose();
  }

  void _onScrolled() {
    if (!_scroll.hasClients) return;
    final position = _scroll.position;
    if (position.pixels >= position.maxScrollExtent - 600) {
      ref.read(postListProvider(_grid).notifier).loadMore();
    }
  }

  /// Hides the bottom bar going down, brings it back coming up. Vertical
  /// only: the strips scroll sideways, and that is not what hides a bar.
  bool _onScroll(UserScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    final direction = notification.direction;
    if (direction == ScrollDirection.reverse && !_hidden) {
      _hidden = true;
      widget.onScrollProgress(1);
    } else if (direction == ScrollDirection.forward && _hidden) {
      _hidden = false;
      widget.onScrollProgress(0);
    }
    return false;
  }

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(postListProvider(_grid).notifier).refresh(),
      ref.read(suggestedPeopleProvider.notifier).refresh(),
      ref.read(discoverCommunitiesProvider.notifier).refresh(),
      ref.read(trendingProvider.notifier).refresh(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final grid = ref.watch(postListProvider(_grid));

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: l10n.explore,
            onAvatarTap: () => widget.drawerKey.currentState?.toggleDrawer(),
            // Settings only: search is the box right under the bar, and a
            // magnifying glass beside a search box is the same thing twice.
            actions: [
              SimpleBarAction(
                icon: Iconsax.setting_2_copy,
                tooltip: l10n.settings,
                onPressed: () => Navigator.pushNamed(context, Routes.settings),
              ),
            ],
          ),
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onScroll,
            // The bar above sits in its own SafeArea as a sibling, so the
            // status bar inset is still on the MediaQuery down here.
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: CustomScrollView(
                  key: const ValueKey('explore-scroll'),
                  controller: _scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: _SearchBox()),
                    const SliverToBoxAdapter(child: _PeopleStrip()),
                    const SliverToBoxAdapter(child: _CommunityStrip()),
                    const SliverToBoxAdapter(child: _TagStrip()),
                    SliverToBoxAdapter(
                      child: _Heading(
                        l10n.ui('ui_dm_media_tab', 'Photos and clips'),
                      ),
                    ),
                    ..._gridSlivers(context, grid),
                    SliverToBoxAdapter(
                      // Clear of the bottom bar, which floats over the page.
                      child: SizedBox(
                        height: BottomNavV4.height +
                            MediaQuery.paddingOf(context).bottom +
                            SpacingTokens.space16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _gridSlivers(BuildContext context, FeedState grid) {
    final l10n = AppLocalizations.of(context);
    if (grid.isLoadingFirstPage && grid.posts.isEmpty) {
      return const [_GridSkeleton()];
    }
    if (grid.error != null && grid.posts.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState.failed(
            title: l10n.literalcouldNotLoadThesePosts,
            detail: grid.error,
            onAction: ref.read(postListProvider(_grid).notifier).refresh,
          ),
        ),
      ];
    }
    if (grid.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            art: EmptyArt.trending,
            title: l10n.ui('ui_explore_grid_empty', 'Nothing to look at yet'),
            detail: l10n.ui(
              'ui_explore_grid_empty_detail',
              'Photos and clips people post will show up here.',
            ),
          ),
        ),
      ];
    }
    return [
      MediaTileGrid(
        key: const ValueKey('explore-grid'),
        posts: grid.posts,
        columns: 3,
        compact: true,
        // On the page's gutter, under the heading, like the strips above.
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space4,
          SpacingTokens.space16,
          SpacingTokens.space4,
        ),
      ),
      if (grid.isLoadingMore)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ];
  }
}

/// A search box that opens search: the full screen, with its filters, is
/// where typing happens. This only has to look like what it is.
class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space4,
        SpacingTokens.space16,
        SpacingTokens.space8,
      ),
      child: Semantics(
        button: true,
        label: l10n.ui('ui_explore_search', 'Search people and posts'),
        excludeSemantics: true,
        child: Material(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(RadiusTokens.radius20),
          child: InkWell(
            key: const ValueKey('explore-search'),
            borderRadius: BorderRadius.circular(RadiusTokens.radius20),
            onTap: () => Navigator.pushNamed(context, Routes.search),
            child: SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space12,
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.search_normal_1_copy,
                      size: 18,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: SpacingTokens.space8),
                    Expanded(
                      child: Text(
                        l10n.ui('ui_explore_search', 'Search people and posts'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize3,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A section's name, over its strip or the grid.
class _Heading extends StatelessWidget {
  final String text;

  const _Heading(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space16,
        SpacingTokens.space16,
        SpacingTokens.space8,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: TypographyTokens.fontSize4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// A row of cards that scrolls sideways, under a heading.
class _Strip extends StatelessWidget {
  final String title;
  final double height;
  final int count;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Key? listKey;

  const _Strip({
    required this.title,
    required this.height,
    required this.count,
    required this.itemBuilder,
    this.listKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(title),
        SizedBox(
          height: height,
          child: ListView.separated(
            key: listKey,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            itemCount: count,
            separatorBuilder: (_, __) =>
                const SizedBox(width: SpacingTokens.space8),
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}

/// The card both strips are made of: the same size, the same hairline, the
/// same button at the foot, so the two read as one kind of thing.
class _Card extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final List<Widget> children;

  const _Card({
    super.key,
    required this.width,
    required this.onTap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.18)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space12),
            child: Column(children: children),
          ),
        ),
      ),
    );
  }
}

const double _cardWidth = 148;

/// People to follow. Gone from the page once there is nobody left to
/// suggest, rather than a heading over nothing.
class _PeopleStrip extends ConsumerWidget {
  const _PeopleStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(suggestedPeopleProvider);
    if (state.loadingFirstPage) return const _StripSkeleton();
    if (state.people.isEmpty) return const SizedBox.shrink();

    return _Strip(
      title: AppLocalizations.of(context).literaldiscoverPeople,
      height: 196,
      count: state.people.length,
      listKey: const ValueKey('explore-people'),
      itemBuilder: (context, index) => _PersonCard(
        person: state.people[index],
        onFollowed: ref.read(suggestedPeopleProvider.notifier).followed,
      ),
    );
  }
}

class _PersonCard extends ConsumerStatefulWidget {
  final ProfileSummary person;
  final ValueChanged<ProfileSummary> onFollowed;

  const _PersonCard({required this.person, required this.onFollowed});

  @override
  ConsumerState<_PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends ConsumerState<_PersonCard> {
  bool _busy = false;

  Future<void> _follow() async {
    setState(() => _busy = true);
    unawaited(HapticFeedback.selectionClick());
    try {
      await ref.read(profileRepositoryProvider).follow(widget.person.id);
      // Followed, so no longer a suggestion: off the strip.
      widget.onFollowed(widget.person.copyWith(isFollowing: true));
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final person = widget.person;
    final scheme = Theme.of(context).colorScheme;
    final name = person.name?.trim();
    final handle = person.handle;

    return _Card(
      key: ValueKey('explore-person-${person.id}'),
      width: _cardWidth,
      onTap: () =>
          openProfile(context, username: person.username, userId: person.id),
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: scheme.primary.withValues(alpha: 0.15),
          foregroundImage:
              person.avatarUrl == null ? null : NetworkImage(person.avatarUrl!),
          child: Icon(Iconsax.user_copy, size: 24, color: scheme.primary),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          name == null || name.isEmpty ? (handle ?? '') : name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: TypographyTokens.fontSize3,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (handle != null)
          Text(
            handle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            key: ValueKey('explore-follow-${person.id}'),
            compact: true,
            label: AppLocalizations.of(context).ui('ui_follow', 'Follow'),
            icon: Iconsax.add,
            busy: _busy,
            onPressed: _follow,
          ),
        ),
      ],
    );
  }
}

/// Communities the reader is not in. They were only to be found two taps
/// into Communities.
class _CommunityStrip extends ConsumerWidget {
  const _CommunityStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(discoverCommunitiesProvider);
    if (state.loadingFirstPage) return const _StripSkeleton();
    if (state.items.isEmpty) return const SizedBox.shrink();

    return _Strip(
      title: AppLocalizations.of(context)
          .ui('ui_explore_communities', 'Communities to join'),
      height: 196,
      count: state.items.length,
      listKey: const ValueKey('explore-communities'),
      itemBuilder: (context, index) =>
          _CommunityCard(community: state.items[index]),
    );
  }
}

class _CommunityCard extends ConsumerStatefulWidget {
  final Community community;

  const _CommunityCard({required this.community});

  @override
  ConsumerState<_CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends ConsumerState<_CommunityCard> {
  bool _busy = false;

  Future<void> _join() async {
    setState(() => _busy = true);
    unawaited(HapticFeedback.selectionClick());
    try {
      final joined = await ref
          .read(communitiesRepositoryProvider)
          .setMembership(widget.community.slug, true);
      // In the reader's list now, and out of the ones they are not in --
      // here and under Discover alike, since this is that same list.
      ref.read(discoverCommunitiesProvider.notifier).joined(joined.id);
      ref.read(myCommunitiesProvider(CommunityFilter.all).notifier).add(joined);
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final community = widget.community;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return _Card(
      key: ValueKey('explore-community-${community.id}'),
      width: _cardWidth,
      onTap: () => Navigator.pushNamed(
        context,
        Routes.community,
        arguments: community.slug,
      ),
      children: [
        CommunityPictureTile(community: community, size: 64),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          community.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: TypographyTokens.fontSize3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '${l10n.ui('ui_community_members', 'Members:')} '
          '${community.members}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            color: scheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            key: ValueKey('explore-join-${community.id}'),
            compact: true,
            label: l10n.ui('ui_join', 'Join'),
            icon: Iconsax.add,
            busy: _busy,
            onPressed: _join,
          ),
        ),
      ],
    );
  }
}

/// The tags people are actually using this week.
///
/// Only those used at least [minUses] times in the week, and only once
/// there are [minTags] of them. Almost every hashtag here has been used once,
/// and a ranking of things used once is a list in no order dressed up as a
/// ranking.
class _TagStrip extends ConsumerWidget {
  const _TagStrip();

  static const minUses = 2;
  static const minTags = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trendingProvider);
    final tags = trendingNow(state.items);
    if (tags.length < minTags) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(
          AppLocalizations.of(context)
              .ui('interest_trending_now', 'Trending now'),
        ),
        ListChipRow(
          children: [
            for (final (index, tag) in tags.indexed) ...[
              if (index > 0) const SizedBox(width: SpacingTokens.space8),
              ListChip(
                key: ValueKey('explore-tag-${tag.tag}'),
                selected: false,
                label: '#${tag.tag}',
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.hashtag,
                  arguments: tag.tag,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// The tags worth calling trending: used at least [minUses] times this week,
/// busiest first, as the server ranked them.
List<TrendingTag> trendingNow(
  List<TrendingTag> tags, {
  int minUses = _TagStrip.minUses,
}) =>
    [
      for (final tag in tags)
        if (tag.recent >= minUses) tag,
    ];

/// The shape of a strip while it loads.
class _StripSkeleton extends StatelessWidget {
  const _StripSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonGroup(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space16,
          0,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox.line(width: 140, height: 16),
            const SizedBox(height: SpacingTokens.space12),
            SizedBox(
              height: 196,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: SpacingTokens.space8),
                itemBuilder: (_, __) => const SkeletonBox(
                  width: _cardWidth,
                  height: 196,
                  radius: RadiusTokens.radiusLg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The shape of the grid while its first page loads.
class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(SpacingTokens.space4),
      sliver: SliverGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: SpacingTokens.space4,
        crossAxisSpacing: SpacingTokens.space4,
        childAspectRatio: 0.8,
        children: [
          for (var i = 0; i < 9; i++)
            const SkeletonGroup(
              child: SkeletonBox(
                width: double.infinity,
                height: double.infinity,
                radius: RadiusTokens.radiusMd,
              ),
            ),
        ],
      ),
    );
  }
}
