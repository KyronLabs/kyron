// lib/services/lens_video.dart
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import '../models/face_anchor.dart';
import '../models/face_region.dart';
import '../models/head_pose.dart';
import '../models/lens.dart';
import '../models/lens_effect.dart';
import '../widgets/face_attachment_painter.dart';
import '../widgets/glasses_painter.dart';
import '../widgets/lens_effect_layer.dart';
import 'app_log.dart';

/// Where the face was at one moment of a recording.
class LensVideoFrame {
  /// From the start of the recording.
  final Duration at;

  /// Null when there was no face in that frame -- the lens draws nothing
  /// there, exactly as the preview drew nothing.
  final List<FacePoint>? landmarks;

  /// The skin colour read off that frame, for a fill.
  final Color? skin;

  const LensVideoFrame(this.at, this.landmarks, {this.skin});
}

/// The face, through a recording, kept as numbers rather than pictures.
///
/// Recorded while the camera records, from the same frames that drive the
/// preview -- so the lens baked into the video is where the viewfinder showed
/// it. Thinned to [spacing]: a pose sampled fifteen times a second is smooth
/// on a face, and every sample kept is a picture drawn afterwards.
class LensVideoTimeline {
  LensVideoTimeline({this.spacing = const Duration(milliseconds: 66)});

  final Duration spacing;
  final List<LensVideoFrame> _frames = [];

  List<LensVideoFrame> get frames => List.unmodifiable(_frames);

  bool get isEmpty => _frames.isEmpty;

  void add(LensVideoFrame frame) {
    if (_frames.isNotEmpty) {
      final last = _frames.last;
      if (frame.at < last.at) return;
      // Kept if the face came or went, however soon: a lens that lingers
      // after the face has gone is the thing that looks broken.
      final changedPresence =
          (last.landmarks == null) != (frame.landmarks == null);
      if (!changedPresence && frame.at - last.at < spacing) return;
    }
    _frames.add(frame);
  }

  void clear() => _frames.clear();
}

/// Sends a bake to the platform, and says where the result is.
///
/// Answers null when it could not: the caller keeps the plain recording and
/// says the lens was not added, rather than losing the clip.
typedef RunLensVideo = Future<String?> Function(Map<String, Object?> job);

/// Bakes a lens into a recording.
///
/// The camera records the picture as it is; what was drawn over the
/// viewfinder is drawn again afterwards, from the poses recorded alongside,
/// one picture per moment. The platform lays those into the video -- on
/// Android, Media3 Transformer and one shader (android/.../LensVideo.kt), on
/// the GPU and the phone's own encoder.
///
/// What this hands over is a plain description, so it is tested here without
/// a phone: the colour matrix, the blur, the crop and the mirror as numbers,
/// and the pictures as files each with the time it takes over.
class LensVideoBaker {
  LensVideoBaker({required this.run});

  final RunLensVideo run;

  /// The overlay sequence is drawn at this share of the frame, and the masks
  /// at half that. Glasses edges stay crisp at three quarters; a mask is
  /// feathered anyway. The shader samples them in 0..1, so any size lines up.
  static const overlayScale = 0.75;
  static const maskScale = 0.375;

  /// The platform channel the app bakes through.
  static const channel = MethodChannel('so.kyron.app/lens_video');

