import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../models/auth_tokens.dart';
import '../models/user.dart';
import '../services/secure_storage_service.dart';

class LoginResponse {
  final AuthTokens tokens;
  final User user;
  LoginResponse({required this.tokens, required this.user});
}

/// Authentication against Supabase.
///
/// Supabase owns credentials, sessions and refresh. The Kyron API no longer
/// issues tokens; it verifies Supabase access tokens instead, so everything
/// here goes through the SDK and the API is left to serve domain data.
///
/// Session persistence and refresh are handled by supabase_flutter itself.
/// SecureStorageService is still used for the cached user record and the
/// onboarding flag, which are app state rather than credentials.
class AuthRepository {
  final SecureStorageService _storage = SecureStorageService();

  GoTrueClient get _auth => Supabase.instance.client.auth;

  /// Maps a Supabase account onto the app's User. `id` is the Supabase subject,
  /// which is also the primary key the API provisions its own row under, so the
  /// two stay aligned without a mapping table.
  User _toUser(sb.User account) {
    final meta = account.userMetadata ?? const <String, dynamic>{};
    return User(
      id: account.id,
      email: account.email ?? '',
      username: meta['username'] as String? ??
          meta['user_name'] as String? ??
          meta['preferred_username'] as String?,
      name: meta['full_name'] as String? ?? meta['name'] as String?,
    );
  }

  AuthTokens _toTokens(Session session) => AuthTokens(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken ?? '',
        expiresAt: session.expiresAt != null
            ? DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000)
            : DateTime.now().add(const Duration(hours: 1)),
      );

  Future<LoginResponse> loginWithUser({
    required String email,
    required String password,
  }) async {
    final res =
        await _auth.signInWithPassword(email: email, password: password);
    final session = res.session;
    final account = res.user;
    if (session == null || account == null) {
      throw const AuthException('Sign-in did not return a session.');
    }
    final user = _toUser(account);
    await _storage.writeUserData(user);
    return LoginResponse(tokens: _toTokens(session), user: user);
  }

  /// Creates the account. The project has email auto-confirm enabled, so this
  /// returns a usable session immediately and there is no code to enter. If
  /// confirmation is ever switched on, `session` comes back null and the caller
  /// should route to a "check your email" screen instead of straight into the
  /// app -- which is why the session is returned rather than assumed.
  Future<LoginResponse?> register({
    required String email,
    required String password,
    String? username,
  }) async {
    final res = await _auth.signUp(
      email: email,
      password: password,
      data: {
        if (username != null && username.isNotEmpty) 'username': username,
      },
    );
    final session = res.session;
    final account = res.user;
    if (session == null || account == null) return null;

    final user = _toUser(account);
    await _storage.writeUserData(user);
    return LoginResponse(tokens: _toTokens(session), user: user);
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } finally {
      // Clear local caches even if the network sign-out fails, so the device
      // is not left showing a signed-in shell.
      await _storage.clearAll();
    }
  }

  /// The SDK refreshes on its own schedule; this forces one and reports whether
  /// a usable session survived.
  Future<bool> refresh() async {
    try {
      final res = await _auth.refreshSession();
      return res.session != null;
    } catch (_) {
      await _storage.clearAll();
      return false;
    }
  }

  /// True when the SDK holds a session at all, expired or not. Distinct from
  /// [hasValidSession]: an expired session is still worth a refresh attempt.
  bool get hasPersistedSession => _auth.currentSession != null;

  bool get hasValidSession {
    final session = _auth.currentSession;
    return session != null && !session.isExpired;
  }

  Future<bool> hasValidAccessToken() async => hasValidSession;

  /// Prefers the live Supabase account over the cached copy so a profile edit
  /// made elsewhere is not masked by stale local data.
  Future<User?> getStoredUserData() async {
    final account = _auth.currentUser;
    if (account != null) return _toUser(account);
    return _storage.readUserData();
  }

  Future<void> sendPasswordReset(String email) =>
      _auth.resetPasswordForEmail(email);

  /// Confirms a sign-up with the 6-digit code Supabase mails out. Only reachable
  /// when email auto-confirm is disabled on the project; with it enabled,
  /// sign-up already returns a session and nothing sends a code.
  Future<LoginResponse> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    final res = await _auth.verifyOTP(
      email: email,
      token: code,
      type: OtpType.signup,
    );
    final session = res.session;
    final account = res.user;
    if (session == null || account == null) {
      throw const AuthException('Verification did not return a session.');
    }
    final user = _toUser(account);
    await _storage.writeUserData(user);
    return LoginResponse(tokens: _toTokens(session), user: user);
  }

  Future<void> resendSignupCode(String email) =>
      _auth.resend(type: OtpType.signup, email: email);

  Future<void> setOnboardingCompleted() =>
      _storage.writeHasCompletedOnboarding(true);

  Future<bool> isOnboardingComplete() => _storage.readHasCompletedOnboarding();
}
