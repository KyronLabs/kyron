// lib/widgets/side_rail.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../utils/layout.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'create_fab.dart';
import 'nav_destinations.dart';

/// Navigation down the side, for a window rather than a phone.
///
/// The same four destinations the bottom bar draws, at a size a pointer aims
/// at rather than a thumb, with their names beside them instead of under
/// them -- a rail has the width for that and reading it beats recognising an
/// icon. The profile, saved posts and settings stay in the drawer the avatar
/// opens: the rail is where you are going, the drawer is you and your things,
/// and putting both in one column makes a list nobody scans.
class SideRail extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelect;

  const SideRail({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: Layout.railWidth,
      decoration: BoxDecoration(
        color: dark ? KyronTheme.darkSurface : KyronTheme.lightSurface,
        border: Border(
          right: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Brand(),
            const SizedBox(height: SpacingTokens.space8),
            for (final destination in NavDestinations.all)
              _RailItem(
                destination: destination,
                active: destination.index == currentIndex,
                onTap: () => onSelect(destination.index),
              ),
            const SizedBox(height: SpacingTokens.space16),
            // The bottom bar's round button does not belong in a rail: it is
            // 56 across, so its icon sat four points left of the destination
            // icons and its label thirty points right of their labels --
            // three left edges where there should be one. This is the same
            // menu behind a control shaped like the rest of the column.
            const _PostButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space24,
        SpacingTokens.space20,
        SpacingTokens.space16,
      ),
      child: Row(
        children: [
          SvgPicture.asset('lib/assets/logo.svg', width: 26, height: 26),
          const SizedBox(width: SpacingTokens.space12),
          Text(
            'Kyron',
            style: TextStyle(
              fontSize: TypographyTokens.fontSize5,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

/// One destination in the rail.
class _RailItem extends StatefulWidget {
  final NavDestination destination;
  final bool active;
  final VoidCallback onTap;

  const _RailItem({
    required this.destination,
    required this.active,
    required this.onTap,
  });

  @override
  State<_RailItem> createState() => _RailItemState();
}

class _RailItemState extends State<_RailItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = widget.active;
    final colour =
        active ? scheme.primary : scheme.onSurface.withValues(alpha: 0.7);

    return Semantics(
      button: true,
      selected: active,
      label: widget.destination.label,
      excludeSemantics: true,
      child: MouseRegion(
        // A pointer has a hover state and a phone does not. Without it nothing
        // on a desktop window answers until it is clicked, which reads as an
        // application that is not listening.
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space12,
              vertical: SpacingTokens.space2,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              height: 46,
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space12,
              ),
              decoration: BoxDecoration(
                color: active
                    ? scheme.primary.withValues(alpha: 0.10)
                    : (_hovered
                        ? scheme.onSurface.withValues(alpha: 0.05)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    active
                        ? widget.destination.activeIcon
                        : widget.destination.icon,
                    size: 22,
                    color: colour,
                  ),
                  const SizedBox(width: SpacingTokens.space16),
                  Text(
                    widget.destination.label,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                      color: colour,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The compose button, shaped to the rail rather than to a bottom bar.
class _PostButton extends StatefulWidget {
  const _PostButton();

  @override
  State<_PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<_PostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ground = dark ? Colors.white : Colors.black;

    return Semantics(
      button: true,
      label: 'Post',
      excludeSemantics: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          // The same menu the bottom bar's button opens.
          onTap: () => CreateFab.chooseWhatToPost(context),
          child: Padding(
            // Lines up with the destinations above: their 12 of outer padding
            // and 12 of inner is this one 24.
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space24,
              vertical: SpacingTokens.space8,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              height: 46,
              decoration: BoxDecoration(
                color: _hovered ? ground.withValues(alpha: 0.85) : ground,
                borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.add_copy,
                    size: 19,
                    color: scheme.surface,
                  ),
                  const SizedBox(width: SpacingTokens.space8),
                  Text(
                    'Post',
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      color: scheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
