import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_comment.dart';
import 'package:kyron_app/providers/post_detail_provider.dart';

PostComment _comment(String id, {String? parentId, int replies = 0}) =>
    PostComment.fromJson({
      'id': id,
      'content': 'comment $id',
      'createdAt': '2026-08-31T12:00:00.000Z',
      'author': const {'id': 'u1', 'username': 'ada'},
      'parentId': parentId,
      'replies': replies,
    });

void main() {
  group('PostComment.fromJson', () {
    test('reads a top-level comment', () {
      final comment = _comment('c1', replies: 3);

      expect(comment.isReply, isFalse);
      expect(comment.replies, 3);
      expect(comment.author.handle, '@ada');
      expect(comment.mine, isFalse);
    });

    test('reads a reply', () {
      expect(_comment('c2', parentId: 'c1').isReply, isTrue);
    });

    test('marks your own comment so the screen can offer to delete it', () {
      final mine = PostComment.fromJson({
        'id': 'c3',
        'content': 'hi',
        'author': const {'id': 'u1'},
        'mine': true,
      });

      expect(mine.mine, isTrue);
    });

    test('survives a comment with no author object', () {
      final orphan = PostComment.fromJson(const {'id': 'c4'});

      expect(orphan.author.handle, isNull);
      expect(orphan.author.displayName, 'Someone on Kyron');
    });
  });

  group('PostDetailState', () {
    test('a thread is not empty while it is still loading', () {
      // Otherwise "No comments yet" flashes before the thread arrives.
      const loading = PostDetailState(isLoading: true);

      expect(loading.threadIsEmpty, isFalse);
    });

    test('a thread is not empty when it failed to load', () {
      const failed = PostDetailState(isLoading: false, error: 'nope');

      expect(failed.threadIsEmpty, isFalse);
    });

    test('a thread is empty only once a load finished with nothing', () {
      const empty = PostDetailState(isLoading: false);

      expect(empty.threadIsEmpty, isTrue);
    });

    test('clearError beats the fallthrough value', () {
      const failed = PostDetailState(error: 'nope');

      expect(failed.copyWith(isLoading: true).error, 'nope');
      expect(failed.copyWith(clearError: true).error, isNull);
    });

    test('hasMore follows the cursor', () {
      expect(const PostDetailState().hasMore, isFalse);
      expect(const PostDetailState(nextCursor: 'c9').hasMore, isTrue);
    });
  });

  group('PostAnalytics', () {
    PostAnalytics report({
      int views = 0,
      int likes = 0,
      int saves = 0,
      int comments = 0,
      List<Map<String, dynamic>> timeline = const [],
    }) =>
        PostAnalytics.fromJson({
          'views': views,
          'likes': likes,
          'saves': saves,
          'comments': comments,
          'createdAt': '2026-08-30T00:00:00.000Z',
          'timeline': timeline,
        });

    test('engagement is unknown, not zero, with no viewers', () {
      // 0% reads as "nobody engaged"; the truth is that nobody looked.
      expect(report().engagementRate, isNull);
    });

    test('engagement counts every action over the viewers', () {
      final rate =
          report(views: 10, likes: 2, saves: 1, comments: 2).engagementRate;

      expect(rate, closeTo(0.5, 1e-9));
    });

    test('reads the daily breakdown', () {
      final r = report(timeline: [
        {'date': '2026-08-30', 'views': 2},
        {'date': '2026-08-31', 'views': 1},
      ]);

      expect(r.timeline.map((d) => d.date), ['2026-08-30', '2026-08-31']);
      expect(r.timeline.first.views, 2);
    });

    test('survives a response with nothing in it', () {
      final empty = PostAnalytics.fromJson(const {});

      expect(empty.views, 0);
      expect(empty.timeline, isEmpty);
      expect(empty.engagementRate, isNull);
    });
  });
}
