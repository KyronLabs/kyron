import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/impression_reporter.dart';
import 'package:kyron_app/widgets/post_list_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// What For You reports as shown, which is what moves the next session on.
///
/// The feed ranked on what somebody had opened and nothing else, so a post
/// they scrolled past every day looked unseen and headed every session.
void main() {
  group('the reporter', () {
    late List<List<String>> sent;
    late ImpressionReporter reporter;

    /// A reporter that records what it sends, on the test's fake clock.
    void start() {
      sent = [];
      reporter = ImpressionReporter((ids) async => sent.add(ids));
      addTearDown(reporter.dispose);
    }

    testWidgets('gathers posts and sends them together', (tester) async {
      start();
      reporter
        ..shown('a')
        ..shown('b');
      expect(sent, isEmpty);

      await tester.pump(ImpressionReporter.batchDelay);
      expect(sent, [
        ['a', 'b'],
      ]);
    });

    testWidgets('reports a post once a session, however often it scrolls by', (
      tester,
    ) async {
      start();
      reporter
        ..shown('a')
        ..shown('a');
      await tester.pump(ImpressionReporter.batchDelay);
      reporter.shown('a');
      await tester.pump(ImpressionReporter.batchDelay);

      expect(sent, [
        ['a'],
      ]);
    });

    testWidgets('counts it again in the next session', (tester) async {
      start();
      reporter.shown('a');
      await tester.pump(ImpressionReporter.batchDelay);
      reporter
        ..startSession()
        ..shown('a');
      await tester.pump(ImpressionReporter.batchDelay);

      expect(sent, [
        ['a'],
        ['a'],
      ]);
    });

    testWidgets('sends what a session gathered before the next begins', (
      tester,
    ) async {
      start();
      reporter
        ..shown('a')
        ..startSession();
      await tester.pump();

      expect(sent, [
        ['a'],
      ]);
    });

    testWidgets('never sends more than the server takes at once', (
      tester,
    ) async {
      start();
      for (var i = 0; i < 120; i++) {
        reporter.shown('p$i');
      }
      await tester.pump(ImpressionReporter.batchDelay * 3);

      expect(
        sent.every((batch) => batch.length <= ImpressionReporter.batchSize),
        isTrue,
      );
      expect(sent.expand((b) => b).toSet(), hasLength(120));
    });

    testWidgets('drops a batch that fails rather than retrying it', (
      tester,
    ) async {
      var calls = 0;
      final failing = ImpressionReporter((ids) {
        calls++;
        return Future.error(StateError('offline'));
      });
      addTearDown(failing.dispose);
      failing.shown('a');
      await tester.pump(ImpressionReporter.batchDelay * 4);

      expect(calls, 1);
    });

    testWidgets('sends what it has when the app goes to the background', (
      tester,
    ) async {
      start();
      reporter.shown('a');
      reporter.didChangeAppLifecycleState(AppLifecycleState.paused);
      await tester.pump();

      expect(sent, [
        ['a'],
      ]);
    });
  });

  group('a card on screen', () {
    setUp(() =>
        VisibilityDetectorController.instance.updateInterval = Duration.zero);

    Future<List<String>> scroll(
      WidgetTester tester, {
      required Duration stay,
    }) async {
      final shown = <String>[];
      final controller = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: ListView(
            controller: controller,
            children: [
              for (var i = 0; i < 12; i++)
                OnScreen(
                  key: ValueKey('card-$i'),
                  onShown: () => shown.add('card-$i'),
                  child: SizedBox(height: 300, child: Text('card $i')),
                ),
            ],
          ),
        ),
      );
      await tester.pump();
      await tester.pump(stay);
      controller.jumpTo(3000);
      await tester.pump();
      await tester.pump(ImpressionReporter.dwell * 2);
      return shown;
    }

    testWidgets('counts once it has stayed on screen', (tester) async {
      final shown = await scroll(
        tester,
        stay: ImpressionReporter.dwell + const Duration(milliseconds: 50),
      );

      // The first screenful stayed long enough; so did where it landed.
      expect(shown, contains('card-0'));
      expect(shown, contains('card-10'));
    });

    testWidgets('does not count what a flick went straight past', (
      tester,
    ) async {
      final shown = await scroll(
        tester,
        stay: const Duration(milliseconds: 100),
      );

      expect(shown, isNot(contains('card-0')));
      // Cards between the two screens were never on screen at all.
      expect(shown, isNot(contains('card-5')));
    });

    testWidgets('reports a card once, however often it comes back', (
      tester,
    ) async {
      // Scrolled far enough away, the list throws the card's state away and
      // builds a new one on the way back, which counts it again. The
      // reporter is what keeps that to one report a session.
      final sent = <List<String>>[];
      final reporter = ImpressionReporter((ids) async => sent.add(ids));
      addTearDown(reporter.dispose);
      final controller = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: ListView(
            controller: controller,
            children: [
              OnScreen(
                key: const ValueKey('card'),
                onShown: () => reporter.shown('card'),
                child: const SizedBox(height: 300, child: Text('card')),
              ),
              const SizedBox(height: 3000),
            ],
          ),
        ),
      );
      for (var i = 0; i < 3; i++) {
        await tester.pump(ImpressionReporter.dwell * 2);
        controller.jumpTo(2000);
        await tester.pump();
        controller.jumpTo(0);
        await tester.pump();
      }
      await tester.pump(ImpressionReporter.batchDelay);

      expect(sent, [
        ['card'],
      ]);
    });
  });
}
