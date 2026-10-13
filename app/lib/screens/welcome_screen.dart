import '../l10n/app_localizations.dart';

// lib/screens/welcome_screen.dart
import 'dart:async';
import 'dart:math' as math;

import '../services/google_sign_in_service.dart';
import '../services/app_log.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/auth_provider.dart';
import '../providers/preferences_provider.dart';
import '../routes.dart';
import '../services/platform_support.dart';
import '../widgets/app_button.dart';
import '../widgets/app_language_selector.dart';
import '../widgets/rooster_art.dart';
import '../widgets/google_button.dart';
import '../widgets/terms_gate.dart';

/// The first screen anybody sees, and for most people the only one they will
/// ever judge Kyron by.
///
/// It used to open with "Welcome back." over a Google button that did nothing
/// -- a greeting for a returning reader, shown to somebody who had never been
/// here, above a control that depressed and then sat there. Both are gone.
///
/// The shape is a picture the full width of the screen with the ways in
/// under it: the top says what kind of place this is and the bottom says what
/// to do about it. The picture is [RoosterArt], a rooster in big rounded
/// pixels.
///
/// The two meet at a straight edge, on the line between two rows of the
/// rooster's squares. It was a card with rounded corners and a shadow, lifted
/// over the picture -- a third shape between the two, competing with the
/// rounded squares of the art, and its shadow a grey smear across a picture
/// that has none. In light mode the ways in sit on the picture's own
/// off-white, so the edge is only there where the bird is.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

