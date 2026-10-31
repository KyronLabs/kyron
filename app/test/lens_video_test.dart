import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/models/lens_effect.dart';
import 'package:kyron_app/models/face_region.dart';
import 'package:kyron_app/services/lens_video.dart';

/// The video half of "the picture taken is the picture seen", checked by
/// running the command: the arguments the phone hands FFmpegKit, handed to a
/// desktop ffmpeg instead, on a clip made here, with the pixels that come out
/// read back.
///
/// Skipped where there is no ffmpeg, rather than passing by checking nothing.
bool get hasFfmpeg {
  try {
    return Process.runSync('ffmpeg', ['-version']).exitCode == 0;
  } catch (_) {
    return false;
  }
}

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

Future<bool> desktop(List<String> args) async {
  final result = await Process.run('ffmpeg', ['-loglevel', 'error', ...args]);
  if (result.exitCode != 0) stderr.writeln(result.stderr);
  return result.exitCode == 0;
}

/// A clip with something to see in it: left half orange, right half blue,
/// with a tone so the audio has to survive too.
Future<String> clip(Directory dir) async {
  final path = '${dir.path}/raw.mp4';
  final result = await Process.run('ffmpeg', [
    '-loglevel',
    'error',
    '-y',
    '-f',
    'lavfi',
    '-i',
    'color=c=0xE08030:s=410x1024:d=2,format=yuv420p[l];'
        'color=c=0x3060E0:s=410x1024:d=2,format=yuv420p[r];'
        '[l][r]hstack',
    '-f',
    'lavfi',
    '-i',
    'sine=frequency=440:duration=2',
    '-shortest',
    '-c:v',
    'mpeg4',
    '-q:v',
    '2',
    '-c:a',
    'aac',
    path,
  ]);
  expect(result.exitCode, 0, reason: '${result.stderr}');
  return path;
}

img.Image still(String video, Directory dir, {double at = 1}) {
  final png = '${dir.path}/still-${DateTime.now().microsecondsSinceEpoch}.png';
  final result = Process.runSync('ffmpeg', [
    '-loglevel',
    'error',
    '-y',
    '-ss',
    '$at',
    '-i',
    video,
    '-frames:v',
    '1',
    png,
  ]);
  expect(result.exitCode, 0, reason: '${result.stderr}');
  return img.decodePng(File(png).readAsBytesSync())!;
}

bool hasAudio(String video) {
  final result = Process.runSync('ffprobe', [
    '-v',
    'error',
    '-select_streams',
    'a',
    '-show_entries',
    'stream=codec_type',
    '-of',
    'csv=p=0',
    video,
  ]);
  return (result.stdout as String).contains('audio');
}

const encoder = ['-c:v', 'mpeg4', '-q:v', '2'];

