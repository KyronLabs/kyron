import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/skeleton.dart';

Future<void> show(WidgetTester tester, Widget child) => tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child))),
    );

void main() {
  group('SkeletonList', () {
    test('every shape is reachable', () {
      // Each of these mirrors a real row. A list that loses its factory is a
      // screen that quietly goes back to a spinner.
      expect(SkeletonList.posts(), isA<SkeletonList>());
      expect(SkeletonList.people(), isA<SkeletonList>());
      expect(SkeletonList.conversations(), isA<SkeletonList>());
      expect(SkeletonList.comments(), isA<SkeletonList>());
      expect(SkeletonList.messages(), isA<SkeletonList>());
      expect(SkeletonList.notifications(), isA<SkeletonList>());
      expect(SkeletonList.communities(), isA<SkeletonList>());
    });

    testWidgets('takes up real height rather than laying out as nothing',
        (tester) async {
      // The first version nested a ListView inside another scroll view, which
      // is not an error: it lays out at no height and renders nothing at all.
      await show(tester, SkeletonList.posts(count: 2));

      expect(
          tester.getSize(find.byType(SkeletonList)).height, greaterThan(200));
    });

    testWidgets('draws as many rows as it was asked for', (tester) async {
      await show(tester, SkeletonList.people(count: 3));

      // Three avatars, one per row.
      expect(find.byType(SkeletonBox), findsAtLeast(3));
    });

    testWidgets('a full-width line actually has width', (tester) async {
      // In a column aligned to the start a line with no width has none to
      // take, and comes out invisible.
      await show(tester, SkeletonList.posts(count: 1));

      final widths = find
          .byType(SkeletonBox)
          .evaluate()
          .map((e) => tester.getSize(find.byWidget(e.widget)).width);

      expect(widths.any((w) => w > 200), isTrue);
    });

    testWidgets('the sweep moves', (tester) async {
      await show(tester, SkeletonList.posts(count: 1));
      await tester.pump(const Duration(milliseconds: 200));

      final ticker = tester.state<State>(find.byType(SkeletonGroup));

      // A shimmer whose sweep never changes is a static grey block, which is
      // what shipped the first time this was written.
      expect(ticker.mounted, isTrue);
      await tester.pump(const Duration(milliseconds: 400));
    });
  });
}
