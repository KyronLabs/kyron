import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
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
  _openingReplies();
  _reportingTheRead();

  group('PostComment.fromJson', () {
    test('reads a top-level comment', () {
      final comment = _comment('c1', replies: 3);

      expect(comment.isReply, isFalse);
      expect(comment.replies, 3);
      expect(comment.author.handle, '@ada');
      expect(comment.mine, isFalse);
    });

    test('marks a comment the post author wrote', () {
      // Decided by the server: a comment page can be opened on its own and
      // has no post in hand to compare against.
      final byAuthor = PostComment.fromJson({
        'id': 'c9',
        'author': const {'id': 'u1'},
        'byAuthor': true,
      });

      expect(byAuthor.byAuthor, isTrue);
      expect(_comment('c1').byAuthor, isFalse);
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

/// A feed that answers a thread page whenever the test says so.
class _SlowFeed extends FeedRepository {
  _SlowFeed() : super(ApiClient());

  /// Held open, so a test can look at the state mid-fetch -- which is the
  /// only moment the bug this covers was visible.
  final _replies = Completer<CommentPage>();

  @override
  Future<FeedPost> byId(String id) async => FeedPost(
        id: id,
        content: 'a post',
        createdAt: DateTime(2026),
        author: const FeedAuthor(id: 'me', username: 'me'),
      );

  @override
  Future<CommentPage> comments(String postId,
          {String? cursor, int limit = 20}) async =>
      CommentPage(items: [_comment('c1', replies: 2)]);

  @override
  Future<CommentPage> replies(String commentId,
      {String? cursor, int limit = 20}) {
    return _replies.future;
  }

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {}

  void answer() => _replies.complete(
        CommentPage(items: [_comment('r1', parentId: 'c1')]),
      );

  void fail() => _replies.completeError(Exception('offline'));
}

void _openingReplies() {
  group('opening a folded run of replies', () {
    ProviderContainer containerFor(_SlowFeed feed) {
      final container = ProviderContainer(
        overrides: [feedRepositoryProvider.overrideWithValue(feed)],
      );
      addTearDown(container.dispose);
      return container;
    }

    test('keeps the row while its replies are on their way', () async {
      final feed = _SlowFeed();
      final container = containerFor(feed);
      final notifier = container.read(postDetailProvider('p1').notifier);
      await pumpEventQueue();

      unawaited(notifier.toggleReplies('c1'));
      await pumpEventQueue();

      // Marking it expanded here would take the "show replies" row away and
      // put nothing in its place, so the branch reads as deleted.
      final state = container.read(postDetailProvider('p1'));
      expect(state.loadingReplies, contains('c1'));
      expect(state.expanded, isNot(contains('c1')));
    });

    test('opens it once they arrive', () async {
      final feed = _SlowFeed();
      final container = containerFor(feed);
      final notifier = container.read(postDetailProvider('p1').notifier);
      await pumpEventQueue();

      final opening = notifier.toggleReplies('c1');
      await pumpEventQueue();
      feed.answer();
      await opening;

      final state = container.read(postDetailProvider('p1'));
      expect(state.expanded, contains('c1'));
      expect(state.loadingReplies, isEmpty);
      expect(state.replies['c1'], hasLength(1));
    });

    test('stops spinning when the replies cannot be fetched', () async {
      final feed = _SlowFeed();
      final container = containerFor(feed);
      final notifier = container.read(postDetailProvider('p1').notifier);
      await pumpEventQueue();

      final opening = notifier.toggleReplies('c1');
      await pumpEventQueue();
      feed.fail();
      await opening;

      // A row that spins forever is worse than one that shows nothing.
      final state = container.read(postDetailProvider('p1'));
      expect(state.loadingReplies, isEmpty);
      expect(state.expanded, contains('c1'));
      expect(state.replies['c1'], isEmpty);
    });
  });
}

/// A feed that remembers every view it was told about.
class _CountingFeed extends FeedRepository {
  _CountingFeed() : super(ApiClient());

  /// One entry per call: null for an open, a duration for a dwell report.
  final List<int?> views = [];

  @override
  Future<FeedPost> byId(String id) async => FeedPost(
        id: id,
        content: 'a post',
        createdAt: DateTime(2026),
        author: const FeedAuthor(id: 'me', username: 'me'),
      );

  @override
  Future<CommentPage> comments(String postId,
          {String? cursor, int limit = 20}) async =>
      const CommentPage(items: []);

  @override
  Future<void> recordView(String postId, {int? dwellMs}) async {
    views.add(dwellMs);
  }
}

void _reportingTheRead() {
  group('reporting the read', () {
    /// A notifier on a clock the test moves by hand.
    ({PostDetailNotifier notifier, _CountingFeed feed, void Function(int) pass})
        reading() {
      final feed = _CountingFeed();
      var clock = DateTime(2026, 9, 8, 12);
      final container = ProviderContainer(
        overrides: [feedRepositoryProvider.overrideWithValue(feed)],
      );
      addTearDown(container.dispose);

      final probe = Provider<PostDetailNotifier>(
        (ref) => PostDetailNotifier(ref, 'p1', now: () => clock),
      );
      return (
        notifier: container.read(probe),
        feed: feed,
        pass: (ms) => clock = clock.add(Duration(milliseconds: ms)),
      );
    }

    test('records the open when the reader arrives', () async {
      final r = reading();
      await pumpEventQueue();

      r.notifier.enter();

      expect(r.feed.views, [null]);
    });

    test('does not record the open until the reader is on the post', () async {
      // Loading the post is not reading it. Recording the view from the fetch
      // counted a screen the reader may never have reached.
      final r = reading();
      await pumpEventQueue();

      expect(r.feed.views, isEmpty);
    });

    test('reports how long they stayed when they leave', () async {
      final r = reading();
      await pumpEventQueue();
      r.notifier.enter();

      r.pass(9000);
      r.notifier.leave();

      expect(r.feed.views, [null, 9000]);
    });

    test('does not spend a round trip on a back-tap', () async {
      final r = reading();
      await pumpEventQueue();
      r.notifier.enter();

      r.pass(200);
      r.notifier.leave();

      expect(r.feed.views, [null]);
    });

    test('counts a second visit as a second read', () async {
      // The provider outlives the screen, so coming back reuses this notifier.
      // Recording the open from the one-time fetch missed every return visit,
      // and a post read four times has to rank below one glanced at once.
      final r = reading();
      await pumpEventQueue();
      r.notifier.enter();
      r.pass(5000);
      r.notifier.leave();

      r.notifier.enter();
      r.pass(5000);
      r.notifier.leave();

      expect(r.feed.views, [null, 5000, null, 5000]);
    });

    test('does not start a second clock while already reading', () async {
      // The screen calls enter on arrival and again when the app returns to
      // the foreground; the second one must not restart the count.
      final r = reading();
      await pumpEventQueue();
      r.notifier.enter();
      r.pass(4000);

      r.notifier.enter();
      r.pass(4000);
      r.notifier.leave();

      expect(r.feed.views, [null, 8000]);
    });

    test('reports nothing for a leave it never entered', () async {
      final r = reading();
      await pumpEventQueue();

      r.notifier.leave();

      expect(r.feed.views, isEmpty);
    });

    test('reports the read when the screen goes away mid-read', () async {
      final r = reading();
      await pumpEventQueue();
      r.notifier.enter();
      r.pass(30000);

      r.notifier.dispose();

      expect(r.feed.views, [null, 30000]);
    });
  });
}
