import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/repositories/auth_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/forgot_password_screen.dart';
import 'package:kyron_app/screens/login_screen.dart';
import 'package:kyron_app/screens/welcome_screen.dart';
import 'package:kyron_app/services/app_log.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:kyron_app/services/google_sign_in_flow.dart';
import 'package:kyron_app/services/google_sign_in_service.dart';
import 'package:kyron_app/services/platform_support.dart';
import 'package:kyron_app/utils/validators.dart';
import 'package:kyron_app/widgets/app_logo.dart';
import 'package:kyron_app/widgets/rooster_art.dart';
import 'package:kyron_app/widgets/google_button.dart';
import 'package:kyron_app/widgets/terms_gate.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

import 'support/fake_google_platform.dart';

/// The way into Kyron, which until now greeted a first-time reader with
/// "Welcome back." over a Google button wired to a comment.
///
/// Everything here is about the first two minutes: what the screen says, what
/// the buttons actually do, what somebody agrees to before any of it, and what
/// happens when the one flow that leaves the app -- a password reset -- has to
/// be finished somewhere else.

/// An account sheet that is up and has not been answered.
class _HangingGoogle extends FakeGooglePlatform {
  @override
  Future<AuthenticationResults> authenticate(AuthenticateParameters params) =>
      Completer<AuthenticationResults>().future;
}

/// The device's account sheet, answering however the test says.
class _Sheet extends GoogleSignInService {
  _Sheet(this.outcome);

  final GoogleOutcome outcome;
  int asked = 0;

  @override
  Future<GoogleOutcome> signIn() async {
    asked++;
    return outcome;
  }
}

/// Records what was asked of Supabase without going near it.
class _FakeAuth extends AuthRepository {
  int googleStarts = 0;
  final resetsSentTo = <String>[];

  @override
  Future<LoginResponse> loginWithUser({
    required String email,
    required String password,
  }) async =>
      // What Supabase says to a password tried on an account made with
      // Google, which has none.
      throw const AuthException('Invalid login credentials');

  /// Thrown by the next call, then cleared.
  Object? nextFailure;

  @override
  Future<bool> startGoogleSignIn() async {
    googleStarts++;
    final failure = nextFailure;
    if (failure != null) {
      nextFailure = null;
      throw failure;
    }
    return true;
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    resetsSentTo.add(email);
    final failure = nextFailure;
    if (failure != null) {
      nextFailure = null;
      throw failure;
    }
  }
}

