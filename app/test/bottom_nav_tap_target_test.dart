// test/bottom_nav_tap_target_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/bottom_nav_v4.dart';

/// A tab must be tappable across its whole cell, not only on its glyph.
///
/// A GestureDetector defaults to HitTestBehavior.deferToChild: it answers only
/// where a child actually painted. With a Column sized to its contents that is
/// the icon and the label and nothing else -- a target about 37 logical pixels
/// tall in a bar of 64, and only as wide as the word. Everything around it,
/// which is most of the cell, swallowed the tap. It made switching tabs a
/// thing you had to aim at.
///
/// Material asks for 48 logical pixels in each direction. These check the
/// corners of the cell, which is where a thumb lands when somebody is not
/// aiming.
void main() {
  const width = 400.0;

  Future<List<int>> tapsAt(
    WidgetTester tester,
    List<Offset> points, {
    double inset = 0,
  }) async {
    final taps = <int>[];
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          size: const Size(width, 800),
          padding: EdgeInsets.only(bottom: inset),
          viewPadding: EdgeInsets.only(bottom: inset),
        ),
        child: MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavV4(
              currentIndex: 0,
              onTap: taps.add,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (final point in points) {
      await tester.tapAt(point);
      await tester.pump();
    }
    return taps;
  }

  testWidgets('the whole of a tab answers, not just its icon', (tester) async {
    tester.view.physicalSize = const Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final bar = 800.0 - BottomNavV4.height;
    // The Communities cell is the fourth of five: x from 240 to 320.
    const cell = width / 5;
    const left = cell * 3;

    final taps = await tapsAt(tester, [
      // Just inside each corner of the cell, and the middle of its top edge.
      Offset(left + 4, bar + 4),
      Offset(left + cell - 4, bar + 4),
      Offset(left + 4, bar + BottomNavV4.height - 4),
      Offset(left + cell - 4, bar + BottomNavV4.height - 4),
      Offset(left + cell / 2, bar + 3),
    ]);

    expect(
      taps,
      [3, 3, 3, 3, 3],
      reason: 'every one of those is inside the tab a thumb was aiming for',
    );
  });

  testWidgets('and each tab answers for itself alone', (tester) async {
    tester.view.physicalSize = const Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final bar = 800.0 - BottomNavV4.height + BottomNavV4.height / 2;
    const cell = width / 5;

    final taps = await tapsAt(tester, [
      Offset(cell * 0.5, bar), // Home
      Offset(cell * 1.5, bar), // Explore
      Offset(cell * 3.5, bar), // Communities
      Offset(cell * 4.5, bar), // Messages
    ]);

    // A widened target must not start answering for its neighbour.
    expect(taps, [0, 1, 3, 4]);
  });

  testWidgets('a gesture bar underneath does not eat the target', (
    tester,
  ) async {
    // The case this was actually broken in, and the reason it looked fine
    // anywhere it was checked: with the inset taken out of the bar's own
    // height the row got 30 logical pixels, overflowed by 11, and a tab
    // answered over 29 of them.
    const inset = 34.0;
    tester.view.physicalSize = const Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    const cell = width / 5;
    // The bar is now height + inset tall, and the row sits above the inset.
    final rowTop = 800.0 - BottomNavV4.height - inset;

    final taps = await tapsAt(
      tester,
      [
        Offset(cell * 3 + 4, rowTop + 2),
        Offset(cell * 3 + cell - 4, rowTop + BottomNavV4.height - 2),
        Offset(cell * 3 + cell / 2, rowTop + BottomNavV4.height / 2),
      ],
      inset: inset,
    );

    expect(taps, [3, 3, 3]);
  });

  testWidgets('and nothing overflows when it is there', (tester) async {
    const inset = 34.0;
    tester.view.physicalSize = const Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tapsAt(tester, const [], inset: inset);

    // An overflow is reported as a test failure by the framework, so reaching
    // here at all is the assertion. Said out loud because it is easy to read
    // this test as empty.
    expect(tester.takeException(), isNull);
  });
}
