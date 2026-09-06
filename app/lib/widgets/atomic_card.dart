// lib/widgets/atomic_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'action_button.dart';

/// One suggested account, as a card in a grid.
///
/// What this replaces was written before the app had a design system and
/// never caught up: a hard-coded 100x120 box inside a 150-tall grid slot, so
/// it overflowed by thirteen pixels on every card that had a bio; a
/// purple-to-teal gradient on the Follow button, which is not a colour Kyron
/// uses anywhere else; and a font family the app does not ship, so every
/// label silently fell back to a different one than the rest of the screen.
class AtomicCard extends StatefulWidget {
  final String avatarUrl;
  final String handle;
  final String? bio;
  final bool isInitiallyFollowing;
  final VoidCallback? onFollowToggle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AtomicCard({
    super.key,
    required this.avatarUrl,
    required this.handle,
    this.bio,
    this.isInitiallyFollowing = false,
    this.onFollowToggle,
    this.onTap,
    this.onLongPress,
  });

  /// What a grid slot has to be for one of these to fit.
  ///
  /// Measured rather than guessed: the tallest arrangement is an avatar, a
  /// name, two lines of bio and the button, plus the padding around them.
  /// Scales with the reader's text size, because at 1.3x the old fixed height
  /// clipped the button off entirely.
  static double slotHeight(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final name = scaler.scale(14) * 1.25;
    final bio = scaler.scale(12) * 1.3 * 2;
    return _padding * 2 +
        _avatar +
        8 +
        name +
        4 +
        bio +
        10 +
        ActionButton.compactHeight;
  }

  static const double _avatar = 44;
  static const double _padding = 12;

  @override
  State<AtomicCard> createState() => _AtomicCardState();
}

class _AtomicCardState extends State<AtomicCard> {
  late bool _following = widget.isInitiallyFollowing;

  void _toggle() {
    setState(() => _following = !_following);
    HapticFeedback.selectionClick();
    widget.onFollowToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bio = widget.bio?.trim();

    return Semantics(
      button: true,
      label: widget.handle,
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
        child: InkWell(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.22),
              ),
            ),
            padding: const EdgeInsets.all(AtomicCard._padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: AtomicCard._avatar / 2,
                  backgroundColor: scheme.primary.withValues(alpha: 0.15),
                  foregroundImage: widget.avatarUrl.isEmpty
                      ? null
                      : NetworkImage(widget.avatarUrl),
                  child: Icon(
                    Iconsax.user_copy,
                    size: 20,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.handle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                // Always two lines tall, whether or not there is a bio, so a
                // row of cards lines its buttons up instead of stepping.
                SizedBox(
                  height: MediaQuery.textScalerOf(context).scale(12) * 1.3 * 2,
                  child: bio == null || bio.isEmpty
                      ? null
                      : Text(
                          bio,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.3,
                            color: scheme.onSurface.withValues(alpha: 0.65),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                ActionButton(
                  compact: true,
                  expand: false,
                  label: _following ? 'Following' : 'Follow',
                  kind: _following
                      ? ActionButtonKind.outlined
                      : ActionButtonKind.primary,
                  onPressed: _toggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
