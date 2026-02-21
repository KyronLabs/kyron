import 'package:dio/dio.dart';
import '../models/auth_tokens.dart';
import '../models/user.dart';
import '../services/secure_storage_service.dart';
import '../services/api_client.dart';

class LoginResponse {
  final AuthTokens tokens;
  final User user;
  LoginResponse({required this.tokens, required this.user});
}

class AuthRepository {
  final ApiClient _client = ApiClient();
  final SecureStorageService _storage = SecureStorageService();

  Future<LoginResponse> loginWithUser({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 AuthRepository.loginWithUser: starting for $email');

      final res = await _client.dio.post('/auth/login',
          data: {'email': email, 'password': password});

      final data = res.data as Map<String, dynamic>;
      
      final access = data['accessToken'] as String;
      final refresh = data['refreshToken'] as String;
      final expiresIn = (data['expiresIn'] as num).toInt();
      final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

      final userData = data['user'] as Map<String, dynamic>;
      final user = User.fromJson(userData);

      final tokens = AuthTokens(
        accessToken: access, 
        refreshToken: refresh, 
        expiresAt: expiresAt
      );

      // Persist tokens
      await _storage.writeAccessToken(access, expiresAt);
      await _storage.writeRefreshToken(refresh);
      await _storage.writeUserData(user);

      print('✅ AuthRepository.loginWithUser: success for ${user.email}');
      return LoginResponse(tokens: tokens, user: user);
    } catch (e) {
      print('❌ AuthRepository.loginWithUser error: $e');
      rethrow;
    }
  }

  Future<AuthTokens> verifyEmail({
    required String userId,
    required String code,
  }) async {
    final res = await _client.dio.post('/auth/verify-email',
        data: {'userId': userId, 'code': code});

    final data = res.data as Map<String, dynamic>;

    final access = data['accessToken'] as String;
    final refresh = data['refreshToken'] as String;
    final expiresIn = (data['expiresIn'] as num).toInt();
    final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

    final user = User.fromJson(data['user'] as Map<String, dynamic>);

    await _storage.writeAccessToken(access, expiresAt);
    await _storage.writeRefreshToken(refresh);
    await _storage.writeUserData(user);

    return AuthTokens(accessToken: access, refreshToken: refresh, expiresAt: expiresAt);
  }

  
  Future<bool> refresh() async {
    print('🔄 AuthRepository.refresh() called');
    
    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null) {
      print('❌ No refresh token found');
      return false;
    }

    try {
      print('🔄 Attempting token refresh...');
      final res = await _client.dio.post('/auth/refresh', 
        data: {'refreshToken': refreshToken}
      );
      
      final data = res.data as Map<String, dynamic>;
      
      final access = data['accessToken'] as String;
      final newRefresh = data['refreshToken'] as String?;
      final expiresIn = (data['expiresIn'] as num).toInt();
      final expiresAt = DateTime.now().add(Duration(seconds: expiresIn));

      await _storage.writeAccessToken(access, expiresAt);
      if (newRefresh != null) {
        await _storage.writeRefreshToken(newRefresh);
      }
      
      print('✅ Token refresh successful');
      return true;
      
    } catch (e) {
      print('❌ Token refresh failed: $e');
      // Clear tokens on refresh failure
      await _storage.clearAll();
      return false;
    }
  }

  Future<void> logout() async {
    final refreshToken = await _storage.readRefreshToken();
    try {
      if (refreshToken != null) {
        await _client.dio.post('/auth/logout', data: {'refreshToken': refreshToken});
      }
    } catch (_) {}
    await _storage.clearAll();
  }

  Future<bool> hasValidAccessToken() async {
    return await _storage.hasValidAccessToken();
  }

  Future<User?> getStoredUserData() async {
    return await _storage.readUserData();
  }

  Future<Response> register({
    required String email,
    required String password,
    String? username,
  }) async {
    final body = {
      'email': email,
      'password': password,
      if (username != null && username.isNotEmpty) 'username': username,
    };

    return await _client.dio.post('/auth/register', data: body);
  }

  // ✅ NEW: Onboarding completion methods
  Future<void> setOnboardingCompleted() async {
    await _storage.writeHasCompletedOnboarding(true);
  }

  Future<bool> isOnboardingComplete() async {
    return await _storage.readHasCompletedOnboarding();
  }

Future<void> debugPrintStoredTokens() async {
  print('🔍 DEBUG: Checking stored tokens...');
  final storage = SecureStorageService();
  final token = await storage.readAccessToken();
  final expiry = await storage.readAccessExpiry();
  final refresh = await storage.readRefreshToken();
  final user = await storage.readUserData();
  final onboarding = await storage.readHasCompletedOnboarding();
  
  print('  Access Token: ${token != null ? "Present (${token.length} chars)" : "NULL"}');
  print('  Refresh Token: ${refresh != null ? "Present" : "NULL"}');
  print('  Expiry: $expiry');
  print('  User: ${user?.email ?? "NULL"}');
  print('  Has completed onboarding: $onboarding');
  
  if (expiry != null) {
    final now = DateTime.now();
    print('  Token is ${expiry.isAfter(now) ? "VALID" : "EXPIRED"} (now: $now)');
  }
  
  print('  Token age: ${expiry != null ? DateTime.now().difference(expiry).inSeconds.abs() : "N/A"} seconds');
 }
}