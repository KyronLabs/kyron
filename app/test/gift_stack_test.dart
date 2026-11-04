import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/gift.dart';
import 'package:kyron_app/widgets/gift_sheet.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';

FeedPost _post(List<String> gifts) => FeedPost(
      id: 'p1',
      content: '',
      createdAt: DateTime(2026, 11, 1),
      author: FeedAuthor.fromJson(const {'id': 'a', 'name': 'Ada'}),
      likes: 12,
      topGifts: gifts,
    );

Widget _row(FeedPost post) => MaterialApp(
      home: Scaffold(
        body: Center(
          child: PostActionsRow(
            post: post,
            onReply: () {},
            onRepost: () {},
            onLike: () {},
            onSave: () {},
            onShare: () {},
          ),
        ),
      ),
    );

void main() {
  test('reads the stack from the API, three at most', () {
    final post = FeedPost.fromJson(const {
      'id': 'p',
      'topGifts': ['rocket', 'gem', 'rose', 'spark', ''],
    });
    expect(post.topGifts, ['rocket', 'gem', 'rose']);
    expect(FeedPost.fromJson(const {'id': 'p'}).topGifts, isEmpty);
  });

  test('a gift you send joins the stack where its price puts it', () {
    expect(withGift(['gem', 'rose'], 'rocket'), ['rocket', 'gem', 'rose']);
    expect(withGift(['rocket', 'gem', 'rose'], 'spark'), [
      'rocket',
      'gem',
      'rose',
    ]);
    expect(withGift(['gem'], 'gem'), ['gem']);
  });

  testWidgets('crowns the heart: the most valuable in the middle, in front', (
    tester,
  ) async {
    await tester.pumpWidget(_row(_post(['rocket', 'gem', 'rose'])));

    // Each gift is drawn twice -- itself, and its cut-out outline behind it
    // in the page's colour -- so the gift is the one at its own size.
    Rect gift(String type) => tester.getRect(
          find.byWidgetPredicate(
            (w) =>
                w is GiftArt &&
                w.type == type &&
                (w.size == GiftStack.size || w.size == GiftStack.sideSize),
          ),
        );
    final rocket = gift('rocket');
    final gem = gift('gem');
    final rose = gift('rose');
    final heart = tester.getRect(find.byIcon(Iconsax.heart_copy));

    // The best in the middle, over the heart's notch; the next two either
    // side of it, smaller and lower, on the lobes.
    expect(rocket.center.dx, closeTo(heart.center.dx, 0.5));
    expect(gem.center.dx, lessThan(rocket.center.dx));
    expect(rose.center.dx, greaterThan(rocket.center.dx));
    expect(gem.width, lessThan(rocket.width));
    expect(gem.center.dy, greaterThan(rocket.center.dy));
    // Worn on the heart: the crown reaches only a little above it, and comes
    // down onto it rather than floating over it.
    expect(heart.top - rocket.top, closeTo(GiftStack.rise, 1));
    expect(rocket.bottom, greaterThan(heart.top));
    // The best is drawn last, in front of the two it overlaps.
    final order = tester
        .widgetList<GiftArt>(find.byType(GiftArt))
        .where((w) => w.size != GiftStack.size + 2 * GiftStack.cut)
        .where((w) => w.size != GiftStack.sideSize + 2 * GiftStack.cut)
        .map((w) => w.type)
        .toList();
    expect(order.last, 'rocket');
    expect(find.bySemanticsLabel(RegExp('Gifted: Rocket, Gem, Rose')),
        findsOneWidget);
  });

  testWidgets('two gifts lean on each other, the best in front', (
    tester,
  ) async {
    await tester.pumpWidget(_row(_post(['crown', 'rose'])));
    final crown = tester.getRect(find.byWidgetPredicate(
        (w) => w is GiftArt && w.type == 'crown' && w.size == GiftStack.size));
    final rose = tester.getRect(find.byWidgetPredicate((w) =>
        w is GiftArt && w.type == 'rose' && w.size == GiftStack.sideSize));
    expect(crown.center.dx, lessThan(rose.center.dx));
    expect(rose.width, lessThan(crown.width));
  });

  testWidgets('moves nothing in the row: the count stays where it was', (
    tester,
  ) async {
    await tester.pumpWidget(_row(_post(const [])));
    final plain = tester.getRect(find.text('12'));
    final plainRow = tester.getSize(find.byType(PostActionsRow));

    await tester.pumpWidget(_row(_post(['rocket', 'gem', 'rose'])));
    expect(tester.getRect(find.text('12')), plain);
    expect(tester.getSize(find.byType(PostActionsRow)), plainRow);
  });

  testWidgets('a post with no gifts has no stack', (tester) async {
    await tester.pumpWidget(_row(_post(const [])));
    expect(find.byType(GiftStack), findsNothing);
  });
}
