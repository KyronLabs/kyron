import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/notifications_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/home_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/app_drawer.dart';
import 'package:kyron_app/widgets/feed_refresh.dart';
import 'package:kyron_app/widgets/interest_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// The home feed's refresh: tapping the logo, and pulling the list down.
///
/// Both end in the same place -- the list at the top and the feed asked for
/// again -- and both move only the logo in the top bar. The avatar, search
/// and bell beside it stay where they are.
class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());

  int loads = 0;

  @override
  Future<FeedPage> following({String? cursor, int limit = 20}) async {
    if (cursor == null) loads++;
    return FeedPage(
      items: [
        for (var i = 0; i < 20; i++)
          FeedPost(
            id: 'p$i',
            content: 'post number $i',
            createdAt: DateTime(2026, 11, 2),
            author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
          ),
      ],
    );
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  late _Feed feed;
  late List<String> haptics;

  Future<void> home(WidgetTester tester, {bool still = false}) async {
    feed = _Feed();
    haptics = [];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'HapticFeedback.vibrate') {
          haptics.add(call.arguments as String);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(feed),
          unreadNotificationsProvider.overrideWith((ref) async => 0),
          // Following: a plain list, without For You's impression timers.
          selectedFeedTabProvider.overrideWith((ref) => 'Following'),
        ],
        child: MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: const Size(400, 800),
              padding: const EdgeInsets.only(top: 24),
              disableAnimations: still,
            ),
            child: Scaffold(
              body: HomeScreen(
                drawerKey: GlobalKey<AppDrawerState>(),
                onScrollProgress: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(feed.loads, 1);
  }

  FeedRefreshController controller(WidgetTester tester) =>
      tester.widget<RefreshLogo>(find.byType(RefreshLogo)).controller;

  ScrollPosition list(WidgetTester tester) =>
      tester.state<ScrollableState>(find.byType(Scrollable).first).position;

  /// A finger pulling the list down by [by], in small steps as a real one
  /// does, and not yet let go.
  Future<TestGesture> pull(WidgetTester tester, double by) async {
    final finger = await tester.startGesture(const Offset(200, 400));
    // Past the touch slop first, so every step after it is a drag.
    await finger.moveBy(const Offset(0, 20));
    await tester.pump();
    for (var moved = 0.0; moved < by; moved += 10) {
      await finger.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    return finger;
  }

  testWidgets('the logo: a soft tap, back to the top, then a fresh feed', (
    tester,
  ) async {
    await home(tester);
    list(tester).jumpTo(900);
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('home-logo')));
    // Felt at once, before anything has moved.
    expect(haptics, ['HapticFeedbackType.lightImpact']);
    expect(list(tester).pixels, 900);
    expect(feed.loads, 1);

    await tester.pumpAndSettle();
    expect(list(tester).pixels, 0);
    expect(feed.loads, 2);
    expect(controller(tester).phase, FeedRefreshPhase.idle);
    expect(controller(tester).extent, 0);
  });

  testWidgets('a second tap while refreshing does not refresh again', (
    tester,
  ) async {
    await home(tester);
    await tester.tap(find.byKey(const ValueKey('home-logo')));
    await tester.pump(const Duration(milliseconds: 300));
    expect(controller(tester).phase, FeedRefreshPhase.refreshing);

    await tester.tap(find.byKey(const ValueKey('home-logo')));
    await tester.pumpAndSettle();
    expect(feed.loads, 2);
    expect(haptics, ['HapticFeedbackType.lightImpact']);
  });

  testWidgets('pulled past the line: one tick, and letting go refreshes', (
    tester,
  ) async {
    await home(tester);
    final finger = await pull(tester, 200);

    final c = controller(tester);
    expect(c.phase, FeedRefreshPhase.pulling);
    expect(c.extent, greaterThan(FeedRefreshController.threshold));
    // Resistance: the list never comes down as far as the finger did.
    expect(c.extent, lessThan(200));
    expect(list(tester).pixels, 0);
    expect(haptics, ['HapticFeedbackType.selectionClick']);

    await finger.up();
    for (var i = 0; i < 36; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(c.phase, FeedRefreshPhase.refreshing);
    // Held open while it loads, for the leaves to fall through.
    expect(c.extent, closeTo(FeedRefreshController.hold, 1));
    expect(feed.loads, 2);

    await tester.pumpAndSettle();
    expect(c.phase, FeedRefreshPhase.idle);
    expect(c.extent, 0);
    expect(feed.loads, 2);
    expect(haptics, hasLength(1));
  });

  testWidgets('let go too soon and nothing reloads', (tester) async {
    await home(tester);
    final finger = await pull(tester, 40);
    expect(controller(tester).extent, greaterThan(0));
    await finger.up();
    await tester.pumpAndSettle();

    expect(feed.loads, 1);
    expect(haptics, isEmpty);
    expect(controller(tester).extent, 0);
  });

  testWidgets('pushing back up closes the gap before the list scrolls', (
    tester,
  ) async {
    await home(tester);
    final finger = await pull(tester, 120);
    final opened = controller(tester).extent;
    expect(opened, greaterThan(FeedRefreshController.threshold));

    await finger.moveBy(const Offset(0, -30));
    await tester.pump();
    expect(controller(tester).extent, closeTo(opened - 30, 0.5));
    expect(list(tester).pixels, 0);

    // All the way back and beyond: the rest of the drag scrolls the list.
    await finger.moveBy(Offset(0, -opened));
    await tester.pump();
    expect(controller(tester).extent, 0);
    expect(list(tester).pixels, closeTo(30, 0.5));

    await finger.up();
    await tester.pumpAndSettle();
    expect(feed.loads, 1);
  });

  testWidgets('only the logo moves: avatar, search and bell stay put', (
    tester,
  ) async {
    await home(tester);
    Rect at(Finder f) => tester.getRect(f);
    final avatar = find.byTooltip('Menu');
    final search = find.byTooltip('Search');
    final bell = find.byKey(const ValueKey('home-notifications'));
    final before = [at(avatar), at(search), at(bell)];

    final finger = await pull(tester, 200);
    await tester.pump(const Duration(milliseconds: 200));
    expect([at(avatar), at(search), at(bell)], before);
    final logo = tester.widget<Transform>(
      find.descendant(
        of: find.byType(RefreshLogo),
        matching: find.byType(Transform),
      ),
    );
    expect(logo.transform.isIdentity(), isFalse);

    await finger.up();
    await tester.pump(const Duration(milliseconds: 500));
    expect([at(avatar), at(search), at(bell)], before);
    await tester.pumpAndSettle();
  });

  testWidgets('leaves fall while it refreshes, and are all gone after', (
    tester,
  ) async {
    await home(tester);
    await tester.tap(find.byKey(const ValueKey('home-logo')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    final leaves = tester.state<FallingLeavesState>(find.byType(FallingLeaves));
    expect(leaves.count, greaterThan(5));
    expect(leaves.count, lessThanOrEqualTo(FallingLeaves.maxLeaves));

    // pumpAndSettle returning at all is the point: every ticker stopped.
    await tester.pumpAndSettle();
    expect(leaves.count, 0);
  });

  testWidgets('reduced motion: no leaves, no swaying, a bar instead', (
    tester,
  ) async {
    await home(tester, still: true);
    expect(find.byType(FallingLeaves), findsNothing);

    await tester.tap(find.byKey(const ValueKey('home-logo')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const ValueKey('home-refresh-bar')), findsOneWidget);
    expect(controller(tester).logoAngle, 0);
    expect(controller(tester).logoScale, 1);

    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('home-refresh-bar')), findsNothing);
    expect(feed.loads, 2);
  });
}
