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

/// The rule: the line that sits above the reply box, between posts, and
/// around every card drawn inside a post. Half a point, in `outline` at 15%.
///
/// This is Kyron's hairline (the design system's
/// frontend/components/dividers.md writes it down): light enough to sit
/// under the content rather than on it. [Hairline] above is the older,
/// heavier line some headers still draw; on a post's own page it read as a
/// bar, not a hairline.
class RuleLine extends StatelessWidget {
  const RuleLine({super.key});

  /// The rule's weight, as [postRule] draws it.
  static const double weight = 0.5;

  static Color colourOf(ColorScheme scheme) =>
      scheme.outline.withValues(alpha: 0.15);

  @override
  Widget build(BuildContext context) => Container(
        height: weight,
        color: colourOf(Theme.of(context).colorScheme),
      );
}

/// The broken rule: a division inside one thing, where [RuleLine] is the
/// boundary between two.
///
/// A solid line says "something else starts here" -- a header and what it
/// heads, one post and the next, the end of a block. Inside a block that is
/// the wrong thing to say: a post's spelled-out counts and its row of
/// actions are one block about the same post, and a second solid rule
/// between them cut the post into three slabs. Broken, the same line keeps
/// the two apart without ending anything.
///
/// The rule, kept in the design system (frontend/components/dividers.md):
/// solid closes, broken divides. A broken line always has a solid one above
/// and below it somewhere, closing the block it sits in.
///
/// The same weight and colour as [RuleLine], only broken: it is the same
/// line saying less, not a different line. Dashes longer than the gaps
/// between them, so it still reads as a line rather than a row of specks.
class BrokenRuleLine extends StatelessWidget {
  const BrokenRuleLine({super.key});

  /// Each dash, and the gap after it.
  static const double dash = 4;
  static const double gap = 3;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: RuleLine.weight,
        width: double.infinity,
        child: CustomPaint(
          painter:
              _Dashes(color: RuleLine.colourOf(Theme.of(context).colorScheme)),
        ),
      );
}

class _Dashes extends CustomPainter {
  final Color color;

  const _Dashes({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const pitch = BrokenRuleLine.dash + BrokenRuleLine.gap;
    // Whole dashes only, centred, so the line starts and ends the same
    // distance in from both edges rather than on a stub at the right.
    final count = ((size.width + BrokenRuleLine.gap) / pitch).floor();
    if (count <= 0) return;
    final used = count * pitch - BrokenRuleLine.gap;
    var x = (size.width - used) / 2;
    for (var i = 0; i < count; i++) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, BrokenRuleLine.dash, size.height),
        paint,
      );
      x += pitch;
    }
  }

  @override
  bool shouldRepaint(_Dashes old) => old.color != color;
}
