import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/widgets/gift_pill.dart';
import 'package:kyron_app/widgets/post_actions_row.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

final _post = FeedPost(
  id: 'p1',
  content: 'The older I get, the more I see why it is important to keep '
      'people around who share your manners',
  createdAt: DateTime(2026, 11, 7),
  author: FeedAuthor.fromJson(const {'id': 'a', 'name': 'Ada'}),
  likes: 3,
);

Widget _host({
  required Widget content,
  int count = 12,
  bool endsInText = false,
  void Function(BuildContext)? onTap,
}) =>
    MaterialApp(
      theme: KyronTheme.lightTheme,
      home: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 300,
            child: GiftPillHost(
              types: const ['crown', 'gem', 'rose'],
              count: count,
              endsInText: endsInText,
              onTap: onTap,
              content: content,
              footer: PostActionsRow(
                post: _post,
                onReply: () {},
                onRepost: () {},
                onLike: () {},
                onSave: () {},
                onShare: () {},
              ),
            ),
          ),
        ),
      ),
    );

Rect _pill(WidgetTester tester) =>
    tester.getRect(find.byKey(const ValueKey('gift-pill')));

void main() {
  testWidgets('under words, below the last line and clear of the row', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(content: Text(_post.content), endsInText: true),
    );
    await tester.pumpAndSettle();

    final words = tester.getRect(find.text(_post.content));
    final row = tester.getRect(find.byType(PostActionsRow));
    final pill = _pill(tester);
    expect(pill.top, greaterThanOrEqualTo(words.bottom));
    expect(pill.bottom, lessThanOrEqualTo(row.top));
    // In the bottom-right corner.
    final host = tester.getRect(find.byType(GiftPillHost));
    expect(pill.right, host.right - GiftPillHost.inset);
  });

  testWidgets('on a picture or a card, astride its bottom edge', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(content: const SizedBox(key: ValueKey('frame'), height: 160)),
    );
    await tester.pumpAndSettle();

    final frame = tester.getRect(find.byKey(const ValueKey('frame')));
    final row = tester.getRect(find.byType(PostActionsRow));
    final pill = _pill(tester);
    expect(pill.center.dy, closeTo(frame.bottom, 0.5));
    expect(pill.bottom, lessThanOrEqualTo(row.top));
  });

  testWidgets('takes a tap on its lower half too', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(
        content: const SizedBox(height: 160),
        onTap: (_) => taps++,
      ),
    );
    await tester.pumpAndSettle();

    final pill = _pill(tester);
    await tester.tapAt(Offset(pill.center.dx, pill.bottom - 3));
    await tester.tapAt(Offset(pill.center.dx, pill.top + 3));
    expect(taps, 2);
  });

  testWidgets('no gifts, no pill, and the post is laid out as before', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(content: Text(_post.content), count: 0, endsInText: true),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('gift-pill')), findsNothing);
    final words = tester.getRect(find.text(_post.content));
    final row = tester.getRect(find.byType(PostActionsRow));
    expect(row.top - words.bottom, SpacingTokens.space8);
  });

  testWidgets('says how many, and yours is in the accent', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: KyronTheme.lightTheme,
        home: const Scaffold(
          body: Center(
            child: GiftPill(types: ['rose'], count: 1500, yours: true),
          ),
        ),
      ),
    );
    final count = tester.widget<Text>(find.text('1.5K'));
    expect(count.style?.color, KyronTheme.lightTheme.colorScheme.primary);
    expect(find.bySemanticsLabel('1500 gifts'), findsOneWidget);
  });
}
