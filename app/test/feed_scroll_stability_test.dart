// test/feed_scroll_stability_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The feed's scroll viewport must not resize while the top bar collapses.
///
/// The home screen hides its top bar as you scroll. It used to do that by
/// shrinking a spacer that was a Column sibling of the feed, which resized the
/// feed's viewport on every frame of a drag. Two things came of that, and the
/// second is the one a reader feels: the whole visible list re-laid-out every
/// frame, and the content stopped tracking the finger, because the viewport
/// was growing underneath it as it moved. It read as a feed that took effort
/// to scroll rather than one that was slow.
///
/// The fix was to let the chrome overlay a full-height list with constant
/// padding. This holds that line: it builds both shapes and measures the
/// viewport across a drag, so the old one fails and the new one passes.
void main() {
  // The range the real header collapses over, in logical pixels.
  const collapseRange = 120.0;
  const statusBar = 24.0;
  const topEdge = 56.0;
  const tabs = 44.0;

  /// A list under a collapsing header, built either way.
  Widget underTest({
    required bool asSibling,
    required AnimationController collapse,
  }) {
    final list = ListView.builder(
      // Constant padding when the chrome overlays: the space is inside the
      // scrollable, so keeping it at the open height costs nothing.
      padding: EdgeInsets.only(
        top: asSibling ? 0 : statusBar + topEdge + tabs,
      ),
      itemCount: 200,
      itemBuilder: (_, i) => SizedBox(height: 220, child: Text('post $i')),
    );

    return MaterialApp(
      home: Scaffold(
        body: asSibling
            // The old shape: a spacer whose height tracks the collapse,
            // beside the list.
            ? Column(
                children: [
                  AnimatedBuilder(
                    animation: collapse,
                    builder: (context, _) => SizedBox(
                      height: statusBar + topEdge * (1 - collapse.value) + tabs,
                    ),
                  ),
                  Expanded(child: list),
                ],
              )
            // The shape now: the list fills the screen, the chrome sits over
            // it and only moves itself.
            : Stack(
                children: [
                  Positioned.fill(child: list),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedBuilder(
                      animation: collapse,
                      builder: (context, _) => SizedBox(
                        height: statusBar + topEdge * (1 - collapse.value),
                        child: const ColoredBox(color: Color(0xFF101010)),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Drags through the whole collapse, driving the header the way the screen's
  /// scroll listener does, and reports every viewport height it passed through.
  Future<(Set<double> viewports, Set<double> extents)> dragThrough(
    WidgetTester tester, {
    required bool asSibling,
  }) async {
    final collapse = AnimationController(vsync: tester, value: 0);
    addTearDown(collapse.dispose);
    await tester.pumpWidget(
      underTest(asSibling: asSibling, collapse: collapse),
    );

    final position =
        tester.state<ScrollableState>(find.byType(Scrollable)).position;
    final viewports = <double>{};
    final extents = <double>{};

    const step = 10.0;
    for (var moved = 0.0; moved < collapseRange; moved += step) {
      await tester.drag(find.byType(ListView), const Offset(0, -step));
      collapse.value = (collapse.value + step / collapseRange).clamp(0.0, 1.0);
      await tester.pump();
      viewports.add(position.viewportDimension);
      extents.add(position.maxScrollExtent);
    }
    return (viewports, extents);
  }

  testWidgets('the viewport holds still while the header collapses', (
    tester,
  ) async {
    final (viewports, extents) = await dragThrough(tester, asSibling: false);

    expect(
      viewports,
      hasLength(1),
      reason: 'a viewport that resizes mid-drag stops the content tracking '
          'the finger, and re-lays-out the whole visible list every frame',
    );
    expect(extents, hasLength(1), reason: 'so the scroll extent holds too');
  });

  testWidgets('and the shape this replaced does not', (tester) async {
    // Guards the test itself. If this ever stops failing, the measurement has
    // gone blind and the one above proves nothing.
    final (viewports, extents) = await dragThrough(tester, asSibling: true);

    expect(viewports.length, greaterThan(1));
    expect(extents.length, greaterThan(1));
  });
}
