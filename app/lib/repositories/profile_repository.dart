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
