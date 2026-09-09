// lib/services/skin_sampler.dart
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';

import '../models/face_anchor.dart';

/// Reads one pixel as 0xAARRGGBB, or null when (x, y) is off the picture.
typedef ReadPixel = int? Function(int x, int y);

/// The colour of somebody's skin, taken from the picture they are in.
///
/// A [FillEffect] needs a colour to cover part of a face with, and writing one
/// into the lens is not an option: a fixed skin tone belongs to exactly one
/// person and looks like a sticker on everybody else. So it is measured, every
/// frame, from the face actually in front of the camera.
class SkinSampler {
  const SkinSampler();

  /// Where to look, in pupil-gaps from the midpoint of the eyes, before the
  /// head's roll is applied.
  ///
  /// Derived from the anchor rather than from remembered landmark indices.
  /// The mesh has 478 points and no memorable ones; a mistyped index would
  /// quietly sample an eyebrow or a nostril and the fill would come out the
  /// wrong colour with nothing to show why. Measured against a face: the
  /// interpupillary gap is about 63mm and a face about 145mm across, so half
  /// a face is 1.15 gaps and these all sit well inside it.
  static const _patches = <Offset>[
    Offset(0, -0.55), // forehead, above the brows and below the hairline
    Offset(-0.75, 0.45), // cheekbones
    Offset(0.75, 0.45),
    Offset(-0.62, 0.80), // cheeks, outside the smile lines
    Offset(0.62, 0.80),
  ];

  /// Half-width of the square read at each patch, in pixels.
  static const _radius = 2;

  /// The skin colour on this face, or null when it cannot be read.
  ///
  /// Null is a real answer and the caller must respect it: a fill with no
  /// colour draws nothing at all, which is better than a guessed tone.
  static Color? sample({
    required ReadPixel read,
    required FaceAnchor face,
  }) {
    final cos = math.cos(face.rollRadians);
    final sin = math.sin(face.rollRadians);
    final gap = face.interpupillary;
    if (!gap.isFinite || gap <= 0) return null;

    final found = <int>[];
    for (final patch in _patches) {
      final dx = patch.dx * gap, dy = patch.dy * gap;
      final cx = (face.centre.dx + dx * cos - dy * sin).round();
      final cy = (face.centre.dy + dx * sin + dy * cos).round();

      for (var y = cy - _radius; y <= cy + _radius; y++) {
        for (var x = cx - _radius; x <= cx + _radius; x++) {
          final pixel = read(x, y);
          if (pixel != null) found.add(pixel);
        }
      }
    }

    // At least three of the five places must be in the picture. Fewer means
    // the head is half out of frame, and one surviving square is not enough
    // for the trim below to mean anything -- a single patch that happened to
    // land on a strand of hair would become the whole answer.
    const square = (2 * _radius + 1) * (2 * _radius + 1);
    if (found.length * 2 < _patches.length * square) return null;
    return _middle(found);
  }

  /// The average of the middle half, by brightness.
  ///
  /// A plain mean is pulled about by whatever is not skin: a strand of hair
  /// across the forehead drags it dark, a specular highlight on a cheekbone
  /// drags it light. Dropping the darkest and lightest quarters removes both,
  /// and averaging what is left still cancels the sensor noise that a single
  /// median pixel would keep.
  static Color _middle(List<int> pixels) {
    double luma(int p) =>
        0.2126 * ((p >> 16) & 0xFF) +
        0.7152 * ((p >> 8) & 0xFF) +
        0.0722 * (p & 0xFF);

    pixels.sort((a, b) => luma(a).compareTo(luma(b)));
    final from = pixels.length ~/ 4;
    final to = pixels.length - from;

    var r = 0, g = 0, b = 0;
    for (var i = from; i < to; i++) {
      r += (pixels[i] >> 16) & 0xFF;
      g += (pixels[i] >> 8) & 0xFF;
      b += pixels[i] & 0xFF;
    }
    final count = to - from;
    return Color.fromARGB(255, r ~/ count, g ~/ count, b ~/ count);
  }

  /// A reader over a camera frame.
  ///
  /// The two platforms hand over pixels in two arrangements -- the same split
  /// [FaceTracker] deals with -- and this is the only other place in the app
  /// that touches raw planes. Null when the format is neither.
  static ReadPixel? forCameraImage(CameraImage frame) {
    final plane = frame.planes.first;
    final bytes = plane.bytes;
    final stride = plane.bytesPerRow;
    final width = frame.width, height = frame.height;
    if (width <= 0 || height <= 0 || stride < width) return null;

    switch (frame.format.group) {
      case ImageFormatGroup.nv21:
        // Luma at full resolution, then one interleaved V,U pair per 2x2
        // block, on the same row stride.
        final uv = stride * height;
        if (bytes.length < uv + stride * ((height + 1) ~/ 2)) return null;
        return (x, y) {
          if (x < 0 || y < 0 || x >= width || y >= height) return null;
          final chroma = uv + (y >> 1) * stride + (x >> 1) * 2;
          if (chroma + 1 >= bytes.length) return null;
          return _fromYuv(bytes[y * stride + x], bytes[chroma + 1],
              bytes[chroma]); // NV21 is V then U
        };

      case ImageFormatGroup.bgra8888:
        if (bytes.length < stride * height || stride < width * 4) return null;
        return (x, y) {
          if (x < 0 || y < 0 || x >= width || y >= height) return null;
          final at = y * stride + x * 4;
          return (0xFF << 24) |
              (bytes[at + 2] << 16) |
              (bytes[at + 1] << 8) |
              bytes[at];
        };

      default:
        // yuv420 with separate planes, jpeg, unknown. Refused rather than
        // read as if it were something else, which would produce a colour.
        return null;
    }
  }

  /// A reader over the raw RGBA of a decoded picture, for the saved still.
  ///
  /// [scale] maps tracker coordinates onto the photograph, which is bigger
  /// than the preview stream the landmarks were found in.
  static ReadPixel forRgba(
    ByteData rgba,
    int width,
    int height, {
    Size scale = const Size(1, 1),
  }) {
    return (x, y) {
      final px = (x * scale.width).round();
      final py = (y * scale.height).round();
      if (px < 0 || py < 0 || px >= width || py >= height) return null;
      final at = (py * width + px) * 4;
      if (at + 3 >= rgba.lengthInBytes) return null;
      return (0xFF << 24) |
          (rgba.getUint8(at) << 16) |
          (rgba.getUint8(at + 1) << 8) |
          rgba.getUint8(at + 2);
    };
  }

  /// BT.601, full range -- what an Android camera hands over for NV21.
  static int _fromYuv(int y, int u, int v) {
    final cu = u - 128, cv = v - 128;
    int clamp(double value) => value < 0
        ? 0
        : value > 255
            ? 255
            : value.round();
    return (0xFF << 24) |
        (clamp(y + 1.402 * cv) << 16) |
        (clamp(y - 0.344136 * cu - 0.714136 * cv) << 8) |
        clamp(y + 1.772 * cu);
  }
}
