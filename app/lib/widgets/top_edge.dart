// lib/widgets/top_edge.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/notifications_provider.dart';
import 'account_avatar.dart';
import 'app_logo.dart';
import 'nav_destinations.dart';

class TopEdge extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  const TopEdge({
    super.key,
    this.onProfileTap,
    this.onLogoTap,
    this.onSearchTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      color: scheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// LEFT – PROFILE AVATAR
          Align(
            alignment: Alignment.centerLeft,
            child: AccountAvatar(
              radius: 16,
              onTap: onProfileTap,
              tooltip: 'Menu',
            ),
          ),

          /// CENTER – LOGO
          GestureDetector(
            onTap: onLogoTap,
            behavior: HitTestBehavior.opaque,
            // AppLogo, which draws the mark in its own colours. This used
            // to be a bare SvgPicture under a `ColorFilter.mode(scheme
            // .primary, srcIn)`, which flattened a leaf that runs teal into
            // green down to one flat #4C8FFF -- so the mark at the top of the
            // home screen was a solid blue shape with none of Kyron's colours
            // left in it. The path was a parameter with exactly one caller
            // passing exactly the file AppLogo already names, so it has gone
            // with it.
            child: const AppLogo(size: 32),
          ),

          /// RIGHT – SEARCH + NOTIFICATIONS
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onSearchTap,
                  icon: const Icon(Iconsax.search_normal_1_copy, size: 22),
                  tooltip: 'Search',
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
                // The two used to sit 18 logical pixels apart -- the eight
                // here plus each button's own five of padding -- which read as
                // two unrelated controls rather than one pair.
                const SizedBox(width: 2),
                _NotificationButton(onPressed: onNotificationTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The bell, and how many things have happened since it was last opened.
///
/// A count rather than a bare dot: "3" and "40" are different enough to be
/// worth telling apart before deciding whether to look.
///
/// The count is the Messages tab's own badge. This drew one of its own --
/// the theme's error colour rather than the tab's red, smaller, and pinned to
/// the corner of the 32-pixel button rather than to the bell, so it floated
/// off to the side of the icon it counted for.
class _NotificationButton extends ConsumerWidget {
  final VoidCallback? onPressed;

  const _NotificationButton({this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    // Nothing while it is still loading and nothing if it fails: a badge is
    // not worth an error state, and a wrong number is worse than none.
    final unread = ref.watch(unreadNotificationsProvider).asData?.value ?? 0;

    return IconButton(
      key: const ValueKey('home-notifications'),
      onPressed: onPressed,
      icon: NavBadge(
        count: unread,
        ring: scheme.surface,
        child: const Icon(Iconsax.notification_copy, size: 22),
      ),
      tooltip: unread == 0 ? 'Notifications' : 'Notifications, $unread unread',
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
    );
  }
}
