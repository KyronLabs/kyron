// lib/widgets/swipe_to_reply.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Pull a message sideways to answer it.
///
/// Every messaging app people already know does this, which is the whole
/// argument for it: replying used to be a long press, a sheet, and a tap on
/// "Reply" -- three steps for the most common thing done to a message.
///
/// The message follows the finger towards the reading direction's end (right
/// in English, left in Arabic) and an arrow fades in behind it. Past
/// [threshold] the phone ticks once, and letting go there replies; letting go
/// short of it does nothing, so a scroll that drifted sideways is harmless.
/// Pulling further than the threshold meets resistance rather than a wall.
class SwipeToReply extends StatefulWidget {
  const SwipeToReply({
    super.key,
    required this.child,
    required this.onReply,
    this.enabled = true,
  });

  final Widget child;
  final VoidCallback onReply;

  /// False for something that cannot be answered -- a message still sending
  /// has no id the server knows yet.
  final bool enabled;

  /// How far the message must travel before letting go replies.
  static const double threshold = 56;

  /// The furthest it travels, however far the finger goes.
  static const double maxTravel = 84;

  @override
  State<SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<SwipeToReply>
    with SingleTickerProviderStateMixin {
  /// How far the message has moved, always positive: the direction is applied
  /// when it is drawn.
  double _travel = 0;

  /// Past the threshold, so the haptic tick fires once per crossing rather
  /// than on every frame beyond it.
  bool _armed = false;

  late final AnimationController _settle = AnimationController(
    vsync: this,
    duration: MotionTokens.fast,
  )..addListener(() => setState(() => _travel = _from * (1 - _settle.value)));

  /// Where the settle animation starts from.
  double _from = 0;

  @override
  void dispose() {
    _settle.dispose();
    super.dispose();
  }

  bool get _rtl => Directionality.of(context) == TextDirection.rtl;

  void _update(DragUpdateDetails details) {
    // Forward is towards the end of the reading direction.
    final forward = _rtl ? -details.delta.dx : details.delta.dx;
    // Past the threshold every pixel of finger moves the message less, so it
    // feels stretched rather than stopped.
    final give = _travel < SwipeToReply.threshold ? 1.0 : 0.35;
    final next = (_travel + forward * give).clamp(0.0, SwipeToReply.maxTravel);
    if (next == _travel) return;

    final armed = next >= SwipeToReply.threshold;
    if (armed && !_armed) HapticFeedback.lightImpact();
    setState(() {
      _travel = next;
      _armed = armed;
    });
  }

  void _end([DragEndDetails? _]) {
    if (_armed) widget.onReply();
    _armed = false;
    _from = _travel;
    _settle.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final progress = math.min(1.0, _travel / SwipeToReply.threshold);
    final direction = _rtl ? -1.0 : 1.0;

    return GestureDetector(
      // Horizontal only, so the list's vertical scroll still wins every
      // gesture that is mostly up or down.
      onHorizontalDragStart: (_) => _settle.stop(),
      onHorizontalDragUpdate: _update,
      onHorizontalDragEnd: _end,
      onHorizontalDragCancel: _end,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          // Behind the message, revealed as it moves: the reply arrow, filling
          // in as the threshold nears so the reader can see how far is far
          // enough.
          if (_travel > 0)
            PositionedDirectional(
              start: 0,
              child: Opacity(
                opacity: progress,
                child: Transform.scale(
                  scale: 0.6 + 0.4 * progress,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: _armed ? 0.14 : 0.07),
                    ),
                    child: Icon(
                      Iconsax.undo_copy,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          Transform.translate(
            offset: Offset(_travel * direction, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
