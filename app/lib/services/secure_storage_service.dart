import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/user.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _kAccessTokenKey = 'access_token';
  static const _kRefreshTokenKey = 'refresh_token';
  static const _kAccessExpKey = 'access_expires_at';
  static const _kUserKey = 'user_json';
  static const _kOnboardingCompleteKey = 'has_completed_onboarding';

  Future<void> writeAccessToken(String token, DateTime expiresAt) async {
    await _storage.write(key: _kAccessTokenKey, value: token);
    await _storage.write(key: _kAccessExpKey, value: expiresAt.toIso8601String());
  }

  Future<void> writeRefreshToken(String token) async {
    await _storage.write(key: _kRefreshTokenKey, value: token);
  }

  Future<String?> readAccessToken() => _storage.read(key: _kAccessTokenKey);
  Future<String?> readRefreshToken() => _storage.read(key: _kRefreshTokenKey);

  Future<DateTime?> readAccessExpiry() async {
    final v = await _storage.read(key: _kAccessExpKey);
    if (v == null) return null;
    return DateTime.tryParse(v);
  }

  Future<bool> hasValidAccessToken() async {
    final token = await readAccessToken();
    final expiry = await readAccessExpiry();
    if (token == null || expiry == null) return false;
    return expiry.isAfter(DateTime.now());
  }

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

  Future<void> writeHasCompletedOnboarding(bool completed) async {
    await _storage.write(key: _kOnboardingCompleteKey, value: completed ? '1' : '0');
  }

  Future<bool> readHasCompletedOnboarding() async {
    final value = await _storage.read(key: _kOnboardingCompleteKey);
    return value == '1';
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}