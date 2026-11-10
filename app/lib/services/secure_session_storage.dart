import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Where the Supabase session lives on the phone: the platform keystore.
///
/// The SDK's default is SharedPreferences, a plain file the refresh token sat
/// in -- readable by anything that can read the app's files, and copied into
/// backups. A refresh token does not expire by itself, so whoever had that
/// file had the account until it signed out everywhere.
///
/// The first launch after the change moves an existing session across and
/// deletes the old copy, so nobody is signed out by the update.
class SecureSessionStorage extends LocalStorage {
  SecureSessionStorage({
    required this.persistSessionKey,
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage();

  /// The SDK's own key for the session, so the move finds the old copy.
  final String persistSessionKey;
  final FlutterSecureStorage _storage;

  /// The keystore is slow to read; the SDK asks often.
  String? _session;

  @override
  Future<void> initialize() async {
    _session = await _storage.read(key: persistSessionKey);
    final preferences = await SharedPreferences.getInstance();
    final legacy = preferences.getString(persistSessionKey);
    if (legacy != null) {
      if (_session == null) {
        await _storage.write(key: persistSessionKey, value: legacy);
        _session = legacy;
      }
      await preferences.remove(persistSessionKey);
    }
  }

  @override
  Future<bool> hasAccessToken() async => _session != null;

  @override
  Future<String?> accessToken() async => _session;

  @override
  Future<void> persistSession(String persistSessionString) async {
    _session = persistSessionString;
    await _storage.write(key: persistSessionKey, value: persistSessionString);
  }

  @override
  Future<void> removePersistedSession() async {
    _session = null;
    await _storage.delete(key: persistSessionKey);
  }
}
