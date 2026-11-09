import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/gift.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/providers/gifts_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/repositories/gifts_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/post_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

const _json = {
  'total': 7,
  'senders': [
    {
      'user': {'id': 'w', 'name': 'Weaver', 'username': 'weaver'},
      'coins': 103,
      'gifts': [
        {'type': 'rocket', 'name': 'Rocket', 'count': 1},
        {'type': 'spark', 'name': 'Spark', 'count': 3},
      ],
    },
    {
      'user': {'id': 's', 'name': 'Sharrrd', 'username': 'shards'},
      'coins': 9,
      'gifts': [
        {'type': 'rose', 'name': 'Rose', 'count': 3},
      ],
    },
  ],
};

class _Gifts extends GiftsRepository {
  _Gifts() : super(ApiClient());
  final asked = <String>[];

  @override
  Future<PostGifts> givers(String postId) async {
    asked.add(postId);
    return PostGifts.fromJson(_json);
  }

  @override
  Future<GiftSheetData> sheet() async => const GiftSheetData(
        catalogue: [
          GiftType(type: 'spark', name: 'Spark', emoji: '', coins: 1),
        ],
        wallet: GiftWallet(coins: 50, earned: 0, weeklyCoins: 100),
      );
}

class _Feed extends FeedRepository {
  _Feed() : super(ApiClient());
  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: [], nextCursor: null);
}

final _post = FeedPost(
  id: 'p1',
  content: 'Arabian fox in the desert',
  createdAt: DateTime(2026, 11, 8),
  author: const FeedAuthor(id: 'k', name: 'Kyron', username: 'kyron'),
  gifts: 7,
  topGifts: const ['rocket', 'rose', 'spark'],
);

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('reads who gave what from the API', () {
    final gifts = PostGifts.fromJson(_json);
    expect(gifts.total, 7);
    expect(gifts.givers.map((g) => g.user.displayName), ['Weaver', 'Sharrrd']);
    expect(gifts.givers.first.count, 4);
    expect(gifts.givers.first.gifts.first.type, 'rocket');
  });

  Future<_Gifts> card(WidgetTester tester) async {
    final gifts = _Gifts();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(_Feed()),
          giftsRepositoryProvider.overrideWithValue(gifts),
        ],
        child: MaterialApp(
          onGenerateRoute: (s) => MaterialPageRoute(
            builder: (_) => Scaffold(body: Text('route ${s.name}')),
          ),
          home: Scaffold(
            body: ListView(
              children: [PostCard(post: _post, source: PostListSource.recent)],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    return gifts;
  }

  testWidgets('the pill opens who gave what, not the gifts to send', (
    tester,
  ) async {
    final gifts = await card(tester);
    await tester.tap(find.byKey(const ValueKey('gift-pill')));
    await tester.pumpAndSettle();

    expect(gifts.asked, ['p1']);
    expect(find.text('7 gifts from 2 people'), findsOneWidget);
    // Biggest giver first, and named as such; nobody else is.
    final weaver =
        tester.getTopLeft(find.byKey(const ValueKey('gift-giver-w')));
    final shards =
        tester.getTopLeft(find.byKey(const ValueKey('gift-giver-s')));
    expect(weaver.dy, lessThan(shards.dy));
    expect(find.text('Top gifter'), findsOneWidget);
    expect(find.text('×3'), findsNWidgets(2));
    // Not the sheet that sends one.
    expect(find.text('Pick a gift'), findsNothing);
  });

  testWidgets('a giver opens their profile', (tester) async {
    await card(tester);
    await tester.tap(find.byKey(const ValueKey('gift-pill')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('gift-giver-s')));
    await tester.pumpAndSettle();
    expect(find.text('Top gifter'), findsNothing);
    expect(find.textContaining('route /'), findsOneWidget);
  });

  testWidgets('holding the heart still opens the gifts to send', (
    tester,
  ) async {
    await card(tester);
    await tester.longPress(find.byIcon(Iconsax.heart_copy));
    await tester.pumpAndSettle();
    expect(find.text('Pick a gift'), findsOneWidget);
  });
}
