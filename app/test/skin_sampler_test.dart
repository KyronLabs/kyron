// test/skin_sampler_test.dart
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/services/skin_sampler.dart';

/// A face-shaped patch of skin on a background nothing like it.
///
/// Painted as an ellipse rather than as the five squares the sampler reads,
/// so the test cannot pass by agreeing with the implementation about where to
/// look -- only by looking somewhere that is actually a face.
class _Frame {
  final int width;
  final int height;
  final Uint8List rgba;

  _Frame(this.width, this.height, Color background)
      : rgba = Uint8List(width * height * 4) {
    for (var i = 0; i < width * height; i++) {
      _write(i, background);
    }
  }

  void _write(int index, Color colour) {
    final at = index * 4;
    rgba[at] = (colour.r * 255).round();
    rgba[at + 1] = (colour.g * 255).round();
    rgba[at + 2] = (colour.b * 255).round();
    rgba[at + 3] = 255;
  }

  void ellipse(Offset centre, Size radii, Color colour) {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final dx = (x - centre.dx) / radii.width;
        final dy = (y - centre.dy) / radii.height;
        if (dx * dx + dy * dy <= 1) _write(y * width + x, colour);
      }
    }
  }

  void rect(Rect box, Color colour) {
    for (var y = box.top.round(); y < box.bottom.round(); y++) {
      for (var x = box.left.round(); x < box.right.round(); x++) {
        if (x < 0 || y < 0 || x >= width || y >= height) continue;
        _write(y * width + x, colour);
      }
    }
  }

  ReadPixel get read => SkinSampler.forRgba(
        ByteData.sublistView(rgba),
        width,
        height,
      );
}

const _skin = Color(0xFFC68B62);
const _wall = Color(0xFF1040F0);

/// Eyes at (100, 100), a pupil-gap of 40, level.
FaceAnchor _face({double roll = 0}) => FaceAnchor(
      centre: const Offset(100, 100),
      interpupillary: 40,
      rollDegrees: roll,
    );

/// A frame with a face in it: the head fills a good part of the picture and
/// the eyes sit where [_face] says they do.
_Frame _portrait() => _Frame(200, 200, _wall)
  ..ellipse(const Offset(100, 120), const Size(55, 75), _skin);

