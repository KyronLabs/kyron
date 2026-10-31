// lib/services/lens_video.dart
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../models/face_anchor.dart';
import '../models/face_region.dart';
import '../models/head_pose.dart';
import '../models/lens.dart';
import '../models/lens_effect.dart';
import '../widgets/face_attachment_painter.dart';
import '../widgets/glasses_painter.dart';
import '../widgets/lens_effect_layer.dart';

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

/// The FFmpeg command that bakes a lens into a recording.
///
/// Pure, so it is tested by running it: test/lens_video_test.dart feeds the
/// same arguments to a desktop ffmpeg and checks the pixels that come out.
/// The phone runs them through FFmpegKit, the same program.
///
/// Inputs, in order: the recording; then, when the lens has effects, a mask
/// sequence (white where the picture is blurred); then, when it draws
/// anything, an overlay sequence (glasses, pictures, a fill's skin). The
/// order the graph stacks them is the order the preview does: colour, then
/// effects, then what is drawn on top.
class LensVideoPlan {
  const LensVideoPlan._();

  /// The filter graph, ending in `[out]`.
  ///
  /// [crop] is the visible part of the frame as fractions of it, and
  /// [blurRadius] the blur as a fraction of the frame's width.
  static String filter({
    required List<double>? matrix,
    required bool masked,
    required bool overlaid,
    required double blurRadius,
    double desaturate = 0,
    double lift = 0,
    Rect crop = const Rect.fromLTWH(0, 0, 1, 1),
    bool mirror = false,
  }) {
    final chains = <String>[];
    var current = '0:v';

    if (matrix != null) {
      chains.add('[$current]format=rgb24,${_mixer(matrix)}[graded]');
      current = 'graded';
    }

    if (masked) {
      final wash = desaturate > 0 || lift > 0
          ? ',${_mixer(_washMatrix(desaturate, lift))}'
          : '';
      chains
        ..add('[$current]format=rgb24,split[sharp][soft]')
        ..add(
          '[soft]boxblur=luma_radius=${_n(blurRadius)}*w:luma_power=2$wash'
          ',format=rgba[blurred]',
        )
        ..add('[1:v][sharp]scale2ref[mask][base]')
        ..add('[mask]format=gray[maskg]')
        ..add('[blurred][maskg]alphamerge[cut]')
        ..add('[base][cut]overlay=format=auto:shortest=1[fx]');
      current = 'fx';
    }

    if (overlaid) {
      final index = masked ? 2 : 1;
      chains
        ..add('[$index:v][$current]scale2ref[art][under]')
        ..add('[under][art]overlay=format=auto:shortest=1[drawn]');
      current = 'drawn';
    }

    final finish = <String>[];
    final whole = crop == const Rect.fromLTWH(0, 0, 1, 1);
    if (!whole) {
      finish.add(
        'crop=w=iw*${_n(crop.width)}:h=ih*${_n(crop.height)}'
        ':x=iw*${_n(crop.left)}:y=ih*${_n(crop.top)}',
      );
    }
    if (mirror) finish.add('hflip');
    // Encoders want even sides and 4:2:0.
    finish
      ..add('scale=trunc(iw/2)*2:trunc(ih/2)*2')
      ..add('format=yuv420p');
    chains.add('[$current]${finish.join(',')}[out]');

    return chains.join(';');
  }

  /// The whole command line, less the program name.
  static List<String> arguments({
    required String input,
    required String output,
    required String filter,
    String? masks,
    String? overlays,
    required List<String> encoder,
  }) =>
      [
        '-y',
        '-i',
        input,
        if (masks != null) ...['-f', 'concat', '-safe', '0', '-i', masks],
        if (overlays != null) ...[
          '-f', 'concat', '-safe', '0', '-i', overlays, //
        ],
        '-filter_complex',
        filter,
        '-map',
        '[out]',
        '-map',
        '0:a?',
        ...encoder,
        '-c:a',
        'copy',
        '-movflags',
        '+faststart',
        output,
      ];

  /// A Flutter colour matrix as `colorchannelmixer`, which has no offsets --
  /// so the offsets follow as a `lutrgb`. The two clip at different points
  /// only for values already at the ends of the range.
  static String _mixer(List<double> m) {
    final mix = 'colorchannelmixer='
        'rr=${_n(m[0])}:rg=${_n(m[1])}:rb=${_n(m[2])}:'
        'gr=${_n(m[5])}:gg=${_n(m[6])}:gb=${_n(m[7])}:'
        'br=${_n(m[10])}:bg=${_n(m[11])}:bb=${_n(m[12])}';
    final offsets = [m[4], m[9], m[14]];
    if (offsets.every((o) => o == 0)) return mix;
    String channel(String c, double o) => "$c='clipval+${_n(o)}'";
    return '$mix,lutrgb=${channel('r', offsets[0])}:'
        '${channel('g', offsets[1])}:${channel('b', offsets[2])}';
  }

  /// Frost's wash as a matrix: the same numbers [LensEffectLayer] uses.
  static List<double> _washMatrix(double desaturate, double lift) {
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

  static String _n(double v) {
    final s = v.toStringAsFixed(5);
    return s.contains('.')
        ? s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '')
        : s;
  }
}

