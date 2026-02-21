import '../models/current_user.dart';
import '../services/api_client.dart';

class CurrentUserRepository {
  final ApiClient _api;
  CurrentUser? _cache;

  CurrentUserRepository(this._api);

  Future<CurrentUser> fetchMe({bool force = false}) async {
    if (_cache != null && !force) return _cache!;

    final res = await _api.dio.get('/profile/me');
    final data = res.data as Map<String, dynamic>;
    final user = CurrentUser.fromJson(data);

    _cache = user;
    return user;
  }

  void clear() {
    _cache = null;
  }
}