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
