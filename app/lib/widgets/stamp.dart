// lib/widgets/stamp.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'verified_badge.dart';

/// Postage stamps: a perforated edge, a painted landscape, and bold type on
/// top of it.
///
/// After a strip of stamps cut from one woodblock print -- sky, a house on
/// a crag, a river below -- with a line of type on each, and the heavy,
/// generous type of a landing page that puts a pill-shaped switch in the
/// middle of a sentence. The picture here is painted in code, not copied:
/// sky, sun, two ranges of hills, pines, rocks and water, in flat colours
/// the way a print lays them down.

/// The outline of a sheet of stamps: a rectangle bitten round its edge, and
/// along [rows] internal lines where it tears.
class StampClipper extends CustomClipper<Path> {
  /// Fractions of the height where the sheet is perforated between stamps.
  final List<double> rows;

  /// Radius of each bite, and the distance between their centres.
  final double hole;
  final double pitch;

  const StampClipper({this.rows = const [], this.hole = 4, this.pitch = 13});

  @override
  Path getClip(Size size) {
    final sheet = Path()..addRect(Offset.zero & size);
    final holes = Path();

    void along(Offset from, Offset to) {
      final length = (to - from).distance;
      final count = math.max(1, (length / pitch).round());
      final step = (to - from) / count.toDouble();
      for (var i = 0; i <= count; i++) {
        holes.addOval(
            Rect.fromCircle(center: from + step * i.toDouble(), radius: hole));
      }
    }

    final w = size.width;
    final h = size.height;
    along(Offset.zero, Offset(w, 0));
    along(Offset(0, h), Offset(w, h));
    along(Offset.zero, Offset(0, h));
    along(Offset(w, 0), Offset(w, h));
    for (final row in rows) {
      // Inside the sheet the holes are smaller, as a perforating wheel makes
      // them, and stop short of the edges so the sheet still holds together.
      final y = h * row;
      final inner = Path();
      final count = math.max(1, ((w - pitch * 2) / pitch).round());
      final step = (w - pitch * 2) / count;
      for (var i = 0; i <= count; i++) {
        inner.addOval(
          Rect.fromCircle(
              center: Offset(pitch + step * i, y), radius: hole * 0.6),
        );
      }
      holes.addPath(inner, Offset.zero);
    }
    return Path.combine(PathOperation.difference, sheet, holes);
  }

  @override
  bool shouldReclip(StampClipper old) =>
      old.rows.length != rows.length || old.hole != hole || old.pitch != pitch;
}

/// The landscape behind the type.
class StampLandscape extends CustomPainter {
  /// Darker, for type that has to sit over the whole of it.
  final bool dim;

  /// Where the water starts, as a fraction of the height. Lower in a tall
  /// strip, so the last panel's type sits on rock rather than on waves.
  final double waterline;

  const StampLandscape({this.dim = false, this.waterline = 0.78});

  /// The top of the sky: the colour a tick takes on a white badge here.
  static const skyTop = Color(0xFF1C97D4);
  static const _skyTop = skyTop;
  static const _skyMid = Color(0xFF6CC6EC);
  static const _horizon = Color(0xFFF5BF94);
  static const _farHills = Color(0xFF7F8DB9);
  static const _nearHills = Color(0xFF3B4874);
  static const _pines = Color(0xFF2C4A40);
  static const _rock = Color(0xFF2E3347);
  static const _rockLight = Color(0xFF555D7E);
  static const _water = Color(0xFF1898BE);
  static const _waterDeep = Color(0xFF0D6A8E);
  static const _foam = Color(0xFFD9F5FA);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    Offset p(double x, double y) => Offset(w * x, h * y);
    Paint flat(Color c) => Paint()..color = c;

