// lib/widgets/glass_icon_button.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// A round control that reads over a photograph: a small dark disc with a
/// white glyph.
///
/// The profile page's, shared. The community page drew its own -- 44 across
/// and darker -- for the same job over the same kind of banner, and looked
/// heavy next to it. The disc is 36; the target around it is 44, the floor
/// for a thumb, so the smaller look costs nothing to hit.
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  /// A dot on the disc: something new behind it.
  final bool dot;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.dot = false,
  });

  /// What is seen.
  static const double disc = 36;

  /// What a thumb has to hit.
  static const double target = 44;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tooltip(
        message: tooltip,
        child: Semantics(
          button: true,
          label: tooltip,
          excludeSemantics: true,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox.square(
              dimension: target,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: disc,
                      height: disc,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x59000000),
                      ),
                      child: Icon(icon, size: 19, color: Colors.white),
                    ),
                    if (dot)
                      Positioned(
                        right: 1,
                        top: 1,
                        child: Container(
                          key: const ValueKey('glass-dot'),
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Back, over a photograph.
class GlassBackButton extends StatelessWidget {
  const GlassBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassIconButton(
      icon: Iconsax.arrow_left_copy,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
