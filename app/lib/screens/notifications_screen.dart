// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/notification_model.dart';
import '../providers/notifications_provider.dart';
import '../routes.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/notification_item.dart';
import '../widgets/notification_skeleton.dart';
import '../widgets/section_tabs.dart';

/// What other people did to your posts and your account.
///
/// This used to generate twenty rows on a 300ms timer -- @user0 through
/// @user19, half of them saying "Great post!" about snow leopards -- so the
/// screen looked identical on a fresh account, a busy one and a dead API.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  /// Null is All. Reposts have no tab of their own and show up under it.
  static const _tabKinds = <NotificationType?>[
    null,
    NotificationType.like,
    NotificationType.comment,
    NotificationType.follow,
  ];
  static const _tabLabels = ['All', 'Likes', 'Replies', 'Follows'];

  late final TabController _tabs =
      TabController(length: _tabKinds.length, vsync: this);

  @override
  void initState() {
    super.initState();
    // Opening the screen is what clears the badge. Fired once, not per tab.
    _markSeen();
  }

  Future<void> _markSeen() async {
    try {
      await ref.read(notificationsRepositoryProvider).markSeen();
    } catch (_) {
      // The badge staying up is not worth interrupting the screen for; the
      // list itself reports anything that actually failed to load.
      return;
    }
    if (mounted) ref.invalidate(unreadNotificationsProvider);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Notifications'),
      ),
      body: Column(
        children: [
          SectionTabs(controller: _tabs, labels: _tabLabels),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                for (final kind in _tabKinds) _NotificationList(kind: kind),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationList extends ConsumerStatefulWidget {
  final NotificationType? kind;

  const _NotificationList({required this.kind});

  @override
  ConsumerState<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends ConsumerState<_NotificationList> {
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
      ref.read(notificationListProvider(widget.kind).notifier).loadMore();
    }
  }

  void _open(NotificationModel row) {
    final postId = row.postId;
    if (postId != null && postId.isNotEmpty) {
      Navigator.pushNamed(context, Routes.postDetail, arguments: postId);
      return;
    }
    openProfile(
      context,
      username: row.actor.username,
      userId: row.actor.id,
    );
  }

  EmptyState _empty() => switch (widget.kind) {
        NotificationType.like => const EmptyState(
            art: EmptyArt.likes,
            title: 'No likes yet',
            detail: 'When somebody likes one of your posts, it shows up here.',
          ),
        NotificationType.comment => const EmptyState(
            art: EmptyArt.messages,
            title: 'No replies yet',
            detail: 'Replies to your posts land here.',
          ),
        NotificationType.follow => const EmptyState(
            art: EmptyArt.people,
            title: 'No new followers',
            detail: 'People who follow you show up here.',
          ),
        NotificationType.repost => const EmptyState(
            art: EmptyArt.posts,
            title: 'No reposts yet',
            detail: 'When somebody reposts you, it shows up here.',
          ),
        null => const EmptyState(
            art: EmptyArt.caughtUp,
            title: 'You are all caught up',
            detail: 'Likes, replies and new followers land here as they '
                'happen.',
          ),
      };

  /// Today, Yesterday, This week, Older -- in that order, skipping any that
  /// hold nothing. Built from the list rather than from a fixed set of keys,
  /// so a heading never appears above an empty group.
  List<(String, List<NotificationModel>)> _grouped(
    List<NotificationModel> rows,
  ) {
    final groups = <String, List<NotificationModel>>{};
    for (final row in rows) {
      groups.putIfAbsent(row.groupKey, () => []).add(row);
    }
    const order = ['Today', 'Yesterday', 'This week', 'Older'];
    return [
      for (final key in order)
        if (groups[key] != null) (key, groups[key]!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final state = ref.watch(notificationListProvider(widget.kind));
    final notifier = ref.read(notificationListProvider(widget.kind).notifier);

    if (state.loadingFirstPage) return const NotificationSkeleton();

    if (state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: notifier.refresh,
        child: (state.error != null
                ? EmptyState.failed(
                    title: 'Could not load notifications',
                    detail: state.error!,
                    onAction: notifier.refresh,
                  )
                : _empty())
            .scrollable,
      );
    }

    final groups = _grouped(state.items);

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: ListView.builder(
        controller: _scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: groups.length + (state.loadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= groups.length) {
            return const Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final (heading, rows) = groups[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space16,
                  SpacingTokens.space16,
                  SpacingTokens.space16,
                  SpacingTokens.space8,
                ),
                child: Text(
                  heading.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              for (final row in rows) ...[
                NotificationItem(notification: row, onTap: () => _open(row)),
                const Hairline(),
              ],
            ],
          );
        },
      ),
    );
  }
}
