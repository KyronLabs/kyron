import '../models/feed_post.dart';
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
}
