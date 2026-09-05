import '../models/explore_entry.dart';
import '../models/profile_model.dart';
import '../models/profile_summary.dart';
import '../services/api_client.dart';

class ProfileRepository {
  final ApiClient _api;

  ProfileRepository(this._api);

  /// A public profile by handle. Pass the handle without its leading @.
  Future<ProfileModel> byUsername(String username) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/profile/${Uri.encodeComponent(username)}',
    );
    return ProfileModel.fromJson(res.data ?? const {});
  }

  Future<void> follow(String userId) =>
      _api.dio.post<void>('/profile/follow/$userId');

  Future<void> unfollow(String userId) =>
      _api.dio.post<void>('/profile/unfollow/$userId');

  /// One page of the people following an account, or the people it follows.
  ///
  /// Paged by cursor rather than an offset: a list being followed and
  /// unfollowed while it is read shifts under an offset, and the reader sees
  /// the same person twice or misses one.
  Future<FollowPage> follows(
    String userId, {
    required bool followers,
    String? cursor,
    int limit = 30,
  }) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/profile/users/$userId/${followers ? 'followers' : 'following'}',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return FollowPage.fromJson(res.data ?? const {});
  }

  /// Accounts worth following, best match first.
  ///
  /// Paged by an offset rather than a row id: the order is computed by the
  /// server from shared topics and follower counts, so there is no row a
  /// cursor could name.
  Future<SuggestionPage> suggested({int? cursor, int limit = 20}) async {
    final res = await _api.dio.get<Map<String, dynamic>>(
      '/profile/suggested',
      queryParameters: {
        'limit': limit,
        if (cursor != null) 'cursor': cursor,
      },
    );
    return SuggestionPage.fromJson(res.data ?? const {});
  }

  /// The topic catalogue, with its counts and the reader's own picks.
  Future<List<Topic>> topics() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/profile/interests');
    return (res.data?['items'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(Topic.fromJson)
        .toList();
  }

  /// Follows or unfollows one topic, leaving the reader's other picks alone.
  /// Returns the recounted number of people into it.
  Future<int> setTopic(String slug, bool following) async {
    final path = '/profile/interests/${Uri.encodeComponent(slug)}';
    final res = following
        ? await _api.dio.put<Map<String, dynamic>>(path)
        : await _api.dio.delete<Map<String, dynamic>>(path);
    return (res.data?['people'] as num?)?.toInt() ?? 0;
  }
}

/// One page of suggestions, with where the next one starts.
class SuggestionPage {
  final List<ProfileSummary> items;

  /// Null once the ranking has run out.
  final int? nextCursor;

  const SuggestionPage({required this.items, this.nextCursor});

  factory SuggestionPage.fromJson(Map<String, dynamic> json) => SuggestionPage(
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProfileSummary.fromJson)
            .toList(),
        nextCursor: (json['nextCursor'] as num?)?.toInt(),
      );
}

/// One page of people, with where the next one starts.
class FollowPage {
  final List<ProfileSummary> items;
  final String? cursor;

  const FollowPage({required this.items, this.cursor});

  factory FollowPage.fromJson(Map<String, dynamic> json) => FollowPage(
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ProfileSummary.fromJson)
            .toList(),
        cursor: json['nextCursor'] as String?,
      );

  String? get nextCursor => cursor;
}
