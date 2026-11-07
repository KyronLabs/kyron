import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

PostComment _c(String id, String text) => PostComment.fromJson({
      'id': id,
      'content': text,
      'createdAt': '2026-11-06T09:00:00Z',
      'author': {'id': 'u$id', 'username': 'u$id'},
    });

class _Repo extends FeedRepository {
  _Repo() : super(ApiClient());

  final asked = <CommentSort>[];

  @override
  Future<FeedPost> byId(String postId) async => FeedPost(
        id: 'p1',
        content: 'A fox',
        createdAt: DateTime(2026, 11, 6),
        author: const FeedAuthor(id: 'k', username: 'kyron', name: 'Kyron'),
        comments: 2,
      );

  @override
  Future<CommentPage> comments(
    String postId, {
    String? cursor,
    int limit = 20,
    CommentSort sort = CommentSort.top,
  }) async {
    asked.add(sort);
    return CommentPage(
      items: sort == CommentSort.top
          ? [_c('a', 'most liked'), _c('b', 'just now')]
          : [_c('b', 'just now'), _c('a', 'most liked')],
    );
  }

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Top by default; Recent from the menu at the heading\'s end', (
    tester,
  ) async {
    final repo = _Repo();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(home: PostDetailScreen(postId: 'p1')),
      ),
    );
    await tester.pumpAndSettle();

    expect(repo.asked, [CommentSort.top]);
    final heading = tester.getRect(find.text('2 comments'));
    final button = tester.getRect(find.byKey(const ValueKey('comment-sort')));
    // At the other end of the same line: the content's right edge.
    final width = tester.getSize(find.byType(MaterialApp)).width;
    expect(button.right, closeTo(width - 8, 1));
    expect(button.left, greaterThan(heading.left + 100));
    expect((button.center.dy - heading.center.dy).abs(), lessThan(2));
    expect(
      tester.getTopLeft(find.text('most liked')).dy,
      lessThan(tester.getTopLeft(find.text('just now')).dy),
    );

    await tester.tap(find.byKey(const ValueKey('comment-sort')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('comment-sort-top')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('comment-sort-recent')));
    await tester.pumpAndSettle();

    expect(repo.asked, [CommentSort.top, CommentSort.recent]);
    expect(
      tester.getTopLeft(find.text('just now')).dy,
      lessThan(tester.getTopLeft(find.text('most liked')).dy),
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('comment-sort')),
        matching: find.text('Recent'),
      ),
      findsOneWidget,
    );
  });
}
