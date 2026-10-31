// lib/models/head_pose.dart
import 'dart:math' as math;
import 'dart:ui';

import 'face_anchor.dart';

/// A point or a direction in three dimensions.
///
/// Small and immutable on purpose: this is arithmetic that runs per frame, and
/// a matrix library for nine numbers is more to read than the nine numbers.
class Vec3 {
  final double x;
  final double y;
  final double z;

  const Vec3(this.x, this.y, this.z);

  static const zero = Vec3(0, 0, 0);

  Vec3 operator +(Vec3 o) => Vec3(x + o.x, y + o.y, z + o.z);
  Vec3 operator -(Vec3 o) => Vec3(x - o.x, y - o.y, z - o.z);
  Vec3 operator *(double s) => Vec3(x * s, y * s, z * s);

  double dot(Vec3 o) => x * o.x + y * o.y + z * o.z;

  Vec3 cross(Vec3 o) =>
      Vec3(y * o.z - z * o.y, z * o.x - x * o.z, x * o.y - y * o.x);

  double get length => math.sqrt(x * x + y * y + z * z);

  Vec3 get normalized {
    final l = length;
    return l == 0 ? this : this * (1 / l);
  }

  bool get isFinite => x.isFinite && y.isFinite && z.isFinite;

  @override
  String toString() => 'Vec3(${x.toStringAsFixed(3)}, '
      '${y.toStringAsFixed(3)}, ${z.toStringAsFixed(3)})';
}

/// Which way a head is facing, and where it is, in frame pixels.
///
/// [FaceAnchor] has three numbers -- where, how big, which way up -- and that
/// is all a flat sticker needs. Glasses are not flat. They have arms that go
/// back to the ears, lenses that narrow as the head turns away and a far side
/// that the face hides. Drawing that needs the head's full orientation, which
/// is what this is: an origin between the pupils and three axes fixed to the
/// face.
///
/// Built from the landmarks' own depth rather than from the tracker's 4x4
/// geometry call. That call is native and needs a running graph, so anything
/// built on it could only be checked on a phone. This is arithmetic over the
/// same points every other placement here already reads, and it is checked in
/// a test against a real detection.
///
/// Axes are in the frame's own handedness: x to the subject's left as seen in
/// the picture (image right), y down, z away from the camera. [forward], the
/// way the face points, is therefore mostly negative z.
class HeadPose {
  /// Between the pupils, in frame pixels. z is relative depth, in pixels too.
  final Vec3 origin;

  /// Across the face, from the eye on the image's left to the one on its
  /// right. Unit length.
  final Vec3 right;

  /// Down the face, brow to chin. Unit length, square to [right].
  final Vec3 down;

  /// Into the head, away from the camera. Unit length. A face looking
  /// straight at the lens has this close to (0, 0, 1).
  final Vec3 back;

  /// The pupil gap in three dimensions, in pixels.
  ///
  /// The 3D distance rather than the 2D one: as a head turns, the gap on
  /// screen shrinks by the cosine of the turn, and a model scaled by that and
  /// *also* rotated by the turn would shrink twice. This one stays the size
  /// of the face.
  final double scale;

  const HeadPose({
    required this.origin,
    required this.right,
    required this.down,
    required this.back,
    required this.scale,
  });

  /// Outer eye corners, brow and chin. Checked against the published mesh
  /// map, and against the fixture in test/face-detection.json: a wrong index
  /// here turns the glasses sideways and nothing else would say so.
  static const leftEyeOuter = 33;
  static const rightEyeOuter = 263;
  static const brow = 10;
  static const chin = 152;

  /// The pose of a face, or null when the landmarks cannot support one.
  ///
  /// [frame] is the upright frame the landmarks are normalised to. Depth is
  /// normalised to the frame's *width*, as MediaPipe states it, so it is
  /// scaled by the width and not the height.
  static HeadPose? resolve(List<FacePoint> landmarks, Size frame) {
    if (landmarks.length < FaceAnchor.requiredLandmarks) return null;
    if (frame.width <= 0 || frame.height <= 0) return null;

    Vec3 at(int i) {
      final p = landmarks[i];
      return Vec3(p.x * frame.width, p.y * frame.height, p.z * frame.width);
    }

    final leftIris = at(FaceAnchor.leftIris);
    final rightIris = at(FaceAnchor.rightIris);
    final scale = (rightIris - leftIris).length;
    if (!scale.isFinite || scale < 1) return null;

    // Across: the outer eye corners rather than the irises. The irises move
    // when somebody looks sideways; the corners of the eyes do not.
    final across = (at(rightEyeOuter) - at(leftEyeOuter)).normalized;
    final along = at(chin) - at(brow);

    // Gram-Schmidt: the brow-to-chin line is not quite square to the eyes on
    // a real face, so the part of it that runs along the eye line is taken
    // out. What remains is "down", exactly perpendicular.
    final down = (along - across * along.dot(across)).normalized;
    final back = across.cross(down).normalized;

    final origin = (leftIris + rightIris) * 0.5;
    final pose = HeadPose(
      origin: origin,
      right: across,
      down: down,
      back: back,
      scale: scale,
    );
    if (!origin.isFinite ||
        !across.isFinite ||
        !down.isFinite ||
        !back.isFinite ||
        across.length < 0.5 ||
        down.length < 0.5) {
      return null;
    }
    return pose;
  }

  /// A face-local point, in pupil-gaps, to frame pixels (z kept as depth).
  ///
  /// Local x runs across the face, y down it, z back into the head -- so the
  /// left pupil is (-0.5, 0, 0), the right one (0.5, 0, 0), and an ear is
  /// somewhere near (±1.1, 0.1, 1.4).
  Vec3 toFrame(Vec3 local) =>
      origin + (right * local.x + down * local.y + back * local.z) * scale;

  /// Turned left or right, in degrees. Positive when the face turns towards
  /// the image's right.
  double get yawDegrees => math.atan2(-back.x, back.z) * 180 / math.pi;

  /// Tipped up or down, in degrees. Positive when the chin goes down.
  double get pitchDegrees => math.atan2(-back.y, back.z) * 180 / math.pi;

  /// Tilted, in degrees, clockwise from level, as [FaceAnchor.rollDegrees].
  double get rollDegrees => math.atan2(right.y, right.x) * 180 / math.pi;

  /// A face square to the camera, at [origin], [scale] pixels between the
  /// pupils. What a lens tile draws its preview on.
  factory HeadPose.facing(Offset origin, double scale, {double yaw = 0}) {
    final r = yaw * math.pi / 180;
    final right = Vec3(math.cos(r), 0, math.sin(r));
    const down = Vec3(0, 1, 0);
    return HeadPose(
      origin: Vec3(origin.dx, origin.dy, 0),
      right: right,
      down: down,
      back: right.cross(down),
      scale: scale,
    );
  }

  @override
  String toString() => 'HeadPose(origin: $origin, scale: '
      '${scale.toStringAsFixed(1)}, yaw: ${yawDegrees.toStringAsFixed(1)}, '
      'pitch: ${pitchDegrees.toStringAsFixed(1)}, roll: '
      '${rollDegrees.toStringAsFixed(1)})';
}
