import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import 'current_user_provider.dart';

enum AuthStatus { unknown, unauthenticated, authenticating, authenticated }

class AuthState {
  final AuthStatus status;
  final User? user;

  AuthState._({required this.status, this.user});

  factory AuthState.unknown() => AuthState._(status: AuthStatus.unknown);
  factory AuthState.unauth() => AuthState._(status: AuthStatus.unauthenticated);
  factory AuthState.authenticating() =>
      AuthState._(status: AuthStatus.authenticating);
  factory AuthState.authenticated(User user) =>
      AuthState._(status: AuthStatus.authenticated, user: user);
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repo;

  @override
  AuthState build() {
    _repo = ref.read(authRepositoryProvider);
    return AuthState.unknown();
  }

  /// Called at app startup
  Future<void> bootstrap() async {
    // If already authenticated, skip
    if (state.status == AuthStatus.authenticated) return;

    state = AuthState.authenticating();

    try {
      // First, try to get user data from storage
      final user = await _repo.getStoredUserData();
      final hasValidToken = await _repo.hasValidAccessToken();

      // If we have a valid token AND user data, we're authenticated
      if (hasValidToken && user != null) {
        state = AuthState.authenticated(user);

        // Load full profile data
        ref.read(currentUserProvider.notifier).load();
        return;
      }

      // Access token expired but a session is still on disk -- worth a refresh.
      // This used to gate on a refresh token in secure storage; Supabase keeps
      // its own session store, so that lookup always came back null and an
      // expired session was never recovered at startup.
      if (_repo.hasPersistedSession && user != null) {
        try {
          final refreshed = await _repo.refresh();
          if (refreshed) {
            final refreshedUser = await _repo.getStoredUserData();
            if (refreshedUser != null) {
              state = AuthState.authenticated(refreshedUser);

              // Load full profile data
              ref.read(currentUserProvider.notifier).load();
              return;
            }
          }
        } catch (e) {
          _log('session refresh failed', e);
        }
      }

      // If we get here, we're not authenticated
      state = AuthState.unauth();
    } catch (e) {
      _log('bootstrap failed', e);
      state = AuthState.unauth();
    }
  }

  /// Diagnostics for a failure the user sees only as a sign-in screen.
  ///
  /// Debug builds only, and never carries an email or a token: these lines
  /// used to print the signed-in address on every launch, which put it in the
  /// device log and in any bug report taken from the device.
  void _log(String what, Object error) {
    if (kDebugMode) debugPrint('auth: $what -- $error');
  }

  Future<bool> login(String email, String password) async {
    state = AuthState.authenticating();
    try {
      final resp = await _repo.loginWithUser(email: email, password: password);
      state = AuthState.authenticated(resp.user);

      // Load full profile data from /profile/me
      await ref.read(currentUserProvider.notifier).load();
      return true;
    } catch (e) {
      _log('sign-in failed', e);
      state = AuthState.unauth();
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();

    // Clear profile data
    ref.read(currentUserProvider.notifier).clear();

    state = AuthState.unauth();
  }

  Future<bool> refreshTokens() async {
    try {
      final ok = await _repo.refresh();
      if (!ok) {
        state = AuthState.unauth();
        return false;
      }

      final user = await _repo.getStoredUserData();
      if (user != null) {
        state = AuthState.authenticated(user);

        // Reload profile data
        ref.read(currentUserProvider.notifier).load();
        return true;
      }

      state = AuthState.unauth();
      return false;
    } catch (e) {
      _log('token refresh failed', e);
      state = AuthState.unauth();
      return false;
    }
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(() => AuthNotifier());

// Helper providers
final currentAuthUserProvider = Provider<User?>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.status == AuthStatus.authenticated;
});
