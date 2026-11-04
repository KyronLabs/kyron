// lib/widgets/hairline.dart
import 'package:flutter/material.dart';

/// One device pixel, whatever the screen.
///
/// A "0.5" border is half a logical pixel, which on a 3x phone is one and a
/// half device pixels: the renderer draws two rows and dims them, and the line
/// comes out soft and heavier than a hairline. This is exactly one row.
double hairlineWidth(BuildContext context) =>
    1 / MediaQuery.devicePixelRatioOf(context);

/// The line that separates a header from what it heads.
///
/// One widget so every one of them is the same weight and colour. Three
/// screens each drew their own, and the pager underneath drew a second one on
/// top of it: two lines, both soft, reading as one thick smudge.
class Hairline extends StatelessWidget {
  const Hairline({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: hairlineWidth(context),
      color: scheme.outline.withValues(alpha: 0.22),
    );
  }
}

/// The rule between two posts, and the outline of every card drawn inside
/// one: a quoted post, a link, a voice post.
///
/// One value for both, so a card's edge can never be heavier than the line
/// that separates whole posts. They were a full logical pixel at a darker
/// alpha -- two to three device pixels on a phone -- and a quote inside a
/// post read as a heavier frame than the feed's own dividers.
BorderSide postRule(ColorScheme scheme) =>
    BorderSide(color: scheme.outline.withValues(alpha: 0.15), width: 0.5);

/// The dotted line: a division inside one thing, where [Hairline] is the
/// boundary between two.
///
/// A solid line says "something else starts here" -- a header and what it
/// heads, one post and the next, the end of a block. Inside a block that is
/// the wrong thing to say: a post's spelled-out counts and its row of
/// actions are one block about the same post, and a second solid rule
/// between them cut the post into three slabs. Dots keep the two apart
/// without ending anything.
///
/// The rule, kept in the design system (frontend/components/dividers.md):
/// solid closes, dotted divides. A dotted line always has a solid one above
/// and below it somewhere, closing the block it sits in; a dotted line at a
/// block's edge is a solid line drawn wrong.
///
/// Round dots, not dashes: at this weight a dash reads as a broken solid
/// line. Each dot is a full point across -- a device-pixel dot vanishes on a
/// 3x screen -- and they sit further apart than they are wide, so the line is
/// lighter than the solid one rather than heavier.
class DottedHairline extends StatelessWidget {
  const DottedHairline({super.key});

  /// Each dot's width, and the distance from one dot's centre to the next.
  static const double dot = 1;
  static const double pitch = 4;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: dot,
      width: double.infinity,
      child: CustomPaint(
        painter: _Dots(
          // Darker than the solid line's 0.22: dots cover a quarter of the
          // length, and at the same alpha they all but disappear.
          color: scheme.outline.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _Dots extends CustomPainter {
  final Color color;

  const _Dots({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const r = DottedHairline.dot / 2;
    final count = (size.width / DottedHairline.pitch).floor();
    if (count <= 0) return;
    // Centred, so the line starts and ends the same distance in from both
    // edges rather than ending on a part-dot at the right.
    final start = (size.width - (count - 1) * DottedHairline.pitch) / 2;
    for (var i = 0; i < count; i++) {
      canvas.drawCircle(
        Offset(start + i * DottedHairline.pitch, size.height / 2),
        r,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_Dots old) => old.color != color;
}
