import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/screens/post_analytics_screen.dart';

PostAnalytics _report({int gifts = 0, List<GiftTally> kinds = const []}) =>
    PostAnalytics(
      views: 7,
      likes: 2,
      saves: 0,
      comments: 1,
      createdAt: DateTime(2026, 10, 30),
      timeline: const [],
      gifts: gifts,
      giftCoins: kinds.fold(0, (sum, k) => sum + k.coins),
      gifters: gifts == 0 ? 0 : 2,
      giftsByType: kinds,
    );

class _Fixed extends PostAnalyticsNotifier {
  _Fixed(super.ref, super.id, this.report);
  final PostAnalytics report;

  @override
  Future<void> load() async => state = AsyncData(report);
}

Future<void> _show(WidgetTester tester, PostAnalytics report) async {
  tester.view.physicalSize = const Size(400, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        postAnalyticsProvider.overrideWith(
          (ref, id) => _Fixed(ref, id, report),
        ),
      ],
      child: const MaterialApp(home: PostAnalyticsScreen(postId: 'p1')),
    ),
  );
  await tester.pump();
}

void main() {
  test('reads gifts from the API, and zero from a server that has none', () {
    final report = PostAnalytics.fromJson({
      'views': 1,
      'gifts': 5,
      'giftCoins': 113,
      'gifters': 2,
      'giftsByType': [
        {
          'type': 'rocket',
          'name': 'Rocket',
          'emoji': '🚀',
          'count': 1,
          'coins': 100
        },
        {'type': '', 'count': 9},
      ],
    });
    expect(report.gifts, 5);
    expect(report.giftCoins, 113);
    expect(report.gifters, 2);
    // A kind with no type is not a gift anyone can be shown.
    expect(report.giftsByType.map((g) => g.name), ['Rocket']);

    final older = PostAnalytics.fromJson({'views': 1});
    expect(older.gifts, 0);
    expect(older.giftsByType, isEmpty);
  });

  testWidgets('shows what the post was given, kind by kind', (tester) async {
    await _show(
      tester,
      _report(
        gifts: 4,
        kinds: const [
          GiftTally(
              type: 'rocket',
              name: 'Rocket',
              emoji: '🚀',
              count: 1,
              coins: 100),
          GiftTally(
              type: 'rose', name: 'Rose', emoji: '🌹', count: 3, coins: 9),
        ],
      ),
    );

    expect(find.text('GIFTS'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('109'), findsOneWidget);
    expect(find.text('Senders'), findsOneWidget);
    expect(find.text('Rocket'), findsOneWidget);
    expect(find.text('×3'), findsOneWidget);
    // The most valuable first, as the API orders them.
    expect(
      tester.getTopLeft(find.text('Rocket')).dy,
      lessThan(tester.getTopLeft(find.text('Rose')).dy),
    );
  });

  testWidgets('says so when nobody has sent one', (tester) async {
    await _show(tester, _report());
    expect(find.text('Nobody has sent this post a gift yet.'), findsOneWidget);
  });
}