void main() {
  final points = fixture();
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('lens-video'));
  tearDown(() => dir.deleteSync(recursive: true));

  LensVideoTimeline faceThroughout() => LensVideoTimeline()
    ..add(LensVideoFrame(Duration.zero, points))
    ..add(LensVideoFrame(const Duration(milliseconds: 700), points));

  Future<String> bake(
    Lens lens, {
    List<LensVideoFrame>? timeline,
    bool mirror = false,
    Rect crop = const Rect.fromLTWH(0, 0, 1, 1),
  }) async {
    final input = await clip(dir);
    return LensVideoBaker(run: desktop, encoders: [encoder]).bake(
      input: input,
      output: '${dir.path}/out.mp4',
      lens: lens,
      timeline: timeline ?? faceThroughout().frames,
      frame: frame,
      work: Directory('${dir.path}/work'),
      mirror: mirror,
      crop: crop,
    );
  }

  /// Where the left lens of a pair of glasses sits on this face, in pixels.
  Offset leftEye() {
    final p = points[FaceAnchor.leftIris];
    return Offset(p.x * frame.width, p.y * frame.height);
  }

  testWidgets('glasses are baked over the eyes', (tester) async {
    await tester.runAsync(() async {
      final specs = Lens.builtIn.firstWhere((l) => l.id == 'specs');
      final out = await bake(specs);
      final before = still('${dir.path}/raw.mp4', dir);
      final after = still(out, dir);

      final eye = leftEye();
      final was = before.getPixel(eye.dx.round(), eye.dy.round());
      final now = after.getPixel(eye.dx.round(), eye.dy.round());
      // A dark tinted lens over orange: much darker than it was.
      expect(now.luminance, lessThan(was.luminance * 0.6));

      // And nowhere near the face, nothing changed.
      final corner = after.getPixel(20, 1000);
      final cornerWas = before.getPixel(20, 1000);
      expect((corner.r - cornerWas.r).abs(), lessThan(12));
      expect(hasAudio(out), isTrue);
    });
  }, skip: !hasFfmpeg);

  testWidgets('a colour lens grades every frame', (tester) async {
    await tester.runAsync(() async {
      final mono = Lens.builtIn.firstWhere((l) => l.id == 'mono');
      final out = await bake(mono, timeline: const []);
      final pixel = still(out, dir).getPixel(100, 500);
      expect((pixel.r - pixel.g).abs(), lessThan(8));
      expect((pixel.g - pixel.b).abs(), lessThan(8));
    });
  }, skip: !hasFfmpeg);

  testWidgets('frost blurs everything but the eyes', (tester) async {
    await tester.runAsync(() async {
      const frosted = Lens(
        id: 'frosted',
        name: 'Frosted',
        effects: [
          FrostEffect(
            blur: 0.16,
            desaturate: 0.3,
            lift: 0.16,
            reveal: FaceRegionKind.eyes,
            feather: 0.05,
          ),
        ],
      );
      final out = await bake(frosted);
      final before = still('${dir.path}/raw.mp4', dir);
      final after = still(out, dir);

      // The seam between orange and blue, well away from the eyes, is
      // smeared by the blur.
      final seamY = 950;
      final left = after.getPixel(400, seamY),
          right = after.getPixel(420, seamY);
      final wasLeft = before.getPixel(400, seamY);
      final wasRight = before.getPixel(420, seamY);
      final sharp = (wasLeft.r - wasRight.r).abs();
      final soft = (left.r - right.r).abs();
      expect(soft, lessThan(sharp * 0.6));

      // And lifted towards white.
      expect(after.getPixel(100, 950).luminance,
          greaterThan(before.getPixel(100, 950).luminance));
    });
  }, skip: !hasFfmpeg);

  testWidgets('mirrored and cropped to what was on screen', (tester) async {
    await tester.runAsync(() async {
      final out = await bake(
        Lens.builtIn.first,
        timeline: const [],
        mirror: true,
        crop: const Rect.fromLTWH(0.1, 0, 0.8, 1),
      );
      final after = still(out, dir);
      expect(after.width, closeTo(820 * 0.8, 2));
      expect(after.height, 1024);
      // Orange was on the left; mirrored, it is on the right.
      final leftSide = after.getPixel(30, 500);
      expect(leftSide.b, greaterThan(leftSide.r));
    });
  }, skip: !hasFfmpeg);

  test('a lens that changes nothing leaves the file alone', () async {
    var ran = false;
    final out = await LensVideoBaker(
      run: (_) async => ran = true,
      encoders: [encoder],
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

  test('the timeline thins samples but never a face arriving or leaving', () {
    final timeline = LensVideoTimeline();
    final face = points;
    timeline
      ..add(LensVideoFrame(Duration.zero, face))
      ..add(LensVideoFrame(const Duration(milliseconds: 20), face))
      ..add(LensVideoFrame(const Duration(milliseconds: 30), null))
      ..add(LensVideoFrame(const Duration(milliseconds: 40), face))
      ..add(LensVideoFrame(const Duration(milliseconds: 200), face));
    expect(
      timeline.frames.map((f) => f.at.inMilliseconds),
      [0, 30, 40, 200],
    );
  });

  test('falls back to the next encoder when the first refuses', () async {
    final tried = <String>[];
    final baker = LensVideoBaker(
      run: (args) async {
        final codec = args[args.indexOf('-c:v') + 1];
        tried.add(codec);
        if (codec == 'second') {
          File(args.last).writeAsStringSync('video');
          return true;
        }
        return false;
      },
      encoders: [
        ['-c:v', 'first'],
        ['-c:v', 'second'],
      ],
    );
    final mono = Lens.builtIn.firstWhere((l) => l.id == 'mono');
    final out = '${Directory.systemTemp.path}/fallback.mp4';
    expect(
      await baker.bake(
        input: 'in.mp4',
        output: out,
        lens: mono,
        timeline: const [],
        frame: frame,
        work: Directory.systemTemp,
      ),
      out,
    );
    expect(tried, ['first', 'second']);
  });
}
