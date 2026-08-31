import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../providers/current_user_provider.dart';

/// The signed-in account's picture.
///
/// Every screen that showed one drew its own, and most of them drew a grey
/// person glyph instead: the explore, communities and messages headers all
/// rendered `Icons.person` whether or not the account had a picture. One
/// widget, reading the profile the app has already loaded.
class AccountAvatar extends ConsumerWidget {
  final double radius;

  /// Drawn around the picture. Null for none.
  final Color? ringColor;
  final double ringWidth;

  final VoidCallback? onTap;
  final String? tooltip;

  const AccountAvatar({
    super.key,
    this.radius = 18,
    this.ringColor,
    this.ringWidth = 2,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    // asData rather than `when`: a failed profile load should still show the
    // fallback glyph, not an error state in the middle of an app bar.
    final avatarUrl = ref.watch(currentUserProvider).asData?.value.avatarUrl;

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primary.withValues(alpha: 0.15),
      foregroundImage: avatarUrl == null ? null : NetworkImage(avatarUrl),
      child: Icon(Iconsax.user, size: radius, color: scheme.primary),
    );

    if (ringColor != null) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor!, width: ringWidth),
        ),
        child: avatar,
      );
    }

    if (onTap == null) return avatar;

    return Tooltip(
      message: tooltip ?? 'Your profile',
      child: GestureDetector(onTap: onTap, child: avatar),
    );
  }
}
