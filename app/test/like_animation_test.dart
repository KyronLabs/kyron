// test/like_animation_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/like_burst.dart';
import 'package:kyron_app/widgets/post_action_colors.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';

/// What the like does when pressed, and what it deliberately does not.
void main() {
  Widget button({required bool active, required bool burst}) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: PostAction(
              icon: Icons.favorite_border,
              label: '12',
              active: active,
              activeColor: PostActionColors.like,
              tooltip: 'Like',
              burst: burst,
              onTap: () {},
            ),
          ),
        ),
      );

  bool bursting(WidgetTester tester) =>
      find.byType(CustomPaint).evaluate().any((element) {
        final painter = (element.widget as CustomPaint).painter;
        return painter is LikeBurstPainter;
      });

  group('the burst', () {
    testWidgets('goes off when a like turns on', (tester) async {
      await tester.pumpWidget(button(active: false, burst: true));
      expect(bursting(tester), isFalse, reason: 'nothing before the tap');

      await tester.tap(find.byType(PostAction));
      // Two pumps: the first is the animation's zero frame, where the ticker
      // learns what time it started. Only the second advances it.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 120));
      expect(bursting(tester), isTrue);

      // And clears itself up rather than leaving a painter per post standing
      // by in a scrolling feed.
      await tester.pumpAndSettle();
      expect(bursting(tester), isFalse);
    });

    testWidgets('stays away when a like is taken back', (tester) async {
      await tester.pumpWidget(button(active: true, burst: true));

      await tester.tap(find.byType(PostAction));
      await tester.pump();
      for (var ms = 0; ms < 700; ms += 60) {
        await tester.pump(const Duration(milliseconds: 60));
        expect(
          bursting(tester),
          isFalse,
          reason: 'celebrating a removal reads as congratulating a change of '
              'mind',
        );
      }
      await tester.pumpAndSettle();
    });

    testWidgets('stays away on the buttons that did not ask for it',
        (tester) async {
      await tester.pumpWidget(button(active: false, burst: false));

      await tester.tap(find.byType(PostAction));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 120));

      // Reply, repost, save and share still give when pressed; a row where
      // everything celebrates has no way left to mark the one that matters.
      expect(bursting(tester), isFalse);
    });
  });

  group('the movement itself', () {
    test('gives before it swells, and comes back to rest', () {
      expect(likePunch(0), 1, reason: 'starts where the icon is');
      expect(likePunch(1), 1, reason: 'and ends there');

      // The dip: pressing something soft gives before it springs, and
      // skipping the give makes a scale-up read as a pop-up.
      expect(likePunch(0.1), lessThan(0.95));

      final peak = [
        for (var i = 0; i <= 100; i++) likePunch(i / 100),
      ].reduce((a, b) => a > b ? a : b);
      expect(peak, greaterThan(1.15), reason: 'it has to be seen');
      expect(peak, lessThan(1.45), reason: 'but it is a like, not a cartoon');
    });

    test('taking one back only dips', () {
      expect(unlikePunch(0), 1);
      expect(unlikePunch(1), 1);
      final values = [for (var i = 0; i <= 20; i++) unlikePunch(i / 20)];
      expect(values.reduce((a, b) => a > b ? a : b), 1.0);
      expect(values.reduce((a, b) => a < b ? a : b), lessThan(0.9));
    });
  });

  group('the painter', () {
    test('draws nothing before it starts or after it is over', () {
      const colour = PostActionColors.like;
      expect(
        const LikeBurstPainter(t: 0, colour: colour)
            .shouldRepaint(const LikeBurstPainter(t: 0, colour: colour)),
        isFalse,
      );
      expect(
        const LikeBurstPainter(t: 0.3, colour: colour)
            .shouldRepaint(const LikeBurstPainter(t: 0.4, colour: colour)),
        isTrue,
      );
    });
  });
}
