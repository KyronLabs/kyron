// lib/widgets/verified_badge.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The mark beside a verified account's name: somebody on the Kyron team
/// checked it is who it says it is.
///
/// A scalloped rosette rather than an icon from the set. Its edge is the
/// same perforation as the stamp that offers it (StampCard), so the badge
/// and the place you ask for it read as one thing.
class VerifiedBadge extends StatelessWidget {
  /// How big beside a name, as a share of the name's font size.
  ///
  /// It was set by hand at each use and came out a full em or more: a solid
  /// disc that size reads larger than the letters beside it. At 0.8 the
  /// scalloped edge lands on the height of the capitals, so it looks the
  /// size of the text.
  static const double perEm = 0.8;

  /// The badge's size beside text of [fontSize].
  static double sizeFor(double fontSize) => fontSize * perEm;

  final double size;

  /// Defaults to the theme's primary colour.
  final Color? color;

  /// The check. White unless the badge itself is.
  final Color tick;

  const VerifiedBadge({
    super.key,
    this.size = 15,
    this.color,
    this.tick = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final fill = color ?? Theme.of(context).colorScheme.primary;
    return Semantics(
      label: 'Verified',
      child: Tooltip(
        message: 'Verified',
        child: CustomPaint(
          size: Size.square(size),
          painter: _RosettePainter(fill, tick),
        ),
      ),
    );
  }
}

class _RosettePainter extends CustomPainter {
  final Color fill;
  final Color tick;
  const _RosettePainter(this.fill, this.tick);

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final centre = Offset(r, r);
    final paint = Paint()
      ..color = fill
      ..isAntiAlias = true;

    // Ten lobes round a disc: a rosette whose edge reads as perforated.
    const lobes = 10;
    canvas.drawCircle(centre, r * 0.80, paint);
    for (var i = 0; i < lobes; i++) {
      final a = i * 2 * math.pi / lobes;
      canvas.drawCircle(
        centre + Offset(math.cos(a), math.sin(a)) * (r * 0.74),
        r * 0.26,
        paint,
      );
    }

    final check = Path()
      ..moveTo(r * 0.56, r * 1.02)
      ..lineTo(r * 0.88, r * 1.32)
      ..lineTo(r * 1.46, r * 0.70);
    canvas.drawPath(
      check,
      Paint()
        ..color = tick
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.24
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(_RosettePainter old) =>
      old.fill != fill || old.tick != tick;
}

/// A name with the badge after it when [verified], for a single line that
/// ellipsises the name and never the badge.
///
/// The badge is sized from the name's own font size, so it matches the text
/// wherever the name appears. Centred on the line, which for this typeface
/// puts it on the middle of the capitals.
class NameWithBadge extends StatelessWidget {
  final String name;
  final bool verified;
  final TextStyle? style;

  const NameWithBadge({
    super.key,
    required this.name,
    required this.verified,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final text = Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
    if (!verified) return text;
    final fontSize =
        DefaultTextStyle.of(context).style.merge(style).fontSize ?? 14;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: text),
        Padding(
          padding: EdgeInsets.only(left: fontSize * 0.25),
          child: VerifiedBadge(size: VerifiedBadge.sizeFor(fontSize)),
        ),
      ],
    );
  }
}
