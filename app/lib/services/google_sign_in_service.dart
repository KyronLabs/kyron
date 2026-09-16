import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_log.dart';

/// What asking Google for an identity produced.
enum GoogleOutcome {
  /// A session exists. The caller can carry on.
  signedIn,

  /// The sheet opened and the reader dismissed it. Not an error, and not
  /// something to show a message about.
  cancelled,

  /// There is no native sheet here, or the project is not registered for one.
  /// The browser flow is the way through, and [GoogleSignInService.reason]
  /// says why it is being used.
  useBrowser,
}

/// Signing in with Google through the platform's own account picker.
///
/// The browser flow this sits in front of works, and is still the fallback,
/// but it is the wrong first choice on a phone: it leaves Kyron, shows a
/// Chrome tab with a URL bar in it, and comes back through a deep link. What
/// Android offers instead is Credential Manager -- a sheet, over the app,
/// listing the accounts already on the device. One tap, no browser, and
/// nothing typed.
///
/// The mechanism is different from OAuth-in-a-browser: the sheet returns a
/// Google **ID token**, which Supabase exchanges for a session directly
/// (`signInWithIdToken`). No redirect is involved, so nothing depends on
/// `so.kyron.app://` being registered, which is also why this is the only
/// Google path that can work on a platform with no deep links.
///
/// ## What it needs, and what happens without it
///
/// On Android the plugin reads the OAuth clients out of
/// `google-services.json`: it needs a **web** client (`client_type: 3`) for
/// the ID token's audience, and an **Android** client (`client_type: 1`)
/// registered with the signing certificate's SHA-1. `kyron-1` currently has
/// neither -- its `google-services.json` carries no `oauth_client` entries at
/// all -- which is the same gap that makes the browser flow answer
/// `Error 401: deleted_client`. Until both exist in Google Cloud and Supabase
/// holds the web client's id and secret, no Google sign-in of any kind can
/// succeed. See docs/AUTH_GOOGLE.md.
///
/// So a configuration failure is not swallowed and is not fatal: it is logged
/// by name and answered with [GoogleOutcome.useBrowser], which at least ends
/// on Google's own error page rather than a sheet that closes with nothing.
class GoogleSignInService {
  GoogleSignInService({SupabaseClient? client}) : _given = client;

  final SupabaseClient? _given;

  /// Resolved when there is a token to exchange, not when this is built.
  /// Every path that ends in [GoogleOutcome.useBrowser] or
  /// [GoogleOutcome.cancelled] returns before Supabase is asked for anything,
  /// and reaching for the singleton up front made all of them depend on it.
  SupabaseClient get _client => _given ?? Supabase.instance.client;

  /// The singleton the plugin exposes. Not injectable -- its constructor is
  /// private -- so a test substitutes `GoogleSignInPlatform.instance`
  /// underneath it instead, which is what this actually talks to.
  GoogleSignIn get _google => GoogleSignIn.instance;

  /// Set from the build when `google-services.json` is not the source of
  /// truth -- the id of the *web* OAuth client, which is what the ID token is
  /// minted for. Empty on Android with a complete `google-services.json`,
  /// which is the intended shape.
  static const String serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );

  /// Why the browser is being used, when it is. Null while nothing has been
  /// tried, and cleared on a successful native sign-in.
  String? reason;

  /// True where the platform has an account picker of its own. False on
  /// Windows and on the web, where the browser flow is not a fallback but the
  /// only flow.
  ///
  /// Asking can throw rather than answer -- there is no plugin registered on
  /// a platform the package does not implement, and a missing plugin is a
  /// raised exception, not a false. Left uncaught that took down Google
  /// sign-in altogether instead of stepping back to the browser, which is the
  /// opposite of what this class is for.
  bool get isSupported {
    try {
      return _google.supportsAuthenticate();
    } catch (_) {
      return false;
    }
  }

  Future<GoogleOutcome> signIn() async {
    if (!isSupported) {
      reason = 'this platform has no account picker of its own';
      return GoogleOutcome.useBrowser;
    }

    // Google is given the hash and Supabase the original, so the ID token can
    // be tied to this attempt without the value it commits to ever crossing
    // the network. initialize() is what carries it, so it is called per
    // attempt rather than once: a nonce reused between sign-ins would not be
    // one.
    final raw = _rawNonce();
    final hashed = sha256.convert(utf8.encode(raw)).toString();

    try {
      await _google.initialize(
        serverClientId: serverClientId.isEmpty ? null : serverClientId,
        nonce: hashed,
      );
    } catch (error) {
      reason = 'Google sign-in could not be initialised: $error';
      AppLog.instance.error('auth', reason!);
      return GoogleOutcome.useBrowser;
    }

    final GoogleSignInAccount account;
    try {
      account = await _google.authenticate();
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled ||
          error.code == GoogleSignInExceptionCode.interrupted) {
        // Dismissing the sheet is an answer, not a fault. Note that Android's
        // Credential Manager also reports some configuration errors this way
        // and the plugin cannot tell them apart, which is worth knowing when
        // a sheet closes immediately and nothing happens.
        return GoogleOutcome.cancelled;
      }
      reason =
          'Google refused the request (${error.code.name}): '
          '${error.description ?? 'no detail'}';
      AppLog.instance.error('auth', reason!);
      return GoogleOutcome.useBrowser;
    } catch (error) {
      // Anything else the platform channel can raise -- a plugin that is not
      // registered here being the one that matters. The browser still works.
      reason = 'the account picker could not be opened: $error';
      AppLog.instance.error('auth', reason!);
      return GoogleOutcome.useBrowser;
    }

    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      // The sheet completed without minting a token for our audience, which
      // is what a missing web OAuth client looks like from here.
      reason =
          'Google returned no ID token, which usually means the project '
          'has no web OAuth client for this app';
      AppLog.instance.error('auth', reason!);
      return GoogleOutcome.useBrowser;
    }

    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      nonce: raw,
    );
    reason = null;
    return GoogleOutcome.signedIn;
  }

  /// 32 bytes of randomness, URL-safe, as the nonce Google commits to.
  ///
  /// [Random.secure] rather than [Random]: a predictable nonce is no nonce,
  /// and this one is the only thing binding an ID token to the attempt that
  /// asked for it.
  static String _rawNonce() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }
}
