// lib/models/face_anchor.dart
import 'dart:math' as math;
import 'dart:ui';

/// One point on a detected face, normalised to the frame.
///
/// Deliberately not the tracker's own landmark type: this and everything
/// built on it is arithmetic, and arithmetic that needs a camera plugin
/// loaded to be tested is arithmetic nobody tests.
class FacePoint {
  final double x;
  final double y;

  const FacePoint(this.x, this.y);
}

/// Where on a face an attachment sits.
enum FaceAnchorPoint {
  eyes,
  nose,
  mouth,
  forehead,
  chin;

  static FaceAnchorPoint? byName(String name) {
    for (final point in values) {
      if (point.name == name) return point;
    }
    return null;
  }
}

/// A resolved place to draw something: where, how big, and which way up.
///
/// The three numbers a flat attachment needs. Anything that also needs to know
/// which way the head is *facing* -- yaw and pitch -- needs the tracker's 4x4
/// transform and a mesh, which is a later step; see docs/LENS_FORMAT.md.
class FaceAnchor {
  /// Where the attachment centres, in frame pixels.
  final Offset centre;

  /// The gap between the pupils, in pixels.
  ///
  /// The unit everything is measured in. See [resolve].
  final double interpupillary;

  /// How far the head is tilted, in degrees, clockwise from level.
  final double rollDegrees;

  const FaceAnchor({
    required this.centre,
    required this.interpupillary,
    required this.rollDegrees,
  });

  /// Landmark indices, each checked by drawing it on a real face rather than
  /// taken from memory. A wrong index here puts the glasses on somebody's ear
  /// and nothing else in the app would notice.
  static const leftIris = 468;
  static const rightIris = 473;
  static const noseTip = 1;
  static const chinPoint = 152;
  static const foreheadPoint = 10;
  static const lipTop = 13;
  static const lipBottom = 14;

  /// The highest index this needs, so a short landmark list is refused rather
  /// than read past.
  static const requiredLandmarks = 474;

  /// Resolves an anchor, or null when the landmarks cannot support one.
  ///
  /// Size comes from the distance between the pupils rather than from a box
  /// around the face. Both irises stay visible well past the angle at which a
  /// jaw outline stops describing anything, so it keeps meaning the same thing
  /// as the head turns: measured across a 60-degree sweep of roll it moved
  /// 1.6%, while the bounding box changed shape completely.
  ///
  /// That is why an attachment states its width in *faces* -- 2.6 means 2.6
  /// times the gap between the pupils -- and is then correct at any distance
  /// from the camera, on any face, at any resolution.
  static FaceAnchor? resolve(
    FaceAnchorPoint point,
    List<FacePoint> landmarks,
    Size frame,
  ) {
    if (landmarks.length < requiredLandmarks) return null;
    if (frame.width <= 0 || frame.height <= 0) return null;

    Offset at(int index) => Offset(
          landmarks[index].x * frame.width,
          landmarks[index].y * frame.height,
        );

    final left = at(leftIris);
    final right = at(rightIris);
    final gap = (right - left).distance;

    // A face this small is a detection artefact, not a face. Dividing by it
    // produces an attachment the size of a postage stamp or of the county.
    if (!gap.isFinite || gap < 1) return null;

    final centre = switch (point) {
      FaceAnchorPoint.eyes => (left + right) / 2,
      FaceAnchorPoint.nose => at(noseTip),
      FaceAnchorPoint.forehead => at(foreheadPoint),
      FaceAnchorPoint.chin => at(chinPoint),
      FaceAnchorPoint.mouth => (at(lipTop) + at(lipBottom)) / 2,
    };

    if (!centre.dx.isFinite || !centre.dy.isFinite) return null;

    return FaceAnchor(
      centre: centre,
      interpupillary: gap,
      rollDegrees:
          math.atan2(right.dy - left.dy, right.dx - left.dx) * 180 / math.pi,
    );
  }

  /// The roll in radians, which is what a canvas rotation wants.
  double get rollRadians => rollDegrees * math.pi / 180;

  @override
  String toString() => 'FaceAnchor(centre: $centre, ipd: '
      '${interpupillary.toStringAsFixed(1)}, roll: '
      '${rollDegrees.toStringAsFixed(2)}deg)';
}
