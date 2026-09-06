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

  /// Everyone in a community. Members only, enforced by the server.
  Future<CommunityMemberPage> members(
    String slug, {
    String? cursor,
    int limit = 30,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/communities/${Uri.encodeComponent(slug)}/members',
      queryParameters: {'limit': limit, if (cursor != null) 'cursor': cursor},
    );
    return CommunityMemberPage.fromJson(res.data ?? const {});
  }

  /// Who has been removed. Moderators and the owner.
  Future<List<CommunityMember>> bans(String slug) async {
    final res = await _api.dio.get<List<dynamic>>(
      '/communities/${Uri.encodeComponent(slug)}/bans',
    );
    return (res.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(CommunityMember.fromJson)
        .toList();
  }

  /// Name, description, avatar, banner. The owner only.
  Future<Community> update(
    String slug, {
    String? name,
    String? description,
    String? avatarUrl,
    String? bannerUrl,
  }) async {
    final res = await _api.dio.patch<Map<String, dynamic>>(
      '/communities/${Uri.encodeComponent(slug)}',
      data: {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
        if (bannerUrl != null) 'bannerUrl': bannerUrl,
      },
    );
    return Community.fromJson(res.data ?? const {});
  }

  /// Promotes or demotes somebody.
  Future<CommunityMember> setRole(
    String slug,
    String userId,
    CommunityRole role,
  ) async {
    final res = await _api.dio.put<Map<String, dynamic>>(
      '/communities/${Uri.encodeComponent(slug)}/members/$userId/role',
      data: {'role': role.wire},
    );
    return CommunityMember.fromJson(res.data ?? const {});
  }

  /// Removes somebody and keeps them out.
  Future<void> removeMember(String slug, String userId, {String? reason}) =>
      _api.dio.delete<Map<String, dynamic>>(
        '/communities/${Uri.encodeComponent(slug)}/members/$userId',
        data: {if (reason != null && reason.isNotEmpty) 'reason': reason},
      );

  /// Lets somebody removed come back.
  Future<void> unban(String slug, String userId) =>
      _api.dio.delete<Map<String, dynamic>>(
        '/communities/${Uri.encodeComponent(slug)}/bans/$userId',
      );

  /// Closes a community. Soft, so its posts still resolve.
  Future<void> remove(String slug) => _api.dio.delete<Map<String, dynamic>>(
        '/communities/${Uri.encodeComponent(slug)}',
      );
}
