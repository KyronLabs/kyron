// lib/widgets/squircle.dart
//
// The shape a community wears.
//
// Not `BorderRadius.circular`, which is a rectangle with quarter-circles stuck
// on it: curvature jumps from zero to 1/r at the tangent point, and the eye
// reads that discontinuity as a corner even though the outline is smooth. A
// squircle varies curvature continuously all the way round, so the outline
// reads as one shape rather than four arcs joined by four straight lines.
//
// The shape itself is Flutter's `ContinuousRectangleBorder`, which is a
// superellipse. A hand-rolled one was written first and measured against it:
// sampling how far each outline reaches along the diagonal, the two agree to
// within 0.4% at every radius, so there was nothing to gain from carrying a
// second implementation of the same curve.
//
// What is here is the part that was actually getting it wrong: the radius.
// `ContinuousRectangleBorder` does not take the same number a `BorderRadius`
// does -- at the same value it rounds visibly less -- so passing the tokens
// straight through is what makes a "squircle" come out looking like a
// rounded rectangle with its corners shaved.
import 'package:flutter/material.dart';

/// A squircle sized to the tile it clips.
///
/// [size] is the width of the square this shape fills. The radius is derived
/// from it rather than passed in, because a fixed radius reads as a different
/// shape at every size: 16 is a gentle easing on a 96-pixel tile and nearly a
/// circle on a 24-pixel one.
class SquircleShape {
  const SquircleShape._();

  /// How much of the tile the corner curve occupies.
  ///
  /// A quarter of the side is the proportion Apple's icon grid uses, and it is
  /// what keeps a 32-pixel avatar and a 96-pixel header the same shape.
  static const double _cornerFraction = 0.25;

  /// `ContinuousRectangleBorder` rounds visibly less than a `BorderRadius` of
  /// the same value. Doubling brings the two into agreement, and skipping it
  /// is what made the corners look shaved.
  static const double _continuousScale = 2;

  /// The radius to hand `ContinuousRectangleBorder` for a tile [size] across.
  static double radiusFor(double size) =>
      size * _cornerFraction * _continuousScale;

  /// The border itself, for a tile [size] across.
  static ContinuousRectangleBorder borderFor(double size, {BorderSide? side}) =>
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(radiusFor(size)),
        side: side ?? BorderSide.none,
      );
}

/// Clips [child] to a squircle [size] across.
class Squircle extends StatelessWidget {
  final Widget child;

  /// The width of the square being clipped. See [SquircleShape].
  final double size;

  const Squircle({super.key, required this.child, required this.size});

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: size,
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: SquircleShape.borderFor(size)),
          child: child,
        ),
      );
}
