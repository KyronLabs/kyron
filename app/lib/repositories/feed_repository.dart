import '../models/feed_post.dart';
import '../models/post_comment.dart';
import '../services/api_client.dart';

class FeedRepository {
  final ApiClient _api;

  FeedRepository(this._api);

  /// One page of the feed, newest first.
  ///
  /// [cursor] is the `nextCursor` of the previous page. The server uses keyset
  /// pagination, so passing it back is what keeps a page boundary stable while
  /// people are posting.
  Future<FeedPage> recent({String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/recent',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// One account's posts, newest first, with the same cursor rules as [recent].
  Future<FeedPage> byAuthor(
    String userId, {
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/users/$userId/posts',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// The posts you have liked, most recently liked first.
  Future<FeedPage> liked({String? cursor, int limit = 20}) =>
      _page('/feed/liked', cursor, limit);

  /// The posts you have saved. Private to you -- there is no path for another
  /// account's saves.
  Future<FeedPage> saved({String? cursor, int limit = 20}) =>
      _page('/feed/saved', cursor, limit);

  Future<FeedPage> _page(String path, String? cursor, int limit) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      path,
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FeedPage.fromJson(res.data ?? const {});
  }

  /// Returns the post's recounted like total, so the screen shows the server's
  /// number rather than its own guess.
  Future<int> setLiked(String postId, bool liked) async {
    final path = '/feed/posts/$postId/like';
    final res = liked
        ? await _api.dio.put<Map<String, dynamic>>(path)
        : await _api.dio.delete<Map<String, dynamic>>(path);
    return (res.data?['likes'] as num?)?.toInt() ?? 0;
  }

  Future<void> setSaved(String postId, bool saved) async {
    final path = '/feed/posts/$postId/save';
    if (saved) {
      await _api.dio.put<void>(path);
    } else {
      await _api.dio.delete<void>(path);
    }
  }

  Future<FeedPost> create(String content) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts',
      // No author: the server takes it from the access token and rejects any
      // attempt to name one.
      data: {'content': content},
    );
    return FeedPost.fromJson(res.data ?? const {});
  }

  Future<void> delete(String postId) => _api.dio.delete('/feed/posts/$postId');

  /// One post on its own, for the screen that shows it with its thread.
  Future<FeedPost> byId(String postId) async {
    final res = await _api.dio.get<Map<String, dynamic>>('/feed/posts/$postId');
    return FeedPost.fromJson(res.data ?? const {});
  }

  Future<CommentPage> comments(String postId,
      {String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/posts/$postId/comments',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return CommentPage.fromJson(res.data ?? const {});
  }

  Future<CommentPage> replies(String commentId,
      {String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/feed/comments/$commentId/replies',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return CommentPage.fromJson(res.data ?? const {});
  }

  Future<PostComment> addComment(
    String postId,
    String content, {
    String? parentId,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/feed/posts/$postId/comments',
      data: {
        'content': content,
        if (parentId != null) 'parentId': parentId,
      },
    );
    return PostComment.fromJson(res.data ?? const {});
  }

  Future<void> deleteComment(String commentId) =>
      _api.dio.delete<void>('/feed/comments/$commentId');

  /// Records that this reader opened the post. Idempotent per reader, and the
  /// author's own opens are not counted.
  Future<void> recordView(String postId) =>
      _api.dio.put<void>('/feed/posts/$postId/view');

  /// How the post is doing. Answers 404 to anyone but its author.
  Future<PostAnalytics> analytics(String postId) async {
    final res = await _api.dio
        .get<Map<String, dynamic>>('/feed/posts/$postId/analytics');
    return PostAnalytics.fromJson(res.data ?? const {});
  }
}
