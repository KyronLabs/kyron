// lib/widgets/glasses_painter.dart
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/face_region.dart';
import '../models/glasses_model.dart';
import '../models/head_pose.dart';

/// Draws a [GlassesModel] on a face, in three dimensions.
///
/// Used twice, like `FaceAttachmentPainter`: over the live preview and into
/// the captured still. The picture taken is the picture seen because both are
/// this code reading the same pose.
///
/// What makes it read as glasses rather than a sticker, in the order it is
/// drawn:
///
/// 1. **A shadow on the face** under the frame. The single biggest cue that
///    something is *on* a face rather than *over* a photograph of one.
/// 2. **Arms that go back to the ears**, hidden wherever the face is in front
///    of them. Turn your head and the near arm runs back past your cheek; the
///    far one disappears behind it.
/// 3. **Perspective**: the near lens is larger than the far one, and both
///    narrow as the head turns.
/// 4. **Tinted lenses with a reflection** that slides across them as the head
///    turns, the way a real lens catches a window.
/// 5. **A shaded rim** -- a bright edge on top and a dark one beneath for
///    acetate, a brushed gradient for metal.
class GlassesPainter extends CustomPainter {
  final GlassesModel model;
  final HeadPose pose;

  /// Every landmark, in the same pixels as [pose], with depth. It is the
  /// surface the arms are depth-tested against; without it they are drawn
  /// over the face, which is wrong but still a pair of glasses.
  final List<Vec3>? face;

  /// Whether the picture underneath is flipped, as a front-camera preview is.
  /// The pose is in unflipped frame pixels; this flips the drawing to match.
  final bool mirrored;

  /// The coordinates [pose] is in. When the canvas is a different size --
  /// the preview box rather than the camera frame -- everything is scaled to
  /// fit. Null means they are the same.
  final Size? frame;

