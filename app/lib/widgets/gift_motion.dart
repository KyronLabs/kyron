// lib/widgets/gift_motion.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The colours a gift's sparkles come in: the coin's gold and the warm
/// colours around it, so a burst reads as a gift and never as an error.
const giftSparkleColours = [
  Color(0xFFF2B233),
  Color(0xFFFFD66B),
  Color(0xFFFF8A3D),
  Color(0xFFFF5C8A),
];

/// The four-pointed star every gift sparkle is drawn as.
Path sparklePath(Offset centre, double radius) {
  final waist = radius * 0.28;
  return Path()
    ..moveTo(centre.dx, centre.dy - radius)
    ..quadraticBezierTo(
      centre.dx + waist,
      centre.dy - waist,
      centre.dx + radius,
      centre.dy,
    )
    ..quadraticBezierTo(
      centre.dx + waist,
      centre.dy + waist,
      centre.dx,
      centre.dy + radius,
    )
    ..quadraticBezierTo(
      centre.dx - waist,
      centre.dy + waist,
      centre.dx - radius,
      centre.dy,
    )
    ..quadraticBezierTo(
      centre.dx - waist,
      centre.dy - waist,
      centre.dx,
      centre.dy - radius,
    )
    ..close();
}

/// A gift doing what it does while it waits to be picked: a spark twinkles,
/// a rose sways, fire flickers, a star turns, a gem catches the light, a
/// cake bobs, a crown tilts and a rocket hovers.
///
/// Three rounds and then still, rather than forever. A grid of eight things
/// moving without end is a grid nobody can read, and a sheet that never
/// stops animating never lets the screen settle. Picking one plays it again.
class GiftMotion extends StatefulWidget {
  final String type;

  /// Whether it moves at all: a gift the wallet cannot cover stays still.
  final bool playing;

  /// Bumped to play it again from the start: the tile passes its picked
  /// state, so a pick sets it off.
  final bool picked;

  final Widget child;

  const GiftMotion({
    super.key,
    required this.type,
    required this.playing,
    required this.picked,
    required this.child,
  });

  /// One round of a gift's motion.
  static const round = Duration(milliseconds: 2400);

  /// How many rounds it plays before it rests.
  static const rounds = 3;

  @override
  State<GiftMotion> createState() => _GiftMotionState();
}

class _GiftMotionState extends State<GiftMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: GiftMotion.round * GiftMotion.rounds,
  );

  bool _still = false;

  /// Where in its round each gift starts, so eight of them do not move in
  /// step like a drill team.
  double get _offset => (widget.type.hashCode % 1000) / 1000;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _still = MediaQuery.disableAnimationsOf(context);
    if (_still) {
      _clock.stop();
      _clock.value = 0;
    } else if (widget.playing && !_clock.isAnimating && _clock.value == 0) {
      _clock.forward();
    }
  }

  @override
  void didUpdateWidget(GiftMotion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_still) return;
    if (!widget.playing) {
      _clock.stop();
      _clock.value = 0;
    } else if (widget.picked && !oldWidget.picked) {
      _clock.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _clock,
      child: widget.child,
      builder: (context, child) {
        final v = _clock.value;
        if (v == 0 || v == 1) return child!;
        // Eased in and out of the whole run, so it starts from rest and comes
        // back to it rather than snapping.
        final envelope = math.min(1.0, math.min(v, 1 - v) * 14);
        final phase = (v * GiftMotion.rounds + _offset) % 1;
        return giftPose(widget.type, phase, envelope, child!);
      },
    );
  }
}

