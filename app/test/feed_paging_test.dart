import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/post_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

/// Paging a list of posts, and what happens when a later page fails.
///
/// For You once stopped at twenty posts for eleven days: the server refused
/// every second page, and the list kept what it had without a word, which
/// looked exactly like a feed with nothing more in it.
class _Pages extends FeedRepository {
  _Pages({this.failures = 0}) : super(ApiClient());

  /// How many requests for the second page fail before one answers.
  int failures;
  final cursors = <String?>[];

  static FeedPost post(int i) => FeedPost(
        id: 'p$i',
        content: 'post number $i',
        createdAt: DateTime(2026, 11, 2),
        author: const FeedAuthor(id: 'ada', username: 'ada', name: 'Ada'),
      );

  @override
  Future<FeedPage> following({String? cursor, int limit = 20}) async {
    cursors.add(cursor);
    if (cursor == null) {
      return FeedPage(
        items: [for (var i = 0; i < 20; i++) post(i)],
        nextCursor: 'r1-20-1',
      );
    }
    if (failures > 0) {
      failures--;
      throw Exception('400: cursor must come from a previous page.');
    }
    return FeedPage(items: [for (var i = 20; i < 25; i++) post(i)]);
  }
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('the notifier', () {
    ProviderContainer containerWith(_Pages pages) {
      final container = ProviderContainer(
        overrides: [
          signedInAs(),
          feedRepositoryProvider.overrideWithValue(pages),
        ],
      );
      addTearDown(container.dispose);
      return container;
    }

    Future<PostListNotifier> loaded(ProviderContainer container) async {
      final notifier =
          container.read(postListProvider(PostListSource.following).notifier);
      await Future<void>.delayed(Duration.zero);
      return notifier;
    }

    test('reads past the first page', () async {
      final pages = _Pages();
      final container = containerWith(pages);
      final notifier = await loaded(container);

      await notifier.loadMore();
      final state = container.read(postListProvider(PostListSource.following));
      expect(state.posts, hasLength(25));
      expect(state.hasMore, isFalse);
      expect(pages.cursors, [null, 'r1-20-1']);
    });

    test('says when a later page failed, and stops asking until told',
        () async {
      final pages = _Pages(failures: 1);
      final container = containerWith(pages);
      final notifier = await loaded(container);

      await notifier.loadMore();
      var state = container.read(postListProvider(PostListSource.following));
      expect(state.posts, hasLength(20));
      expect(state.loadMoreFailed, isTrue);
      // The page is still there to be had.
      expect(state.hasMore, isTrue);

      // Scrolling at the foot calls this on every frame: no request each time.
      await notifier.loadMore();
      await notifier.loadMore();
      expect(pages.cursors, [null, 'r1-20-1']);

      await notifier.retryMore();
      state = container.read(postListProvider(PostListSource.following));
      expect(state.posts, hasLength(25));
      expect(state.loadMoreFailed, isFalse);
    });
  });

  group('the list', () {
    testWidgets('shows why the rest did not come, and gets it on Try again', (
      tester,
    ) async {
      final pages = _Pages(failures: 1);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            signedInAs(),
            feedRepositoryProvider.overrideWithValue(pages),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: PostListView(
                source: PostListSource.following,
                emptyTitle: 'Nothing',
                emptyDetail: 'Nothing here yet.',
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      // To the foot, which asks for the next page -- and it fails.
      await tester.dragUntilVisible(
        find.byKey(const ValueKey('feed-more-retry')),
        find.byType(Scrollable).first,
        const Offset(0, -600),
      );
      expect(find.text("Couldn't load more posts."), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('feed-more-retry')));
      await tester.pump();
      await tester.pump();
      expect(find.text("Couldn't load more posts."), findsNothing);
      await tester.dragUntilVisible(
        find.text('post number 24'),
        find.byType(Scrollable).first,
        const Offset(0, -600),
      );
      expect(find.text('post number 24'), findsOneWidget);
    });
  });
}
