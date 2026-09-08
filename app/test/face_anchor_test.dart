import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';

/// A real detection, from MediaPipe's own public test portrait.
///
/// 478 landmarks produced by the same models the app runs on a device, so this
/// checks the placement arithmetic against a real face rather than against
/// numbers somebody invented. The expected values under `expected` came out of
/// `tools/face.py` in kyron-lenses -- a separate implementation, in another
/// language, from the same data. Agreeing with it is the point.
void main() {
  final fixture = jsonDecode(
    File('test/face-detection.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  final landmarks = [
    for (final p in fixture['landmarks'] as List)
      FacePoint((p as List)[0] as double, p[1] as double),
  ];
  final frame = Size(
    (fixture['imageWidth'] as int).toDouble(),
    (fixture['imageHeight'] as int).toDouble(),
  );
  final expected = (fixture['expected'] as Map)['eyes'] as Map;

  group('FaceAnchor on a real face', () {
    test('the fixture is what it claims to be', () {
      // A fixture that silently emptied would make everything below pass by
      // having nothing to check.
      expect(landmarks, hasLength(478));
      expect(frame, const Size(820, 1024));
    });

    test('lands where the Python tool put it', () {
      final anchor = FaceAnchor.resolve(
        FaceAnchorPoint.eyes,
        landmarks,
        frame,
      );

      expect(anchor, isNotNull);
      // Within a tenth of a pixel of an implementation written separately, in
      // another language. Anything looser would let a real mistake through.
      expect(anchor!.centre.dx, closeTo(expected['cx'] as double, 0.1));
      expect(anchor.centre.dy, closeTo(expected['cy'] as double, 0.1));
      expect(anchor.interpupillary, closeTo(expected['ipd'] as double, 0.1));
      expect(anchor.rollDegrees, closeTo(expected['roll'] as double, 0.01));
    });

    test('this portrait is very nearly level', () {
      // Sanity on the fixture itself: a roll of 30 degrees here would mean the
      // landmarks are not the ones this test thinks they are.
      final anchor =
          FaceAnchor.resolve(FaceAnchorPoint.eyes, landmarks, frame)!;
      expect(anchor.rollDegrees.abs(), lessThan(2));
    });

    test('every anchor lands somewhere on the face', () {
      // The face occupies roughly the top third of this portrait; an anchor
      // outside the frame means an index is wrong.
      for (final point in FaceAnchorPoint.values) {
        final anchor = FaceAnchor.resolve(point, landmarks, frame);
        expect(anchor, isNotNull, reason: point.name);
        expect(anchor!.centre.dx, inInclusiveRange(0, frame.width),
            reason: point.name);
        expect(anchor.centre.dy, inInclusiveRange(0, frame.height),
            reason: point.name);
      }
    });

    test('the anchors are in the order a face is', () {
      // Forehead above eyes above nose above mouth above chin. This is what
      // catches two indices being swapped, which nothing else here would.
      double y(FaceAnchorPoint p) =>
          FaceAnchor.resolve(p, landmarks, frame)!.centre.dy;

      expect(y(FaceAnchorPoint.forehead), lessThan(y(FaceAnchorPoint.eyes)));
      expect(y(FaceAnchorPoint.eyes), lessThan(y(FaceAnchorPoint.nose)));
      expect(y(FaceAnchorPoint.nose), lessThan(y(FaceAnchorPoint.mouth)));
      expect(y(FaceAnchorPoint.mouth), lessThan(y(FaceAnchorPoint.chin)));
    });

    test('scales with the frame, because it is measured in faces', () {
      // The same face at twice the resolution is the same face: every number
      // doubles and the roll does not move.
      final small = FaceAnchor.resolve(FaceAnchorPoint.eyes, landmarks, frame)!;
      final large = FaceAnchor.resolve(
        FaceAnchorPoint.eyes,
        landmarks,
        Size(frame.width * 2, frame.height * 2),
      )!;

      expect(large.interpupillary, closeTo(small.interpupillary * 2, 0.001));
      expect(large.centre.dx, closeTo(small.centre.dx * 2, 0.001));
      expect(large.rollDegrees, closeTo(small.rollDegrees, 0.001));
    });
  });

  group('FaceAnchor refuses what it cannot place', () {
    test('too few landmarks', () {
      // The iris points are at 468 and 473. A 468-point model has neither.
      expect(
        FaceAnchor.resolve(
          FaceAnchorPoint.eyes,
          landmarks.take(468).toList(),
          frame,
        ),
        isNull,
      );
    });

    test('no landmarks at all', () {
      expect(
        FaceAnchor.resolve(FaceAnchorPoint.eyes, const [], frame),
        isNull,
      );
    });

    test('a frame with no size', () {
      expect(
        FaceAnchor.resolve(FaceAnchorPoint.eyes, landmarks, Size.zero),
        isNull,
      );
    });

    test('a face too small to be one', () {
      // Both irises in the same place: a detection artefact. Dividing by that
      // gap produces an attachment the size of a county.
      final collapsed = [
        for (var i = 0; i < landmarks.length; i++) const FacePoint(0.5, 0.5),
      ];
      expect(
        FaceAnchor.resolve(FaceAnchorPoint.eyes, collapsed, frame),
        isNull,
      );
    });
  });
}
