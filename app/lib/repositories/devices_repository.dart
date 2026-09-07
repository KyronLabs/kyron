// lib/repositories/devices_repository.dart
import '../services/api_client.dart';

/// Where this install can be reached when the app is closed.
class DevicesRepository {
  final ApiClient _api;

  DevicesRepository(this._api);

  /// Records the token, moving it if it belonged to another account. Called
  /// on every launch, because a token can rotate while the app is closed.
  Future<void> register(String token, String platform) => _api.dio.put<void>(
        '/devices',
        data: {'token': token, 'platform': platform},
      );

  /// Forgets it, on sign-out.
  Future<void> forget(String token) => _api.dio.delete<void>(
        '/devices',
        data: {'token': token},
      );
}
