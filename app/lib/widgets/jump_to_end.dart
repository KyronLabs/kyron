// lib/widgets/jump_to_end.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Which way the button sends the reader.
enum JumpDirection {
  /// Back to the first row. What a comment thread wants: the post and the
  /// comment the conversation is about are at the top.
  top,

  /// Down to the last row. What a chat wants: the newest message is the end.
  bottom,
}

/// A button that returns the reader to one end of a long list.
///
/// Shown only once the list has actually moved away from that end, and only
/// while there is somewhere to go: a control that is always on screen and
/// often does nothing is worse than no control.
class JumpToEnd extends StatefulWidget {
  final ScrollController controller;
  final JumpDirection direction;

  /// How far from the target end the list has to be before the button
  /// appears. A screen or so: a couple of rows is not lost.
  final double after;

  /// Drawn over the button, for the chat's unread count. Hidden when zero.
  final int badge;

  const JumpToEnd({
    super.key,
    required this.controller,
    required this.direction,
    this.after = 600,
    this.badge = 0,
  });

  @override
  State<JumpToEnd> createState() => _JumpToEndState();
}

class _JumpToEndState extends State<JumpToEnd> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(JumpToEnd old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.controller.hasClients) return;
    final position = widget.controller.position;
    // Distance to the end this button goes to, not to the end the list is
    // scrolled from -- they are opposite ends and mixing them up shows the
    // button exactly when it is useless.
    final away = widget.direction == JumpDirection.top
        ? position.pixels - position.minScrollExtent
        : position.maxScrollExtent - position.pixels;
    final show = away > widget.after;
    if (show != _show) setState(() => _show = show);
  }

  Future<void> _jump() async {
    if (!widget.controller.hasClients) return;
    final position = widget.controller.position;
    final target = widget.direction == JumpDirection.top
        ? position.minScrollExtent
        : position.maxScrollExtent;

    // Jumped rather than animated when the distance is long: scrolling
    // through a thousand rows at a readable speed takes longer than the
    // reader is willing to watch, and animating it builds every row on the
    // way past.
    if ((position.pixels - target).abs() > 4000) {
      widget.controller.jumpTo(target);
      return;
    }
    await widget.controller.animateTo(
      target,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      offset: _show
          ? Offset.zero
          : Offset(0, widget.direction == JumpDirection.top ? -0.6 : 0.6),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: _show ? 1 : 0,
        // Not just invisible: an offscreen button that still takes taps is a
        // dead spot the reader cannot see or explain.
        child: IgnorePointer(
          ignoring: !_show,
          child: Material(
            elevation: 3,
            shape: const CircleBorder(),
            color: scheme.surfaceContainerHighest,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _jump,
              child: SizedBox.square(
                dimension: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      widget.direction == JumpDirection.top
                          ? Iconsax.arrow_up_2_copy
                          : Iconsax.arrow_down_1_copy,
                      size: 18,
                      color: scheme.onSurface,
                    ),
                    if (widget.badge > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            widget.badge > 99 ? '99+' : '${widget.badge}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: scheme.onPrimary,
                            ),
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
