import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/widgets/comment_tile.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

const _author = FeedAuthor(
  id: 'author',
  username: 'willow',
  name: 'Willow',
);

PostComment _reply({FeedAuthor? authorLike}) => PostComment(
      id: 'c1',
      content: 'mmmn',
      createdAt: DateTime(2026, 3, 4),
      author: const FeedAuthor(id: 'u2', username: 'archieee'),
      authorLike: authorLike,
    );

Future<void> _pump(WidgetTester tester, PostComment comment) =>
    tester.pumpWidget(
      MaterialApp(
        theme: KyronTheme.lightTheme,
        home: Scaffold(
          body: CommentTile(
            comment: comment,
            onReply: () {},
            onLike: () {},
            onAction: (_) {},
          ),
        ),
      ),
    );

void main() {
  group('a reply the post author liked', () {
    testWidgets("carries the author's face beside the menu", (tester) async {
      await _pump(tester, _reply(authorLike: _author));

      expect(find.byType(AuthorLikedBadge), findsOneWidget);
      // Beside the menu, at the end of the line: to its left and level.
      final badge = tester.getCenter(find.byType(AuthorLikedBadge));
      final menu = tester.getCenter(find.byTooltip('More'));
      expect(badge.dx, lessThan(menu.dx));
      expect((badge.dy - menu.dy).abs(), lessThan(1));
    });

    testWidgets('and a reply they did not has none', (tester) async {
      await _pump(tester, _reply());

      expect(find.byType(AuthorLikedBadge), findsNothing);
    });
  });

  testWidgets('the name sits at the top of the reply, level with the avatar',
      (tester) async {
    // The line took the 28-point menu button's height and centred the name in
    // it, a few points below where the avatar beside it starts.
    await _pump(tester, _reply());

    final name = tester.getRect(find.text('archieee').first);
    final tile = tester.getRect(find.byType(CommentTile));
    expect(name.top - tile.top, lessThan(4));
  });

  group('the author liking a reply', () {
    test('shows their badge at once, and takes it away with the like', () {
      final liked = _reply().withLike(true, asAuthor: _author);
      expect(liked.liked, isTrue);
      expect(liked.likes, 1);
      expect(liked.authorLike?.id, 'author');

      final unliked = liked.withLike(false, asAuthor: _author);
      expect(unliked.authorLike, isNull);
      expect(unliked.likes, 0);
    });

    test("anybody else's like leaves the author's badge alone", () {
      final withBadge = _reply(authorLike: _author);

      expect(withBadge.withLike(true).authorLike?.id, 'author');
      expect(withBadge.withLike(false).authorLike?.id, 'author');
    });

    test('is read from the server', () {
      final comment = PostComment.fromJson({
        'id': 'c1',
        'author': const {'id': 'u2'},
        'authorLike': const {
          'id': 'author',
          'username': 'willow',
          'avatarUrl': 'https://cdn.invalid/w.jpg',
        },
      });
      expect(comment.authorLike?.avatarUrl, 'https://cdn.invalid/w.jpg');
      expect(
        PostComment.fromJson(const {'id': 'c2', 'authorLike': null}).authorLike,
        isNull,
      );
    });
  });
}
