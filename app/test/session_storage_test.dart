import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kyron_app/services/secure_session_storage.dart';
import 'package:kyron_app/services/secure_storage_service.dart';

/// What signing out and the session store leave behind on the phone.
void main() {
  const key = 'sb-project-auth-token';

  test('signing out keeps the message key and identity it shares a store with',
      () async {
    FlutterSecureStorage.setMockInitialValues({
      'user_json': '{}',
      'access_token': 'old',
      'refresh_token': 'old',
      'access_expires_at': 'old',
      'has_completed_onboarding': 'u1',
      // Written by MessageVault and IdentityVault, which a sign-out keeps.
      'e2ee.secret.u1': 'secret',
      'e2ee.device.u1': 'device',
      'identity.did': 'did',
    });

    await SecureStorageService().clearSession();

    final left = await const FlutterSecureStorage().readAll();
    expect(
        left.keys,
        unorderedEquals([
          'has_completed_onboarding',
          'e2ee.secret.u1',
          'e2ee.device.u1',
          'identity.did',
        ]));
  });

  test('moves a session out of plain preferences on first launch', () async {
    FlutterSecureStorage.setMockInitialValues({});
    SharedPreferences.setMockInitialValues({key: '{"session":1}'});

    final storage = SecureSessionStorage(persistSessionKey: key);
    await storage.initialize();

    expect(await storage.accessToken(), '{"session":1}');
    expect(await const FlutterSecureStorage().read(key: key), '{"session":1}');
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.containsKey(key), isFalse);
  });

  test('keeps the keystore copy when both exist, and forgets on sign-out',
      () async {
    FlutterSecureStorage.setMockInitialValues({key: 'new'});
    SharedPreferences.setMockInitialValues({key: 'stale'});

    final storage = SecureSessionStorage(persistSessionKey: key);
    await storage.initialize();
    expect(await storage.accessToken(), 'new');

    await storage.removePersistedSession();
    expect(await storage.hasAccessToken(), isFalse);
    expect(await const FlutterSecureStorage().read(key: key), isNull);
  });
}
