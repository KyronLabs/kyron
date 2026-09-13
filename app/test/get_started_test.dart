import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/repositories/auth_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/forgot_password_screen.dart';
import 'package:kyron_app/screens/welcome_screen.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:kyron_app/services/platform_support.dart';
import 'package:kyron_app/utils/validators.dart';
import 'package:kyron_app/widgets/app_logo.dart';
import 'package:kyron_app/widgets/google_button.dart';
import 'package:kyron_app/widgets/terms_gate.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

/// The way into Kyron, which until now greeted a first-time reader with
/// "Welcome back." over a Google button wired to a comment.
///
/// Everything here is about the first two minutes: what the screen says, what
/// the buttons actually do, what somebody agrees to before any of it, and what
/// happens when the one flow that leaves the app -- a password reset -- has to
/// be finished somewhere else.

/// Records what was asked of Supabase without going near it.
class _FakeAuth extends AuthRepository {
  int googleStarts = 0;
  final resetsSentTo = <String>[];

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

  Widget app(Widget home) => ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(auth)],
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
    testWidgets('asks before the first way in, and takes no for an answer',
        (tester) async {
      final prefs = AppPreferences();
      bool? answer;

      await tester.pumpWidget(app(Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            answer = await TermsGate.require(context, preferences: prefs);
          },
          child: const Text('go'),
        ),
      )));

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsOneWidget);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();

      expect(answer, isFalse, reason: 'a gate that lets you through is a sign');
      expect(await prefs.readTermsAcceptedAt(), isNull);
    });

    testWidgets('records when, and never asks that reader again',
        (tester) async {
      final prefs = AppPreferences();
      final answers = <bool>[];

      await tester.pumpWidget(app(Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            answers.add(await TermsGate.require(context, preferences: prefs));
          },
          child: const Text('go'),
        ),
      )));

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      await agree(tester);

      expect(answers, [true]);
      // A date rather than a flag: the terms change, and a stored `true` says
      // nothing about which version anybody read.
      final accepted = await prefs.readTermsAcceptedAt();
      expect(accepted, isNotNull);
      expect(
        DateTime.now().difference(accepted!).inMinutes,
        lessThan(1),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsNothing);
      expect(answers, [true, true]);
    });

    testWidgets('says the three things that matter and links the documents',
        (tester) async {
      await tester.pumpWidget(app(Builder(
        builder: (context) => TextButton(
          onPressed: () =>
              TermsGate.require(context, preferences: AppPreferences()),
          child: const Text('go'),
        ),
      )));
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
    testWidgets('never greets a first-timer as a returning one',
        (tester) async {
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

    testWidgets('starts no sign-in until the terms are agreed to',
        (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();

      expect(find.text('Before you start'), findsOneWidget);
      expect(auth.googleStarts, 0);

      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(auth.googleStarts, 0,
          reason: 'declining the terms has to stop the sign-in');
    });

    testWidgets('and starts one once they are', (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      await agree(tester);

      expect(auth.googleStarts, 1);
    });

    testWidgets('says so rather than opening a browser that cannot come back',
        (tester) async {
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

    testWidgets('shows the failure when the browser will not open',
        (tester) async {
      PlatformSupport.current = PlatformSupport.mobile;
      auth.nextFailure = StateError('no browser');

      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();
      await agree(tester);

      expect(auth.googleStarts, 1);
      expect(
          find.textContaining('Could not open Google sign-in'), findsOneWidget);
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

    testWidgets('the legal line opens the summary rather than a wall of text',
        (tester) async {
      await tester.pumpWidget(app(const WelcomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(
        find.text('By continuing you agree to our Terms and Privacy Policy'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Before you start'), findsOneWidget);
    });
  });

  group('the Google button', () {
    test('says one of the three things Google allows, and nothing else', () {
      expect(
        GoogleAction.values.map((a) => a.label),
        ['Sign in with Google', 'Sign up with Google', 'Continue with Google'],
      );
    });

    testWidgets('never recolours the mark', (tester) async {
      // Recolouring it is the single thing Google's guidelines are most
      // explicit about, and the asset this replaced was three greys out of a
      // file whose own metadata called it search.svg.
      await tester.pumpWidget(app(
        const Scaffold(body: Center(child: GoogleButton(onTap: null))),
      ));
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
      expect(svg.colorFilter, isNull,
          reason: 'the home app bar flattened it to the accent blue');
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
      expect(find.text('That does not look like an email address'),
          findsOneWidget);
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
          find.textContaining('If there is a Kyron account'), findsOneWidget);
    });

    testWidgets('warns a desktop reader that the link opens on the phone',
        (tester) async {
      PlatformSupport.current = PlatformSupport.desktop;
      await tester.pumpWidget(app(const ForgotPasswordScreen()));
      await tester.enterText(find.byType(TextFormField), 'someone@kyron.so');
      await tester.tap(find.text('Send the link'));
      await tester.pumpAndSettle();

      expect(find.textContaining('not on Windows'), findsOneWidget);
    });

    testWidgets('holds the resend button down while the limiter is counting',
        (tester) async {
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

    testWidgets('shows a refusal in place, and stays on the form',
        (tester) async {
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
}
