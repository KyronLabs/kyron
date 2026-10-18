import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_log.dart';

/// What asking Google for an identity produced.
enum GoogleOutcome {
  /// A session exists. The caller can carry on.
  signedIn,

  /// The sheet opened and the reader dismissed it. The browser flow is still
  /// available when the platform reports a configuration failure as a
  /// cancellation, so callers can decide whether to offer that fallback.
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
/// Two OAuth clients, in the **same** Google Cloud project: the **web**
/// client Supabase signs in as, which is the ID token's audience and is named
/// below as [serverClientId]; and an **Android** client registered with the
/// package name and the signing certificate's SHA-1, which is how Credential
/// Manager decides the app asking is allowed to ask.
///
/// The web client used to be left for the plugin to find in
/// `google-services.json`. It never could: that file is Firebase's, from
/// project `kyron-1`, and the web client lives in a different Google Cloud
/// project altogether, so the file carries no `oauth_client` for it. Every
/// attempt ended in "serverClientId must be provided" and went to the browser
/// -- which is why the account sheet never once appeared. See
/// docs/AUTH_GOOGLE.md.
///
/// So a configuration failure is not swallowed and is not fatal: it is logged
/// by name and answered with [GoogleOutcome.useBrowser], which still signs
/// the reader in, just less gracefully.
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

  /// The *web* OAuth client: the one Supabase's Google provider is set up
  /// with, and so the audience the ID token has to be minted for.
  ///
  /// Not a secret. A client id is in the address bar of every Google consent
  /// screen; it is the client *secret* that is kept, and that lives in
  /// Supabase. Named here because nothing else on the phone can supply it --
  /// see the class comment -- and a build can still point somewhere else with
  /// `--dart-define=GOOGLE_SERVER_CLIENT_ID=...`.
  static const String serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        '601078807832-b3n2mcc7h16fjvvom372for7id18cdpj.apps.googleusercontent.com',
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
        // Android's Credential Manager reports some configuration errors --
        // an app it does not recognise, chiefly -- as the sheet being
        // dismissed, and the plugin cannot tell them apart from a person
        // closing it. Treat both as a browser fallback: leaving the reader on
        // the welcome screen made a broken Google button indistinguishable
        // from a successful cancellation.
        //
        // Google's own words go in the log, though. They are the only thing
        // that says which it was, and which setting is wrong: on a Play
        // install whose signing certificate is not registered, the sheet
        // opens, the account is picked, and this arrives as
        // "[16] Account reauth failed" -- the browser then signs in fine,
        // which hides the problem from everyone but the log.
        final detail = error.description ?? '';
        reason = refusedAsCancel(detail)
            ? 'Google would not sign this build in (${error.code.name}: '
                "$detail). This install's signing certificate SHA-1 is not "
                'registered as an Android OAuth client beside the web client '
                '-- see docs/AUTH_GOOGLE.md; trying browser sign-in'
            : 'the Google account picker closed (${error.code.name}: '
                "${detail.isEmpty ? 'no detail' : detail}); trying browser "
                'sign-in';
        AppLog.instance.error('auth', reason!);
        return GoogleOutcome.useBrowser;
      }
      reason = 'Google refused the request (${error.code.name}): '
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
      reason = 'Google returned no ID token, which usually means the project '
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

  /// Whether a "cancelled" from Credential Manager is really Google saying no.
  ///
  /// Matched on the message, since the code is the same as a dismissal's:
  ///
  /// - `[16] Account reauth failed` -- an account picked, and refused for
  ///   this install's signing certificate.
  /// - `[10]` / "Developer console is not set up correctly" -- Google's
  ///   DEVELOPER_ERROR, which no person can cause by closing a sheet.
  ///
  /// Both go to the browser anyway; this decides what the log says about it.
  @visibleForTesting
  static bool refusedAsCancel(String detail) => _refusal.hasMatch(detail);

  static final RegExp _refusal = RegExp(
    r'reauth|developer console|\[10\]',
    caseSensitive: false,
  );

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
