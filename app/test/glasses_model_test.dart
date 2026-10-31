import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/glasses_model.dart';
import 'package:kyron_app/models/lens.dart';

void main() {
  for (final style in GlassesStyle.values) {
    final model = GlassesModel(
      style: style,
      frame: Colors.black,
      tint: Colors.black,
    );

    group('$style', () {
      test('has two lenses, one round each pupil, mirror images', () {
        final left = model.lens(-1);
        final right = model.lens(1);
        expect(left, hasLength(GlassesModel.outlineSteps));

        double mean(Iterable<double> v) => v.reduce((a, b) => a + b) / v.length;
        expect(mean(left.map((p) => p.x)), closeTo(-0.5, 0.06));
        expect(mean(right.map((p) => p.x)), closeTo(0.5, 0.06));

        // The same shape reflected: each lens's extent mirrors the other's.
        final lx = left.map((p) => p.x);
        final rx = right.map((p) => p.x);
        expect(lx.reduce((a, b) => a < b ? a : b),
            closeTo(-rx.reduce((a, b) => a > b ? a : b), 1e-9));
      });

      test('lenses do not meet across the nose', () {
        final innerLeft = model.lens(-1).map((p) => p.x).reduce(
              (a, b) => a > b ? a : b,
            );
        expect(innerLeft, lessThan(-0.05));
      });

      test('sits in front of the eyes and wraps back towards the temples', () {
        final right = model.lens(1);
        final inner = right.reduce((a, b) => a.x < b.x ? a : b);
        final outer = right.reduce((a, b) => a.x > b.x ? a : b);
        expect(inner.z, lessThan(0));
        expect(outer.z, greaterThan(inner.z));
      });

      test('arms run from the hinge back past the ears', () {
        for (final side in [-1, 1]) {
          final arm = model.temple(side);
          expect(arm.first.z, lessThan(0));
          expect(arm.last.z, greaterThan(1));
          for (final point in arm) {
            expect(point.x.sign, side.toDouble());
          }
        }
      });
    });
  }

  test('built-in glasses are face lenses that change the picture', () {
    final glasses = Lens.builtIn.where((l) => l.glasses != null).toList();
    expect(glasses.map((l) => l.id), containsAll(['specs', 'aviator']));
    for (final lens in glasses) {
      expect(lens.needsFace, isTrue);
      expect(lens.changesPicture, isTrue);
      // Never on the wire: the format refuses schema 4.
      expect(lens.toJson().containsKey('glasses'), isFalse);
    }
    expect(Lens.builtIn.first.changesPicture, isFalse);
  });
}
