import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import 'current_user_provider.dart';
import 'keys_provider.dart';
import 'identity_provider.dart';

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
        // Makes this install's message keypair if it has none, and publishes
        // the public half so other people can write to it in private.
        // Awaited nowhere: a chat opened before it finishes sends in the
        // clear, which is what happened before this existed.
        unawaited(ref.read(messageVaultProvider).unlock());
        // And this account's portable identifier, on the same terms: made on
        // the device if it has none, and claimed by proving it holds the key.
        // Nothing waits on it -- an account without one works exactly as it
        // did before identifiers existed.
        unawaited(ref.read(identityVaultProvider).ensure());
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
      await _settle(resp.user);
      return true;
    } catch (e) {
      _log('sign-in failed', e);
      state = AuthState.unauth();
      return false;
    }
  }

  /// Hands a Google sign-in to the browser.
  ///
  /// Returns once the consent screen is open, which is not the same as
  /// somebody having signed in: the session comes back over the redirect and
  /// is taken up by [adoptExternalSession]. The state is deliberately left
  /// alone here -- moving to `authenticating` would put RootScreen on the
  /// splash behind a browser the reader may simply close, and nothing would
  /// move it off again.
  ///
  /// Throws when the browser could not be opened at all, which the caller
  /// shows: a sign-in button that does nothing is indistinguishable from a
  /// broken one.
  Future<bool> startGoogleSignIn() => _repo.startGoogleSignIn();

  /// Takes up a session that arrived from outside -- a Google redirect, or a
  /// link in an email -- and signs the app in behind it.
  ///
  /// False when there turned out to be no session, which is what closing the
  /// browser without finishing looks like.
  Future<bool> adoptExternalSession() async {
    try {
      final user = await _repo.adoptCurrentSession();
      if (user == null) {
        _log('external sign-in', StateError('the redirect carried no session'));
        return false;
      }
      await _settle(user);
      return true;
    } catch (e) {
      _log('external sign-in failed', e);
      state = AuthState.unauth();
      return false;
    }
  }

  /// What every successful sign-in has to do, wherever it came from.
  ///
  /// The two key vaults used to be warmed only by [bootstrap], so they were
  /// ready on the second launch and not the first. Survivable for an account
  /// signing in with a password it already had; not at all for one created
  /// seconds ago by tapping Google, whose first chat would have gone out in
  /// the clear.
  Future<void> _settle(User user) async {
    state = AuthState.authenticated(user);

    // Neither is awaited, on the same terms as bootstrap: a chat opened
    // before the keypair exists sends in the clear, and an account without an
    // identifier works exactly as it did before identifiers existed -- but
    // neither is worth holding the app on a spinner for.
    unawaited(ref.read(messageVaultProvider).unlock());
    unawaited(ref.read(identityVaultProvider).ensure());

    // Awaited: the app behind this draws the signed-in person.
    await ref.read(currentUserProvider.notifier).load();
  }

  Future<void> logout() async {
    // Before the session goes, because withdrawing the published key needs
    // one. The secret half is deleted either way: it is this device's
    // identity, and it leaves with the account that made it.
    await ref.read(messageVaultProvider).lock();
    // The identifier belongs to the account that made it, exactly like the
    // message key.
    await ref.read(identityVaultProvider).forget();

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
