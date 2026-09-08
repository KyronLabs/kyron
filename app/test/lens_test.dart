import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/services/lens_renderer.dart';

/// A one-pixel image of [colour], so a lens can be checked on a known input.
Future<ui.Image> pixel(int r, int g, int b) {
  final bytes = Uint8List.fromList([r, g, b, 255]);
  final done = Completer<ui.Image>();
  ui.decodeImageFromPixels(bytes, 1, 1, ui.PixelFormat.rgba8888, done.complete);
  return done.future;
}

/// What a rendered image's only pixel came out as.
Future<List<int>> readPixel(ui.Image image) async {
  final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  return data!.buffer.asUint8List().sublist(0, 4);
}

void main() {
  const renderer = LensRenderer();

  group('the catalogue', () {
    test('opens on the lens that changes nothing', () {
      // "None" has to be selectable or there is no way back to the plain
      // picture once a lens is on.
      expect(Lens.all.first.id, 'none');
      expect(Lens.all.first.filter, isNull);
    });

    test('every lens has a distinct id and a name worth reading', () {
      final ids = Lens.all.map((lens) => lens.id).toSet();

      expect(ids, hasLength(Lens.all.length));
      for (final lens in Lens.all) {
        expect(lens.name.trim(), isNotEmpty);
      }
    });

    test('every matrix is the shape dart:ui takes', () {
      // A 4x5 matrix. One element out and the filter throws at draw time --
      // on the shutter press, on a device, with a picture already taken.
      for (final lens in Lens.all.where((l) => l.matrix != null)) {
        expect(lens.matrix, hasLength(20), reason: lens.id);
        expect(() => lens.filter, returnsNormally, reason: lens.id);
      }
    });

    test('an unknown id falls back rather than throwing', () {
      // The id is persisted between sessions; a build that drops a lens must
      // not crash the camera for whoever had it selected.
      expect(Lens.byId('no-such-lens').id, 'none');
      expect(Lens.byId('mono').id, 'mono');
    });
  });

  group('applying a lens', () {
    test('leaves the picture alone when the lens is None', () async {
      final source = await pixel(10, 200, 90);

      final out = await renderer.apply(source, Lens.byId('none'));

      expect(identical(out, source), isTrue);
    });

    test('Mono makes grey, weighted the way the eye sees', () async {
      // Not a third each: green carries most of the brightness, and an even
      // split makes a grey that reads as muddy.
      final out =
          await renderer.apply(await pixel(255, 0, 0), Lens.byId('mono'));

      final rgba = await readPixel(out);
      expect(rgba[0], rgba[1]);
      expect(rgba[1], rgba[2]);
      // Pure red is about 21% of full brightness.
      expect(rgba[0], inInclusiveRange(50, 60));
    });

    test('Mono keeps green brighter than red, as luminance does', () async {
      final red = await readPixel(
        await renderer.apply(await pixel(255, 0, 0), Lens.byId('mono')),
      );
      final green = await readPixel(
        await renderer.apply(await pixel(0, 255, 0), Lens.byId('mono')),
      );

      expect(green[0], greaterThan(red[0]));
    });

    test('Warm moves a neutral grey towards red', () async {
      final rgba = await readPixel(
        await renderer.apply(await pixel(128, 128, 128), Lens.byId('warm')),
      );

      expect(rgba[0], greaterThan(rgba[2]));
    });

    test('Cool moves the same grey the other way', () async {
      final rgba = await readPixel(
        await renderer.apply(await pixel(128, 128, 128), Lens.byId('cool')),
      );

      expect(rgba[2], greaterThan(rgba[0]));
    });

    test('Faded lifts black off the floor', () async {
      // Which is what a faded print looks like; a matrix that only lowers
      // contrast leaves black at black and reads as underexposure.
      final rgba = await readPixel(
        await renderer.apply(await pixel(0, 0, 0), Lens.byId('faded')),
      );

      expect(rgba[0], greaterThan(20));
    });

    test('Punch pulls colours apart rather than clipping them', () async {
      final plain = await readPixel(await pixel(180, 90, 90));
      final punched = await readPixel(
        await renderer.apply(await pixel(180, 90, 90), Lens.byId('punch')),
      );

      // More separation between the channels than it started with...
      expect(punched[0] - punched[1], greaterThan(plain[0] - plain[1]));
      // ...and still inside the range a colour can occupy.
      expect(punched[0], lessThanOrEqualTo(255));
    });

    test('keeps the size of the frame it was given', () async {
      final source = await pixel(1, 2, 3);

      final out = await renderer.apply(source, Lens.byId('noir'));

      expect(out.width, source.width);
      expect(out.height, source.height);
    });

    test('encodes to bytes the composer can take', () async {
      final out = await renderer.apply(await pixel(9, 9, 9), Lens.byId('mono'));

      final bytes = await renderer.encode(out);

      // A PNG, by its signature, rather than "some bytes came back".
      expect(bytes.sublist(0, 4), [0x89, 0x50, 0x4e, 0x47]);
    });
  });
}