void main() {
  late _FakeAuth auth;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    auth = _FakeAuth();
  });

  tearDown(() => PlatformSupport.current = null);

  Widget app(Widget home, {GoogleSignInService? sheet}) => ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          if (sheet != null)
            googleSignInServiceProvider.overrideWithValue(sheet),
        ],
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: home,
          onGenerateRoute: Routes.onGenerateRoute,
        ),
      );

  /// Taps through the terms sheet, which stands in front of every way in.
  Future<void> agree(WidgetTester tester) async {
    await tester.tap(find.text('Agree and continue'));
    await tester.pumpAndSettle();
  }

  group('the terms gate', () {
    testWidgets('asks before the first way in, and takes no for an answer', (
      tester,
    ) async {
      final prefs = AppPreferences();
      bool? answer;

      await tester.pumpWidget(
        app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                answer = await TermsGate.require(context, preferences: prefs);
              },
              child: const Text('go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();

      expect(answer, isFalse, reason: 'a gate that lets you through is a sign');
      expect(await prefs.readTermsAcceptedAt(), isNull);
    });

    testWidgets('records when, and never asks that reader again', (
      tester,
    ) async {
      final prefs = AppPreferences();
      final answers = <bool>[];

      await tester.pumpWidget(
        app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                answers.add(
                  await TermsGate.require(context, preferences: prefs),
                );
              },
              child: const Text('go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      await agree(tester);

      expect(answers, [true]);
      // A date rather than a flag: the terms change, and a stored `true` says
      // nothing about which version anybody read.
      final accepted = await prefs.readTermsAcceptedAt();
      expect(accepted, isNotNull);
      expect(DateTime.now().difference(accepted!).inMinutes, lessThan(1));

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsNothing);
      expect(answers, [true, true]);
    });

    testWidgets('says the three things that matter and links the documents', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () =>
                  TermsGate.require(context, preferences: AppPreferences()),
              child: const Text('go'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      expect(find.text('What you post is yours'), findsOneWidget);
      expect(find.text('What Kyron keeps'), findsOneWidget);
      expect(find.text('How to behave'), findsOneWidget);
      expect(find.text('Terms of Service'), findsOneWidget);
      expect(find.text('Privacy Policy'), findsOneWidget);
    });
  });

  group('the get-started screen', () {
    setUp(() {
      // No account picker, so the screen takes the browser path these tests
      // are about. Without this the default platform implementation answers
      // over a method channel nothing is listening on, and the screen decides
      // the sheet was dismissed -- which is a correct reading of a real
      // dismissal and the wrong one here.
      GoogleSignInPlatform.instance = FakeGooglePlatform(supports: false);
    });

    testWidgets('never greets a first-timer as a returning one', (
      tester,
    ) async {
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Welcome back.'), findsNothing);
      expect(find.textContaining('Welcome back'), findsNothing);
    });

    testWidgets('offers all three ways in', (tester) async {
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with email'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
    });

    testWidgets('starts no sign-in until the terms are agreed to', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();

      expect(find.text('Before you start'), findsOneWidget);
      expect(auth.googleStarts, 0);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(
        auth.googleStarts,
        0,
        reason: 'declining the terms has to stop the sign-in',
      );
    });

    testWidgets('and starts one once they are', (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      await agree(tester);
      // The screen records why it used the browser, and the log coalesces
      // writes behind a timer. Settled here rather than left for the binding
      // to complain about after the tree is gone.
      await AppLog.instance.flush();

      expect(auth.googleStarts, 1);
    });

    testWidgets('the Google button stands exactly as tall as the email one', (
      tester,
    ) async {
      // It was eight pixels taller, and outlined where the button under it is
      // filled: two buttons for the same decision that did not look related.
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      final google = tester.getSize(
        find.descendant(
          of: find.byType(GoogleButton),
          matching: find.byType(Material),
        ),
      );
      final email = tester.getSize(
        find.descendant(
          of: find.byType(FilledButton),
          matching: find.byType(Material),
        ),
      );
      expect(google.height, email.height);

      // And solid: no outline round it.
      final material = tester.widget<Material>(
        find.descendant(
          of: find.byType(GoogleButton),
          matching: find.byType(Material),
        ),
      );
      expect(material.shape, isA<StadiumBorder>());
      expect((material.shape! as StadiumBorder).side, BorderSide.none);
    });

    testWidgets('while Google is asked, the others step back, not vanish', (
      tester,
    ) async {
      // Tapping Google used to switch the email button off, and a switched-
      // off filled button is a pale grey smudge: the blue button under it
      // disappeared in one frame. Now it fades, keeps its colour, and only
      // stops taking taps.
      PlatformSupport.current = PlatformSupport.mobile;
      GoogleSignInPlatform.instance = _HangingGoogle();
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      // Agreed by hand: the spinner that starts behind the closing sheet
      // never settles.
      await tester.tap(find.text('Agree and continue'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // The mark has given way to a spinner; the label is still there.
      expect(find.byKey(const ValueKey('google-busy')), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);

      // Still a live, blue button -- just further away.
      final email = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(email.onPressed, isNotNull);
      final fade = tester.widget<AnimatedOpacity>(
        find
            .ancestor(
              of: find.byType(FilledButton),
              matching: find.byType(AnimatedOpacity),
            )
            .first,
      );
      expect(fade.opacity, lessThan(1));
      expect(fade.opacity, greaterThan(0.2));

      // And it does not answer while Google is being asked.
      await tester.tap(find.text('Continue with email'), warnIfMissed: false);
      // Not settled: the spinner turns for as long as the sheet is up.
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(WelcomeScreen), findsOneWidget);
      await AppLog.instance.flush();
    });

    testWidgets('says so rather than opening a browser that cannot come back', (
      tester,
    ) async {
      // Windows registers nothing for so.kyron.app://, so Google would hand
      // the finished sign-in to a scheme nothing on the machine answers.
      PlatformSupport.current = PlatformSupport.desktop;
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      await agree(tester);

      expect(auth.googleStarts, 0);
      expect(find.text('Google sign-in needs the phone app'), findsOneWidget);
      // Useful, not just apologetic: it has to name the way through.
      expect(find.textContaining('Forgot password'), findsOneWidget);
    });

    testWidgets('shows the failure when the browser will not open', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.mobile;
      auth.nextFailure = StateError('no browser');

      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      await agree(tester);
      await AppLog.instance.flush();

      expect(auth.googleStarts, 1);
      expect(
        find.textContaining('Could not open Google sign-in'),
        findsOneWidget,
      );
    });

    testWidgets('gates the email path the same way', (tester) async {
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with email'));
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      // Still on the way-in screen, not on sign-up.
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('the legal line opens the summary rather than a wall of text', (
      tester,
    ) async {
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(
        find.text('By continuing you agree to our Terms and Privacy Policy'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsOneWidget);
    });
  });

  group('the log-in screen', () {
    // "Already on Kyron? Log in" is where somebody coming back goes. It had an
    // email and a password field and nothing else, so an account made with
    // "Continue with Google" -- which has no password -- had no way in from
    // it at all.
    testWidgets('lets an account made with Google sign in with it', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.mobile;
      final sheet = _Sheet(GoogleOutcome.useBrowser);
      await tester.pumpWidget(app(const LoginScreen(), sheet: sheet));
      await tester.pumpAndSettle();

      expect(find.text('Sign in with Google'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('login-google')));
      await tester.pumpAndSettle();
      await AppLog.instance.flush();

      expect(sheet.asked, 1);
      expect(auth.googleStarts, 1,
          reason: 'the sheet could not, the browser can');
    });

    testWidgets('says so when the sheet reports a dismissal', (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(
        app(const LoginScreen(), sheet: _Sheet(GoogleOutcome.cancelled)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('login-google')));
      await tester.pumpAndSettle();

      expect(find.text('Google sign-in was cancelled.'), findsOneWidget);
      expect(auth.googleStarts, 0);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('a password that fails points a Google account the right way', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const LoginScreen()));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byType(TextFormField).first, 'ama@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'not-a-password');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Signed up with Google? Use Sign in with Google'),
        findsOneWidget,
      );
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('does not offer Google where it cannot come back', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.desktop;
      await tester.pumpWidget(app(const LoginScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(GoogleButton), findsNothing);
    });
  });

  group('the Google button', () {
    test('says one of the three things Google allows, and nothing else', () {
      expect(GoogleAction.values.map((a) => a.label), [
        'Sign in with Google',
        'Sign up with Google',
        'Continue with Google',
      ]);
    });

    testWidgets('never recolours the mark', (tester) async {
      // Recolouring it is the single thing Google's guidelines are most
      // explicit about, and the asset this replaced was three greys out of a
      // file whose own metadata called it search.svg.
      await tester.pumpWidget(
        app(const Scaffold(body: Center(child: GoogleButton(onTap: null)))),
      );
      await tester.pumpAndSettle();

      final logo = tester.widget<SvgPicture>(
        find.descendant(
          of: find.byType(GoogleButton),
          matching: find.byType(SvgPicture),
        ),
      );
      expect(logo.colorFilter, isNull);
    });
  });

  group('the mark', () {
    testWidgets('is drawn in its own colours by default', (tester) async {
      await tester.pumpWidget(app(const Scaffold(body: AppLogo(size: 32))));
      await tester.pumpAndSettle();

      final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(
        svg.colorFilter,
        isNull,
        reason: 'the home app bar flattened it to the accent blue',
      );
    });

    test('and as a silhouette is near-black by day, barely lit by night', () {
      final day = AppLogo.silhouetteColor(dark: false);
      final night = AppLogo.silhouetteColor(dark: true);

      // Blackish in daylight.
      expect(day.computeLuminance(), lessThan(0.05));

      // At night: lighter than the background it sits on, and only just.
      const ground = KyronTheme.darkBackground;
      expect(night.computeLuminance(), greaterThan(ground.computeLuminance()));
      expect(night.computeLuminance(), lessThan(0.05));
    });
  });

  group('an email address', () {
    test('may be on a top-level domain longer than four letters', () {
      // The pattern was `{2,4}`, which turned away every .online, .digital
      // and .photography address there is.
      expect(Validators.email('someone@kyron.online'), isNull);
      expect(Validators.email('someone@example.photography'), isNull);
      expect(Validators.email('first.last+tag@sub.example.co.uk'), isNull);
    });

    test('and still has to be one', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email(null), isNotNull);
      expect(Validators.email('nobody'), isNotNull);
      expect(Validators.email('nobody@'), isNotNull);
      expect(Validators.email('nobody@example'), isNotNull);
      expect(Validators.email('two people@example.com'), isNotNull);
    });
  });

  group('asking for a password reset', () {
    testWidgets('sends nothing for an address that is not one', (tester) async {
      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), 'nobody');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      expect(auth.resetsSentTo, isEmpty);
      expect(
        find.text('That does not look like an email address'),
        findsOneWidget,
      );
    });

    testWidgets('sends, and then says what happens next', (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), ' Someone@kyron.so ');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      expect(auth.resetsSentTo, ['Someone@kyron.so']);

      // The instructions are the other half of the fix: the next thing that
      // has to happen happens in a different application, minutes later.
      expect(find.textContaining('Check Someone@kyron.so'), findsOneWidget);
      expect(find.textContaining('look in spam or promotions'), findsOneWidget);
      expect(find.textContaining('one hour'), findsOneWidget);
      expect(find.text('Open the mail from Kyron'), findsOneWidget);
      expect(find.text('Tap the link inside it'), findsOneWidget);
      expect(find.text('Set a password and carry on'), findsOneWidget);

      // Careful about what it claims: Supabase answers the same way whether
      // or not an account exists, so "we sent it" would be a lie.
      expect(
        find.textContaining('If there is a Kyron account'),
        findsOneWidget,
      );
    });

    testWidgets('warns a desktop reader that the link opens on the phone', (
      tester,
    ) async {
      PlatformSupport.current = PlatformSupport.desktop;
      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), 'someone@kyron.so');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      expect(find.textContaining('not on Windows'), findsOneWidget);
    });

    testWidgets('holds the resend button down while the limiter is counting', (
      tester,
    ) async {
      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), 'someone@kyron.so');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      // Supabase refuses a second request within the minute and answers with
      // an error rather than a mail, so a Resend with no cooldown is a button
      // that mostly fails.
      expect(find.textContaining('Send again in'), findsOneWidget);
      final resend = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(resend.onPressed, isNull);

      await tester.pump(const Duration(seconds: 61));
      await tester.pumpAndSettle();
      expect(find.text('Send again'), findsOneWidget);
      expect(auth.resetsSentTo, hasLength(1));
    });

    testWidgets('shows a refusal in place, and stays on the form', (
      tester,
    ) async {
      auth.nextFailure = const AuthException(
        'For security purposes, you can only request this after 41 seconds.',
      );

      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), 'someone@kyron.so');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      // Supabase's own words, which are written for a reader.
      expect(find.textContaining('after 41 seconds'), findsOneWidget);
      // And not pretending it worked.
      expect(find.textContaining('Check someone@kyron.so'), findsNothing);
      expect(find.text('Send the link'), findsOneWidget);
    });
  });

  group('the picture', () {
    test('is the artwork itself, shipped and declared', () async {
      // Not a redrawing: the file, pixel for pixel, at the size it was made.
      final file = File(RoosterArt.asset);
      expect(file.existsSync(), isTrue);
      expect(
          File('pubspec.yaml').readAsStringSync(), contains(RoosterArt.asset));

      final codec = await ui.instantiateImageCodec(file.readAsBytesSync());
      final frame = await codec.getNextFrame();
      expect(frame.image.width, RoosterArt.imageSize.width);
      expect(frame.image.height, RoosterArt.imageSize.height);
      frame.image.dispose();
    });

    test('knows which squares hold the bird, with the eye among them', () {
      expect(RoosterArt.squares, hasLength(25));
      expect(RoosterArt.squares.every((row) => row.length == 20), isTrue);
      expect(
        RoosterArt.squares.join().split('').where((c) => c == '#'),
        hasLength(335),
      );
      expect(
        RoosterArt.squares[RoosterArt.eye.row][RoosterArt.eye.column],
        '#',
      );
    });

    test('draws every one of the cast on the rooster\'s own grid', () async {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(RoosterArt.cast.first, same(RoosterArt.member));
      expect(RoosterArt.cast.map((who) => who.name).toSet(),
          hasLength(RoosterArt.cast.length));
      for (final who in welcomeCast) {
        // The same size as the rooster, so a tile turns into the square in
        // the same place.
        final file = File(who.asset);
        expect(file.existsSync(), isTrue, reason: who.name);
        expect(pubspec, contains(who.asset), reason: who.name);
        final codec = await ui.instantiateImageCodec(file.readAsBytesSync());
        final frame = await codec.getNextFrame();
        expect(frame.image.width, RoosterArt.imageSize.width);
        expect(frame.image.height, RoosterArt.imageSize.height);
        frame.image.dispose();

        expect(who.squares, hasLength(25), reason: who.name);
        expect(who.squares.every((row) => row.length == 20), isTrue);
        expect(who.squares[who.eye.row][who.eye.column], '#',
            reason: '${who.name} flips in from a square it is in');
        // Inside the 18 rows a phone always shows, unless it is cropped by
        // the frame like the rooster.
        final below = who.squares.skip(18).join().contains('#');
        final cropped = who.squares.last.contains('#');
        expect(!below || cropped, isTrue, reason: who.name);
        // And cropped means cut by the frame, at full width -- not a stalk
        // of pale squares trailing down to it. That is what the first cat
        // was: its bottom row a third the width of its shoulders.
        if (cropped) {
          int width(String row) => '#'.allMatches(row).length;
          expect(
            width(who.squares.last),
            greaterThanOrEqualTo((width(who.squares[17]) * 0.75).floor()),
            reason: '${who.name} runs off the foot of the frame at full width',
          );
        }
      }
    });

    test('fills a phone from the right, the head clear of the status bar', () {
      final (:scale, :origin) = RoosterArt.layout(const Size(390, 380), 47);

      expect(origin.dy, 47);
      // Cropped by the right edge, as the artwork is.
      expect(
          origin.dx + RoosterArt.imageSize.width * scale, closeTo(390, 0.01));
      // The comb, head and wattles all in frame: the wattles end 975 pixels
      // down the artwork.
      expect(origin.dy + 975 * scale, lessThanOrEqualTo(380.01));
    });

    test('keeps the whole head in a wide, short window', () {
      // A close-up of the comb is what filling the width of a desktop window
      // would give. Smaller, on the right, instead.
      final (:scale, :origin) = RoosterArt.layout(const Size(1200, 380), 0);

      expect(origin.dy + 975 * scale, lessThanOrEqualTo(380.01));
      expect(origin.dx, greaterThan(600));
      expect(
          origin.dx + RoosterArt.imageSize.width * scale, closeTo(1200, 0.01));
    });

    Future<void> pumpArt(WidgetTester tester, {bool still = false}) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: const Size(390, 844),
              disableAnimations: still,
            ),
            child: const SizedBox(width: 390, height: 380, child: RoosterArt()),
          ),
        ),
      );
      // The picture decodes off the test clock.
      // The whole cast, so a flip is never waiting on one to decode.
      await tester.runAsync(() async {
        for (final who in RoosterArt.cast) {
          await precacheImage(
            AssetImage(who.asset),
            tester.element(find.byType(RoosterArt)),
          );
        }
      });
      await tester.pump();
    }

    testWidgets('arrives, holds, and flips into each of the cast in turn', (
      tester,
    ) async {
      await pumpArt(tester);
      expect(tester.hasRunningAnimations, isTrue, reason: 'arriving');

      // Holding: a timer, not an animation, so nothing repaints while the
      // picture stands still.
      await tester.pump(RoosterArt.arriving);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.hasRunningAnimations, isFalse, reason: 'holding');

      // Then the rooster turns over, tile by tile, into the cat.
      await tester.pump(RoosterArt.holding);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.hasRunningAnimations, isTrue, reason: 'flipping');

      await tester.pump(RoosterArt.flipping);
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.hasRunningAnimations, isFalse, reason: 'the cat holds');

      // Gone with the screen, timers and all.
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('holds every visitor still: nothing moves between flips', (
      tester,
    ) async {
      await pumpArt(tester);
      // A flip animates for 1.5 seconds and every hold is a timer, so
      // nothing in the loop keeps the picture moving longer than a flip.
      var streak = Duration.zero;
      var longest = Duration.zero;
      const step = Duration(milliseconds: 100);
      for (var i = 0; i < 260; i++) {
        await tester.pump(step);
        streak = tester.hasRunningAnimations ? streak + step : Duration.zero;
        if (streak > longest) longest = streak;
      }
      expect(longest, lessThanOrEqualTo(RoosterArt.flipping + step * 2));

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('is all there, and stays, when the phone asks for no motion', (
      tester,
    ) async {
      await pumpArt(tester, still: true);
      expect(tester.hasRunningAnimations, isFalse);

      // No loop either: the rooster, and nobody else.
      await tester.pump(RoosterArt.holding + RoosterArt.flipping);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.hasRunningAnimations, isFalse);
    });

    test('is cut between two rows of squares, never through one', () {
      // Whatever sits under the picture meets it with a straight edge, and
      // an edge through a row leaves a line of half-squares along it.
      for (final (size, inset) in [
        (const Size(390, 388), 47.0),
        (const Size(360, 240), 24.0),
        (const Size(412, 380), 0.0),
        (const Size(1200, 380), 0.0),
      ]) {
        final height = RoosterArt.fitHeight(size, inset);
        expect(height, lessThanOrEqualTo(size.height));
        expect(height, greaterThan(size.height - 40));

        final (:scale, :origin) =
            RoosterArt.layout(Size(size.width, height), inset);
        final rows = ((height - origin.dy) / scale - RoosterArt.gridOrigin.dy) /
            RoosterArt.pitch.height;
        expect(rows, closeTo(rows.roundToDouble(), 1e-6), reason: '$size');
        // And the head is never what gives way.
        expect(origin.dy + 975 * scale, lessThanOrEqualTo(height + 0.01));
      }
    });

    testWidgets('asks for dark status bar icons over its light ground', (
      tester,
    ) async {
      // In the dark theme too: the ground is the artwork's off-white either
      // way, and light icons would be white on white.
      await pumpArt(tester);
      final region = tester.widget<AnnotatedRegion<SystemUiOverlayStyle>>(
        find.byType(AnnotatedRegion<SystemUiOverlayStyle>).first,
      );
      expect(region.value.statusBarIconBrightness, Brightness.dark);
      await tester.pumpAndSettle();
    });

    test('nothing of the meadow it replaced is left', () {
      expect(File('pubspec.yaml').readAsStringSync(),
          isNot(contains('lib/assets/nature/')));
      expect(Directory('lib/assets/nature').existsSync(), isFalse);
    });
  });
}
