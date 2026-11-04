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

  testWidgets('lines the gifts up on the heart, the most valuable first', (
    tester,
  ) async {
    await tester.pumpWidget(_row(_post(['rocket', 'gem', 'rose'])));

    final art = find.descendant(
      of: find.byType(GiftStack),
      matching: find.byType(GiftArt),
    );
    expect(art, findsNWidgets(3));
    final rocket = tester.getRect(
      find.byWidgetPredicate((w) => w is GiftArt && w.type == 'rocket'),
    );
    final rose = tester.getRect(
      find.byWidgetPredicate((w) => w is GiftArt && w.type == 'rose'),
    );
    // Side by side, most valuable first: one gift tall, never a tower.
    expect(rocket.left, lessThan(rose.left));
    expect(rocket.top, rose.top);
    expect(tester.getSize(find.byType(GiftStack)).height, GiftStack.size);
    // Tiny, and above the heart, centred on it.
    expect(rocket.width, GiftStack.size);
    final heart = tester.getRect(find.byIcon(Iconsax.heart_copy));
    expect(rose.bottom, closeTo(heart.top, 0.5));
    final stack = tester.getRect(find.byType(GiftStack));
    expect(stack.center.dx, closeTo(heart.center.dx, 0.5));
    expect(find.bySemanticsLabel(RegExp('Gifted: Rocket, Gem, Rose')),
        findsOneWidget);
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
