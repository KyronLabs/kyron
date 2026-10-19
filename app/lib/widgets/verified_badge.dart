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
class NameWithBadge extends StatelessWidget {
  final String name;
  final bool verified;
  final TextStyle? style;
  final double badgeSize;

  const NameWithBadge({
    super.key,
    required this.name,
    required this.verified,
    this.style,
    this.badgeSize = 15,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: text),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: VerifiedBadge(size: badgeSize),
        ),
      ],
    );
  }
}
