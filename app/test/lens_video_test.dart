import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/face_region.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/models/lens_effect.dart';
import 'package:kyron_app/services/lens_video.dart';

/// What the camera hands the platform to put a lens into a video.
///
/// The platform half (Media3 and one shader, LensVideo.kt) needs a phone. Its
/// shader is checked separately by tools/lens_shader_check.mjs, which runs it
/// in a browser's WebGL against the job this file describes. This checks the
/// job itself: the numbers, and the pictures drawn into it.

/// The detection in test/face-detection.json is of an 820x1024 picture.
const frame = Size(820, 1024);

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

const frosted = Lens(
  id: 'frosted',
  name: 'Frosted',
  effects: [FrostEffect(reveal: FaceRegionKind.eyes)],
);

void main() {
  final points = fixture();
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('lens-video'));
  tearDown(() => dir.deleteSync(recursive: true));

  List<LensVideoFrame> faceThroughout() => (LensVideoTimeline()
        ..add(LensVideoFrame(Duration.zero, points))
        ..add(LensVideoFrame(const Duration(milliseconds: 700), points)))
      .frames;

  Future<Map<String, Object?>?> describe(
    Lens lens, {
    List<LensVideoFrame>? timeline,
    bool mirror = false,
    Rect crop = const Rect.fromLTWH(0, 0, 1, 1),
  }) =>
      LensVideoBaker(run: (_) async => null).describe(
        input: 'in.mp4',
        output: 'out.mp4',
        lens: lens,
        timeline: timeline ?? faceThroughout(),
        frame: frame,
        work: Directory('${dir.path}/work'),
        mirror: mirror,
        crop: crop,
      );

  List<Map> entries(Map<String, Object?> job, String key) =>
      (job[key]! as List).cast<Map>();

  img.Image picture(Map entry) =>
      img.decodePng(File(entry['path'] as String).readAsBytesSync())!;

  testWidgets('glasses are drawn over the eyes, for each moment', (t) async {
    await t.runAsync(() async {
      final specs = Lens.builtIn.firstWhere((l) => l.id == 'specs');
      final job = (await describe(specs))!;

      final art = entries(job, 'overlays');
      expect(art.map((e) => e['at']), [0, 700000]);
      expect(entries(job, 'masks'), isEmpty);
      expect(job['matrix'], isNull);

      final drawn = picture(art.first);
      // Drawn at three quarters of the frame; the shader samples it in 0..1.
      expect(drawn.width, (frame.width * LensVideoBaker.overlayScale).round());
      final iris = points[FaceAnchor.leftIris];
      final eye = drawn.getPixel(
        (iris.x * drawn.width).round(),
        (iris.y * drawn.height).round(),
      );
      expect(eye.a, greaterThan(150), reason: 'a tinted lens over the eye');
      expect(drawn.getPixel(10, drawn.height - 10).a, 0);
    });
  });

  testWidgets('the lens leaves when the face does', (t) async {
    await t.runAsync(() async {
      final specs = Lens.builtIn.firstWhere((l) => l.id == 'specs');
      final timeline = (LensVideoTimeline()
            ..add(LensVideoFrame(const Duration(milliseconds: 300), points))
            ..add(LensVideoFrame(const Duration(milliseconds: 900), null)))
          .frames;
      final art =
          entries((await describe(specs, timeline: timeline))!, 'overlays');

      // Blank until the face was found, drawn, then blank again.
      expect(art.map((e) => e['at']), [0, 300000, 900000]);
      expect(art.first['path'], art.last['path']);
      expect(picture(art.first).getPixel(400, 300).a, 0);
      expect(art[1]['path'], isNot(art.first['path']));
    });
  });

  testWidgets('frost masks everything but the eyes and washes it', (t) async {
    await t.runAsync(() async {
      final job = (await describe(frosted))!;
      final masks = entries(job, 'masks');
      expect(masks, hasLength(2));
      expect(entries(job, 'overlays'), isEmpty);

      final mask = picture(masks.first);
      final iris = points[FaceAnchor.leftIris];
      final eye = mask.getPixel(
        (iris.x * mask.width).round(),
        (iris.y * mask.height).round(),
      );
      expect(eye.r, lessThan(40), reason: 'the eyes stay sharp');
      expect(mask.getPixel(5, mask.height - 5).r, greaterThan(215));

      // A spread in proportion to the face, and the wash Flutter applies.
      final blur = job['blur']! as double;
      expect(blur, greaterThan(0.005));
      expect(blur, lessThan(0.1));
      expect(job['wash'], LensVideoBaker.washMatrix(0.3, 0.16));
    });
  });

  testWidgets('a colour lens is its matrix and nothing drawn', (t) async {
    await t.runAsync(() async {
      final mono = Lens.builtIn.firstWhere((l) => l.id == 'mono');
      final job = (await describe(mono, timeline: const []))!;
      expect(job['matrix'], mono.matrix);
      expect(entries(job, 'overlays'), isEmpty);
      expect(entries(job, 'masks'), isEmpty);
      expect(job['blur'], 0.0);
    });
  });

  testWidgets('crop and mirror are passed as they were seen', (t) async {
    await t.runAsync(() async {
      final job = (await describe(
        Lens.builtIn.first,
        timeline: const [],
        mirror: true,
        crop: const Rect.fromLTWH(0.1, 0, 0.8, 1),
      ))!;
      expect(job['crop'], [0.1, 0.0, 0.8, 1.0]);
      expect(job['mirror'], isTrue);
    });
  });

  test('a lens that changes nothing leaves the file alone', () async {
    var ran = false;
    final out = await LensVideoBaker(
      run: (_) async {
        ran = true;
        return 'baked.mp4';
      },
    ).bake(
      input: 'in.mp4',
      output: 'out.mp4',
      lens: Lens.builtIn.first,
      timeline: const [],
      frame: frame,
      work: Directory.systemTemp,
    );
    expect(out, 'in.mp4');
    expect(ran, isFalse);
  });

  test('a platform that cannot bake is an error the caller sees', () async {
    final mono = Lens.builtIn.firstWhere((l) => l.id == 'mono');
    expect(
      LensVideoBaker(run: (_) async => null).bake(
        input: 'in.mp4',
        output: 'out.mp4',
        lens: mono,
        timeline: const [],
        frame: frame,
        work: Directory.systemTemp,
      ),
      throwsStateError,
    );
  });

  test('the timeline thins samples but never a face arriving or leaving', () {
    final timeline = LensVideoTimeline()
      ..add(LensVideoFrame(Duration.zero, points))
      ..add(LensVideoFrame(const Duration(milliseconds: 20), points))
      ..add(LensVideoFrame(const Duration(milliseconds: 30), null))
      ..add(LensVideoFrame(const Duration(milliseconds: 40), points))
      ..add(LensVideoFrame(const Duration(milliseconds: 200), points));
    expect(
      timeline.frames.map((f) => f.at.inMilliseconds),
      [0, 30, 40, 200],
    );
  });

  testWidgets('writes the job the shader check reads', (t) async {
    // tools/lens_shader_check.mjs runs the Android shader against this.
    const out = String.fromEnvironment('lensJob');
    if (out.isEmpty) return;
    await t.runAsync(() async {
      for (final lens in [
        Lens.builtIn.firstWhere((l) => l.id == 'specs'),
        frosted,
        Lens.builtIn.firstWhere((l) => l.id == 'mono'),
      ]) {
        final job = (await LensVideoBaker(run: (_) async => null).describe(
          input: 'in.mp4',
          output: 'out.mp4',
          lens: lens,
          timeline: faceThroughout(),
          frame: frame,
          work: Directory('$out/${lens.id}'),
        ))!;
        File('$out/${lens.id}.json').writeAsStringSync(jsonEncode(job));
      }
    });
  });
}
