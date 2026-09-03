// lib/widgets/playback_bar.dart
import 'package:flutter/material.dart';

/// The progress bar: watched, downloaded, and still to come.
///
/// Three shades rather than two. A bar that only says how far you have got
/// cannot say whether the next few seconds are ready, so a clip that stalls
/// looks like a clip that broke.
class PlaybackBar extends StatefulWidget {
  final Duration position;
  final Duration buffered;
  final Duration total;
  final ValueChanged<Duration> onSeek;

  const PlaybackBar({
    super.key,
    required this.position,
    required this.buffered,
    required this.total,
    required this.onSeek,
  });

  @override
  State<PlaybackBar> createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  /// Where the finger is, while it is down. The bar follows the finger rather
  /// than the clip during a drag; the clip catches up when it is let go.
  double? _dragging;

  double get _played {
    if (_dragging != null) return _dragging!.clamp(0.0, 1.0);
    return _fraction(widget.position);
  }

  double _fraction(Duration at) {
    final total = widget.total.inMilliseconds;
    if (total <= 0) return 0;
    return (at.inMilliseconds / total).clamp(0.0, 1.0);
  }

  void _seekTo(double fraction) {
    final at = widget.total * fraction.clamp(0.0, 1.0);
    widget.onSeek(at);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double at(Offset local) => width <= 0 ? 0 : local.dx / width;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => _seekTo(at(d.localPosition)),
          onHorizontalDragStart: (d) =>
              setState(() => _dragging = at(d.localPosition)),
          onHorizontalDragUpdate: (d) =>
              setState(() => _dragging = at(d.localPosition)),
          onHorizontalDragEnd: (_) {
            final to = _dragging;
            setState(() => _dragging = null);
            if (to != null) _seekTo(to);
          },
          child: SizedBox(
            // Taller than the bar it draws, so the bar can be thin and still
            // be something a thumb can catch.
            height: 28,
            child: CustomPaint(
              painter: _ScrubberPainter(
                played: _played,
                buffered: _fraction(widget.buffered),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}

class _ScrubberPainter extends CustomPainter {
  final double played;
  final double buffered;

  const _ScrubberPainter({required this.played, required this.buffered});

  /// Watched, downloaded, and still to come.
  static const Color _playedColor = Colors.white;
  static const Color _bufferedColor = Color(0x8CFFFFFF);
  static const Color _remainingColor = Color(0x3DFFFFFF);

  static const double _thickness = 4;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0) return;

    final top = (size.height - _thickness) / 2;
    final radius = Radius.circular(_thickness / 2);

    void bar(double fraction, Color color) {
      final width = (size.width * fraction.clamp(0.0, 1.0));
      // Nothing to draw rather than a dot at zero: a rounded cap at width
      // zero still paints a circle, which reads as a bar that has already
      // started.
      if (width <= 0) return;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, top, width, _thickness),
          radius,
        ),
        Paint()..color = color,
      );
    }

    // Painted back to front: what is left, then what has downloaded, then what
    // has been watched. Each is rounded at both ends, so the leading edge of
    // the fill is a cap rather than a cut.
    bar(1, _remainingColor);
    bar(buffered, _bufferedColor);
    bar(played, _playedColor);
  }

  @override
  bool shouldRepaint(_ScrubberPainter old) =>
      old.played != played || old.buffered != buffered;
}
