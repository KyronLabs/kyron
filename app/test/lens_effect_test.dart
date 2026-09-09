import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/face_region.dart';
import 'package:kyron_app/models/lens_effect.dart';
import 'package:kyron_app/widgets/lens_effect_layer.dart';

/// How much detail there is in a patch: the variance of its Laplacian, which
/// is the standard "is this in focus" number. An erased mouth scores near
/// zero; an untouched eye keeps whatever it started with.
double detail(Uint8List rgba, int width, Rect box) {
  double at(int x, int y) {
    final i = (y * width + x) * 4;
    return 0.2126 * rgba[i] + 0.7152 * rgba[i + 1] + 0.0722 * rgba[i + 2];
  }

  final values = <double>[];
  for (var y = box.top.round() + 1; y < box.bottom - 1; y++) {
    for (var x = box.left.round() + 1; x < box.right - 1; x++) {
      values.add(at(x, y - 1) +
          at(x, y + 1) +
          at(x - 1, y) +
          at(x + 1, y) -
          4 * at(x, y));
    }
  }
  if (values.isEmpty) return 0;
  final mean = values.reduce((a, b) => a + b) / values.length;
  return values.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) /
      values.length;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // A face, drawn rather than photographed: a pale oval with dark eyes and a
  // dark mouth. Enough for "was the mouth erased and were the eyes kept",
  // which is what these effects promise, and it needs no image checked in.
  Future<ui.Image> drawnFace(Size size) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFF202030));
    canvas.drawOval(
      Rect.fromCenter(
          center: size.center(Offset.zero), width: 300, height: 400),
      Paint()..color = const Color(0xFFE8C0A0),
    );
    // Eyes and mouth as hard stripes, so any blur over them is unmistakable.
    for (final dx in [-55.0, 55.0]) {
      canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(dx, -60)), width: 46, height: 20),
        Paint()..color = const Color(0xFF101010),
      );
    }
    canvas.drawRect(
      Rect.fromCenter(
          center: size.center(const Offset(0, 90)), width: 120, height: 26),
      Paint()..color = const Color(0xFF401010),
    );
    final picture = recorder.endRecording();
    final image =
        await picture.toImage(size.width.round(), size.height.round());
    picture.dispose();
    return image;
  }

  /// Landmarks placed so the irises sit on the drawn eyes.
  List<FacePoint> landmarksFor(Size size) {
    final points = List<FacePoint>.filled(
      FaceAnchor.requiredLandmarks,
      const FacePoint(0.5, 0.5),
    );
    FacePoint at(double dx, double dy) => FacePoint(
          (size.width / 2 + dx) / size.width,
          (size.height / 2 + dy) / size.height,
        );
    points[FaceAnchor.leftIris] = at(-55, -60);
    points[FaceAnchor.rightIris] = at(55, -60);
    points[FaceAnchor.foreheadPoint] = at(0, -170);
    points[FaceAnchor.chinPoint] = at(0, 180);
    points[FaceAnchor.noseTip] = at(0, 20);
    points[FaceAnchor.lipTop] = at(0, 84);
    points[FaceAnchor.lipBottom] = at(0, 98);
    // A spread of points over the lower face, so the hull has an area.
    for (var i = 0; i < 60; i++) {
      final t = i / 59;
      points[i] = at(-120 + 240 * t, 40 + 120 * (t * (1 - t)) * 2);
      points[i + 60] = at(-120 + 240 * t, 170);
    }
    return points;
  }

  Future<Uint8List> bake(LensEffect effect, Size size) async {
    final photo = await drawnFace(size);
    final landmarks = landmarksFor(size);
    final face = FaceAnchor.resolve(FaceAnchorPoint.eyes, landmarks, size)!;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(photo, Offset.zero, Paint());
    const LensEffectBaker().paint(
      canvas,
      photo,
      [effect],
      landmarks: landmarks,
      face: face,
      frame: size,
      skin: const Color(0xFFE8C0A0),
    );
    final picture = recorder.endRecording();
    final out = await picture.toImage(size.width.round(), size.height.round());
    picture.dispose();
    final data = await out.toByteData(format: ui.ImageByteFormat.rawRgba);
    return data!.buffer.asUint8List();
  }

  const size = Size(500, 600);
  final eyes =
      Rect.fromCenter(center: const Offset(250, 240), width: 180, height: 44);
  final mouth =
      Rect.fromCenter(center: const Offset(250, 390), width: 150, height: 44);

  test('fill erases the mouth and leaves the eyes', () async {
    final before = await drawnFace(size);
    final raw = await before.toByteData(format: ui.ImageByteFormat.rawRgba);
    final original = raw!.buffer.asUint8List();

    final after = await bake(
      const FillEffect(region: FaceRegionKind.lowerFace),
      size,
    );

    final mouthBefore = detail(original, 500, mouth);
    final mouthAfter = detail(after, 500, mouth);
    final eyesBefore = detail(original, 500, eyes);
    final eyesAfter = detail(after, 500, eyes);

    // The mouth is what a fill is for. Anything above a fraction of what it
    // started with means features survived, which is the failure this effect
    // exists to avoid -- and the one a partial-opacity fill actually had.
    expect(mouthBefore, greaterThan(50), reason: 'the drawn mouth has detail');
    expect(mouthAfter, lessThan(mouthBefore * 0.05));

    // The eyes are above the region and must come through.
    expect(eyesAfter, greaterThan(eyesBefore * 0.5));
  });

  test('frost keeps the eyes and takes everything else', () async {
    final before = await drawnFace(size);
    final raw = await before.toByteData(format: ui.ImageByteFormat.rawRgba);
    final original = raw!.buffer.asUint8List();

    final after = await bake(const FrostEffect(), size);

    expect(detail(after, 500, eyes),
        greaterThan(detail(original, 500, eyes) * 0.8));
    expect(detail(after, 500, mouth),
        lessThan(detail(original, 500, mouth) * 0.05));
  });

  test('a fill with no sampled skin draws nothing', () async {
    // A guessed skin tone is somebody else's skin on all but one face.
    final photo = await drawnFace(size);
    final landmarks = landmarksFor(size);
    final face = FaceAnchor.resolve(FaceAnchorPoint.eyes, landmarks, size)!;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(photo, Offset.zero, Paint());
    const LensEffectBaker().paint(
      canvas,
      photo,
      const [FillEffect(region: FaceRegionKind.lowerFace)],
      landmarks: landmarks,
      face: face,
      frame: size,
    );
    final picture = recorder.endRecording();
    final out = await picture.toImage(500, 600);
    picture.dispose();
    final data = await out.toByteData(format: ui.ImageByteFormat.rawRgba);

    final raw = await photo.toByteData(format: ui.ImageByteFormat.rawRgba);
    expect(
      detail(data!.buffer.asUint8List(), 500, mouth),
      closeTo(detail(raw!.buffer.asUint8List(), 500, mouth), 1),
    );
  });
}
