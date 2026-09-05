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
