// lib/widgets/mascot.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Kyron's mascot.
///
/// A vector rather than a picture: an empty state shows it at 120, a header at
/// 40 and a tab at 24, and one file that stays crisp at all three beats three
/// files that go soft at the wrong one.
///
/// Its own colours in both themes -- a yellow bird that turns grey in the dark
/// is not the mascot -- so it is drawn on [MascotBackdrop] rather than
/// recoloured, which is what keeps the dark half of the plumage off a dark
/// background.
class Mascot extends StatelessWidget {
  final double size;

  const Mascot({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/assets/mascot.svg',
      width: size,
      height: size,
      // Read out as one thing rather than as forty petals.
      semanticsLabel: 'Kyron',
    );
  }
}

/// The mascot on a soft disc, which is how empty states show it.
///
/// The disc is not decoration. Half the plumage is near-black, and on the dark
/// theme's near-black background that half disappears; the disc puts a lit
/// surface behind it in both themes.
class MascotBackdrop extends StatelessWidget {
  final double size;

  const MascotBackdrop({super.key, this.size = 132});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size * 1.24,
      height: size * 1.24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Neutral rather than the brand colour. The mascot is yellow, the
        // scheme's primary is blue, and a blue halo behind a yellow bird
        // fights it; grey behind it does not fight anything.
        color: scheme.onSurface.withValues(alpha: dark ? 0.07 : 0.05),
      ),
      alignment: Alignment.center,
      child: Mascot(size: size),
    );
  }
}

/// What a screen says when it has nothing to show.
///
/// One widget for empty and for failed, because the two are the same shape and
/// were drifting apart: the feed's version had a title, a detail line and a
/// 48px icon, the follow lists' had one line of text and a 40px one, and
/// anything new grew a third.
class EmptyState extends StatelessWidget {
  /// What is missing, in a few words. The line people actually read.
  final String title;

  /// Why, or what to do about it. Omitted when the title says it all.
  final String? detail;

  /// The button under it, and what it does. Both or neither.
  final String? action;
  final VoidCallback? onAction;

  /// Shown instead of the mascot. Failures use one: a cheerful bird over
  /// "could not connect" reads as the app not having noticed.
  final IconData? icon;

  /// Smaller, for an empty state inside a card or a sheet rather than a screen.
  final bool compact;

  const EmptyState({
    super.key,
    required this.title,
    this.detail,
    this.action,
    this.onAction,
    this.icon,
    this.compact = false,
  });

  /// The shape a failed read takes: an icon, the reason, and a way to retry.
  const EmptyState.failed({
    super.key,
    required this.title,
    this.detail,
    this.onAction,
    this.action = 'Try again',
    this.compact = false,
  }) : icon = Iconsax.cloud_cross_copy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final detail = this.detail;
    final action = this.action;
    final icon = this.icon;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SpacingTokens.space32,
        vertical: compact ? SpacingTokens.space24 : SpacingTokens.space40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: compact ? 40 : 56,
              color: scheme.onSurface.withValues(alpha: 0.35),
            )
          else
            MascotBackdrop(size: compact ? 72 : 116),
          SizedBox(
            height: compact ? SpacingTokens.space16 : SpacingTokens.space20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            // Was titleMedium, which is 16 and reads as a caption under an
            // illustration this size. This is the sentence on the screen.
            style: TextStyle(
              fontSize: compact ? 17 : 20,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: scheme.onSurface,
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 14 : 15,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
          if (action != null && onAction != null) ...[
            const SizedBox(height: SpacingTokens.space20),
            FilledButton.tonal(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space24,
                  vertical: SpacingTokens.space12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
                ),
              ),
              child: Text(
                action,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// The same thing, filling what is left of a scroll view.
  Widget get sliver => SliverFillRemaining(hasScrollBody: false, child: this);

  /// The same thing in a list of its own, so pull-to-refresh still works when
  /// there is nothing to scroll.
  Widget get scrollable => LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: this,
            ),
          ],
        ),
      );
}
