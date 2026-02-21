// lib/widgets/top_edge.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/current_user_provider.dart';

class TopEdge extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final userAsync = ref.watch(currentUserProvider);

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
            child: GestureDetector(
              onTap: onProfileTap,
              child: userAsync.when(
                loading: () => _avatarPlaceholder(scheme),
                error: (_, __) => _avatarPlaceholder(scheme),
                data: (user) => CircleAvatar(
                  radius: 16,
                  backgroundColor: scheme.tertiaryContainer,
                  backgroundImage: user.avatarUrl != null 
                      ? NetworkImage(user.avatarUrl!) 
                      : null,
                  child: user.avatarUrl == null
                      ? Icon(
                          Iconsax.user, 
                          size: 16, 
                          color: scheme.onTertiaryContainer
                        )
                      : null,
                ),
              ),
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
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onNotificationTap,
                  icon: const Icon(Iconsax.notification, size: 22),
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

  Widget _avatarPlaceholder(ColorScheme scheme) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.tertiaryContainer,
      ),
      child: Icon(
        Iconsax.user, 
        size: 16, 
        color: scheme.onTertiaryContainer
      ),
    );
  }
}