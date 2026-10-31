import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/head_pose.dart';

/// The same real detection face_anchor_test.dart reads: MediaPipe's own test
/// portrait, 478 landmarks with depth. A pose that is only checked against
/// invented numbers can be self-consistently wrong.
List<FacePoint> fixture() {
  final json = jsonDecode(File('test/face-detection.json').readAsStringSync())
      as Map<String, dynamic>;
  return [
    for (final p in json['landmarks'] as List)
      FacePoint(
        ((p as List)[0] as num).toDouble(),
        (p[1] as num).toDouble(),
        (p[2] as num).toDouble(),
      ),
  ];
}

const frame = Size(820, 1024);

/// [points] turned about the vertical axis through [pivot] by [degrees],
/// in frame pixels and back -- a head turning, made from a real face.
List<FacePoint> turned(List<FacePoint> points, double degrees) {
  final r = degrees * math.pi / 180;
  final c = math.cos(r), s = math.sin(r);
  final pivot = points[FaceAnchor.noseTip];
  final px = pivot.x * frame.width, pz = pivot.z * frame.width;
  return [
    for (final p in points)
      () {
        final x = p.x * frame.width - px;
        final z = p.z * frame.width - pz;
        // Positive degrees turns the face towards the image's right: its
        // forward vector, -z, swings towards +x.
        final nx = x * c - z * s;
        final nz = x * s + z * c;
        return FacePoint((nx + px) / frame.width, p.y, (nz + pz) / frame.width);
      }(),
  ];
}

void main() {
  final face = fixture();

  test('the portrait is close to square on to the camera', () {
    final pose = HeadPose.resolve(face, frame)!;
    expect(pose.yawDegrees.abs(), lessThan(12));
    expect(pose.pitchDegrees.abs(), lessThan(20));
    expect(pose.rollDegrees.abs(), lessThan(5));
    // Facing the camera: into the head is away from it.
    expect(pose.back.z, greaterThan(0.9));
  });

  test('axes are a right-angled set of unit vectors', () {
    final pose = HeadPose.resolve(turned(face, 30), frame)!;
    for (final axis in [pose.right, pose.down, pose.back]) {
      expect(axis.length, closeTo(1, 1e-9));
    }
    expect(pose.right.dot(pose.down), closeTo(0, 1e-9));
    expect(pose.right.dot(pose.back), closeTo(0, 1e-9));
    expect(pose.down.dot(pose.back), closeTo(0, 1e-9));
  });

  test('follows a head turning, in both directions', () {
    final straight = HeadPose.resolve(face, frame)!.yawDegrees;
    for (final degrees in [-40.0, -20.0, 20.0, 40.0]) {
      final yaw = HeadPose.resolve(turned(face, degrees), frame)!.yawDegrees;
      expect(yaw - straight, closeTo(degrees, 2), reason: '$degrees');
    }
  });

  test('keeps the face the same size as it turns', () {
    // The 2D pupil gap falls with the cosine of the turn; the 3D one must
    // not, or glasses shrink twice -- once by scale, once by rotation.
    final straight = HeadPose.resolve(face, frame)!.scale;
    final away = HeadPose.resolve(turned(face, 45), frame)!.scale;
    expect(away / straight, closeTo(1, 0.02));
  });

  test('puts the pupils where the irises are', () {
    final pose = HeadPose.resolve(face, frame)!;
    final left = pose.toFrame(const Vec3(-0.5, 0, 0));
    final iris = face[FaceAnchor.leftIris];
    // Within a few percent of the gap: "right" runs along the eye corners,
    // not exactly through the irises.
    expect(left.x, closeTo(iris.x * frame.width, pose.scale * 0.06));
    expect(left.y, closeTo(iris.y * frame.height, pose.scale * 0.06));
  });

  test('refuses what cannot be a face', () {
    expect(HeadPose.resolve(face.take(100).toList(), frame), isNull);
    expect(HeadPose.resolve(face, Size.zero), isNull);
    final collapsed = [for (var i = 0; i < 478; i++) const FacePoint(.5, .5)];
    expect(HeadPose.resolve(collapsed, frame), isNull);
  });

  test('flat landmarks still give a usable, front-facing pose', () {
    // A source with no depth must degrade to 2D, not to nonsense.
    final flat = [for (final p in face) FacePoint(p.x, p.y)];
    final pose = HeadPose.resolve(flat, frame)!;
    expect(pose.back.z, closeTo(1, 1e-6));
  });
}