void main() {
  test('reads the skin off a face and not the wall behind it', () {
    final colour = SkinSampler.sample(read: _portrait().read, face: _face());

    expect(colour, _skin);
  });

  test('ignores hair across the forehead and a highlight on a cheek', () {
    final frame = _portrait()
      // A dark fringe over the whole forehead patch.
      ..rect(const Rect.fromLTRB(60, 72, 140, 84), const Color(0xFF241811))
      // A blown-out specular on the left cheekbone.
      ..rect(const Rect.fromLTRB(66, 114, 76, 124), const Color(0xFFFFFFFF));

    final colour = SkinSampler.sample(read: frame.read, face: _face());

    // Exactly the skin: the trimmed quarters take both extremes with them.
    expect(colour, _skin);
  });

  test('follows a head that is tilted', () {
    // A face rolled 25 degrees, with the head rotated to match. If the
    // sampler ignored roll it would read the wall beside the cheek.
    const roll = 25.0;
    final radians = roll * math.pi / 180;
    final frame = _Frame(200, 200, _wall);
    final cos = math.cos(radians), sin = math.sin(radians);
    for (var y = 0; y < 200; y++) {
      for (var x = 0; x < 200; x++) {
        // Back into the upright face's frame, about the eyes.
        final ox = x - 100.0, oy = y - 100.0;
        final fx = ox * cos + oy * sin;
        final fy = -ox * sin + oy * cos;
        final dx = fx / 55, dy = (fy - 20) / 75;
        if (dx * dx + dy * dy <= 1) frame._write(y * 200 + x, _skin);
      }
    }

    expect(
        SkinSampler.sample(read: frame.read, face: _face(roll: roll)), _skin);
  });

  test('still reads a face pushed against the edge of the picture', () {
    final frame = _Frame(200, 200, _wall)
      ..ellipse(const Offset(10, 120), const Size(55, 75), _skin);

    // The eyes are three pixels in, so the two patches on the left of the
    // face fall off the picture. Three remain, which is enough.
    expect(
      SkinSampler.sample(
        read: frame.read,
        face: const FaceAnchor(
          centre: Offset(3, 100),
          interpupillary: 40,
          rollDegrees: 0,
        ),
      ),
      _skin,
    );
  });

  test('says no when the face is mostly outside the picture', () {
    final frame = _Frame(200, 200, _wall)
      ..ellipse(const Offset(-3, 120), const Size(55, 75), _skin);

    // The eyes are off the left edge: only the two patches on the right of
    // the face land, and a colour from those would be a guess dressed up as
    // a measurement.
    expect(
      SkinSampler.sample(
        read: frame.read,
        face: const FaceAnchor(
          centre: Offset(-10, 100),
          interpupillary: 40,
          rollDegrees: 0,
        ),
      ),
      isNull,
    );
  });

  test('says no to a face too small to have measured', () {
    expect(
      SkinSampler.sample(
        read: _portrait().read,
        face: const FaceAnchor(
          centre: Offset(100, 100),
          interpupillary: 0,
          rollDegrees: 0,
        ),
      ),
      isNull,
    );
  });

  group('camera frames', () {
    CameraImage build(
      ImageFormatGroup group,
      Uint8List bytes,
      int width,
      int height,
      int bytesPerRow,
    ) {
      return CameraImage.fromPlatformInterface(
        CameraImageData(
          format: CameraImageFormat(group, raw: 0),
          planes: [CameraImagePlane(bytes: bytes, bytesPerRow: bytesPerRow)],
          width: width,
          height: height,
        ),
      );
    }

    test('unpacks BGRA in the order iOS hands it over', () {
      // One pixel: blue 0x10, green 0x20, red 0x30.
      final bytes = Uint8List.fromList([0x10, 0x20, 0x30, 0xFF]);
      final read = SkinSampler.forCameraImage(
          build(ImageFormatGroup.bgra8888, bytes, 1, 1, 4));

      expect(read, isNotNull);
      expect(read!(0, 0), 0xFF302010);
      expect(read(1, 0), isNull, reason: 'off the right edge');
      expect(read(-1, 0), isNull);
    });

    test('converts NV21 luma and chroma to a colour', () {
      // A 2x2 block, one chroma pair. Y=180 flat, V=170 U=100: a warm tone,
      // which is what a face reads as.
      const y = 180, u = 100, v = 170;
      final bytes = Uint8List.fromList([y, y, y, y, v, u]);
      final read = SkinSampler.forCameraImage(
          build(ImageFormatGroup.nv21, bytes, 2, 2, 2));

      expect(read, isNotNull);
      final pixel = read!(0, 0);
      expect(pixel, isNotNull);

      // BT.601, worked through by hand rather than read back off the code.
      final r = (y + 1.402 * (v - 128)).round();
      final g = (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).round();
      final b = (y + 1.772 * (u - 128)).round();
      expect((pixel! >> 16) & 0xFF, r);
      expect((pixel >> 8) & 0xFF, g);
      expect(pixel & 0xFF, b);
      // Warm, not grey: red above blue is the whole reason chroma is read.
      expect(r, greaterThan(b));

      // Every pixel of the block shares the one chroma pair.
      expect(read(1, 1), pixel);
      expect(read(2, 0), isNull);
    });

    test('refuses a format it cannot read rather than inventing a colour', () {
      final bytes = Uint8List(64);
      expect(
        SkinSampler.forCameraImage(
            build(ImageFormatGroup.yuv420, bytes, 4, 4, 4)),
        isNull,
      );
      expect(
        SkinSampler.forCameraImage(
            build(ImageFormatGroup.jpeg, bytes, 4, 4, 4)),
        isNull,
      );
    });

    test('refuses a buffer too short for the size it claims', () {
      expect(
        SkinSampler.forCameraImage(
            build(ImageFormatGroup.nv21, Uint8List(4), 8, 8, 8)),
        isNull,
      );
      expect(
        SkinSampler.forCameraImage(
            build(ImageFormatGroup.bgra8888, Uint8List(4), 8, 8, 32)),
        isNull,
      );
    });
  });
}