    // Sky, from a clear blue down to the warm band above the hills.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_skyTop, _skyMid, _horizon],
          stops: [0, 0.32, 0.52],
        ).createShader(Offset.zero & size),
    );

    // A low sun, half behind the far hills.
    canvas.drawCircle(
      p(0.70, 0.44),
      w * 0.07,
      flat(const Color(0xFFFFE6C2).withValues(alpha: 0.9)),
    );

    // Birds, a few strokes high up.
    final birds = Paint()
      ..color = const Color(0xFF243553)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, w * 0.004)
      ..strokeCap = StrokeCap.round;
    for (final b in const [
      Offset(0.64, 0.12),
      Offset(0.70, 0.16),
      Offset(0.84, 0.08),
    ]) {
      final c = p(b.dx, b.dy);
      final s = w * 0.012;
      canvas.drawPath(
        Path()
          ..moveTo(c.dx - s, c.dy)
          ..quadraticBezierTo(c.dx - s / 2, c.dy - s * 0.6, c.dx, c.dy)
          ..quadraticBezierTo(c.dx + s / 2, c.dy - s * 0.6, c.dx + s, c.dy),
        birds,
      );
    }

    // The far range.
    canvas.drawPath(
      Path()
        ..moveTo(0, h * 0.54)
        ..lineTo(w * 0.16, h * 0.42)
        ..lineTo(w * 0.30, h * 0.48)
        ..lineTo(w * 0.50, h * 0.33)
        ..lineTo(w * 0.70, h * 0.47)
        ..lineTo(w * 0.86, h * 0.39)
        ..lineTo(w, h * 0.45)
        ..lineTo(w, h * 0.66)
        ..lineTo(0, h * 0.66)
        ..close(),
      flat(_farHills),
    );

    // The near range: a long dark slope rising to the right.
    final near = Path()..moveTo(w * _ridge.first.dx, h * _ridge.first.dy);
    for (final point in _ridge.skip(1)) {
      near.lineTo(w * point.dx, h * point.dy);
    }
    near
      ..lineTo(w, h * 0.74)
      ..close();
    canvas.drawPath(near, flat(_nearHills));

    // Pines standing on that ridge, stacked triangles as a print cuts them.
    // Sized by the shorter side, so a tall strip does not grow giant trees.
    final unit = math.min(w, h);
    for (final x in const [0.60, 0.68, 0.74, 0.88]) {
      _pine(canvas, Offset(w * x, h * _ridgeAt(x) + unit * 0.02), unit * 0.16,
          _pines);
    }
    _pine(canvas, p(0.16, 0.66), unit * 0.26, _pines);

    // Rocks the water runs between.
    final rock = flat(_rock);
    canvas.drawPath(
      Path()
        ..moveTo(0, h * 0.64)
        ..lineTo(w * 0.22, h * 0.62)
        ..lineTo(w * 0.44, h * 0.70)
        ..lineTo(w * 0.62, h * 0.66)
        ..lineTo(w, h * 0.70)
        ..lineTo(w, h)
        ..lineTo(0, h)
        ..close(),
      rock,
    );
    final grain = Paint()
      ..color = _rockLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, w * 0.004);
    for (final g in const [
      [0.05, 0.70, 0.18, 0.67],
      [0.30, 0.74, 0.40, 0.72],
      [0.58, 0.72, 0.74, 0.70],
      [0.82, 0.76, 0.95, 0.74],
    ]) {
      canvas.drawLine(p(g[0], g[1]), p(g[2], g[3]), grain);
    }

    // Water, deepening towards the bottom, with lines of foam.
    final waterRect = Rect.fromLTRB(0, h * waterline, w, h);
    canvas.drawRect(
      waterRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_water, _waterDeep],
        ).createShader(waterRect),
    );
    final foam = Paint()
      ..color = _foam
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, unit * 0.012)
      ..strokeCap = StrokeCap.round;
    for (var row = 0; row < 4; row++) {
      final y = h * (waterline + 0.03) + unit * row * 0.07;
      if (y > h) break;
      final wave = Path()..moveTo(0, y);
      const crests = 7;
      for (var i = 0; i < crests; i++) {
        final x1 = w * (i + 0.5) / crests;
        final x2 = w * (i + 1) / crests;
        final lift = unit * (0.012 + 0.006 * ((i + row) % 2));
        wave
          ..quadraticBezierTo(x1 - w * 0.02, y - lift * 2, x1, y - lift)
          ..quadraticBezierTo(x1 + w * 0.03, y + lift, x2, y);
      }
      canvas.drawPath(
          wave, foam..color = _foam.withValues(alpha: 0.9 - row * 0.15));
    }

    if (dim) {
      canvas.drawRect(
        Offset.zero & size,
        flat(Colors.black.withValues(alpha: 0.18)),
      );
    }
  }

  /// The near ridge, left to right, as fractions of the size.
  static const _ridge = [
    Offset(0.30, 0.70),
    Offset(0.55, 0.45),
    Offset(0.78, 0.27),
    Offset(1.00, 0.20),
  ];

  /// How high the ridge is at [x], as a fraction of the height.
  static double _ridgeAt(double x) {
    for (var i = 1; i < _ridge.length; i++) {
      final a = _ridge[i - 1];
      final b = _ridge[i];
      if (x <= b.dx) {
        return a.dy + (b.dy - a.dy) * ((x - a.dx) / (b.dx - a.dx));
      }
    }
    return _ridge.last.dy;
  }

  void _pine(Canvas canvas, Offset base, double height, Color colour) {
    final paint = Paint()..color = colour;
    final width = height * 0.42;
    for (var tier = 0; tier < 3; tier++) {
      final top = base.dy - height * (0.45 + tier * 0.22);
      final bottom = base.dy - height * (tier * 0.22);
      final half = width * (1 - tier * 0.25) / 2;
      canvas.drawPath(
        Path()
          ..moveTo(base.dx, top)
          ..lineTo(base.dx + half, bottom)
          ..lineTo(base.dx - half, bottom)
          ..close(),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StampLandscape old) =>
      old.dim != dim || old.waterline != waterline;
}

/// Type on a stamp: heavy, white, and a little shadow so it holds over the
/// lighter parts of the picture.
TextStyle stampType(double size, {FontWeight weight = FontWeight.w700}) =>
    TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: weight,
      height: 1.05,
      // Tight, as large type wants: the heaviest weight Inter ships here is
      // Bold, and closing it up is what makes it read as heavy.
      letterSpacing: size >= 20 ? -0.6 : -0.1,
      shadows: const [
        Shadow(color: Color(0x66000000), blurRadius: 6, offset: Offset(0, 1)),
      ],
    );

