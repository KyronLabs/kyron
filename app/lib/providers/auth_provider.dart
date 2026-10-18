import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';
import 'current_user_provider.dart';
import 'keys_provider.dart';
import 'identity_provider.dart';
import 'push_provider.dart';
import 'preferences_provider.dart';

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

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

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
        _startSession(user);
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
              _startSession(refreshedUser);
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
    _startSession(user);

    // Awaited: the app behind this draws the signed-in person.
    await ref.read(currentUserProvider.notifier).load();
  }

  /// What every way into a signed-in app has to start: a launch with a live
  /// token, a launch whose token had expired and was refreshed, and a fresh
  /// sign-in.
  ///
  /// The refreshed launch used to set the state and skip all three. A
  /// Supabase access token lasts an hour, so opening the app more than an
  /// hour after last using it -- which is what an update does -- left the
  /// message key unread: every sealed message showed as "cannot be read",
  /// and every message sent went out in the clear. The push token was not
  /// refreshed on that path either.
  ///
  /// Nothing here is awaited: a chat opened before the key is read waits
  /// for it (MessageVault does), an account without an identifier works
  /// exactly as it did before identifiers existed, and none of it is worth
  /// holding the app on a spinner for.
  void _startSession(User user) {
    // Makes this account's message keypair on this install if it has none,
    // and publishes the public half so other people can write to it in
    // private.
    unawaited(ref.read(messageVaultProvider).unlock(user.id));
    // This account's verifiable identifier: made on the device if it has
    // none, and claimed by proving it holds the key.
    unawaited(ref.read(identityVaultProvider).ensure(user.id));
    // The push token, which can have rotated while the app was closed -- a
    // server holding the old one pushes into nothing. Asked for after
    // sign-in rather than before it: that is when asking about
    // notifications is a question rather than an ambush. Not when the
    // reader turned notifications off in settings: the switch used to save
    // a preference that nothing read, and this phone was registered anyway.
    unawaited(() async {
      final wanted = await ref.read(appPreferencesProvider).readPushEnabled();
      if (wanted) await ref.read(pushRegistrarProvider).start();
    }());
  }

  Future<void> logout() async {
    // The message key and the identifier stay on this phone, under this
    // account: they are what reads its messages and what it is known by, and
    // deleting them on sign-out made every message sent to it before
    // unreadable here once it signed back in. Another account signing in
    // here reads only its own.
    await ref.read(messageVaultProvider).lock();
    // The push token does go, before the session does, because unregistering
    // needs one: left registered, it delivers this account's notifications
    // to whoever holds the handset next.
    await ref.read(pushRegistrarProvider).stop();

    await _repo.logout();

    // Clear profile data
    ref.read(currentUserProvider.notifier).clear();

    state = AuthState.unauth();
  }

  /// Signs out after the account itself has been deleted.
  ///
  /// The same as [logout], except that it cannot fail: the server now refuses
  /// this session, so withdrawing the key and the push token are expected to
  /// fail, and a sign-out that threw here would leave the app showing an
  /// account that no longer exists.
  Future<void> accountDeleted() async {
    // The keys sign-out keeps go with the account: nothing is left for them
    // to read, and nobody can sign in as it again.
    final gone = state.user?.id;
    if (gone != null) {
      try {
        await ref.read(messageVaultProvider).erase(gone);
        await ref.read(identityVaultProvider).erase(gone);
      } catch (e) {
        _log('erasing keys after deletion', e);
      }
    }
    try {
      await logout();
    } catch (e) {
      _log('sign-out after deletion', e);
      ref.read(currentUserProvider.notifier).clear();
      state = AuthState.unauth();
    }
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

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

// Helper providers
final currentAuthUserProvider = Provider<User?>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final s = ref.watch(authNotifierProvider);
  return s.status == AuthStatus.authenticated;
});
