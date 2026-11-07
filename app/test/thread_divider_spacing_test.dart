import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/post_detail_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/comment_tile.dart';
import 'package:kyron_app/widgets/thread.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

class _Repo extends FeedRepository {
  _Repo() : super(ApiClient());

  @override
  Future<FeedPost> byId(String postId) async => FeedPost(
        id: 'p1',
        content: 'A fox',
        createdAt: DateTime(2026, 11, 6),
        author: const FeedAuthor(id: 'k', username: 'kyron', name: 'Kyron'),
        comments: 2,
      );

  @override
  Future<CommentPage> comments(String postId,
          {String? cursor,
          int limit = 20,
          CommentSort sort = CommentSort.top}) async =>
      CommentPage(items: [
        for (final id in ['c1', 'c2'])
          PostComment.fromJson({
            'id': id,
            'content': 'comment $id',
            'createdAt': '2026-11-06T09:00:00Z',
            'author': {'id': 'u$id', 'username': 'u$id'},
          }),
      ]);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  @override
  Future<FeedPage> recent({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets(
      'the line between two conversations sits midway between the buttons '
      'and the next face', (tester) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(_Repo()),
        ],
        child: const MaterialApp(home: PostDetailScreen(postId: 'p1')),
      ),
    );
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    final line = tester.getRect(find.byType(ThreadDivider).first);
    final ruleTop = line.top + ThreadDivider.above;
    final ruleBottom = line.bottom - ThreadDivider.below;
    // The first conversation's buttons, and the second one's face.
    final heart = tester.getRect(find.byIcon(Iconsax.heart_copy).at(1));
    final face = tester.getRect(find.byType(CommentAvatar).at(1));

    final over = ruleTop - heart.bottom;
    final under = face.top - ruleBottom;
    expect(over, closeTo(under, 0.5));
    expect(over, closeTo(16, 0.5));
  });
}
