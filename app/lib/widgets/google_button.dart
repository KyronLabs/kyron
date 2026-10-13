import '../l10n/app_localizations.dart';

// lib/widgets/google_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// What the button may say.
///
/// Google's branding guidelines allow these three and no others: not "Log in
/// with Google", not "Google", not a bare G on a coloured pill.
enum GoogleAction {
  signIn,
  signUp,
  continueWith;

  String get label => switch (this) {
        GoogleAction.signIn => 'Sign in with Google',
        GoogleAction.signUp => 'Sign up with Google',
        GoogleAction.continueWith => 'Continue with Google',
      };

  String localizedLabel(BuildContext context) => switch (this) {
        GoogleAction.signIn => AppLocalizations.of(context).googleSignIn,
        GoogleAction.signUp => AppLocalizations.of(context).googleSignUp,
        GoogleAction.continueWith =>
          AppLocalizations.of(context).googleContinue,
      };
}

/// Sign in with Google, drawn the way Google requires.
///
/// A solid pill, the same height as every other button on the screen it
/// sits on. It was the white, outlined version of Google's button, eight
/// pixels taller than the email button under it, and next to Kyron's filled
/// buttons it read as an unfinished form field rather than a way in.
///
/// Google's guidelines are specific, and an app that gets them wrong can have
/// its OAuth client suspended, so the colours are theirs rather than ours:
///
///   light screens   #131314 ground, #E3E3E3 text   (Google's dark button)
///   dark screens    #F2F2F2 ground, #1F1F1F text   (Google's neutral one)
///   type            Roboto Medium, 14
///   logo            18 high, 12 clear of the text, never recoloured
///   height          at least 40
///
/// Black on a light screen and light on a dark one is how Kyron fills its
/// own strongest buttons too, so this is one of ours that happens to say
/// Google. The dark button's one-pixel grey rim is left off: it is there to
/// stop a near-black button vanishing into a near-black screen, and on a
/// light screen the button's own edge does that.
///
/// The corner radius is the one real choice: Google allows a 4 square or a
/// full pill. Kyron's other buttons are pills, so this is one too.
class GoogleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final GoogleAction action;

  /// The mark gives way to a spinner while Google is being asked, and the
  /// label stays put: the reader can still see what they pressed, and the
  /// button does not change size, so nothing around it moves.
  final bool isLoading;

  const GoogleButton({
    super.key,
    required this.onTap,
    this.action = GoogleAction.continueWith,
    this.isLoading = false,
  });

  /// The theme's button height, so it lines up with the button under it.
  static const double height = KyronTheme.buttonHeight;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final ground = dark ? const Color(0xFFF2F2F2) : const Color(0xFF131314);
    final ink = dark ? const Color(0xFF1F1F1F) : const Color(0xFFE3E3E3);

    return Semantics(
      button: true,
      enabled: onTap != null && !isLoading,
      label: action.localizedLabel(context),
      excludeSemantics: true,
      child: Material(
        color: ground,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          // A press darkens or lightens the whole pill a touch, rather than
          // a ripple of the wrong colour spreading across it.
          splashFactory: NoSplash.splashFactory,
          highlightColor: ink.withValues(alpha: 0.10),
          child: SizedBox(
            height: height,
            child: Padding(
              // Google asks for 12 either side of the content.
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 18,
                    child: AnimatedSwitcher(
                      duration: KyronTheme.motionFast,
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween(begin: 0.6, end: 1.0).animate(animation),
                          child: child,
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              key: const ValueKey('google-busy'),
                              strokeWidth: 2,
                              strokeCap: StrokeCap.round,
                              valueColor: AlwaysStoppedAnimation<Color>(ink),
                            )
                          // Never given a colorFilter: the mark is four
                          // colours and recolouring it breaks the terms it is
                          // used under.
                          : SvgPicture.asset(
                              'lib/assets/google_g.svg',
                              key: const ValueKey('google-mark'),
                              width: 18,
                              height: 18,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      action.localizedLabel(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // Roboto is Google's requirement. Naming it here
                        // rather than inheriting Kyron's face is deliberate:
                        // this button belongs to Google's identity, not ours.
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.25,
                        color: ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
