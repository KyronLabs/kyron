import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/clip_page_physics.dart';

/// A screen-sized page, four pages long.
ScrollMetrics _at(double pixels) => FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 800 * 3,
      pixels: pixels,
      viewportDimension: 800,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 3,
    );

void main() {
  const physics = ClipPageScrollPhysics();

  group('let go without a flick', () {
    test('a short drag is enough to move on', () {
      // A sixth of the page. [PageScrollPhysics] would put this back.
      expect(physics.targetPixels(_at(800 + 140), 0), 1600);
    });

    test('a shorter one is not', () {
      expect(physics.targetPixels(_at(800 + 90), 0), 800);
    });

    test('the same going back up', () {
      expect(physics.targetPixels(_at(1600 - 140), 0), 800);
      expect(physics.targetPixels(_at(1600 - 90), 0), 1600);
    });

    test('resting on a page leaves it there', () {
      expect(physics.targetPixels(_at(800), 0), 800);
    });
  });

  group('flicked', () {
    test('moves on from wherever it was', () {
      expect(physics.targetPixels(_at(800 + 5), 300), 1600);
    });

    test('one page at a time, however hard', () {
      // The clip after the next one is a clip nobody has looked at.
      expect(physics.targetPixels(_at(800 + 5), 9000), 1600);
    });

    test('goes back when the flick is upwards', () {
      expect(physics.targetPixels(_at(1600 - 5), -300), 800);
      expect(physics.targetPixels(_at(800 + 700), -300), 800);
    });

    test('never past either end of the list', () {
      expect(physics.targetPixels(_at(0), -3000), 0);
      expect(physics.targetPixels(_at(2400), 3000), 2400);
    });
  });

  test('asks less of the finger than the stock page physics', () {
    // Both numbers are the point of this class, so both are pinned.
    const stock = PageScrollPhysics();
    expect(physics.minFlingVelocity, lessThan(stock.minFlingVelocity));
    expect(physics.minFlingDistance, lessThan(stock.minFlingDistance));
    expect(ClipPageScrollPhysics.commitFraction, lessThan(0.5));
  });

  test('a page with no height cannot be paged', () {
    final flat = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 0,
      pixels: 0,
      viewportDimension: 0,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 3,
    );
    expect(physics.targetPixels(flat, 500), 0);
  });
}
