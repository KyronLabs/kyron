// test/feed_refresh_visible_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pull to refresh has to be visible, not merely present.
///
/// The home feed runs full height with its top bar laid over it. A
/// [RefreshIndicator] drops its spinner at the top of its own box, so with the
/// list starting at y=0 that is *behind the bar* -- the gesture still worked,
/// the spinner still turned, and nobody could see either. It read as the
/// feature having been taken away.
///
/// `edgeOffset` is what moves it. This holds the line with a measurement
/// rather than a look, and fails on the arrangement that lost it.
void main() {
  // Status bar, top bar and tab strip, as HomeScreen lays them out.
  const chrome = 24.0 + 56.0 + 44.0;

  /// Where the spinner settles during a pull, or NaN if there is none.
  Future<double> spinnerTop(WidgetTester tester, double edgeOffset) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  edgeOffset: edgeOffset,
                  onRefresh: () async {},
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: chrome),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 40,
                    itemBuilder: (_, i) =>
                        SizedBox(height: 90, child: Text('$i')),
                  ),
                ),
              ),
              // The bar, opaque and over the list.
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: chrome,
                child: ColoredBox(color: Color(0xFF101010)),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final drag = await tester.startGesture(const Offset(200, 400));
    await drag.moveBy(const Offset(0, 250));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final spinner = find.byType(RefreshProgressIndicator);
    final top =
        spinner.evaluate().isEmpty ? double.nan : tester.getTopLeft(spinner).dy;

    await drag.up();
    await tester.pumpAndSettle();
    return top;
  }

  testWidgets('the spinner comes down below the top bar', (tester) async {
    final top = await spinnerTop(tester, chrome);

    expect(top, isNot(isNaN), reason: 'a pull must produce a spinner at all');
    expect(
      top,
      greaterThanOrEqualTo(chrome),
      reason: 'a spinner inside the bar is one nobody can see, which is what '
          'made pulling to refresh look like it had been removed',
    );
  });

  testWidgets('and the arrangement without an offset hides it', (tester) async {
    // Guards the test above. If this stops failing, the measurement has gone
    // blind and the one above proves nothing.
    final top = await spinnerTop(tester, 0);

    expect(top, isNot(isNaN));
    expect(top, lessThan(chrome));
  });
}
