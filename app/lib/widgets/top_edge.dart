// lib/widgets/top_edge.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'account_avatar.dart';

class TopEdge extends StatelessWidget {
  final String logoPath;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  const TopEdge({
    super.key,
    required this.logoPath,
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
            child: SvgPicture.asset(
              logoPath,
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                scheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),

          /// RIGHT – SEARCH + NOTIFICATIONS
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onSearchTap,
                  icon: const Icon(Iconsax.search_normal_1, size: 22),
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
                IconButton(
                  onPressed: onNotificationTap,
                  icon: const Icon(Iconsax.notification, size: 22),
                  tooltip: 'Notifications',
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
