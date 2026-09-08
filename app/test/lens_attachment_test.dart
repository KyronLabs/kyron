
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/face_anchor.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/models/lens_attachment.dart';

Map<String, Object?> attachment({
  Object? asset = 'https://cdn.example/glasses.png',
  Object? anchor = 'eyes',
  Object? width = 2.6,
  Object? offsetX,
  Object? offsetY,
  Object? rotation,
}) =>
    {
      'asset': asset,
      'anchor': anchor,
      'width': width,
      if (offsetX != null) 'offsetX': offsetX,
      if (offsetY != null) 'offsetY': offsetY,
      if (rotation != null) 'rotation': rotation,
    };

void main() {
  group('LensAttachment.tryParse', () {
    test('reads one', () {
      final parsed = LensAttachment.tryParse(attachment());
      expect(parsed, isNotNull);
      expect(parsed!.anchor, FaceAnchorPoint.eyes);
      expect(parsed.width, 2.6);
      expect(parsed.offset, Offset.zero);
    });

    test('insists on https', () {
      // A lens is data the app fetches. Anything but https in a published
      // catalogue is a mistake or somebody testing what this will load.
      for (final asset in [
        'http://cdn.example/g.png',
        'file:///etc/passwd',
        'data:image/png;base64,AAAA',
        '//cdn.example/g.png',
        'javascript:alert(1)',
      ]) {
        expect(
          LensAttachment.tryParse(attachment(asset: asset)),
          isNull,
          reason: asset,
        );
      }
    });

    test('refuses an unknown anchor', () {
      // Silently defaulting to the eyes would put a hat over somebody's face.
      expect(LensAttachment.tryParse(attachment(anchor: 'elbow')), isNull);
      expect(LensAttachment.tryParse(attachment(anchor: 'Eyes')), isNull);
      expect(LensAttachment.tryParse(attachment(anchor: 7)), isNull);
    });

    test('bounds the width', () {
      expect(LensAttachment.tryParse(attachment(width: 0)), isNull);
      expect(LensAttachment.tryParse(attachment(width: -1)), isNull);
      expect(LensAttachment.tryParse(attachment(width: 1e9)), isNull);
      expect(LensAttachment.tryParse(attachment(width: 'big')), isNull);
      expect(
        LensAttachment.tryParse(
          attachment(width: LensAttachment.maxWidth),
        ),
        isNotNull,
      );
    });

    test('bounds the offset and the rotation', () {
      expect(LensAttachment.tryParse(attachment(offsetX: 99)), isNull);
      expect(LensAttachment.tryParse(attachment(offsetY: -99)), isNull);
      expect(LensAttachment.tryParse(attachment(rotation: 400)), isNull);
      expect(LensAttachment.tryParse(attachment(rotation: -90)), isNotNull);
    });

    test('refuses a number JSON can carry but nothing can use', () {
      // 1e400 is legal JSON and overflows to infinity.
      expect(LensAttachment.tryParse(attachment(width: 1e400)), isNull);
      expect(LensAttachment.tryParse(attachment(offsetX: 1e400)), isNull);
    });

    test('survives a round trip', () {
      const original = LensAttachment(
        asset: 'https://cdn.example/hat.png',
        anchor: FaceAnchorPoint.forehead,
        width: 3.2,
        offset: Offset(0.1, -0.8),
        rotation: -12,
      );
      final back = LensAttachment.tryParse(original.toJson())!;
      expect(back.asset, original.asset);
      expect(back.anchor, original.anchor);
      expect(back.width, original.width);
      expect(back.offset, original.offset);
      expect(back.rotation, original.rotation);
    });
  });

  group('placeOn', () {
    const face = FaceAnchor(
      centre: Offset(200, 100),
      interpupillary: 50,
      rollDegrees: 0,
    );

    test('sizes in faces, not pixels', () {
      const glasses = LensAttachment(
        asset: 'https://a/b.png',
        anchor: FaceAnchorPoint.eyes,
        width: 2.6,
      );
      // 2.6 x the 50px gap between the pupils.
      final where = glasses.placeOn(face, 2.0);
      expect(where.width, closeTo(130, 0.001));
      expect(where.height, closeTo(65, 0.001), reason: 'from the aspect ratio');
      expect(where.center, const Offset(200, 100));
    });

    test('a face twice as close gives an attachment twice as big', () {
      const glasses = LensAttachment(
        asset: 'https://a/b.png',
        anchor: FaceAnchorPoint.eyes,
        width: 2.6,
      );
      const closer = FaceAnchor(
        centre: Offset(200, 100),
        interpupillary: 100,
        rollDegrees: 0,
      );
      expect(
        glasses.placeOn(closer, 2).width,
        closeTo(glasses.placeOn(face, 2).width * 2, 0.001),
      );
    });

    test('the offset turns with the head', () {
      // A hat pushed "up" has to stay up when somebody leans, rather than
      // sliding off sideways.
      const hat = LensAttachment(
        asset: 'https://a/b.png',
        anchor: FaceAnchorPoint.forehead,
        width: 3,
        offset: Offset(0, -1),
      );
      const upright = FaceAnchor(
        centre: Offset(200, 100),
        interpupillary: 50,
        rollDegrees: 0,
      );
      const tilted = FaceAnchor(
        centre: Offset(200, 100),
        interpupillary: 50,
        rollDegrees: 90,
      );

      // Upright: one pupil-gap straight up.
      expect(hat.placeOn(upright, 1).center.dy, closeTo(50, 0.001));
      expect(hat.placeOn(upright, 1).center.dx, closeTo(200, 0.001));

      // Head turned a quarter turn: the same nudge now points sideways.
      expect(hat.placeOn(tilted, 1).center.dx, closeTo(250, 0.001));
      expect(hat.placeOn(tilted, 1).center.dy, closeTo(100, 0.001));
    });
  });

  group('a lens with attachments', () {
    test('parses at schema 2', () {
      final lens = Lens.tryParse({
        'id': 'specs',
        'name': 'Specs',
        'schema': 2,
        'attachments': [attachment()],
      });
      expect(lens, isNotNull);
      expect(lens!.needsFace, isTrue);
      expect(lens.attachments, hasLength(1));
    });

    test('is refused when it claims schema 1', () {
      // The schema is what an older build reads to decide whether it can draw
      // this at all. Attachments under schema 1 is a lens lying about itself.
      expect(
        Lens.tryParse({
          'id': 'specs',
          'name': 'Specs',
          'attachments': [attachment()],
        }),
        isNull,
      );
    });

    test('a schema from the future is dropped, not half-drawn', () {
      // Better a lens that is not there than a chip that is there and does
      // nothing.
      expect(
        Lens.tryParse({'id': 'x', 'name': 'X', 'schema': 99}),
        isNull,
      );
    });

    test('one bad attachment makes the whole lens wrong', () {
      // Half a pair of glasses is not a lens with a bit missing.
      expect(
        Lens.tryParse({
          'id': 'specs',
          'name': 'Specs',
          'schema': 2,
          'attachments': [attachment(), attachment(anchor: 'elbow')],
        }),
        isNull,
      );
    });

    test('a colour lens still needs no face', () {
      expect(Lens.builtIn.every((lens) => !lens.needsFace), isTrue);
    });

    test('a lens may tint and attach at once', () {
      final lens = Lens.tryParse({
        'id': 'both',
        'name': 'Both',
        'schema': 2,
        'matrix': List<double>.filled(20, 0.5),
        'attachments': [attachment()],
      });
      expect(lens!.filter, isNotNull);
      expect(lens.needsFace, isTrue);
    });
  });
}
