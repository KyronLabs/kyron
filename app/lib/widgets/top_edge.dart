// lib/widgets/top_edge.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../providers/notifications_provider.dart';
import 'account_avatar.dart';
import 'app_logo.dart';

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
class _NotificationButton extends ConsumerWidget {
  final VoidCallback? onPressed;

  const _NotificationButton({this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    // Nothing while it is still loading and nothing if it fails: a badge is
    // not worth an error state, and a wrong number is worse than none.
    final unread = ref.watch(unreadNotificationsProvider).asData?.value ?? 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.notification_copy, size: 22),
          tooltip:
              unread == 0 ? 'Notifications' : 'Notifications, $unread unread',
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          padding: EdgeInsets.zero,
        ),
        if (unread > 0)
          Positioned(
            top: -2,
            right: -4,
            // Ignored by the pointer so the badge cannot eat the tap that is
            // meant for the bell underneath it.
            child: IgnorePointer(
              child: Container(
                constraints: const BoxConstraints(minWidth: 16),
                height: 16,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: scheme.error,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: scheme.surface, width: 1.5),
                ),
                child: Text(
                  unread > 99 ? '99+' : '$unread',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    color: scheme.onError,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
