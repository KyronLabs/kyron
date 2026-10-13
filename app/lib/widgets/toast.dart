// lib/widgets/toast.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'answer_shape.dart';

/// Where a toast appears.
enum ToastSpot {
  /// Over the middle of the screen. For something that has just happened and
  /// has no place on the page -- a copy, a saved change -- where the eye
  /// already is.
  middle,

  /// Along the bottom, above the safe area. For anything tied to what is at
  /// the bottom of the screen, and for a message long enough to want the width.
  bottom,
}

/// Something a toast can do about what it says: open the post it reports
/// as posted, the conversation it reports as sent.
///
/// A toast that says "Posted" and then disappears leaves the reader to go
/// and find the post. One button, at the end of the line, does it.
class ToastAction {
  final String label;
  final VoidCallback onPressed;

  const ToastAction(this.label, this.onPressed);
}

/// A short message over whatever is on screen.
///
/// An overlay rather than a SnackBar. A SnackBar belongs to the nearest
/// Scaffold, so it cannot appear over a full-screen viewer or a bottom sheet,
/// it slides the floating button around, and there is no way to put one in the
/// middle of the screen. This is drawn on the root overlay, so it is over
/// everything and does not move anything.
///
/// Shaped like a single poll answer: the same height, the same corner, the
/// same solid fill. One shape used in both places is one shape to recognise.
class Toast {
  const Toast._();

  /// The height and corner of a poll answer, which this borrows.
  static const double minHeight = AnswerShape.minHeight;
  static const double radius = AnswerShape.radius;

  /// How long a message stays. Long enough to read twice at this length.
  static const Duration stay = Duration(milliseconds: 2600);

  /// How long one with something to press stays: long enough to read it,
  /// decide, and reach the button.
  static const Duration stayWithAction = Duration(seconds: 5);

  /// How long it takes to arrive and to leave.
  static const Duration motion = MotionTokens.fast;

  static OverlayEntry? _entry;
  static Timer? _timer;

  /// Whether a toast is on screen. Read by tests.
  static bool get isShowing => _entry != null;

  /// Shows [message], replacing whatever was already showing.
  ///
  /// Replacing rather than queueing: two messages in a row almost always means
  /// the second one supersedes the first, and a queue makes somebody wait to
  /// be told something that is no longer true.
  static void show(
    BuildContext context,
    String message, {
    ToastSpot spot = ToastSpot.bottom,
    IconData? icon,
    Duration? stay,
    ToastAction? action,
  }) =>
      showOn(
        anchor(context),
        message,
        spot: spot,
        icon: icon,
        stay: stay,
        action: action,
      );

  /// Where a message would be drawn, captured now.
  ///
  /// For a screen that reports what it did after it has gone -- a sheet that
  /// pops and then says whether the thing it was for worked. Its context is
  /// dead by then; the overlay it was drawn on is not.
  static OverlayState? anchor(BuildContext context) =>
      Overlay.maybeOf(context, rootOverlay: true);

  /// Shows [message] on an overlay captured earlier by [anchor].
  static void showOn(
    OverlayState? overlay,
    String message, {
    ToastSpot spot = ToastSpot.bottom,
    IconData? icon,
    Duration? stay,
    ToastAction? action,
  }) {
    // No overlay means no app to show it over. Silently doing nothing is
    // right here: a message is never worth crashing a screen for.
    if (overlay == null || !overlay.mounted) return;

    dismiss();

    final entry = OverlayEntry(
      builder: (context) => _Toast(
        message: message,
        spot: spot,
        icon: icon,
        action: action,
        onTap: dismiss,
      ),
    );
    _entry = entry;
    overlay.insert(entry);

    _timer = Timer(
      stay ?? (action == null ? Toast.stay : Toast.stayWithAction),
      dismiss,
    );
  }

  /// Takes the current message away, if there is one.
  static void dismiss() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }
}

class _Toast extends StatefulWidget {
  final String message;
  final ToastSpot spot;
  final IconData? icon;
  final ToastAction? action;
  final VoidCallback onTap;

  const _Toast({
    required this.message,
    required this.spot,
    required this.icon,
    required this.action,
    required this.onTap,
  });

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Toast.motion,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottom = widget.spot == ToastSpot.bottom;

    // A Material under the words, and it is not decoration. The root overlay
    // sits above every screen's Scaffold, so nothing up here provides a text
    // style: Flutter falls back to its debug one, which underlines every
    // character with a double yellow rule and swaps the typeface. That is
    // what every toast in the app looked like. Transparent, so the card below
    // is still the only thing drawn.
    final card = Material(
      type: MaterialType.transparency,
      child: Semantics(
        liveRegion: true,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: Toast.minHeight,
              maxWidth: 420,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
              vertical: SpacingTokens.space12,
            ),
            decoration: BoxDecoration(
              color: scheme.onSurface,
              borderRadius: BorderRadius.circular(Toast.radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              // Wide enough for the words and no wider, in the middle of the
              // screen; the full width along the bottom, where a stretched pill
              // is what everything else down there looks like.
              mainAxisSize: bottom ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: scheme.surface),
                  const SizedBox(width: SpacingTokens.space12),
                ],
                Flexible(
                  // Along the bottom it takes the width, so a button after it
                  // sits at the far end rather than against the words.
                  fit: bottom ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: scheme.surface,
                    ),
                  ),
                ),
                if (widget.action case final action?) ...[
                  const SizedBox(width: SpacingTokens.space12),
                  _ActionLabel(action: action),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    final padding = MediaQuery.paddingOf(context);

    // Filling the screen without blocking it: Padding and Align only report a
    // hit where their child actually is, so everything around the card stays
    // tappable and a message never gets in the way of what it is reporting on.
    return Positioned.fill(
      child: Padding(
        // The bottom one is held off the safe area; the middle one is not
        // inset at all vertically, because an inset on one side only would
        // put "the middle of the screen" a few pixels off it.
        padding: bottom
            ? EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                padding.top + SpacingTokens.space16,
                SpacingTokens.space16,
                padding.bottom + SpacingTokens.space24,
              )
            : const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        child: Align(
          alignment: bottom ? Alignment.bottomCenter : Alignment.center,
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                // Rises into place along the bottom; the middle one only
                // fades, because sliding something into the centre of the
                // screen reads as it having come from somewhere.
                begin: bottom ? const Offset(0, 0.4) : Offset.zero,
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: card,
            ),
          ),
        ),
      ),
    );
  }
}

/// The button at the end of a toast.
///
/// The accent, made light enough to read on the dark card in a light theme
/// and left as it is on the light card in a dark one. The plain accent on
/// near-black is a dark blue on black.
class _ActionLabel extends StatelessWidget {
  final ToastAction action;

  const _ActionLabel({required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colour = theme.brightness == Brightness.dark
        ? scheme.primary
        : Color.lerp(scheme.primary, Colors.white, 0.45)!;

    return Semantics(
      button: true,
      child: InkWell(
        key: const ValueKey('toast-action'),
        borderRadius: BorderRadius.circular(Toast.radius),
        onTap: () {
          Toast.dismiss();
          action.onPressed();
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 32, minWidth: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space8,
            ),
            // Both factors: without the height one a Center is as tall as
            // it is allowed to be, and the toast with it.
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(
                action.label,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  fontWeight: FontWeight.w700,
                  color: colour,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
