import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

import '../models/user.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _kUserKey = 'user_json';
  static const _kOnboardingCompleteKey = 'has_completed_onboarding';

  /// Left by the API's own sign-in, which is gone. Nothing reads them; they
  /// are only deleted, so no phone keeps an old token lying about.
  static const _legacyKeys = [
    'access_token',
    'refresh_token',
    'access_expires_at',
  ];

  Future<void> writeUserData(User user) async {
    await _storage.write(key: _kUserKey, value: jsonEncode(user.toJson()));
  }

  Future<User?> readUserData() async {
    final j = await _storage.read(key: _kUserKey);
    if (j == null) return null;
    try {
      final m = jsonDecode(j) as Map<String, dynamic>;
      return User.fromJson(m);
    } catch (_) {
      return null;
    }
  }

  /// Records that [userId] finished onboarding on this device.
  ///
  /// The account id rather than a bare boolean, because the store is per
  /// device and onboarding is per account. As a boolean, a second account
  /// signing up on the same handset inherited the first one's completion and
  /// was taken straight to the home screen with no profile behind it.
  Future<void> writeOnboardingCompletedFor(String userId) async {
    await _storage.write(key: _kOnboardingCompleteKey, value: userId);
  }

  /// The account that finished onboarding here, or null if none has.
  Future<String?> readOnboardingCompletedFor() =>
      _storage.read(key: _kOnboardingCompleteKey);

  /// Forgets the signed-in account's cached details.
  ///
  /// Only this service's own entries. The store is shared: MessageVault and
  /// IdentityVault keep the device's message key and identity in it, which
  /// stay on the phone through a sign-out by design (docs/E2EE.md). This was
  /// `deleteAll()`, which took them too, so every sign-out -- and every
  /// failed refresh -- minted a new message key, and what had been sealed
  /// for the old one became "Waiting for this message".
  ///
  /// The onboarding entry stays: it names the account that finished
  /// onboarding, so it cannot leak to another one.
  Future<void> clearSession() async {
    for (final key in [_kUserKey, ..._legacyKeys]) {
      await _storage.delete(key: key);
    }
  }
}
