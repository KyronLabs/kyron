import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/ar_lens_screen.dart';
import 'package:kyron_app/services/skin_sampler.dart';

void main() {
  group('upright frames', () {
    test('a sensor on its side gives a portrait picture', () {
      // The bug: landmarks normalised to the upright picture were multiplied
      // by the landscape buffer's size.
      const raw = Size(1280, 720);
      expect(SkinSampler.uprightSize(raw, 90), const Size(720, 1280));
      expect(SkinSampler.uprightSize(raw, 270), const Size(720, 1280));
      expect(SkinSampler.uprightSize(raw, 0), raw);
      expect(SkinSampler.uprightSize(raw, 180), raw);
    });

    test('reads the raw pixel that turns into each upright one', () {
      // A 4x2 buffer whose pixel value is its own address.
      const w = 4, h = 2;
      int? raw(int x, int y) =>
          x < 0 || y < 0 || x >= w || y >= h ? null : y * w + x;

      // Turned 90 clockwise the picture is 2 wide, 4 tall, and its top-left
      // is the raw bottom-left.
      final cw =
          SkinSampler.upright(raw, width: w, height: h, rotationDegrees: 90);
      expect(cw(0, 0), raw(0, 1));
      expect(cw(1, 0), raw(0, 0));
      expect(cw(0, 3), raw(3, 1));

      final ccw =
          SkinSampler.upright(raw, width: w, height: h, rotationDegrees: 270);
      expect(ccw(0, 0), raw(3, 0));
      expect(ccw(1, 3), raw(0, 1));

      final flip =
          SkinSampler.upright(raw, width: w, height: h, rotationDegrees: 180);
      expect(flip(0, 0), raw(3, 1));

      final same =
          SkinSampler.upright(raw, width: w, height: h, rotationDegrees: 0);
      expect(same(2, 1), raw(2, 1));
    });
  });

  group('the camera that opens first', () {
    CameraDescription camera(String name, CameraLensDirection direction) =>
        CameraDescription(
          name: name,
          lensDirection: direction,
          sensorOrientation: 90,
        );

    test('is the front one, wherever it is listed', () {
      final cameras = [
        camera('0', CameraLensDirection.back),
        camera('1', CameraLensDirection.front),
      ];
      expect(ArLensScreen.initialCamera(cameras), 1);
    });

    test('is the only one there is, on a phone with no selfie camera', () {
      expect(
        ArLensScreen.initialCamera([camera('0', CameraLensDirection.back)]),
        0,
      );
    });
  });

  group('the saved photo is what was on screen', () {
    test('a tall screen crops the sides off a 16:9 photo', () {
      const photo = Size(720, 1280);
      const screen = Size(390, 844); // 9:19.5
      final crop = ArLensScreen.visibleCrop(photo, screen);
      expect(crop.height, 1280);
      expect(crop.width, closeTo(1280 * 390 / 844, 0.5));
      expect(crop.center.dx, closeTo(360, 0.5));
    });

    test('a wide screen crops top and bottom', () {
      final crop = ArLensScreen.visibleCrop(
        const Size(720, 1280),
        const Size(600, 800),
      );
      expect(crop.width, 720);
      expect(crop.height, closeTo(960, 0.5));
    });

    test('the same shape is left alone', () {
      const photo = Size(720, 1280);
      expect(
        ArLensScreen.visibleCrop(photo, const Size(360, 641)),
        Offset.zero & photo,
      );
    });
  });
}