/// [child] posed as [type] at [phase] through its round, at [strength]: 0 is
/// at rest, 1 is the full motion.
Widget giftPose(String type, double phase, double strength, Widget child) {
  final w = phase * 2 * math.pi;
  final s = strength;
  switch (type) {
    case 'spark':
      return Transform.rotate(
        angle: 0.14 * math.sin(w) * s,
        child: Transform.scale(
          scale: 1 + 0.10 * math.sin(2 * w) * s,
          child: child,
        ),
      );
    case 'rose':
      return Transform.rotate(
        angle: 0.11 * math.sin(w) * s,
        alignment: Alignment.bottomCenter,
        child: child,
      );
    case 'fire':
      // Taller and thinner, then shorter and wider, from the base: a flame
      // breathes from where it burns.
      final f = math.sin(3 * w) * 0.6 + math.sin(7 * w) * 0.4;
      return Transform(
        alignment: Alignment.bottomCenter,
        transform: Matrix4.diagonal3Values(
          1 - 0.04 * f * s,
          1 + 0.08 * f * s,
          1,
        ),
        child: child,
      );
    case 'star':
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(0.65 * math.sin(w) * s),
        child: child,
      );
    case 'gem':
      // A glint across the face, once a round, through the gem's own shape.
      final sweep = (phase * 1.6 - 0.3);
      return ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (rect) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.6 * s),
            Colors.white.withValues(alpha: 0),
          ],
          stops: [
            (sweep - 0.12).clamp(0.0, 1.0),
            sweep.clamp(0.0, 1.0),
            (sweep + 0.12).clamp(0.0, 1.0),
          ],
        ).createShader(rect),
        child: Transform.scale(
          scale: 1 + 0.04 * math.sin(w) * s,
          child: child,
        ),
      );
    case 'cake':
      final hop = math.sin(w).abs();
      return Transform.translate(
        offset: Offset(0, -3.5 * hop * s),
        child: Transform(
          alignment: Alignment.bottomCenter,
          // A little squash on landing.
          transform: Matrix4.diagonal3Values(
            1 + 0.04 * (1 - hop) * s,
            1 - 0.04 * (1 - hop) * s,
            1,
          ),
          child: child,
        ),
      );
    case 'crown':
      return Transform.translate(
        offset: Offset(0, -1.5 * math.sin(2 * w) * s),
        child: Transform.rotate(
          angle: 0.13 * math.sin(w) * s,
          child: child,
        ),
      );
    case 'rocket':
      // Hovering on its engine: a slow rise and fall with a fine shake.
      return Transform.translate(
        offset: Offset(
          0.6 * math.sin(11 * w) * s,
          -3.5 * math.sin(w) * s,
        ),
        child: Transform.rotate(
          angle: 0.05 * math.sin(2 * w) * s,
          child: child,
        ),
      );
    default:
      return Transform.translate(
        offset: Offset(0, -2.5 * math.sin(w) * s),
        child: child,
      );
  }
}

/// The burst behind a gift as it is sent: sparkles thrown out in a ring,
/// a second ring of motes after them, and a glow under it all.
class GiftBurstPainter extends CustomPainter {
  /// How far through the burst, 0 to 1.
  final double t;

  const GiftBurstPainter({required this.t});

  static const _sparkles = 14;
  static const _motes = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = size.center(Offset.zero);
    final reach = size.shortestSide / 2;

    // The glow: up quickly, out slowly.
    final glow = Curves.easeOut.transform((t * 2.5).clamp(0, 1)) *
        (1 - Curves.easeIn.transform(t));
    canvas.drawCircle(
      centre,
      reach * (0.45 + 0.25 * t),
      Paint()
        ..shader = RadialGradient(
          colors: [
            giftSparkleColours[1].withValues(alpha: 0.7 * glow),
            giftSparkleColours[0].withValues(alpha: 0),
          ],
        ).createShader(
          Rect.fromCircle(center: centre, radius: reach * (0.45 + 0.25 * t)),
        ),
    );

    final out = Curves.easeOutCubic.transform(t);
    final fade = 1 - Curves.easeInQuad.transform(t);

    for (var i = 0; i < _sparkles; i++) {
      final angle = i * 2 * math.pi / _sparkles + 0.3 * math.sin(i * 7.0);
      final distance = reach * (0.32 + 0.6 * out) * (0.85 + 0.15 * (i % 3));
      final at = centre + Offset(math.cos(angle), math.sin(angle)) * distance;
      // Each one twinkles as it goes: up, down and up again.
      final twinkle = 0.65 + 0.35 * math.sin(t * 14 + i);
      final radius = (6.0 + 4.0 * (i % 2)) * fade * twinkle;
      if (radius <= 0.2) continue;
      canvas.drawPath(
        sparklePath(at, radius),
        Paint()
          ..color = giftSparkleColours[i % giftSparkleColours.length]
              .withValues(alpha: fade),
      );
    }