/// Runs an FFmpeg command and says whether it worked.
typedef RunFfmpeg = Future<bool> Function(List<String> arguments);

/// Bakes a lens into a recording.
///
/// The camera records the picture as it is; what was drawn over the
/// viewfinder is drawn again afterwards, from the poses recorded alongside,
/// and laid into the video by FFmpeg. Two steps rather than one live
/// composite because the live preview is the camera's own texture on the GPU,
/// and getting it back out frame by frame to encode is the slow way round.
class LensVideoBaker {
  LensVideoBaker({required this.run, required this.encoders});

  final RunFfmpeg run;

  /// Encoder arguments to try in order. The phone's hardware encoder first;
  /// a software one after it, because a hardware encoder that refuses a
  /// size is a recording lost.
  final List<List<String>> encoders;

  /// The overlay sequence is drawn at this share of the frame, and the masks
  /// at half that. Glasses edges stay crisp at three quarters; a mask is
  /// feathered anyway.
  static const overlayScale = 0.75;
  static const maskScale = 0.375;

  /// Returns the path of the baked video, or [input] when nothing changes.
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
    final effects = lens.effects;
    final fills = effects.whereType<FillEffect>().toList();
    final draws = lens.glasses != null || attachments.isNotEmpty;
    final masked = effects.isNotEmpty && !frame.isEmpty && timeline.isNotEmpty;
    final overlaid =
        !frame.isEmpty && timeline.isNotEmpty && (draws || fills.isNotEmpty);

    final whole = crop == const Rect.fromLTWH(0, 0, 1, 1);
    if (lens.matrix == null && !masked && !overlaid && whole && !mirror) {
      return input;
    }

    await work.create(recursive: true);

    String? masks;
    if (masked) {
      masks = await _sequence(
        work,
        'mask',
        timeline,
        frame * maskScale,
        maskScale,
        blank: Colors.black,
        draw: (canvas, f, sample) =>
            _mask(canvas, f, sample.landmarks!, effects),
      );
    }

    String? overlays;
    if (overlaid) {
      overlays = await _sequence(
        work,
        'art',
        timeline,
        frame * overlayScale,
        overlayScale,
        blank: Colors.transparent,
        draw: (canvas, f, sample) =>
            _art(canvas, f, sample, lens, attachments, fills),
      );
    }

    final frost = effects.whereType<FrostEffect>().firstOrNull;
    final graph = LensVideoPlan.filter(
      matrix: lens.matrix,
      masked: masked,
      overlaid: overlaid,
      blurRadius: _blurRadius(timeline, frame, effects),
      desaturate: frost?.desaturate ?? 0,
      lift: frost?.lift ?? 0,
      crop: crop,
      mirror: mirror,
    );

    for (final encoder in encoders) {
      final ok = await run(
        LensVideoPlan.arguments(
          input: input,
          output: output,
          filter: graph,
          masks: masks,
          overlays: overlays,
          encoder: encoder,
        ),
      );
      if (ok && File(output).existsSync() && File(output).lengthSync() > 0) {
        return output;
      }
    }
    throw StateError('The lens could not be applied to the video.');
  }

  /// Draws one picture per sample, and the concat list that times them.
  ///
  /// A frame with no face gets the blank picture, written once and listed as
  /// often as it is needed. The last entry runs for an hour: the overlay ends
  /// with the video (`shortest=1`), never before it.
  Future<String> _sequence(
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

    final lines = <String>['ffconcat version 1.0'];
    void entry(String file, Duration duration) {
      lines
        ..add("file '${file.replaceAll("'", r"'\''")}'")
        ..add('duration ${(duration.inMicroseconds / 1e6).toStringAsFixed(4)}');
    }

    // Nothing before the first sample: the face had not been found yet.
    if (timeline.first.at > Duration.zero) entry(empty, timeline.first.at);

    String last = empty;
    for (var i = 0; i < timeline.length; i++) {
      final sample = timeline[i];
      final next = i + 1 < timeline.length
          ? timeline[i + 1].at
          : sample.at + const Duration(hours: 1);
      String file = empty;
      if (sample.landmarks != null) {
        file = p.join(work.path, '$name-${i.toString().padLeft(5, '0')}.png');
        await _write(file, width, height, (canvas) {
          canvas.drawColor(blank, BlendMode.src);
          canvas.scale(scale);
          draw(canvas, frame, sample);
        });
      }
      entry(file, next - sample.at);
      last = file;
    }
    // The concat demuxer drops the last entry's duration unless the file is
    // listed once more after it.
    lines.add("file '${last.replaceAll("'", r"'\''")}'");

    final list = p.join(work.path, '$name.txt');
    await File(list).writeAsString('${lines.join('\n')}\n');
    return list;
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

  /// The blur, as a share of the frame's width: the strongest effect's, at
  /// the median face size through the clip. One number for the whole video,
  /// because a blur that breathed as somebody leaned in would be visible.
  static double _blurRadius(
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
    // Two box passes of radius r have a spread of about 0.82 r.
    return (sigma * 1.22 / frame.width).clamp(0.001, 0.2);
  }
}
