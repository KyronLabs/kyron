import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/exposure_meter.dart';

/// Opening the camera up so the face in front of it is actually exposed.
///
/// The report this came from was that the face tracking "isn't capturing my
/// face well", from somebody with dark skin. A phone's automatic exposure
/// meters the whole scene, so anything bright behind a face takes the exposure
/// down and the face with it -- and a face that lands in the bottom stop of
/// the sensor has little contrast left for a detector to work with.

/// A frame of one flat colour, as the sampler reads it.
int? Function(int, int) flat(int value, {Rect? inside}) => (x, y) {
      if (inside != null &&
          !inside.contains(Offset(x.toDouble(), y.toDouble()))) {
        return 0xFFFFFFFF;
      }
      return 0xFF000000 | (value << 16) | (value << 8) | value;
    };

void main() {
  final at = DateTime(2026, 9, 13, 12);

  group('reading the light', () {
    test('measures a flat grey as the grey it is', () {
      final luma = ExposureMeter.luma(
        read: flat(128),
        region: const Rect.fromLTWH(0, 0, 100, 100),
      );
      expect(luma, closeTo(128 / 255, 0.005));
    });

    test('reads only the region it is given', () {
      // The whole point: a bright wall behind somebody must not be in the
      // measurement, because taking it in is what put the face in the dark.
      final luma = ExposureMeter.luma(
        read: flat(30, inside: const Rect.fromLTWH(40, 40, 40, 40)),
        region: const Rect.fromLTWH(40, 40, 40, 40),
      );
      expect(luma, closeTo(30 / 255, 0.02));
    });

    test('answers null when the region is off the picture', () {
      expect(
        ExposureMeter.luma(
          read: (_, __) => null,
          region: const Rect.fromLTWH(0, 0, 10, 10),
        ),
        isNull,
      );
    });
  });

  group('deciding what to ask for', () {
    test('leaves a well-exposed face alone', () {
      final meter = ExposureMeter();
      expect(
        meter.offsetFor(luma: 0.46, min: -4, max: 4, now: at),
        isNull,
      );
      expect(meter.applied, 0);
    });

    test('opens up for a face in the dark, by stops rather than by fractions',
        () {
      // A face at 0.12 is nearly two stops under. A linear correction would
      // ask for +0.34 and leave it nearly as dark; this is the case the whole
      // thing exists for, so it has to ask for a real amount of light.
      final meter = ExposureMeter();
      final wanted = meter.offsetFor(luma: 0.12, min: -4, max: 4, now: at);

      expect(wanted, isNotNull);
      expect(wanted, greaterThan(0.5));
      expect(wanted, meter.maxStep);
    });

    test('closes down for a face that is blown out', () {
      final meter = ExposureMeter();
      final wanted = meter.offsetFor(luma: 0.95, min: -4, max: 4, now: at);
      expect(wanted, isNotNull);
      expect(wanted, lessThan(0));
    });

    test('gets there in steps, not in one jump', () {
      final meter = ExposureMeter();
      var now = at;
      final asked = <double>[];
      // Each correction brightens the frame, so the reading walks up with it.
      for (final luma in [0.08, 0.14, 0.26, 0.40, 0.45]) {
        now = now.add(const Duration(seconds: 1));
        final wanted = meter.offsetFor(luma: luma, min: -4, max: 4, now: now);
        if (wanted != null) asked.add(wanted);
      }

      expect(asked, isNotEmpty);
      for (var i = 1; i < asked.length; i++) {
        expect(
            asked[i] - asked[i - 1], lessThanOrEqualTo(meter.maxStep + 1e-9));
      }
      // And it arrives somewhere useful rather than oscillating.
      expect(asked.last, greaterThan(1.0));
    });

    test('will not change again until the camera has settled', () {
      // The camera's own metering reacts to the compensation and takes a few
      // hundred milliseconds. Measuring during that measures the last
      // correction rather than the scene, and the meter chases itself.
      final meter = ExposureMeter();
      expect(meter.offsetFor(luma: 0.10, min: -4, max: 4, now: at), isNotNull);
      expect(
        meter.offsetFor(
          luma: 0.10,
          min: -4,
          max: 4,
          now: at.add(const Duration(milliseconds: 100)),
        ),
        isNull,
      );
      expect(
        meter.offsetFor(
          luma: 0.10,
          min: -4,
          max: 4,
          now: at.add(const Duration(seconds: 1)),
        ),
        isNotNull,
      );
    });

    test('stays inside what the camera says it will take', () {
      final meter = ExposureMeter();
      var now = at;
      for (var i = 0; i < 10; i++) {
        now = now.add(const Duration(seconds: 1));
        meter.offsetFor(luma: 0.03, min: -1, max: 1, now: now);
      }
      expect(meter.applied, lessThanOrEqualTo(1.0));
    });

    test('does nothing at all on a camera that takes no compensation', () {
      // Both ends zero is how the plugin reports a camera without exposure
      // compensation, and asking it anyway throws on some devices.
      final meter = ExposureMeter();
      expect(meter.offsetFor(luma: 0.05, min: 0, max: 0, now: at), isNull);
    });

    test('asks for a usable amount when the frame is black', () {
      // A covered lens, or a camera still opening. The correction works out
      // infinite, and the step clamp is the only thing that makes it a number
      // -- which is worth a test precisely because it is a side effect of a
      // limit that is there for a different reason.
      final meter = ExposureMeter();
      final wanted = meter.offsetFor(luma: 0, min: -4, max: 4, now: at);
      expect(wanted, isNotNull);
      expect(wanted!.isFinite, isTrue);
      expect(wanted, meter.maxStep);
    });

    test('forgets what it asked for when the camera is swapped', () {
      final meter = ExposureMeter();
      meter.offsetFor(luma: 0.10, min: -4, max: 4, now: at);
      expect(meter.applied, greaterThan(0));

      meter.reset();
      expect(meter.applied, 0);
      // And immediately, rather than after the settle time of a camera that
      // is no longer the one pointing at anything.
      expect(
        meter.offsetFor(
          luma: 0.10,
          min: -4,
          max: 4,
          now: at.add(const Duration(milliseconds: 10)),
        ),
        isNotNull,
      );
    });
  });

  group('where to meter', () {
    test('stays inside the face rather than taking in the wall behind it', () {
      // A face is about 2.3 pupil-gaps across and 3.2 tall.
      final region = ExposureMeter.regionAround(const Offset(200, 300), 60);
      expect(region.width, lessThan(60 * 2.3));
      expect(region.height, lessThan(60 * 3.2));
      expect(region.center, const Offset(200, 300));
    });

    test('looks where a head is before it has found one', () {
      final region = ExposureMeter.regionForSelfie(const Size(720, 1280));
      expect(region.center.dx, 360);
      // Above the middle: somebody holding a phone has their head in the top
      // half of the frame, not the centre of it.
      expect(region.center.dy, lessThan(640));
      expect(region.width, lessThan(720));
    });
  });
}
