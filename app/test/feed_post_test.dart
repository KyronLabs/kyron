import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/providers/feed_provider.dart';

void main() {
  group('FeedPost.fromJson', () {
    test('reads a full post', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'hello',
        'createdAt': '2026-08-31T10:00:00.000Z',
        'author': {
          'id': 'u1',
          'name': 'Ada',
          'username': 'ada',
          'avatarUrl': 'https://example.test/a.png',
        },
      });

      expect(post.id, 'p1');
      expect(post.content, 'hello');
      expect(post.createdAt.toUtc().hour, 10);
      expect(post.author.displayName, 'Ada');
      expect(post.author.handle, '@ada');
    });

    test('survives a post with no author object', () {
      // A malformed row should not take the whole feed down with a cast error.
      final post = FeedPost.fromJson({'id': 'p1', 'content': 'x'});
      expect(post.author.id, '');
      expect(post.author.handle, isNull);
    });

    test('survives an unparseable timestamp', () {
      final post = FeedPost.fromJson({
        'id': 'p1',
        'content': 'x',
        'createdAt': 'not a date',
      });
      expect(post.createdAt, isA<DateTime>());
    });
  });

  group('FeedAuthor display', () {
    test('prefers the name', () {
      const a = FeedAuthor(id: 'u', name: 'Ada', username: 'ada');
      expect(a.displayName, 'Ada');
    });

    test('falls back to the handle when there is no name', () {
      const a = FeedAuthor(id: 'u', username: 'ada');
      expect(a.displayName, 'ada');
    });

    test('never renders a placeholder handle', () {
      // The old feed printed "@user" for every account, which made a real
      // account indistinguishable from filler.
      const a = FeedAuthor(id: 'u');
      expect(a.displayName, isNot(contains('@')));
      expect(a.handle, isNull);
    });

    test('treats blank strings as absent', () {
      const a = FeedAuthor(id: 'u', name: '   ', username: '');
      expect(a.displayName, 'Someone on Kyron');
      expect(a.handle, isNull);
    });
  });

  group('FeedPage.fromJson', () {
    test('reads items and the cursor', () {
      final page = FeedPage.fromJson({
        'items': [
          {'id': 'a', 'content': 'x', 'author': <String, dynamic>{}},
        ],
        'nextCursor': 'a',
      });
      expect(page.items, hasLength(1));
      expect(page.nextCursor, 'a');
    });

    test('reads an empty last page', () {
      final page =
          FeedPage.fromJson({'items': <dynamic>[], 'nextCursor': null});
      expect(page.items, isEmpty);
      expect(page.nextCursor, isNull);
    });
  });

  group('FeedState', () {
    test('is not empty while the first page is still loading', () {
      // Otherwise the empty state flashes before the feed arrives, which reads
      // as "you have nothing" every single launch.
      const loading = FeedState(isLoadingFirstPage: true);
      expect(loading.isEmpty, isFalse);
    });

    test('is not empty when the first page failed', () {
      // A failure is its own state with a retry; showing "nothing here yet"
      // would tell someone their feed is empty when it is unreachable.
      const failed = FeedState(error: 'boom');
      expect(failed.isEmpty, isFalse);
    });

    test('is empty only once a load finished with no posts', () {
      const settled = FeedState();
      expect(settled.isEmpty, isTrue);
    });

    test('hasMore follows the cursor', () {
      expect(const FeedState(nextCursor: 'x').hasMore, isTrue);
      expect(const FeedState().hasMore, isFalse);
    });

    test('clearError and clearCursor beat the fallthrough values', () {
      const s = FeedState(error: 'boom', nextCursor: 'c');
      expect(s.copyWith(clearError: true).error, isNull);
      expect(s.copyWith(clearCursor: true).nextCursor, isNull);
    });
  });
}
