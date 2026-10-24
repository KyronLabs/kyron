// lib/repositories/devices_repository.dart
import '../services/api_client.dart';

/// Where this install can be reached when the app is closed.
class DevicesRepository {
  final ApiClient _api;

  DevicesRepository(this._api);

  /// Records the token, moving it if it belonged to another account, and the
  /// language the app is in, so the server says its pushes in it. Called on
  /// every launch, because a token can rotate while the app is closed.
  Future<void> register(String token, String platform, {String? locale}) =>
      _api.dio.put<void>(
        '/devices',
        data: {
          'token': token,
          'platform': platform,
          if (locale != null) 'locale': locale,
        },
      );

  /// Forgets it, on sign-out.
  Future<void> forget(String token) =>
      _api.dio.delete<void>('/devices', data: {'token': token});

  /// Asks the server to send this account a notification now, and says how
  /// far it got.
  Future<PushTest> test() async {
    final res = await _api.dio.post<Map<String, dynamic>>('/devices/test');
    final data = res.data ?? const {};
    return PushTest(
      configured: data['configured'] == true,
      devices: (data['devices'] as num?)?.toInt() ?? 0,
      delivered: (data['delivered'] as num?)?.toInt() ?? 0,
    );
  }
}

/// What a test notification found: which of push's three halves -- the
/// server's key, this account's registered phones, Google taking the
/// message -- is the one not working.
class PushTest {
  /// Whether the server has a key to send with at all.
  final bool configured;

  /// How many phones this account has registered.
  final int devices;

  /// How many of them Google accepted the test for.
  final int delivered;

  const PushTest({
    required this.configured,
    required this.devices,
    required this.delivered,
  });
}
