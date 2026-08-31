// lib/widgets/simple_app_bar.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../routes.dart';
import 'account_avatar.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onAvatarTap;
  final VoidCallback? onSettingsTap;

  const SimpleAppBar({
    super.key,
    required this.title,
    required this.onAvatarTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        child: Row(
          children: [
            AccountAvatar(
              radius: 18,
              ringColor: scheme.primary.withValues(alpha: 0.3),
              ringWidth: 1.5,
              onTap: onAvatarTap,
              tooltip: 'Menu',
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.search),
              tooltip: 'Search',
              icon: Icon(
                Iconsax.search_normal_1_copy,
                color: scheme.onSurface.withValues(alpha: 0.7),
                size: 22,
              ),
            ),
            IconButton(
              onPressed: onSettingsTap ??
                  () => Navigator.pushNamed(context, Routes.settings),
              tooltip: 'Settings',
              icon: Icon(
                Iconsax.setting_2_copy,
                color: scheme.onSurface.withValues(alpha: 0.7),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
