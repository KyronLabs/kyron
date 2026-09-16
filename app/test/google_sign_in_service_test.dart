import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:kyron_app/services/google_sign_in_service.dart';

import 'support/fake_google_platform.dart';

void main() {
  // None of these reach Supabase: each returns before there is a token to
  // exchange. Built without one on purpose -- if a path ever did reach it,
  // the singleton would throw rather than quietly do something.
  GoogleSignInService service() => GoogleSignInService();

  test('uses the browser where there is no account picker', () async {
    // Windows and the web. The browser is not a fallback there, it is the
    // only flow.
    GoogleSignInPlatform.instance = FakeGooglePlatform(supports: false);

    final outcome = await service().signIn();

    expect(outcome, GoogleOutcome.useBrowser);
  });

  test('treats a dismissed sheet as an answer, not a failure', () async {
    GoogleSignInPlatform.instance = FakeGooglePlatform(
      throws: const GoogleSignInException(
        code: GoogleSignInExceptionCode.canceled,
      ),
    );

    final s = service();
    expect(await s.signIn(), GoogleOutcome.cancelled);
    // Nothing to explain, so nothing is said.
    expect(s.reason, isNull);
  });

  test('falls back, and says why, when Google mints no ID token', () async {
    // What a project with no web OAuth client looks like from here: the sheet
    // completes, and hands back nothing to exchange.
    GoogleSignInPlatform.instance = FakeGooglePlatform(result: googleResults());

    final s = service();
    expect(await s.signIn(), GoogleOutcome.useBrowser);
    expect(s.reason, contains('web OAuth client'));
  });

  test('falls back, and says why, when Google refuses the request', () async {
    GoogleSignInPlatform.instance = FakeGooglePlatform(
      throws: const GoogleSignInException(
        code: GoogleSignInExceptionCode.clientConfigurationError,
        description: 'no matching client',
      ),
    );

    final s = service();
    expect(await s.signIn(), GoogleOutcome.useBrowser);
    expect(s.reason, contains('clientConfigurationError'));
    expect(s.reason, contains('no matching client'));
  });

  test('falls back when the platform has no plugin registered', () async {
    // The shape of a desktop or web build: asking whether there is a sheet
    // raises rather than answers. Left uncaught that took Google sign-in down
    // altogether instead of stepping back to the browser.
    GoogleSignInPlatform.instance = FakeGooglePlatform(
      initThrows: MissingPluginException('no implementation'),
    );

    final s = service();
    expect(await s.signIn(), GoogleOutcome.useBrowser);
    expect(s.reason, contains('could not be initialised'));
  });

  test('hands Google a hashed nonce, never the value it commits to', () async {
    // The raw nonce goes to Supabase and the hash to Google, so the thing
    // binding the token to this attempt never crosses the network.
    final fake = FakeGooglePlatform(result: googleResults());
    GoogleSignInPlatform.instance = fake;

    await service().signIn();

    final nonce = fake.initialisedWith?.nonce;
    expect(nonce, isNotNull);
    // SHA-256, hex.
    expect(nonce, matches(RegExp(r'^[0-9a-f]{64}$')));
  });

  test('asks for a different nonce every time', () async {
    final first = FakeGooglePlatform(result: googleResults());
    GoogleSignInPlatform.instance = first;
    await service().signIn();

    final second = FakeGooglePlatform(result: googleResults());
    GoogleSignInPlatform.instance = second;
    await service().signIn();

    expect(
      first.initialisedWith?.nonce,
      isNot(equals(second.initialisedWith?.nonce)),
    );
  });
}