/// Which way in is busy. One at a time: two sign-ins at once is two sessions
/// racing to be the one the app keeps.
enum _Path { google, email, login }

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  _Path? _busy;

  /// The terms, once, before the first way in is taken.
  ///
  /// False means they were not agreed to, and the caller stops -- which is
  /// the difference between a gate and a notice.
  Future<bool> _agreed() =>
      TermsGate.require(context, preferences: ref.read(appPreferencesProvider));

  /// Lets go of the busy state if a sign-in that succeeded never moved the
  /// app on -- the profile could not be fetched, say -- so the screen does
  /// not sit on a spinner for ever.
  Timer? _stuck;

  @override
  void dispose() {
    _stuck?.cancel();
    super.dispose();
  }

  Future<void> _continueWithGoogle() async {
    if (_busy != null) return;

    // Before the browser opens, not after: agreeing to terms on the way back
    // from Google is agreeing to them with an account already made.
    if (!await _agreed()) return;
    if (!mounted) return;

    // Nothing on a desktop registers `so.kyron.app://`, so the consent screen
    // would open and the session would have nowhere to land. Said plainly,
    // with the way in that does work, rather than opening a browser on a
    // journey with no end.
    if (!PlatformSupport.current.authRedirect) {
      await _explainNoGoogleHere();
      return;
    }

    setState(() => _busy = _Path.google);
    var signedIn = false;
    try {
      // The device's own account picker first. On Android that is Credential
      // Manager: a sheet over Kyron listing the accounts already signed in on
      // the phone, one tap, no browser and nothing typed. It hands back an ID
      // token, which Supabase exchanges for a session on the spot -- so
      // unlike the browser flow, nothing depends on a redirect coming back.
      final google = GoogleSignInService();
      final outcome = await google.signIn();

      switch (outcome) {
        case GoogleOutcome.signedIn:
          // main.dart is listening, and replaces this screen once the profile
          // is in. The spinner stays until then: dropping it now would put
          // the buttons back, live, for the second or so before the screen
          // goes -- which reads as the sign-in having failed.
          signedIn = true;
          return;
        case GoogleOutcome.cancelled:
          // The sheet was dismissed. That is an answer, and saying anything
          // about it would be nagging.
          return;
        case GoogleOutcome.useBrowser:
          break;
      }

      // No sheet here, or the project is not registered for one. The browser
      // still works when Google's side is configured, so it is the fallback
      // rather than a dead end -- and the reason is in the log, because
      // "nothing happened" is the worst thing this could report.
      AppLog.instance.info(
        'auth',
        'Falling back to the browser for Google: ${google.reason}',
      );
      await ref.read(authNotifierProvider.notifier).startGoogleSignIn();
      // The browser has it now. The session arrives over the redirect and
      // main.dart routes on it, because by then this screen may be gone.
    } catch (error) {
      if (mounted) _sayFailed(error);
    } finally {
      // Otherwise cleared as soon as the browser is up, not when somebody
      // signs in: this screen is behind it, and a spinner left running would
      // still be running if they came back without finishing.
      if (mounted) {
        if (signedIn) {
          _stuck = Timer(const Duration(seconds: 20), () {
            if (mounted) setState(() => _busy = null);
          });
        } else {
          setState(() => _busy = null);
        }
      }
    }
  }

  void _continueWithEmail() {
    if (_busy != null) return;
    _go(_Path.email, Routes.signup);
  }

  void _logIn() {
    if (_busy != null) return;
    _go(_Path.login, Routes.login);
  }

  Future<void> _go(_Path path, String route) async {
    setState(() => _busy = path);
    final agreed = await _agreed();
    if (!mounted) return;
    setState(() => _busy = null);
    if (!agreed) return;
    Navigator.of(context).pushNamed(route);
  }

  void _sayFailed(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)
              .couldNotOpenGoogleSignIn(error.toString()),
        ),
        backgroundColor: KyronTheme.errorPink,
        duration: const Duration(seconds: 6),
      ),
    );
  }

  /// Why the Google button did not open a browser, and what to do instead.
  ///
  /// Actionable rather than apologetic: an account made with Google has an
  /// email address, and Supabase will set a password on it from the reset
  /// mail, so there is a real way through on a machine that cannot take the
  /// redirect.
  Future<void> _explainNoGoogleHere() {
    final platform = PlatformSupport.current.name;
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      // Scroll-controlled and capped rather than left to the default 9/16 of
      // the screen, which this overflowed on a small window -- a sheet whose
      // only button is under a black-and-yellow overflow bar.
      isScrollControlled: true,
      builder: (context) {
        final scheme = Theme.of(context).colorScheme;
        const side = EdgeInsets.symmetric(horizontal: SpacingTokens.space24);

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    padding: side,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .googleSignInNeedsPhoneApp,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize5,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: SpacingTokens.space12),
                        Text(
                          AppLocalizations.of(context)
                              .googleSignInDesktopExplanation(platform),
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            height: 1.5,
                            color: scheme.onSurface.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: side.copyWith(
                    top: SpacingTokens.space20,
                    bottom: SpacingTokens.space24,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(Routes.signup);
                    },
                    child: Text(AppLocalizations.of(context).continueWithEmail),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ground = _Sheet.groundOf(context);

    return Scaffold(
      // The picture runs to the very top edge, behind the status bar, which
      // is the whole point of it -- so no SafeArea out here. The ways in
      // take their own insets below.
      backgroundColor: ground,
      body: LayoutBuilder(
        builder: (context, box) {
          // Getting on for half the screen, so the picture is a picture --
          // but never more than leaves room for both ways in, which is what a
          // resized desktop window and a small phone both ask for. Then
          // brought up to the nearest line between two rows of squares, so
          // the edge under it does not cut a row in half.
          final wanted = math.max(
            120.0,
            math.min(
              box.maxHeight * 0.46,
              math.min(380.0, box.maxHeight - _sheetFloor),
            ),
          );
          final artHeight = RoosterArt.fitHeight(
            Size(box.maxWidth, wanted),
            MediaQuery.paddingOf(context).top,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: artHeight, child: const RoosterArt()),
              Expanded(
                child: _Sheet(
                  busy: _busy,
                  onGoogle: _continueWithGoogle,
                  onEmail: _continueWithEmail,
                  onLogIn: _logIn,
                  onTerms: _agreed,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// What the ways in need to hold the headline, both buttons and the footer
  /// without scrolling. Below this the picture gives way rather than the
  /// buttons going under the fold.
  static const double _sheetFloor = 400;
}

/// Everything under the picture: what Kyron is, and the three ways in.
class _Sheet extends StatelessWidget {
  final _Path? busy;
  final VoidCallback onGoogle;
  final VoidCallback onEmail;
  final VoidCallback onLogIn;
  final Future<bool> Function() onTerms;

  const _Sheet({
    required this.busy,
    required this.onGoogle,
    required this.onEmail,
    required this.onLogIn,
    required this.onTerms,
  });

  /// The picture's own off-white by day, so the ways in and the picture are
  /// one surface and the straight edge between them shows only where the
  /// bird is. The picture keeps its colours at night, so there the edge is
  /// the whole width: a photograph above the page, not a card on it.
  static Color groundOf(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? KyronTheme.darkBackground
          : RoosterArt.ground;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ink = dark ? KyronTheme.darkTextPrimary : KyronTheme.lightTextPrimary;
    final quiet =
        dark ? KyronTheme.darkTextSecondary : KyronTheme.lightTextSecondary;

    return ColoredBox(
      color: groundOf(context),
      child: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space24,
              _padTop,
              SpacingTokens.space24,
              _padBottom,
            ),
            // Centred in whatever is left over on a tall screen, and
            // scrollable on a short one. The minimum is the sheet less its
            // own padding: setting it to the whole sheet makes every screen
            // scroll by exactly the padding, which reads as a bug.
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: math.max(0, box.maxHeight - _padTop - _padBottom),
              ),
              // A phone's width at most: on a desktop window the buttons ran
              // the whole width of the screen, a metre of blue to say
              // "Continue with email".
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _maxWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context).postItSayItShowIt,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize7,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                          letterSpacing: -0.4,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space12),
                      Text(
                        AppLocalizations.of(context).textVoiceVideoPeopleRooms,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize3,
                          height: 1.45,
                          color: quiet,
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space28),
                      _Receding(
                        away: busy != null && busy != _Path.google,
                        child: GoogleButton(
                          onTap: onGoogle,
                          isLoading: busy == _Path.google,
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space12),
                      _Receding(
                        away: busy != null && busy != _Path.email,
                        child: AppButton(
                          label: AppLocalizations.of(context).continueWithEmail,
                          icon: Iconsax.sms,
                          onTap: onEmail,
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space16),
                      _Receding(
                        away: busy != null && busy != _Path.login,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).alreadyOnKyron,
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize2,
                                color: quiet,
                              ),
                            ),
                            TextButton(
                              onPressed: onLogIn,
                              style: TextButton.styleFrom(
                                minimumSize: const Size(0, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: SpacingTokens.space8,
                                ),
                              ),
                              child: Text(AppLocalizations.of(context).logIn),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: SpacingTokens.space24),
                      // The legal line opens the same summary the gate shows rather
                      // than throwing the reader straight out to a wall of clauses.
                      // Nobody has ever read a document they had to leave the screen
                      // to find; the full ones are one tap further in, for whoever
                      // wants them.
                      Center(
                        child: TextButton(
                          onPressed: () => onTerms(),
                          child: Text(
                            AppLocalizations.of(context)
                                .byContinuingAgreeTermsPrivacy,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize1,
                              fontWeight: FontWeight.w400,
                              color: quiet,
                            ),
                          ),
                        ),
                      ),
                      const Center(child: AppLanguageSelector()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Named because the minimum height above has to subtract exactly these.
  static const double _padTop = SpacingTokens.space28;
  static const double _maxWidth = 440;
  static const double _padBottom = SpacingTokens.space20;
}

/// A way in that steps back while another one is being taken.
///
/// It fades and stops taking taps, and keeps its colours. The buttons used to
/// be switched off instead, and a switched-off filled button is drawn in a
/// pale grey at a twelfth of its colour: tapping Google turned the blue
/// button under it into a smudge in a single frame, which looked like the
/// screen breaking rather than like waiting.
class _Receding extends StatelessWidget {
  final bool away;
  final Widget child;

  const _Receding({required this.away, required this.child});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: away,
      child: AnimatedOpacity(
        opacity: away ? 0.4 : 1,
        duration: KyronTheme.motionNormal,
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}
