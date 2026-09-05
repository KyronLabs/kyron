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
      color: scheme.surface,
      // No bottom border. Every screen using this puts a pager underneath,
      // and the pager carries the one hairline between the header and the
      // content. Two lines four pixels apart is what read as a thick smudge.
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
      child: Row(
        children: [
          // The same size as the home page's, which is the one people see
          // most: 32 across, no ring. This was 36 across inside a 3px ring,
          // so moving between tabs resized the reader's own face.
          AccountAvatar(radius: 16, onTap: onAvatarTap, tooltip: 'Menu'),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          // Sized and spaced like the home page's pair: 22px glyphs in 32px
          // boxes, two logical pixels apart. A default IconButton is 48 across
          // with eight of its own padding, which put these three times as far
          // apart as the ones on the page next door.
          _Action(
            icon: Iconsax.search_normal_1_copy,
            tooltip: 'Search',
            onPressed: () => Navigator.pushNamed(context, Routes.search),
          ),
          const SizedBox(width: 2),
          _Action(
            icon: Iconsax.setting_2_copy,
            tooltip: 'Settings',
            onPressed: onSettingsTap ??
                () => Navigator.pushNamed(context, Routes.settings),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _Action({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 22),
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
    );
  }
}