  /// [run] for the app: the channel, on a platform that answers it.
  static Future<String?> viaChannel(Map<String, Object?> job) async {
    try {
      return await channel.invokeMethod<String>('bake', job);
    } on PlatformException catch (error) {
      AppLog.instance.error('ar', 'Lens video: ${error.code} ${error.message}');
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  /// Returns the path of the baked video, or [input] when nothing changes.
  /// Throws when the platform could not bake it.
  Future<String> bake({
    required String input,
    required String output,
    required Lens lens,
    required List<LensVideoFrame> timeline,
    required Size frame,
    required Directory work,
    List<ResolvedAttachment> attachments = const [],
    Rect crop = const Rect.fromLTWH(0, 0, 1, 1),
    bool mirror = false,
  }) async {
    final job = await describe(
      input: input,
      output: output,
      lens: lens,
      timeline: timeline,
      frame: frame,
      work: work,
      attachments: attachments,
      crop: crop,
      mirror: mirror,
    );
    if (job == null) return input;
    final baked = await run(job);
    if (baked == null) {
      throw StateError('The lens could not be applied to the video.');
    }
    return baked;
  }

  /// What [bake] sends, or null when the lens changes nothing.
  ///
  /// `matrix` and `wash` are Flutter's 4x5 colour matrices, offsets in
  /// 0-255. `blur` is the spread as a share of the frame's width. `crop` is
  /// left, top, width, height as fractions. `overlays` and `masks` are
  /// `{at: microseconds, path}`, sorted, each on screen until the next.
  Future<Map<String, Object?>?> describe({
    required String input,
    required String output,
    required Lens lens,
    required List<LensVideoFrame> timeline,
    required Size frame,
    required Directory work,
    List<ResolvedAttachment> attachments = const [],
    Rect crop = const Rect.fromLTWH(0, 0, 1, 1),
    bool mirror = false,
  }) async {
    final effects = lens.effects;
    final fills = effects.whereType<FillEffect>().toList();
    final draws = lens.glasses != null || attachments.isNotEmpty;
    final masked = effects.isNotEmpty && !frame.isEmpty && timeline.isNotEmpty;
    final overlaid =
        !frame.isEmpty && timeline.isNotEmpty && (draws || fills.isNotEmpty);

    final whole = crop == const Rect.fromLTWH(0, 0, 1, 1);
    if (lens.matrix == null && !masked && !overlaid && whole && !mirror) {
      return null;
    }

    await work.create(recursive: true);

    final masks = masked
        ? await _sequence(
            work,
            'mask',
            timeline,
            frame * maskScale,
            maskScale,
            blank: Colors.black,
            draw: (canvas, f, sample) =>
                _mask(canvas, f, sample.landmarks!, effects),
          )
        : const <Map<String, Object?>>[];

    final overlays = overlaid
        ? await _sequence(
            work,
            'art',
            timeline,
            frame * overlayScale,
            overlayScale,
            blank: Colors.transparent,
            draw: (canvas, f, sample) =>
                _art(canvas, f, sample, lens, attachments, fills),
          )
        : const <Map<String, Object?>>[];

    final frost = effects.whereType<FrostEffect>().firstOrNull;
    return {
      'input': input,
      'output': output,
      'matrix': lens.matrix,
      'overlays': overlays,
      'masks': masks,
      'blur': masked ? _blurSpread(timeline, frame, effects) : 0.0,
      'wash': frost == null ? null : washMatrix(frost.desaturate, frost.lift),
      'crop': [crop.left, crop.top, crop.width, crop.height],
      'mirror': mirror,
    };
  }

  /// Frost's wash as a matrix: the same numbers [LensEffectLayer] uses.
  static List<double> washMatrix(double desaturate, double lift) {
    const lr = 0.2126, lg = 0.7152, lb = 0.0722;
    final keep = 1 - desaturate;
    final scale = 1 - lift;
    final offset = 255 * lift;
    double diag(double luma) => (keep + desaturate * luma) * scale;
    double off(double luma) => desaturate * luma * scale;
    return [
      diag(lr), off(lg), off(lb), 0, offset, //
      off(lr), diag(lg), off(lb), 0, offset, //
      off(lr), off(lg), diag(lb), 0, offset, //
      0, 0, 0, 1, 0, //
    ];
  }

  /// Draws one picture per sample, each with the time it takes over.
  ///
  /// A moment with no face gets the blank picture, written once and listed
  /// as often as it is needed -- so the lens leaves the video when the face
  /// does, as it left the viewfinder.
  Future<List<Map<String, Object?>>> _sequence(
    Directory work,
    String name,
    List<LensVideoFrame> timeline,
    Size size,
    double scale, {
    required Color blank,
    required void Function(Canvas canvas, Size frame, LensVideoFrame sample)
        draw,
  }) async {
    final width = math.max(2, size.width.round());
    final height = math.max(2, size.height.round());
    final frame = Size(size.width / scale, size.height / scale);

    final empty = p.join(work.path, '$name-blank.png');
    await _write(empty, width, height, (canvas) {
      canvas.drawColor(blank, BlendMode.src);
    });

    final entries = <Map<String, Object?>>[];
    // Nothing before the first sample: the face had not been found yet.
    if (timeline.first.at > Duration.zero) {
      entries.add({'at': 0, 'path': empty});
    }
    for (var i = 0; i < timeline.length; i++) {
      final sample = timeline[i];
      var file = empty;
      if (sample.landmarks != null) {
        file = p.join(work.path, '$name-${i.toString().padLeft(5, '0')}.png');
        await _write(file, width, height, (canvas) {
          canvas.drawColor(blank, BlendMode.src);
          canvas.scale(scale);
          draw(canvas, frame, sample);
        });
      }
      entries.add({'at': sample.at.inMicroseconds, 'path': file});
    }
    return entries;
  }

  static Future<void> _write(
    String path,
    int width,
    int height,
    void Function(Canvas canvas) draw,
  ) async {
    final recorder = ui.PictureRecorder();
    draw(Canvas(recorder));
    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    picture.dispose();
    try {
      final png = await image.toByteData(format: ui.ImageByteFormat.png);
      if (png == null) throw StateError('A lens frame could not be encoded.');
      await File(path).writeAsBytes(png.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  }

  /// White wherever an effect blurs the picture, feathered like the still.
  static void _mask(
    Canvas canvas,
    Size frame,
    List<FacePoint> points,
    List<LensEffect> effects,
  ) {
    final face = FaceAnchor.resolve(FaceAnchorPoint.eyes, points, frame);
    if (face == null) return;
    final gap = face.interpupillary;
    for (final effect in effects) {
      final (region, feather, invert) = switch (effect) {
        FillEffect(:final region, :final feather) => (region, feather, false),
        FrostEffect(:final reveal, :final feather) => (reveal, feather, true),
      };
      final path = FaceRegion.path(region, points, frame, face);
      if (path == null) continue;
      final shape = invert ? EverythingBut(path, frame).getClip(frame) : path;
      final soft = gap * feather;
      canvas.drawPath(
        shape,
        Paint()
          ..color = Colors.white
          ..maskFilter =
              soft > 0.5 ? MaskFilter.blur(BlurStyle.normal, soft) : null,
      );
    }
  }

  /// Glasses, pictures and a fill's skin, over a transparent frame.
  static void _art(
    Canvas canvas,
    Size frame,
    LensVideoFrame sample,
    Lens lens,
    List<ResolvedAttachment> attachments,
    List<FillEffect> fills,
  ) {
    final points = sample.landmarks!;
    final eyes = FaceAnchor.resolve(FaceAnchorPoint.eyes, points, frame);
    if (eyes == null) return;

    // Skin over the blurred region, as the preview lays it.
    for (final fill in fills) {
      final path = FaceRegion.path(fill.region, points, frame, eyes);
      // No reading, no fill -- as in the preview, rather than guessing at
      // somebody's skin.
      final skin = sample.skin;
      if (path == null || skin == null) continue;
      final soft = eyes.interpupillary * fill.feather;
      canvas.drawPath(
        path,
        Paint()
          ..color = skin.withValues(alpha: 1 - fill.keepShading)
          ..maskFilter =
              soft > 0.5 ? MaskFilter.blur(BlurStyle.normal, soft) : null,
      );
    }

    final glasses = lens.glasses;
    if (glasses != null) {
      final pose = HeadPose.resolve(points, frame);
      if (pose != null) {
        GlassesPainter.paintGlasses(
          canvas,
          glasses,
          pose,
          face: [
            for (final point in points)
              Vec3(
                point.x * frame.width,
                point.y * frame.height,
                point.z * frame.width,
              ),
          ],
        );
      }
    }

    if (attachments.isNotEmpty) {
      final anchor = FaceAnchor.resolve(
        lens.attachments.first.anchor,
        points,
        frame,
      );
      if (anchor != null) {
        FaceAttachmentPainter(attachments: attachments, face: anchor)
            .paint(canvas, frame);
      }
    }
  }

  /// The blur's spread (one standard deviation), as a share of the frame's
  /// width: the strongest effect's, at the median face size through the
  /// clip. One number for the whole video, because a blur that breathed as
  /// somebody leaned in would be visible.
  static double _blurSpread(
    List<LensVideoFrame> timeline,
    Size frame,
    List<LensEffect> effects,
  ) {
    if (effects.isEmpty || frame.isEmpty) return 0;
    final gaps = <double>[
      for (final sample in timeline)
        if (sample.landmarks case final points?)
          if (FaceAnchor.resolve(FaceAnchorPoint.eyes, points, frame)
              case final face?)
            face.interpupillary,
    ]..sort();
    if (gaps.isEmpty) return 0;
    final gap = gaps[gaps.length ~/ 2];
    final sigma = effects
        .map(
          (e) => switch (e) {
            FillEffect(:final feather) => gap * math.max(0.10, feather),
            FrostEffect(:final blur) => gap * blur,
          },
        )
        .reduce(math.max);
    return (sigma / frame.width).clamp(0.001, 0.2);
  }
}
