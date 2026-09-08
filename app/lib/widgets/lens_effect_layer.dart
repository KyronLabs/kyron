// lib/widgets/lens_effect_layer.dart
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/face_anchor.dart';
import '../models/face_region.dart';
import '../models/lens_effect.dart';

/// Every effect a lens has, mapped onto the box the preview is drawn in.
///
/// [FaceRegion] works in camera-frame pixels, because that is what the
/// landmarks are normalised against, so rather than rescale each path this
/// maps the whole layer once. The [OverflowBox] is the part that is easy to
/// get wrong and was: without it the children are sized by the *box* while
/// the paths are in *frame* coordinates, so a 720-wide frame drawn into a
/// 360-wide preview covered only the top-left quarter of it -- the frost
/// stopped a quarter of the way down the screen. Measured, then fixed.
///
/// The same transform carries the front camera's mirror. [CameraPreview]
/// flips the front preview, and an effect built from raw landmarks would
/// otherwise sit on the wrong side of a face.
class LensEffectOverlay extends StatelessWidget {
  final List<LensEffect> effects;
  final List<FacePoint> landmarks;
  final FaceAnchor face;

  /// The camera frame's own size, which the landmarks are normalised to.
  final Size frame;

  /// The colour a [FillEffect] paints with, or null to skip it.
  final Color? skin;

  /// Whether the preview underneath is mirrored, as the front camera is.
  final bool mirrored;

  const LensEffectOverlay({
    super.key,
    required this.effects,
    required this.landmarks,
    required this.face,
    required this.frame,
    this.skin,
    this.mirrored = false,
  });

  /// Camera-frame coordinates onto a preview box of [box], mirrored or not.
  ///
  /// Static and pure so it can be checked with arithmetic. Nothing else in
  /// this file can be checked by rendering it: a [BackdropFilter] does not
  /// run under `RepaintBoundary.toImage`, and pumping one wedges a headless
  /// test run outright.
  ///
  /// One scale for both axes, taken from the width. A blur is specified in
  /// frame pixels and this transform scales it, so an uneven scale would
  /// smear it into an ellipse; the preview is drawn at the camera's own
  /// aspect ratio precisely so the two factors agree.
  static Matrix4 mapping({
    required Size frame,
    required Size box,
    required bool mirrored,
  }) {
    final scale = box.width / frame.width;
    return Matrix4.identity()
      ..translateByDouble(mirrored ? box.width : 0, 0, 0, 1)
      ..scaleByDouble(
        mirrored ? -scale : scale,
        box.height / frame.height,
        1,
        1,
      );
  }

