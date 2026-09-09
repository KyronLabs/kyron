// lib/models/face_region.dart
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'face_anchor.dart';

/// An area of a face, as opposed to a point on one.
///
/// [FaceAnchor] answers "where do I hang this"; a region answers "which part
/// of the picture does this effect apply to". Named rather than expressed as a
/// list of landmark indices, so a lens stays readable and cannot address a
/// point that does not exist.
enum FaceRegionKind {
  /// Nose and mouth: everything below the eyes, down to the chin.
  lowerFace,

  /// A slot across both eyes.
  eyes,

  /// The whole face.
  face;

  static FaceRegionKind? byName(String name) {
    for (final kind in values) {
      if (kind.name == name) return kind;
    }
    return null;
  }
}

/// Turns a named region into something a canvas can clip or fill.
class FaceRegion {
  const FaceRegion._();

  /// How far below the eyes [FaceRegionKind.lowerFace] starts, in pupil-gaps.
  ///
  /// Far enough to clear the lower lashes; near enough that the bridge of the
  /// nose is inside. Tuned by rendering it and looking.
  static const lowerFaceTop = 0.28;

  /// The outline of a region, or null when the landmarks cannot support one.
  static Path? path(
    FaceRegionKind kind,
    List<FacePoint> landmarks,
    Size frame,
    FaceAnchor face,
  ) {
    if (landmarks.length < FaceAnchor.requiredLandmarks) return null;
    if (frame.width <= 0 || frame.height <= 0) return null;

    return switch (kind) {
      FaceRegionKind.eyes => _slot(face),
      FaceRegionKind.lowerFace => _hullBelow(landmarks, frame, face),
      FaceRegionKind.face => _hullOf(
          [
            for (final p in landmarks)
              Offset(p.x * frame.width, p.y * frame.height),
          ],
        ),
    };
  }

  /// A rounded slot across both eyes, measured in pupil-gaps so it is the
  /// same shape on every face at every distance.
  static Path _slot(FaceAnchor face) {
    final gap = face.interpupillary;
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: face.centre,
        width: gap * 2.5,
        height: gap * 0.78,
      ),
      Radius.circular(gap * 0.19),
    );
    // Turned with the head, about the eyes, so it stays level with them.
    return _rotated(Path()..addRRect(rect), face);
  }

  /// Everything below the eye line, hulled.
  ///
  /// Derived from the point cloud rather than a memorised list of outline
  /// indices: a wrong index in such a list is invisible until it puts a corner
  /// of the region on somebody's ear.
  static Path? _hullBelow(
    List<FacePoint> landmarks,
    Size frame,
    FaceAnchor face,
  ) {
    final top = face.centre.dy + face.interpupillary * lowerFaceTop;
    final below = <Offset>[
      for (final p in landmarks)
        if (p.y * frame.height > top)
          Offset(p.x * frame.width, p.y * frame.height),
    ];
    // Three points is the fewest that bound an area.
    if (below.length < 3) return null;
    return _hullOf(below);
  }

  static Path? _hullOf(List<Offset> points) {
    final hull = convexHull(points);
    if (hull.length < 3) return null;
    final path = Path()..moveTo(hull.first.dx, hull.first.dy);
    for (final point in hull.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    return path..close();
  }

  static Path _rotated(Path path, FaceAnchor face) {
    if (face.rollDegrees == 0) return path;
    return path.transform(_rotationAbout(face.centre, face.rollRadians));
  }

  /// A rotation about a point, as the 4x4 a Path transform wants.
  ///
  /// Translate to the origin, rotate, translate back -- composed by hand
  /// because that is three lines rather than a matrix library.
  static Float64List _rotationAbout(Offset centre, double radians) {
    final c = math.cos(radians);
    final s = math.sin(radians);
    return Float64List.fromList(<double>[
      c, s, 0, 0, //
      -s, c, 0, 0, //
      0, 0, 1, 0, //
      centre.dx - centre.dx * c + centre.dy * s,
      centre.dy - centre.dx * s - centre.dy * c,
      0, 1, //
    ]);
  }

  /// The smallest convex outline containing every point.
  ///
  /// Andrew's monotone chain: sort, then sweep the lower and upper halves,
  /// dropping any point that turns the wrong way. Exposed for its own test --
  /// a hull that is subtly wrong makes a region that is subtly wrong, and
  /// nothing downstream would say so.
  static List<Offset> convexHull(List<Offset> input) {
    if (input.length < 3) return List.of(input);

    final points = List.of(input)
      ..sort(
          (a, b) => a.dx == b.dx ? a.dy.compareTo(b.dy) : a.dx.compareTo(b.dx));

    double cross(Offset o, Offset a, Offset b) =>
        (a.dx - o.dx) * (b.dy - o.dy) - (a.dy - o.dy) * (b.dx - o.dx);

    List<Offset> half(List<Offset> ordered) {
      final out = <Offset>[];
      for (final point in ordered) {
        while (out.length > 1 &&
            cross(out[out.length - 2], out.last, point) <= 0) {
          out.removeLast();
        }
        out.add(point);
      }
      return out..removeLast();
    }

    return [...half(points), ...half(points.reversed.toList())];
  }
}
