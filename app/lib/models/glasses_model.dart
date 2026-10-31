// lib/models/glasses_model.dart
import 'dart:math' as math;
import 'dart:ui';

import 'head_pose.dart';

/// The shapes of frame the app can build.
enum GlassesStyle {
  /// Two near-circles on a thin metal frame.
  round,

  /// Teardrops under a double bridge.
  aviator,

  /// Thick, squared acetate, wider at the brow than at the cheek.
  square,

  /// Acetate swept up at the outer corners.
  catEye;
}

/// A pair of glasses, as geometry.
///
/// Built, not loaded. A downloaded mesh is a parser's worth of attack surface
/// and a file format to version; a frame described by its style and three
/// colours is data in the same sense a colour matrix is, and the app owns
/// every line that turns it into triangles. See docs/AR.md.
///
/// Everything is in **face-local pupil-gaps**: x across the face with the
/// pupils at ±0.5, y down, z back into the head. [HeadPose.toFrame] puts it on
/// a face at any size, at any angle.
class GlassesModel {
  final GlassesStyle style;

  /// The frame's colour. A metal frame is shaded as metal around it.
  final Color frame;

  /// The lens tint, and how much of the eye it hides at its darkest.
  final Color tint;
  final double tintOpacity;

  /// Thin and shiny, or thick and matte.
  final bool metal;

  const GlassesModel({
    required this.style,
    required this.frame,
    required this.tint,
    this.tintOpacity = 0.7,
    this.metal = false,
  });

  /// How far in front of the pupils the lenses sit. A real pair is about
  /// 12 mm off the eye, and a pupil gap is about 63 mm.
  static const frontDepth = -0.22;

  /// Points around each lens. Enough that a circle 400 px wide on a close
  /// selfie does not show corners.
  static const outlineSteps = 48;

  /// Rim thickness, in pupil-gaps.
  double get rimWidth => metal ? 0.028 : 0.075;

  /// Half-width and half-height of one lens.
  (double, double) get _extent => switch (style) {
        GlassesStyle.round => (0.34, 0.31),
        GlassesStyle.aviator => (0.42, 0.36),
        GlassesStyle.square => (0.42, 0.29),
        GlassesStyle.catEye => (0.42, 0.29),
      };

  /// Where each lens centres, below the pupil line by a touch: a real frame
  /// hangs off the nose, and its centre is a little under the eye.
  double get _drop => style == GlassesStyle.aviator ? 0.07 : 0.03;

  /// One lens outline, in face-local coordinates. [side] is -1 for the lens
  /// on the image's left and 1 for the right.
  List<Vec3> lens(int side) {
    final (a, b) = _extent;
    final cx = 0.5 * side;
    final cy = _drop;
    final points = <Vec3>[];

    for (var i = 0; i < outlineSteps; i++) {
      final t = i / outlineSteps * 2 * math.pi;
      final c = math.cos(t);
      final s = math.sin(t);
      // Outward is towards the temple, whichever side this is.
      final outward = c * side;

      double x, y;
      switch (style) {
        case GlassesStyle.round:
          x = a * c;
          y = b * s;
        case GlassesStyle.square:
          // A superellipse: flat sides, rounded corners. Wider across the brow
          // than the cheek, which is what makes it read as a wayfarer.
          x = a * _signedPow(c, 0.42) * (1 + 0.07 * -_signedPow(s, 0.42));
          y = b * _signedPow(s, 0.42);
        case GlassesStyle.aviator:
          // Fuller below than above, and the bottom swept towards the nose.
          // Towards the nose is -x for the right lens and +x for the left.
          x = a * c - side * 0.10 * math.max(0, s) * math.max(0, -outward) * a;
          y = b * s * (s > 0 ? 1.18 : 0.78);
        case GlassesStyle.catEye:
          x = a * _signedPow(c, 0.6);
          y = b * _signedPow(s, 0.7);
          // The outer top corner lifted -- the whole point of the shape.
          y -= 0.16 * math.max(0, outward) * math.max(0, -s);
      }

      final px = cx + x;
      final py = cy + y;
      points.add(Vec3(px, py, _wrap(px)));
    }
    return points;
  }

  /// The frame curves back round the face towards the temples, rather than
  /// being a flat plate: a flat front is the thing that makes AR glasses look
  /// like a sticker.
  static double _wrap(double x) {
    final t = math.max(0.0, x.abs() - 0.12) / 0.8;
    return frontDepth + 0.10 * t * t;
  }

  /// Across the nose, inner edge to inner edge, arched.
  List<Vec3> bridge() {
    final (a, b) = _extent;
    final inner = 0.5 - a + 0.02;
    final y = _drop - b * (style == GlassesStyle.round ? 0.35 : 0.45);
    const steps = 10;
    return [
      for (var i = 0; i <= steps; i++)
        () {
          final u = i / steps * 2 - 1; // -1 .. 1
          final x = u * inner;
          return Vec3(x, y - 0.06 * (1 - u * u), _wrap(x) - 0.01);
        }(),
    ];
  }

  /// The aviator's brow bar, lens top to lens top. Null for every other
  /// style.
  List<Vec3>? browBar() {
    if (style != GlassesStyle.aviator) return null;
    final (_, b) = _extent;
    final y = _drop - b * 0.78;
    const steps = 12;
    return [
      for (var i = 0; i <= steps; i++)
        () {
          final x = (i / steps * 2 - 1) * 0.62;
          return Vec3(x, y - 0.015 * (1 - x * x), _wrap(x) - 0.01);
        }(),
    ];
  }

  /// One arm, hinge to ear and down behind it. [side] as for [lens].
  ///
  /// The first point is the hinge, on the front of the frame; the rest run
  /// back. Only the first stretch can ever be in front of the face -- the
  /// painter hides the remainder wherever the face is in the way.
  List<Vec3> temple(int side) {
    final (a, b) = _extent;
    final hingeX = 0.5 + a + rimWidth * 0.3;
    final hingeY = _drop - b * 0.45;
    final s = side.toDouble();
    return [
      Vec3(s * hingeX, hingeY, _wrap(hingeX)),
      Vec3(s * (hingeX + 0.06), hingeY + 0.01, 0.25),
      Vec3(s * 1.04, hingeY + 0.03, 0.75),
      Vec3(s * 1.07, hingeY + 0.06, 1.25),
      // Over the ear and down behind it.
      Vec3(s * 1.05, hingeY + 0.20, 1.50),
    ];
  }

  /// Where the frame meets the nose: a pad each side on a metal frame, and
  /// nothing on acetate, which rests on the bridge itself.
  List<Vec3> nosePads() {
    if (!metal) return const [];
    final (a, _) = _extent;
    final x = 0.5 - a + 0.05;
    return [
      Vec3(-x, _drop + 0.08, frontDepth + 0.06),
      Vec3(x, _drop + 0.08, frontDepth + 0.06),
    ];
  }

  static double _signedPow(double v, double p) =>
      v.sign * math.pow(v.abs(), p).toDouble();
}
