// lib/screens/welcome_screen.dart
import 'dart:math' as math;

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
import '../widgets/get_started_art.dart';
import '../widgets/google_button.dart';
import '../widgets/terms_gate.dart';

/// The first screen anybody sees, and for most people the only one they will
/// ever judge Kyron by.
///
/// It used to open with "Welcome back." over a Google button that did nothing
/// -- a greeting for a returning reader, shown to somebody who had never been
/// here, above a control that depressed and then sat there. Both are gone.
///
/// The shape is a picture the full width of the screen with a sheet of
/// content lifted over it, because that is what the reader already knows from
/// every app that does this well: the top says what kind of place this is and
/// the bottom says what to do about it. The picture is [GetStartedArt], drawn
/// rather than shipped, so it is right in both themes and at any size.
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
  Future<bool> _agreed() => TermsGate.require(
        context,
        preferences: ref.read(appPreferencesProvider),
      );

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
    try {
      await ref.read(authNotifierProvider.notifier).startGoogleSignIn();
      // The browser has it now. The session arrives over the redirect and
      // main.dart routes on it, because by then this screen may be gone.
    } catch (error) {
      if (mounted) _sayFailed(error);
    } finally {
      // Cleared as soon as the browser is up, not when somebody signs in:
      // this screen is behind it, and a spinner left running would still be
      // running if they came back without finishing.
      if (mounted) setState(() => _busy = null);
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
        content: Text('Could not open Google sign-in. $error'),
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
                          'Google sign-in needs the phone app',
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize5,
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: SpacingTokens.space12),
                        Text(
                          'Google hands the finished sign-in back to Kyron '
                          'over a link only Android and iOS answer, so on '
                          '$platform the browser would have nowhere to return '
                          'it to.\n\n'
                          'If you already have a Kyron account through Google, '
                          'use Continue with email with that same address and '
                          'tap Forgot password — it will mail you a link to '
                          'set one.',
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
                    child: const Text('Continue with email'),
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
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // The picture runs to the very top edge, behind the status bar, which
      // is the whole point of it -- so no SafeArea out here. The sheet takes
      // its own insets below.
      backgroundColor: dark ? KyronTheme.darkBackground : Colors.white,
      body: LayoutBuilder(
        builder: (context, box) {
          // Getting on for half the screen, so the picture is a picture --
          // but never more than leaves the sheet room for both ways in, which
          // is what a resized desktop window and a small phone both ask for.
          final artHeight = math.max(
            120.0,
            math.min(
              box.maxHeight * 0.46,
              math.min(380.0, box.maxHeight - _sheetFloor),
            ),
          );

          // Both children positioned, and the fit explicit. A bare Stack
          // sizes itself to its largest *unpositioned* child, so putting the
          // picture in as a plain SizedBox made the whole Stack as tall as
          // the picture -- and the sheet, pinned to its bottom, came out 28
          // pixels high and clipped away everything in it. The screen laid
          // out perfectly and rendered as an empty white page.
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: artHeight,
                child: const GetStartedArt(),
              ),
              Positioned(
                // Lifted over the picture so the two are one thing rather than
                // a photograph with a form under it.
                top: artHeight - _overlap,
                left: 0,
                right: 0,
                bottom: 0,
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

  static const double _overlap = 28;

  /// What the sheet needs to hold the headline, both buttons and the footer
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

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ground = dark ? KyronTheme.darkBackground : Colors.white;
    final ink = dark ? KyronTheme.darkTextPrimary : KyronTheme.lightTextPrimary;
    final quiet =
        dark ? KyronTheme.darkTextSecondary : KyronTheme.lightTextSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(RadiusTokens.radius20 + 8),
        ),
        // A lifted edge rather than a drawn line: the picture behind it is
        // busy, and a hairline over that reads as a seam.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.45 : 0.10),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Post it, say it, show it.',
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
                    'Text, voice and video, the people who make them, and the '
                    'rooms they talk in.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      height: 1.45,
                      color: quiet,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space28),
                  GoogleButton(
                    onTap: onGoogle,
                    isLoading: busy == _Path.google,
                  ),
                  const SizedBox(height: SpacingTokens.space12),
                  AppButton(
                    label: 'Continue with email',
                    icon: Iconsax.sms,
                    onTap: onEmail,
                    enabled: busy == null,
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already on Kyron?',
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          color: quiet,
                        ),
                      ),
                      TextButton(
                        onPressed: busy == null ? onLogIn : null,
                        style: TextButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpacingTokens.space8,
                          ),
                        ),
                        child: const Text('Log in'),
                      ),
                    ],
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
                        'By continuing you agree to our Terms and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight: FontWeight.w400,
                          color: quiet,
                        ),
                      ),
                    ),
                  ),
                  Center(child: AppLanguageSelector()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Named because the minimum height above has to subtract exactly these.
  static const double _padTop = SpacingTokens.space28;
  static const double _padBottom = SpacingTokens.space20;
}
