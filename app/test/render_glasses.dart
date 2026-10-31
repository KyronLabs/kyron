import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/head_pose.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/widgets/glasses_painter.dart';

/// A tool, not a test: draws every built-in pair of glasses onto a photo,
/// through the same painter the shutter bakes with.
///
///     flutter test test/render_glasses.dart \
///       --dart-define=photo=face.png --dart-define=landmarks=face.json
///
/// `landmarks` is `{"landmarks": [[x, y, z], ...]}` for that photo, as
/// kyron-lenses/tools/face.py writes it. Without a photo it draws the face
/// in test/face-detection.json as points, turned left and right, which is
/// what shows the arms hiding behind the head.
const photoPath = String.fromEnvironment('photo');
const landmarksPath = String.fromEnvironment('landmarks',
    defaultValue: 'test/face-detection.json');
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    final json = jsonDecode(File(landmarksPath).readAsStringSync()) as Map;
    final points = [
      for (final p in json['landmarks'] as List)
        FacePoint(
          ((p as List)[0] as num).toDouble(),
          (p[1] as num).toDouble(),
          (p[2] as num).toDouble(),
        ),
    ];
    final lenses = Lens.builtIn.where((l) => l.glasses != null);

    await tester.runAsync(() async {
      ui.Image? photo;
      if (photoPath.isNotEmpty) {
        final codec =
            await ui.instantiateImageCodec(File(photoPath).readAsBytesSync());
        photo = (await codec.getNextFrame()).image;
      }
      final size = photo == null
          ? const Size(820, 1024)
          : Size(photo.width.toDouble(), photo.height.toDouble());

      for (final lens in lenses) {
        for (final yaw
            in photo == null ? [-50.0, -25.0, 0.0, 25.0, 50.0] : [0.0]) {
          final face = yaw == 0 ? points : _turned(points, size, yaw);
          final pose = HeadPose.resolve(face, size)!;
          final recorder = ui.PictureRecorder();
          final canvas = Canvas(recorder);
          if (photo != null) {
            canvas.drawImage(photo, Offset.zero, Paint());
          } else {
            canvas.drawRect(
              Offset.zero & size,
              Paint()..color = const Color(0xFF8D6E63),
            );
            for (final p in face) {
              canvas.drawCircle(
                Offset(p.x * size.width, p.y * size.height),
                1.5,
                Paint()..color = const Color(0x66FFFFFF),
              );
            }
          }
          GlassesPainter.paintGlasses(
            canvas,
            lens.glasses!,
            pose,
            face: [
              for (final p in face)
                Vec3(p.x * size.width, p.y * size.height, p.z * size.width),
            ],
          );
          final image = await recorder
              .endRecording()
              .toImage(size.width.round(), size.height.round());
          final png = await image.toByteData(format: ui.ImageByteFormat.png);
          File('$out/glasses-${lens.id}-${yaw.round()}.png')
              .writeAsBytesSync(png!.buffer.asUint8List());
        }
      }
    });
  });
}

List<FacePoint> _turned(List<FacePoint> points, Size frame, double degrees) {
  final r = degrees * math.pi / 180;
  final c = math.cos(r), s = math.sin(r);
  final pivot = points[FaceAnchor.noseTip];
  final px = pivot.x * frame.width, pz = pivot.z * frame.width;
  return [
    for (final p in points)
      () {
        final x = p.x * frame.width - px;
        final z = p.z * frame.width - pz;
        return FacePoint(
          (x * c - z * s + px) / frame.width,
          p.y,
          (x * s + z * c + pz) / frame.width,
        );
      }(),
  ];
}
