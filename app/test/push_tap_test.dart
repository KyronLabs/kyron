import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/thread_screen.dart' show ThreadArgs;
import 'package:kyron_app/services/push_tap.dart';

/// A tapped notification opens what it is about.
///
/// A message notification opened the feed. The tap was listened for by the
/// signed-in screen itself, which a cold start builds only after the splash
/// and the onboarding check -- so a tap that arrived first had nobody to hear
/// it -- and an activity notification carried only its kind, so the best it
/// could open was the notifications page.
void main() {
  group('where a notification goes', () {
    test('a message, to its conversation', () {
      final where = pushDestination({
        'type': 'message',
        'conversationId': 'c1',
      });
      expect(where?.route, Routes.thread);
      expect((where?.arguments as ThreadArgs).conversationId, 'c1');
    });

    test('a like, reply or repost, to the post', () {
      for (final kind in ['like', 'comment', 'repost']) {
        final where = pushDestination({
          'type': 'notification',
          'kind': kind,
          'postId': 'p1',
          'actorId': 'u1',
        });
        expect(where?.route, Routes.postDetail, reason: kind);
        expect(where?.arguments, 'p1', reason: kind);
      }
    });

    test('a follow, to the follower', () {
      final where = pushDestination({
        'type': 'notification',
        'kind': 'follow',
        'actorId': 'u1',
      });
      expect(where?.route, Routes.profile);
      expect(where?.arguments, 'u1');
    });

    test('anything else about activity, to the notifications page', () {
      // What a server from before the post went into the push sends.
      expect(
        pushDestination({'type': 'notification', 'kind': 'like'})?.route,
        Routes.notifications,
      );
    });

    test('the test notification, and what this build does not know, nowhere',
        () {
      expect(pushDestination({'type': 'test'}), isNull);
      expect(pushDestination({'type': 'something.new'}), isNull);
      expect(pushDestination({}), isNull);
      // A message with nothing to open is not a reason to open something
      // else.
      expect(pushDestination({'type': 'message'}), isNull);
    });
  });

  group('a tap', () {
    final opened = <RouteSettings>[];

    Widget app(Widget home) => MaterialApp(
          home: home,
          onGenerateRoute: (settings) {
            opened.add(settings);
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => Scaffold(body: Text('at ${settings.name}')),
            );
          },
        );

    setUp(opened.clear);

    testWidgets('that came before the app was there, opens once it is', (
      tester,
    ) async {
      // A cold start: the tap is known before the signed-in screen exists.
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.read(pendingPushTapProvider.notifier).state = {
        'type': 'message',
        'conversationId': 'c1',
      };

      // The splash first.
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: app(const Text('splash')),
        ),
      );
      await tester.pump();
      expect(opened, isEmpty);

      // Then the app.
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: app(const PushTapOpener(child: Text('feed'))),
        ),
      );
      await tester.pumpAndSettle();

      expect(opened.map((r) => r.name), [Routes.thread]);
      expect(find.text('at ${Routes.thread}'), findsOneWidget);
      // Opened once: forgotten, so a rebuild does not open it again.
      expect(container.read(pendingPushTapProvider), isNull);
    });

    testWidgets('while the app is open, opens over it', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: app(const PushTapOpener(child: Text('feed'))),
        ),
      );
      await tester.pump();
      expect(opened, isEmpty);

      container.read(pendingPushTapProvider.notifier).state = {
        'type': 'notification',
        'kind': 'like',
        'postId': 'p1',
      };
      await tester.pumpAndSettle();

      expect(opened.single.name, Routes.postDetail);
      expect(opened.single.arguments, 'p1');
      // Over the app, so back is back to it.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('feed'), findsOneWidget);
    });
  });
}
