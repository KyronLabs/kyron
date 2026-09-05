// lib/repositories/communities_repository.dart
import '../models/community.dart';
import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../services/api_client.dart';

class CommunitiesRepository {
  final ApiClient _api;

  CommunitiesRepository(this._api);

  /// The communities the reader is in.
  Future<CommunityPage> mine({String? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/communities/mine',
      queryParameters: {'limit': limit, if (cursor != null) 'cursor': cursor},
    );
    return CommunityPage.fromJson(res.data ?? const {});
  }

  /// Communities the reader is not in, busiest first.
  Future<CommunityPage> discover({String? query, int limit = 30}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/communities/discover',
      queryParameters: {
        'limit': limit,
        if (query != null && query.trim().isNotEmpty) 'q': query.trim(),
      },
    );
    return CommunityPage.fromJson(res.data ?? const {});
  }

  Future<Community> bySlug(String slug) async {
    final res = await _api.dio
        .get<Map<String, dynamic>>('/communities/${Uri.encodeComponent(slug)}');
    return Community.fromJson(res.data ?? const {});
  }

  Future<Community> create(String name, {String? description}) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/communities',
      data: {
        'name': name,
        if (description != null && description.trim().isNotEmpty)
          'description': description.trim(),
      },
    );
    return Community.fromJson(res.data ?? const {});
  }

  /// Joins or leaves. Answers with the community as it now stands.
  Future<Community> setMembership(String slug, bool joined) async {
    final path = '/communities/${Uri.encodeComponent(slug)}/membership';
    final res = joined
        ? await _api.dio.put<Map<String, dynamic>>(path)
        : await _api.dio.delete<Map<String, dynamic>>(path);
    return Community.fromJson(res.data ?? const {});
  }

  /// Writes a post into it.
  ///
  /// Its own endpoint rather than the feed's with a community named: whether
  /// this account may post here is the community's rule, and asking the
  /// community is what enforces it.
  Future<FeedPost> post(
    String slug,
    String content, {
    List<PendingMedia> media = const [],
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/communities/${Uri.encodeComponent(slug)}/posts',
      data: {
        'content': content,
        if (media.isNotEmpty)
          'media':
              media.where((m) => m.isReady).map((m) => m.toJson()).toList(),
      },
    );
    return FeedPost.fromJson(res.data ?? const {});
  }
}
