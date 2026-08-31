import '../models/profile_model.dart';
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
}