/// One stamp, for a single message: the sidebar's way into verification.
class StampCard extends StatelessWidget {
  final String title;
  final String subtitle;

  /// The corner mark: the badge, as a stamp carries its value.
  final bool showBadge;
  final VoidCallback? onTap;
  final double height;

  const StampCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBadge = true,
    this.onTap,
    this.height = 112,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onTap != null,
      label: '$title. $subtitle',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: ClipPath(
            clipper: const StampClipper(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const CustomPaint(
                  painter: StampLandscape(dim: true, waterline: 0.9),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    SpacingTokens.space16,
                    SpacingTokens.space12,
                    SpacingTokens.space12,
                    SpacingTokens.space12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: stampType(22),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: stampType(12, weight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      if (showBadge)
                        const VerifiedBadge(
                          size: 28,
                          color: Colors.white,
                          tick: StampLandscape.skyTop,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A strip of stamps cut from one picture, with a line of type on each:
/// the steps of verification, in the order they happen.
class StampStrip extends StatelessWidget {
  final List<({String title, String detail})> panels;
  final double panelHeight;

  const StampStrip({
    super.key,
    required this.panels,
    this.panelHeight = 156,
  });

  @override
  Widget build(BuildContext context) {
    final n = panels.length;
    return SizedBox(
      height: panelHeight * n,
      child: ClipPath(
        clipper: StampClipper(rows: [for (var i = 1; i < n; i++) i / n]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(
              painter: StampLandscape(dim: true, waterline: 0.9),
            ),
            Column(
              children: [
                for (var i = 0; i < n; i++)
                  SizedBox(
                    height: panelHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingTokens.space20),
                      child: Align(
                        // Left, right, left: the way the type steps down the
                        // strip it was drawn from.
                        alignment:
                            i.isEven ? Alignment.topLeft : Alignment.topRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: i.isEven
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Text(
                              panels[i].title,
                              textAlign:
                                  i.isEven ? TextAlign.left : TextAlign.right,
                              style: stampType(26),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              panels[i].detail,
                              textAlign:
                                  i.isEven ? TextAlign.left : TextAlign.right,
                              style: stampType(13, weight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '0${i + 1}',
                              style: stampType(11, weight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
