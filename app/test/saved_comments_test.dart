import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/post_collection_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// Saved, with its second tab: the comments kept from under other posts.
class _Saved extends FeedRepository {
  _Saved() : super(ApiClient());

  final unsaved = <String>[];

  @override
  Future<FeedPage> saved({String? cursor, int limit = 20}) async =>
      const FeedPage(items: []);

  @override
  Future<CommentPage> savedComments({String? cursor, int limit = 20}) async =>
      CommentPage(items: [
        PostComment.fromJson(const {
          'id': 'c1',
          'content': 'Worth keeping',
          'author': {'id': 'ben', 'username': 'ben', 'name': 'Ben'},
          'saved': true,
          'onPost': {
            'id': 'p1',
            'author': {'id': 'ada', 'username': 'ada', 'name': 'Ada'},
          },
        }),
      ]);

  @override
  Future<void> setCommentSaved(String commentId, bool saved) async {
    if (!saved) unsaved.add(commentId);
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('lists saved comments with whose post they answer', (
    tester,
  ) async {
    final repo = _Saved();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(repo),
        ],
        child: const MaterialApp(home: PostCollectionScreen.saved()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Posts'), findsOneWidget);
    await tester.tap(find.text('Comments'));
    await tester.pumpAndSettle();

    expect(find.text('Worth keeping'), findsOneWidget);
    expect(find.text('Replying to @ada'), findsOneWidget);

    // Unsaving here takes it off the list there and then.
    await tester.tap(find.byIcon(Iconsax.archive_tick));
    await tester.pumpAndSettle();
    expect(repo.unsaved, ['c1']);
    expect(find.text('Worth keeping'), findsNothing);
  });
}