    // The motes start late and go further, so the burst has depth.
    final late = ((t - 0.15) / 0.85).clamp(0.0, 1.0);
    if (late > 0) {
      final drift = Curves.easeOut.transform(late);
      for (var i = 0; i < _motes; i++) {
        final angle = i * 2 * math.pi / _motes + 0.17;
        final distance = reach * (0.5 + 0.48 * drift);
        final at = centre +
            Offset(math.cos(angle), math.sin(angle)) * distance +
            Offset(0, 6 * drift);
        canvas.drawCircle(
          at,
          2.4 * (1 - late),
          Paint()
            ..color = giftSparkleColours[(i + 1) % giftSparkleColours.length]
                .withValues(alpha: 1 - late),
        );
      }
    }
  }

  @override
  bool shouldRepaint(GiftBurstPainter oldDelegate) => oldDelegate.t != t;
}

/// A gift flying from where it was sent to the heart it is about to become.
///
/// In the root overlay, so it passes over the sheet as the sheet goes and
/// over whatever the post sits in. [onArrive] is called once it is there,
/// or once it is gone for any other reason, so the heart always changes.
abstract final class GiftFlight {
  static const duration = Duration(milliseconds: 720);

  static void fly(
    BuildContext context, {
    required Widget art,
    required Rect from,
    required Offset to,
    required double landingSize,
    required VoidCallback onArrive,
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    late final OverlayEntry entry;
    var arrived = false;
    void arrive() {
      if (arrived) return;
      arrived = true;
      onArrive();
    }

    entry = OverlayEntry(
      builder: (_) => _Flight(
        art: art,
        from: from,
        to: to,
        landingSize: landingSize,
        onDone: () {
          entry.remove();
          entry.dispose();
          arrive();
        },
        onGone: arrive,
      ),
    );
    overlay.insert(entry);
  }
}

class _Flight extends StatefulWidget {
  final Widget art;
  final Rect from;
  final Offset to;
  final double landingSize;
  final VoidCallback onDone;
  final VoidCallback onGone;

  const _Flight({
    required this.art,
    required this.from,
    required this.to,
    required this.landingSize,
    required this.onDone,
    required this.onGone,
  });

  @override
  State<_Flight> createState() => _FlightState();
}

class _FlightState extends State<_Flight> with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController(
    vsync: this,
    duration: GiftFlight.duration,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onDone();
    })
    ..forward();

  @override
  void dispose() {
    _t.dispose();
    widget.onGone();
    super.dispose();
  }

  /// Where the gift is at [t]: an arc up and over, rather than a straight
  /// line, so it reads as thrown rather than slid.
  Offset _at(double t) {
    final a = widget.from.center;
    final b = widget.to;
    final control = Offset(
      a.dx + (b.dx - a.dx) * 0.15,
      math.min(a.dy, b.dy) - 90,
    );
    final u = 1 - t;
    return a * (u * u) + control * (2 * u * t) + b * (t * t);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final raw = _t.value;
          final t = Curves.easeInOutCubic.transform(raw);
          final shrink = Curves.easeInCubic.transform(raw);
          final size = widget.from.width +
              (widget.landingSize - widget.from.width) * shrink;
          final at = _at(t);
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _TrailPainter(
                    points: [
                      for (var k = 1; k <= 7; k++)
                        if (t - k * 0.045 > 0)
                          _at(Curves.easeInOutCubic
                              .transform((raw - k * 0.045).clamp(0, 1))),
                    ],
                    fade: 1 - raw * 0.4,
                  ),
                ),
              ),
              Positioned(
                left: at.dx - size / 2,
                top: at.dy - size / 2,
                width: size,
                height: size,
                // Gone in the last few frames, as the heart takes its place.
                child: Opacity(
                  opacity: raw > 0.92 ? (1 - raw) / 0.08 : 1,
                  child: Transform.rotate(
                    angle: 0.45 * math.sin(math.pi * t),
                    child: child,
                  ),
                ),
              ),
            ],
          );
        },
        child: FittedBox(child: widget.art),
      ),
    );
  }
}

/// The sparkles a flying gift leaves behind it.
class _TrailPainter extends CustomPainter {
  final List<Offset> points;
  final double fade;

  const _TrailPainter({required this.points, required this.fade});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < points.length; i++) {
      final left = 1 - (i + 1) / (points.length + 1);
      canvas.drawPath(
        sparklePath(points[i], 2 + 4 * left),
        Paint()
          ..color = giftSparkleColours[i % giftSparkleColours.length]
              .withValues(alpha: left * fade),
      );
    }
  }

  @override
  bool shouldRepaint(_TrailPainter oldDelegate) => true;
}
