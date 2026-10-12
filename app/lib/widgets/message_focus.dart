// lib/widgets/message_focus.dart
import 'dart:math' as math;
import 'dart:ui' show ImageFilter, lerpDouble;

import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'action_sheet.dart' show SheetAction;
import 'hairline.dart';

/// A long-pressed message, lifted out of the conversation: the chat blurred
/// behind it, the message itself sharp where it was, the quick reactions
/// above it and what can be done to it below.
///
/// What every messenger does now, and better than the sheet it replaces for
/// one reason: the sheet covered the message it was about, so the reader
/// chose "Delete" without seeing what they were deleting.
class MessageFocus extends StatelessWidget {
  /// Where the message is on screen, in global coordinates.
  final Rect rect;

  /// The message, drawn again at [rect]'s size.
  final Widget message;

  /// Which side the message hangs from: the menu and the reactions line up
  /// with it.
  final bool alignEnd;

  /// The quick reactions, or null for a message that cannot take one.
  final Widget? reactions;

  final List<SheetAction<String>> actions;
  final Animation<double> animation;

  const MessageFocus({
    super.key,
    required this.rect,
    required this.message,
    required this.alignEnd,
    required this.actions,
    required this.animation,
    this.reactions,
  });

  /// Lifts [message] out of the page and answers what was chosen, or null
  /// when the reader tapped away.
  ///
  /// [reactions] is handed a function that closes the overlay with a value,
  /// for the reaction row's own taps.
  static Future<String?> show(
    BuildContext context, {
    required Rect rect,
    required Widget message,
    required bool alignEnd,
    required List<SheetAction<String>> actions,
    Widget Function(void Function(String value) choose)? reactions,
  }) {
    return Navigator.of(context, rootNavigator: true).push<String>(
      PageRouteBuilder<String>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionDuration: MotionTokens.normal,
        reverseTransitionDuration: MotionTokens.fast,
        pageBuilder: (overlay, animation, _) => MessageFocus(
          rect: rect,
          message: message,
          alignEnd: alignEnd,
          actions: actions,
          animation: animation,
          reactions: reactions?.call(
            (value) => Navigator.of(overlay).pop(value),
          ),
        ),
      ),
    );
  }

  /// A row of the menu.
  static const double rowHeight = 44;

  /// The reactions' pill.
  static const double reactionsHeight = 52;

  static const double menuWidth = 232;
  static const double _gap = SpacingTokens.space8;

  /// The nearest anything comes to the screen's side.
  static const double _edge = SpacingTokens.space12;

  /// How much the message grows as it lifts.
  static const double _lift = 1.03;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final size = media.size;

    // The room there is: inside the safe area, and above the keyboard if it
    // is up.
    final top = media.padding.top + SpacingTokens.space12;
    final bottom = size.height -
        math.max(media.padding.bottom, media.viewInsets.bottom) -
        SpacingTokens.space12;

    final above = reactions == null ? 0.0 : reactionsHeight + _gap;
    final menuHeight = actions.length * rowHeight + 1.0 * (actions.length - 1);
    final below = _gap + menuHeight;

    // A message too tall to fit between its reactions and its menu is shown
    // from its top, cut off at the bottom: the menu matters more than the
    // last lines of something the reader has just been reading.
    final height = math.min(rect.height, bottom - top - above - below);

    // Where it lands: where it was, unless that pushes the menu off the
    // bottom or the reactions off the top.
    final landed = (rect.top)
        .clamp(top + above, math.max(top + above, bottom - below - height))
        .toDouble();

    // The menu's left edge: under the message's own side, kept on screen.
    final menuLeft = (alignEnd ? rect.right - menuWidth : rect.left)
        .clamp(_edge, math.max(_edge, size.width - menuWidth - _edge))
        .toDouble();

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = Curves.easeOutCubic.transform(animation.value);
        final y = lerpDouble(rect.top, landed, t)!;

        return Stack(
          children: [
            // The conversation, out of focus and a shade darker. A tap
            // anywhere on it puts the message back.
            Positioned.fill(
              child: GestureDetector(
                key: const ValueKey('message-focus-backdrop'),
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18 * t, sigmaY: 18 * t),
                  child: ColoredBox(
                    color: Colors.black.withValues(alpha: 0.22 * t),
                  ),
                ),
              ),
            ),
            // Over the message, from the side it hangs from.
            if (reactions != null)
              Positioned(
                top: y - above,
                height: reactionsHeight,
                left: alignEnd ? null : math.max(_edge, rect.left),
                right:
                    alignEnd ? math.max(_edge, size.width - rect.right) : null,
                child: _Appear(
                  t: t,
                  alignment:
                      alignEnd ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: _Pill(child: reactions!),
                ),
              ),
            Positioned(
              key: const ValueKey('message-focus-message'),
              top: y,
              left: rect.left,
              width: rect.width,
              height: height,
              child: Transform.scale(
                scale: lerpDouble(1, _lift, t),
                alignment:
                    alignEnd ? Alignment.centerRight : Alignment.centerLeft,
                child: ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.topCenter,
                    minHeight: rect.height,
                    maxHeight: rect.height,
                    child: IgnorePointer(child: message),
                  ),
                ),
              ),
            ),
            Positioned(
              top: y + height + _gap,
              left: menuLeft,
              width: menuWidth,
              child: _Appear(
                t: t,
                alignment: alignEnd ? Alignment.topRight : Alignment.topLeft,
                child: _Menu(
                  actions: actions,
                  onPick: (value) => Navigator.of(context).pop(value),
                  scheme: scheme,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Grows out of the message's side, rather than appearing whole.
class _Appear extends StatelessWidget {
  final double t;
  final Alignment alignment;
  final Widget child;

  const _Appear({
    required this.t,
    required this.alignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: lerpDouble(0.86, 1, t),
          alignment: alignment,
          child: child,
        ),
      );
}

/// The quick reactions' pill, floating over the blur.
class _Pill extends StatelessWidget {
  final Widget child;

  const _Pill({required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLow,
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: StadiumBorder(side: postRule(scheme)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space4),
        child: child,
      ),
    );
  }
}

/// What can be done to the message: one row each, a hairline between, the
/// one that removes something in the error colour.
class _Menu extends StatelessWidget {
  final List<SheetAction<String>> actions;
  final void Function(String value) onPick;
  final ColorScheme scheme;

  const _Menu({
    required this.actions,
    required this.onPick,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surfaceContainerLow,
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.radius16),
        side: postRule(scheme),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, action) in actions.indexed) ...[
            if (index > 0) const Hairline(),
            InkWell(
              key: ValueKey('message-focus-${action.value}'),
              onTap: () => onPick(action.value),
              child: SizedBox(
                height: MessageFocus.rowHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          action.label,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            color: action.destructive
                                ? scheme.error
                                : scheme.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        action.icon,
                        size: 20,
                        color: action.destructive
                            ? scheme.error
                            : scheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
