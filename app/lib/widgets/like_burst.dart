// lib/widgets/like_burst.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The flourish behind a like: a ring going out, and sparks after it.
///
/// Painted rather than assembled from widgets, because it is one short-lived
/// drawing over a control in a scrolling list. A stack of AnimatedContainers
/// for every post in the feed is a lot of elements standing by to do nothing.
///
/// Drawn *behind* the icon and clipped by nothing, so it can spill outside the
/// button. The row leaves it room; see [LikeBurst.reach].
class LikeBurstPainter extends CustomPainter {
  /// 0 at the tap, 1 when it is over.
  final double t;

  /// The like colour. Sparks are drawn from it and two neighbours, so the
  /// burst reads as one thing rather than confetti.
  final Color colour;

  const LikeBurstPainter({required this.t, required this.colour});

  /// How many sparks. Six reads as deliberate; more looks like a party popper
  /// on a control somebody presses while reading.
  static const int sparks = 6;

  /// Turned off the vertical, so no spark shoots straight up the middle where
  /// the eye is already looking.
  static const double _phase = math.pi / 7;

  @override
  void paint(Canvas canvas, Size size) {
    if (t <= 0 || t >= 1) return;
    final centre = size.center(Offset.zero);
    final reach = size.shortestSide / 2;

    _ring(canvas, centre, reach);
    _sparks(canvas, centre, reach);
  }

  /// A circle on its way out, its edge thinning as it goes.
  ///
  /// Front-loaded: it is gone by the time the sparks are properly out, which
  /// is what makes the two read as one movement rather than two.
  void _ring(Canvas canvas, Offset centre, double reach) {
    const until = 0.45;
    if (t >= until) return;
    final p = t / until;

    // Fast out of the gate and slowing, which is how something thrown moves.
    final eased = 1 - math.pow(1 - p, 3).toDouble();
    final radius = reach * (0.15 + 0.75 * eased);
    final width = 5.0 * (1 - eased);
    if (width <= 0) return;

    canvas.drawCircle(
      centre,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..color = colour.withValues(alpha: (1 - p) * 0.55),
    );
  }

  /// Dots thrown outward, swelling and then shrinking to nothing.
  void _sparks(Canvas canvas, Offset centre, double reach) {
    const from = 0.12;
    if (t <= from) return;
    final p = ((t - from) / (1 - from)).clamp(0.0, 1.0);
    final eased = 1 - math.pow(1 - p, 2.4).toDouble();

    for (var i = 0; i < sparks; i++) {
      final angle = _phase + i * 2 * math.pi / sparks;
      // Alternating throws, so the ring of dots is not a perfect wheel.
      final far = reach * (i.isEven ? 0.92 : 0.76);
      final at =
          centre + Offset(math.cos(angle), math.sin(angle)) * far * eased;

      // Out to full size a third of the way, then away to nothing.
      final swell = p < 0.35 ? p / 0.35 : 1 - ((p - 0.35) / 0.65);
      final dot = 2.6 * swell;
      if (dot <= 0) continue;

      canvas.drawCircle(
        at,
        dot,
        Paint()..color = _sparkColour(i).withValues(alpha: swell.clamp(0, 1)),
      );
    }
  }

  /// Three tones around the like colour rather than one flat red: a burst in a
  /// single colour reads as a smudge, and a rainbow reads as somebody else's
  /// app.
  Color _sparkColour(int i) {
    final hsl = HSLColor.fromColor(colour);
    return switch (i % 3) {
      0 => colour,
      1 => hsl.withHue((hsl.hue + 18) % 360).withLightness(0.62).toColor(),
      _ => hsl.withHue((hsl.hue - 14) % 360).withLightness(0.58).toColor(),
    };
  }

  @override
  bool shouldRepaint(LikeBurstPainter old) =>
      old.t != t || old.colour != colour;
}

/// How the icon itself moves, as a multiplier on its size.
///
/// A dip before the swell. Pressing something soft is the reference: it gives
/// before it springs, and skipping the give is what makes a scale-up read as a
/// pop-up rather than a press.
double likePunch(double t) {
  if (t <= 0 || t >= 1) return 1;
  const dip = 0.18;
  if (t < dip) return 1 - 0.16 * (t / dip);
  final p = (t - dip) / (1 - dip);
  // Overshoot, then settle. Back-out: past the target and returning.
  const c = 1.9;
  final over = 1 + (c + 1) * math.pow(p - 1, 3) + c * math.pow(p - 1, 2);
  return 0.84 + 0.16 * over.toDouble() + 0.22 * math.sin(math.pi * p);
}

/// Taking a like back is not an occasion.
///
/// It gets a dip and a return and nothing else -- no ring, no sparks. Firing
/// the same celebration in both directions is what makes a like button feel
/// like it is congratulating you for changing your mind.
double unlikePunch(double t) {
  if (t <= 0 || t >= 1) return 1;
  return 1 - 0.18 * math.sin(math.pi * t);
}
