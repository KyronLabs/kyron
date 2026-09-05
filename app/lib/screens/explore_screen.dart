// lib/screens/explore_screen.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/explore_entry.dart';
import '../providers/explore_provider.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import '../widgets/app_drawer.dart';
import '../widgets/list_message.dart';
import '../widgets/person_tile.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/toast.dart';
import 'topic_screen.dart';

/// What is happening on Kyron that the reader is not already following.
///
/// Three answers to that, and all three are read from the network. What this
/// replaces was twenty rows of "Trending #1 -- 1234 posts", twenty tiles of
/// "Topic 1" and twenty rows of "User 1": a page that looked identical whether
/// the network was busy, empty or unreachable.
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

class _ExploreScreenState extends ConsumerState<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this);

  /// Whether the bottom bar has been hidden. Toggled rather than reported per
  /// frame: the container animates on the change, not on the offset.
  bool _hidden = false;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  /// Hides the bottom bar going down, brings it back coming up.
  ///
  /// One listener for all three tabs. Each of them scrolls its own list, and a
  /// controller per tab meant only whichever one happened to be attached
  /// reported anything.
  ///
  /// Filtered by axis, not by depth. The tab strip is itself a scroll view, so
  /// the one notification that arrives here at depth zero is the sideways
  /// swipe between tabs -- which is not what hides a bottom bar.
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: 'Explore',
            onAvatarTap: () => widget.drawerKey.currentState?.toggleDrawer(),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: scheme.outline.withValues(alpha: 0.15),
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabs,
            indicatorColor: scheme.primary,
            labelColor: scheme.primary,
            unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: const [
              Tab(text: 'Trending'),
              Tab(text: 'Topics'),
              Tab(text: 'People'),
            ],
          ),
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onScroll,
            child: TabBarView(
              controller: _tabs,
              children: const [_TrendingTab(), _TopicsTab(), _PeopleTab()],
            ),
          ),
        ),
      ],
    );
  }
}

/// The hashtags being used right now.
class _TrendingTab extends ConsumerWidget {
  const _TrendingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trendingProvider);
    final notifier = ref.read(trendingProvider.notifier);

    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.items.isEmpty
          ? _Message(
              icon: state.error != null
                  ? Iconsax.cloud_cross_copy
                  : Iconsax.hashtag_copy,
              title: state.error ?? 'Nothing is trending yet',
              detail: state.error != null
                  ? null
                  : 'Hashtags people are using turn up here as they are used.',
              onRetry: state.error != null ? notifier.refresh : null,
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: SpacingTokens.space8,
              ),
              itemCount: state.items.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: SpacingTokens.space16,
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.15),
              ),
              itemBuilder: (context, index) => _TrendingRow(
                rank: index + 1,
                tag: state.items[index],
              ),
            ),
    );
  }
}

class _TrendingRow extends StatelessWidget {
  final int rank;
  final TrendingTag tag;

  const _TrendingRow({required this.rank, required this.tag});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.6);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space4,
      ),
      // The position is worth showing: it is the only thing that says this is
      // a ranking rather than a list in no particular order.
      leading: SizedBox(
        width: 24,
        child: Text(
          '$rank',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, color: muted),
        ),
      ),
      title: Text(
        '#${tag.tag}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        // Two numbers, because they answer different questions: how big this
        // tag is, and why it is on this list at all.
        '${formatCount(tag.posts)} ${tag.posts == 1 ? 'post' : 'posts'}'
        '${tag.recent > 0 ? ' · ${formatCount(tag.recent)} this week' : ''}',
        style: TextStyle(fontSize: 13, color: muted),
      ),
      onTap: () =>
          Navigator.pushNamed(context, Routes.hashtag, arguments: tag.tag),
    );
  }
}