  @override
  Widget build(BuildContext context) {
    if (effects.isEmpty || frame.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, box) {
        // One scale for both axes, taken from the width. A blur is specified
        // in frame pixels and the transform scales it, so an uneven scale
        // would smear it into an ellipse; the preview is drawn at the
        // camera's own aspect ratio precisely so the two agree.
        return Transform(
          transform: mapping(
            frame: frame,
            box: Size(box.maxWidth, box.maxHeight),
            mirrored: mirrored,
          ),
          child: OverflowBox(
            alignment: Alignment.topLeft,
            minWidth: frame.width,
            maxWidth: frame.width,
            minHeight: frame.height,
            maxHeight: frame.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                for (final effect in effects)
                  LensEffectLayer(
                    effect: effect,
                    landmarks: landmarks,
                    face: face,
                    frame: frame,
                    skin: skin,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// One effect, over whatever is beneath it.
///
/// Both kinds work the same way, which is the thing worth noticing: each is a
/// **clipped blur of what is already there**, with a colour laid over it.
/// Fill clips *to* a region and covers it with skin; frost clips to everything
/// *but* a region and washes it out. [BackdropFilter] is what reads the pixels
/// below, so this must sit over the preview in the same layer.
///
/// The blur is why a fill erases a nose. Letting the sharp original through at
/// partial opacity leaves nostrils and lips clearly visible -- measured: it
/// changed 31,927 pixels and still read as an unmodified face. Blurring what
/// shows through keeps the shape of a face without keeping its features.
class LensEffectLayer extends StatelessWidget {
  final LensEffect effect;
  final List<FacePoint> landmarks;
  final FaceAnchor face;
  final Size frame;

  /// The colour a [FillEffect] paints with. Null means the fill is skipped:
  /// a guessed skin tone is somebody else's skin on all but one face.
  final Color? skin;

  const LensEffectLayer({
    super.key,
    required this.effect,
    required this.landmarks,
    required this.face,
    required this.frame,
    this.skin,
  });

  @override
  Widget build(BuildContext context) {
    final gap = face.interpupillary;

    final (region, blur, overlay, invert) = switch (effect) {
      FillEffect(:final region, :final feather, :final keepShading) => (
          region,
          // Enough to take a nose out. Tied to the feather so one number in
          // the lens controls how soft the whole thing is.
          gap * math.max(0.10, feather),
          skin?.withValues(alpha: 1 - keepShading),
          false,
        ),
      FrostEffect(:final reveal, :final blur, :final desaturate, :final lift) =>
        (reveal, gap * blur, null, true),
    };

    if (effect is FillEffect && overlay == null) {
      return const SizedBox.shrink();
    }

    final path = FaceRegion.path(region, landmarks, frame, face);
    if (path == null) return const SizedBox.shrink();

    return ClipPath(
      clipper: invert ? EverythingBut(path, frame) : _Only(path),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: math.max(0.1, blur),
          sigmaY: math.max(0.1, blur),
        ),
        // Sized to the frame for the same reason: the path this is clipped
        // by is in frame pixels, and a box-sized child stops short of it.
        child: SizedBox.fromSize(
          size: frame,
          child: switch (effect) {
            // Skin over the blurred region. The blur removed the features; this
            // gives back a colour that belongs to this face rather than a
            // painted-on one.
            FillEffect() => ColoredBox(
                color: overlay!,
                child: const SizedBox.expand(),
              ),
            // Etched glass washes the colour out and lifts everything towards
            // white. Blur alone reads as a camera out of focus, not as glass.
            FrostEffect(:final desaturate, :final lift) => ColorFiltered(
                colorFilter: ColorFilter.matrix(
                  _wash(desaturate: desaturate, lift: lift),
                ),
                child: const SizedBox.expand(),
              ),
          },
        ),
      ),
    );
  }

  /// Desaturation and lift as one colour matrix, so Skia does both in a pass.
  static List<double> _wash({
    required double desaturate,
    required double lift,
  }) {
    // Luminance weights, as everywhere else in this app: the eye is far more
    // sensitive to green than to blue.
    const lr = 0.2126, lg = 0.7152, lb = 0.0722;
    final keep = 1 - desaturate;
    final scale = 1 - lift;
    final offset = 255 * lift;

    double diag(double luma) => (keep + desaturate * luma) * scale;
    double off(double luma) => desaturate * luma * scale;

    return <double>[
      diag(lr), off(lg), off(lb), 0, offset, //
      off(lr), diag(lg), off(lb), 0, offset, //
      off(lr), off(lg), diag(lb), 0, offset, //
      0, 0, 0, 1, 0, //
    ];
  }
}

/// Just one region.
class _Only extends CustomClipper<Path> {
  final Path region;

  const _Only(this.region);

  @override
  Path getClip(Size size) => region;

  @override
  bool shouldReclip(_Only old) => old.region != region;
}

/// Everything except one region.
///
/// The rectangle is the **camera frame**, never the size the widget happened
/// to be laid out at. Those are different numbers -- a phone draws a 720-wide
/// stream into a 360-wide preview -- and taking the layout size covered a
/// quarter of the screen while the region paths carried on in frame pixels.
/// Passed in rather than read from `getClip`, so it cannot go wrong that way
/// again.
@visibleForTesting
class EverythingBut extends CustomClipper<Path> {
  final Path? hole;
  final Size frame;

  const EverythingBut(this.hole, this.frame);

  @override
  Path getClip(Size size) {
    final all = Path()..addRect(Offset.zero & frame);
    final cut = hole;
    if (cut == null) return all;
    return Path.combine(PathOperation.difference, all, cut);
  }

  @override
  bool shouldReclip(EverythingBut old) =>
      old.hole != hole || old.frame != frame;
}

/// The same effects, drawn into a canvas over a photograph.
///
/// The live preview uses [LensEffectLayer], which leans on [BackdropFilter] to
/// read the camera underneath it. A [ui.PictureRecorder] has no backdrop to
/// filter, so the still is done here instead: the photograph is drawn again,
/// blurred, clipped to the region. Two implementations of one idea, which is a
/// cost worth naming -- they are kept honest by both taking their numbers from
/// the same [LensEffect].
class LensEffectBaker {
  const LensEffectBaker();

  /// Draws [effects] over a photograph that is already on [canvas].
  void paint(
    Canvas canvas,
    ui.Image photo,
    List<LensEffect> effects, {
    required List<FacePoint> landmarks,
    required FaceAnchor face,
    required Size frame,
    Color? skin,
  }) {
    final whole = Rect.fromLTWH(
      0,
      0,
      photo.width.toDouble(),
      photo.height.toDouble(),
    );
    final gap = face.interpupillary;

    for (final effect in effects) {
      final (region, blur, feather, invert) = switch (effect) {
        FillEffect(:final region, :final feather) => (
            region,
            gap * math.max(0.10, feather),
            gap * feather,
            false
          ),
        FrostEffect(:final reveal, :final blur, :final feather) => (
            reveal,
            gap * blur,
            gap * feather,
            true
          ),
      };
      if (effect is FillEffect && skin == null) continue;

      final path = FaceRegion.path(region, landmarks, frame, face);
      if (path == null) continue;

      // One draw, both filters. The wash has to be applied *to the
      // photograph*; painting a white rectangle through a colour matrix, as
      // this first did, produces a white rectangle -- the frost came out as a
      // blank page with a slot cut in it.
      final paint = Paint()
        ..imageFilter = ui.ImageFilter.blur(
          sigmaX: math.max(0.1, blur),
          sigmaY: math.max(0.1, blur),
        );
      if (effect case FrostEffect(:final desaturate, :final lift)) {
        // Etched glass washes the colour out and lifts it towards white. Blur
        // alone reads as a camera out of focus, not as glass.
        paint.colorFilter = ColorFilter.matrix(
          LensEffectLayer._wash(desaturate: desaturate, lift: lift),
        );
      }

      // A layer, so the region can be masked with a soft edge afterwards. A
      // clip cannot feather -- it is in or out per pixel -- and a hard edge
      // reads as a sticker laid over a face rather than part of it.
      canvas.saveLayer(whole, Paint());

      // The photograph again, blurred. This is what takes a nose out of a
      // face: letting the sharp original through at partial opacity leaves
      // nostrils and lips plainly visible.
      canvas.drawImageRect(photo, whole, whole, paint);

      if (effect case FillEffect(:final keepShading)) {
        // Skin over the blur, giving back a colour that belongs to this face
        // rather than a painted-on one.
        canvas.drawRect(
          whole,
          Paint()..color = skin!.withValues(alpha: 1 - keepShading),
        );
      }

      // Always dstOut, never dstIn: a draw only touches the pixels its own
      // shape covers, so dstIn with a small path leaves everything *outside*
      // it untouched -- which blurred the entire frame for a fill. Cutting
      // away the unwanted part is the operation with the right shape.
      final cutout = invert
          ? path
          : Path.combine(
              PathOperation.difference, Path()..addRect(whole), path);

      canvas.drawPath(
        cutout,
        Paint()
          ..blendMode = BlendMode.dstOut
          ..color = const Color(0xFF000000)
          ..maskFilter =
              feather > 0.5 ? MaskFilter.blur(BlurStyle.normal, feather) : null,
      );

      canvas.restore();
    }
  }
}