  const GlassesPainter({
    required this.model,
    required this.pose,
    this.face,
    this.mirrored = false,
    this.frame,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final source = frame;
    if (source != null && !source.isEmpty && source != size) {
      canvas.scale(size.width / source.width, size.height / source.height);
    }
    final width = source ?? size;
    if (mirrored) {
      canvas.translate(width.width, 0);
      canvas.scale(-1, 1);
    }
    paintGlasses(canvas, model, pose, face: face);
    canvas.restore();
  }

  /// The drawing itself, onto a canvas already in the pose's coordinates.
  /// Public so a lens tile can draw a pair without a [CustomPaint].
  static void paintGlasses(
    Canvas canvas,
    GlassesModel model,
    HeadPose pose, {
    List<Vec3>? face,
  }) {
    final p = _Projector(pose);
    final rim = model.rimWidth * pose.scale;

    final lenses = [
      for (final side in const [-1, 1]) (side, model.lens(side)),
    ];
    // Far lens first, so the near one's rim overlaps it where they meet in a
    // hard turn. Further back is larger depth.
    lenses.sort(
      (a, b) => p.depth(_centre(b.$2)).compareTo(p.depth(_centre(a.$2))),
    );

    // 1. The shadow, cast down and back onto the skin.
    _shadow(canvas, p, model, lenses.map((l) => l.$2), rim);

    // 2. The arms, wherever the head is not in front of them.
    final surface = _Surface.of(face);
    for (final side in const [-1, 1]) {
      _arm(canvas, p, model, pose, surface, side, rim);
    }

    // 3 and 4. Each lens: glass, reflection, rim.
    for (final (side, outline) in lenses) {
      final path = p.path(outline);
      _glass(canvas, path, model, pose, side);
      _stroke(canvas, path, model, rim, p.scaleAt(_centre(outline)));
    }

    final bridge = p.path(model.bridge(), close: false);
    _stroke(canvas, bridge, model, rim * 0.8, 1);
    final bar = model.browBar();
    if (bar != null) {
      _stroke(canvas, p.path(bar, close: false), model, rim * 0.7, 1);
    }

    for (final pad in model.nosePads()) {
      final at = p.offset(pad);
      canvas.drawOval(
        Rect.fromCenter(
          center: at,
          width: pose.scale * 0.05,
          height: pose.scale * 0.08,
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.35),
      );
    }

    // 5. The front of each arm: hinge to just behind it, which is in front of
    // the cheek whenever it is visible at all.
    for (final side in const [-1, 1]) {
      final arm = model.temple(side);
      final front = p.path(arm.sublist(0, 2), close: false);
      _stroke(canvas, front, model, rim * 0.95, p.scaleAt(arm[0]));
    }
  }

  /// One arm, behind the hinge: sampled along its length and drawn only where
  /// nothing is in front of it.
  ///
  /// A depth test against the face mesh, point by point, rather than a clip
  /// to the face's outline. The outline alone hid the near arm exactly where
  /// it should show -- running back over the side of a turned head -- and
  /// could not hide the far arm where the skull, which the mesh does not
  /// cover, is in front of it.
  static void _arm(
    Canvas canvas,
    _Projector p,
    GlassesModel model,
    HeadPose pose,
    _Surface? surface,
    int side,
    double rim,
  ) {
    // The side turned away from the camera has the back of the head in front
    // of its arm everywhere the face mesh does not reach.
    final far = pose.right.z * side > 0.08;
    // Hinge to the top of the ear. The hook down behind the ear is behind
    // the ear from every angle a selfie is taken at, and the ear is not in
    // the mesh to hide it, so it is not drawn at all.
    final arm = model.temple(side).sublist(1, 4);

    const steps = 10;
    final samples = <Vec3>[
      for (var i = 0; i < arm.length - 1; i++)
        for (var j = 0; j < steps; j++)
          arm[i] + (arm[i + 1] - arm[i]) * (j / steps),
      arm.last,
    ];

    bool visible(Vec3 local) {
      final at = p.offset(local);
      if (surface == null) return !far;
      final nearest = surface.nearest(at);
      if (nearest == null) return !far;
      // Outside the face: only the far side's skull can be in front.
      if (!surface.covers(at)) return !far;
      // Over the face: in front of the skin there, or not drawn.
      return pose.toFrame(local).z <= nearest.z + pose.scale * 0.03;
    }

    Path? run;
    var length = 0;
    void flush() {
      // A run of one sample is a dot where the arm grazes the depth test,
      // which reads as a speck on the cheek rather than as an arm.
      if (run != null && length > 1) {
        _stroke(canvas, run!, model, rim * 0.85, p.scaleAt(arm[1]));
      }
      run = null;
      length = 0;
    }

    for (final sample in samples) {
      if (!visible(sample)) {
        flush();
        continue;
      }
      final at = p.offset(sample);
      if (run == null) {
        run = Path()..moveTo(at.dx, at.dy);
      } else {
        run!.lineTo(at.dx, at.dy);
      }
      length++;
    }
    flush();
  }

  static Vec3 _centre(List<Vec3> points) {
    var sum = Vec3.zero;
    for (final point in points) {
      sum = sum + point;
    }
    return sum * (1 / points.length);
  }

  static void _shadow(
    Canvas canvas,
    _Projector p,
    GlassesModel model,
    Iterable<List<Vec3>> outlines,
    double rim,
  ) {
    // The frame moved down and back onto the face: the light is overhead and
    // a little in front, as it is in most rooms.
    const drop = Vec3(0, 0.07, 0.20);
    final shadow = Path();
    for (final outline in outlines) {
      shadow.addPath(
        p.path([for (final point in outline) point + drop]),
        Offset.zero,
      );
    }
    canvas.drawPath(
      shadow,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = rim * 1.6
        ..color = Colors.black.withValues(alpha: 0.28)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, rim * 1.2 + 1),
    );
  }

  static void _glass(
    Canvas canvas,
    Path path,
    GlassesModel model,
    HeadPose pose,
    int side,
  ) {
    final bounds = path.getBounds();
    if (bounds.isEmpty || !bounds.isFinite) return;

    // Darkest at the top, as a gradient lens is, and as a real one looks when
    // the brow shades its upper half.
    final top = model.tintOpacity.clamp(0.0, 1.0);
    canvas.drawPath(
      path,
      Paint()
        ..shader = ui.Gradient.linear(
          bounds.topCenter,
          bounds.bottomCenter,
          [
            model.tint.withValues(alpha: top),
            model.tint.withValues(alpha: top * 0.72),
          ],
        ),
    );

    // The reflection: a soft diagonal band that slides across as the head
    // turns, with the near lens catching more of it.
    final yaw = pose.yawDegrees.clamp(-60.0, 60.0);
    final slide = (yaw / 60) * 0.6 + side * 0.08;
    final cx = bounds.center.dx + slide * bounds.width;
    canvas.save();
    canvas.clipPath(path);
    final band = Rect.fromCenter(
      center: Offset(cx, bounds.center.dy),
      width: bounds.width * 0.55,
      height: bounds.height * 1.6,
    );
    canvas.translate(band.center.dx, band.center.dy);
    canvas.rotate(-0.45);
    canvas.translate(-band.center.dx, -band.center.dy);
    canvas.drawRect(
      band,
      Paint()
        ..shader = ui.Gradient.linear(
          band.centerLeft,
          band.centerRight,
          [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.22),
            Colors.white.withValues(alpha: 0.06),
            Colors.white.withValues(alpha: 0),
          ],
          const [0, 0.35, 0.6, 1],
        ),
    );
    canvas.restore();