/// The topic catalogue: what a reader can say they are into.
class _TopicsTab extends ConsumerWidget {
  const _TopicsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(topicsProvider);
    final notifier = ref.read(topicsProvider.notifier);

    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.items.isEmpty
          ? _Message(
              icon: state.error != null
                  ? Iconsax.cloud_cross_copy
                  : Iconsax.category_copy,
              title: state.error ?? 'No topics yet',
              detail: state.error != null
                  ? null
                  : 'Topics are set up by Kyron. There are none right now.',
              onRetry: state.error != null ? notifier.refresh : null,
            )
          : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(SpacingTokens.space16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: SpacingTokens.space12,
                mainAxisSpacing: SpacingTokens.space12,
                // A height, not a ratio. A ratio is a fixed number of pixels
                // once the column width is known, and at the largest text
                // scale the app allows a two-line name and a count are taller
                // than that -- which is a card that overflows rather than one
                // that grows.
                mainAxisExtent: _topicCardHeight(context),
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) => _TopicCard(
                topic: state.items[index],
                onToggle: () async {
                  final error = await notifier.toggle(state.items[index]);
                  if (error != null && context.mounted) {
                    Toast.show(context, error);
                  }
                },
              ),
            ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback onToggle;

  const _TopicCard({required this.topic, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final on = topic.following;

    return Material(
      color: on
          ? scheme.primary.withValues(alpha: 0.1)
          : scheme.surfaceContainerHighest.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
        // The card opens the topic; the tick follows it. Two things a card can
        // do needs the more useful one on the card itself.
        onTap: () => Navigator.pushNamed(
          context,
          Routes.topic,
          arguments: TopicArgs(slug: topic.slug, name: topic.name),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
            border: Border.all(
              color: on
                  ? scheme.primary.withValues(alpha: 0.5)
                  : scheme.outline.withValues(alpha: 0.1),
            ),
          ),
          padding: const EdgeInsets.all(SpacingTokens.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      topic.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onToggle,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    tooltip: on
                        ? 'Stop following ${topic.name}'
                        : 'Follow ${topic.name}',
                    icon: Icon(
                      on ? Iconsax.tick_circle : Iconsax.add_circle_copy,
                      size: 22,
                      color: on
                          ? scheme.primary
                          : scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                topic.people == 1
                    ? '1 person'
                    : '${formatCount(topic.people)} people',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Accounts worth following, best match first.
class _PeopleTab extends ConsumerStatefulWidget {
  const _PeopleTab();

  @override
  ConsumerState<_PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends ConsumerState<_PeopleTab> {
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
    final position = _scroll.position;
    if (position.pixels >= position.maxScrollExtent - 400) {
      ref.read(suggestedPeopleProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(suggestedPeopleProvider);
    final notifier = ref.read(suggestedPeopleProvider.notifier);

    if (state.loadingFirstPage) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.people.isEmpty
          ? _Message(
              icon: state.error != null
                  ? Iconsax.cloud_cross_copy
                  : Iconsax.people_copy,
              title: state.error ?? 'Nobody left to suggest',
              detail: state.error != null
                  ? null
                  : 'You already follow everyone Kyron would put here.',
              onRetry: notifier.refresh,
            )
          : ListView.separated(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.people.length + (state.loadingMore ? 1 : 0),
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 72,
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.15),
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
                  // Followed, so no longer a suggestion. Leaving it here with
                  // a Following button on it is a list that never gets shorter
                  // however much you use it.
                  onChanged: (updated) {
                    if (updated.isFollowing) notifier.followed(updated);
                  },
                  onOpen: () => openProfile(
                    context,
                    username: person.username,
                    userId: person.id,
                  ),
                );
              },
            ),
    );
  }
}

/// How tall a topic card has to be to hold what is in it.
///
/// Two lines of name -- or the tick beside it, whichever is taller -- then the
/// count, at whatever text scale the reader has chosen. Deliberately an upper
/// bound: a line box is taller than its font size by an amount that depends on
/// the font, and the cost of guessing high is a few pixels of space at the
/// bottom of a card rather than a card that overflows.
double _topicCardHeight(BuildContext context) {
  final scale = MediaQuery.textScalerOf(context);
  final name = math.max(scale.scale(15) * 1.6 * 2, 40);
  final count = scale.scale(13) * 1.8;
  return math.max(
    112,
    SpacingTokens.space12 * 2 + name + SpacingTokens.space8 + count,
  );
}

/// A tab with nothing in it, scrollable so pull-to-refresh still works.
class _Message extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? detail;
  final VoidCallback? onRetry;

  const _Message({
    required this.icon,
    required this.title,
    this.detail,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: ListMessage(
              icon: icon,
              title: title,
              detail: detail,
              action: onRetry == null ? null : 'Try again',
              onAction: onRetry,
            ),
          ),
        ],
      ),
    );
  }
}