    // A thin bright crescent under the top rim: light catching the edge of
    // the glass.
    canvas.save();
    canvas.clipPath(path);
    canvas.drawPath(
      path.shift(Offset(0, bounds.height * 0.05)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, bounds.height * 0.04)
        ..color = Colors.white.withValues(alpha: 0.10)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          math.max(0.5, bounds.height * 0.02),
        ),
    );
    canvas.restore();
  }

  /// A rim or an arm, with depth: a dark core, a lit edge on top, and for
  /// metal a brushed gradient along it.
  static void _stroke(
    Canvas canvas,
    Path path,
    GlassesModel model,
    double width,
    double perspective,
  ) {
    final w = math.max(1.0, width * perspective);
    final bounds = path.getBounds();
    if (!bounds.isFinite) return;

    final hsl = HSLColor.fromColor(model.frame);
    final dark =
        hsl.withLightness((hsl.lightness * 0.45).clamp(0, 1)).toColor();
    final light =
        hsl.withLightness((hsl.lightness + 0.32).clamp(0, 0.95)).toColor();

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    if (model.metal) {
      // Brushed metal: bright, mid, dark, bright across the frame.
      base.shader = ui.Gradient.linear(
        bounds.topLeft,
        bounds.bottomRight,
        [light, model.frame, dark, model.frame, light],
        const [0, 0.3, 0.55, 0.8, 1],
      );
      canvas.drawPath(path, base);
    } else {
      // Acetate: a darker underside, the colour itself, then a lit top edge.
      canvas.drawPath(
        path.shift(Offset(0, w * 0.18)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = w
          ..strokeJoin = StrokeJoin.round
          ..color = dark,
      );
      base.color = model.frame;
      canvas.drawPath(path, base);
    }

    canvas.drawPath(
      path.shift(Offset(0, -w * 0.22)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * (model.metal ? 0.3 : 0.22)
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: model.metal ? 0.55 : 0.28),
    );
  }

  @override
  bool shouldRepaint(GlassesPainter old) =>
      old.pose != pose ||
      old.model != model ||
      old.mirrored != mirrored ||
      old.frame != frame ||
      old.face != face;
}

/// The face mesh as something to test against: its outline, and the depth of
/// the skin at any point inside it.
class _Surface {
  final List<Vec3> points;
  final Path outline;

  _Surface(this.points, this.outline);

  static _Surface? of(List<Vec3>? points) {
    if (points == null || points.length < 3) return null;
    final outline = FaceRegion.hullPath([
      for (final point in points) Offset(point.x, point.y),
    ]);
    return outline == null ? null : _Surface(points, outline);
  }

  bool covers(Offset at) => outline.contains(at);

  /// The landmark closest to [at] on screen. 478 distances, a few dozen
  /// times a frame: cheaper than building anything to search faster.
  Vec3? nearest(Offset at) {
    Vec3? best;
    var bestDistance = double.infinity;
    for (final point in points) {
      final dx = point.x - at.dx, dy = point.y - at.dy;
      final d = dx * dx + dy * dy;
      if (d < bestDistance) {
        bestDistance = d;
        best = point;
      }
    }
    return best;
  }
}

/// Face-local points to canvas points, with perspective.
///
/// A phone held at arm's length is roughly seven pupil-gaps from the face,
/// so something one pupil-gap nearer than the eyes is drawn about 15% larger.
/// That is all perspective is here, and it is enough to make the near lens
/// bigger than the far one.
class _Projector {
  final HeadPose pose;
  final double focal;

  _Projector(this.pose) : focal = pose.scale * 7;

  Vec3 _frame(Vec3 local) => pose.toFrame(local);

  double depth(Vec3 local) => _frame(local).z - pose.origin.z;

  double scaleAt(Vec3 local) => focal / math.max(1, focal + depth(local));

  Offset offset(Vec3 local) {
    final v = _frame(local);
    final f = focal / math.max(1, focal + (v.z - pose.origin.z));
    return Offset(
      pose.origin.x + (v.x - pose.origin.x) * f,
      pose.origin.y + (v.y - pose.origin.y) * f,
    );
  }

  Path path(List<Vec3> points, {bool close = true}) {
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final at = offset(points[i]);
      if (i == 0) {
        path.moveTo(at.dx, at.dy);
      } else {
        path.lineTo(at.dx, at.dy);
      }
    }
    if (close) path.close();
    return path;
  }
}
