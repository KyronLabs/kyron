// lib/widgets/google_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// What the button may say.
///
/// Google's branding guidelines allow these three and no others: not "Log in
/// with Google", not "Google", not a bare G on a coloured pill.
enum GoogleAction {
  signIn('Sign in with Google'),
  signUp('Sign up with Google'),
  continueWith('Continue with Google');

  const GoogleAction(this.label);

  final String label;
}

/// Sign in with Google, drawn the way Google requires.
///
/// The version this replaced met almost none of it. Its logo was not Google's
/// -- three greys, and `search.svg` in its own metadata -- the text was pure
/// black on pure white with no border, and the corner radius, the type size
/// and the gap to the logo were all somebody's guess. Google's guidelines are
/// specific about every one of those, and an app that gets them wrong can have
/// its OAuth client suspended, so the numbers below are theirs rather than
/// ours:
///
///   light   #FFFFFF ground, #747775 border, #1F1F1F text
///   dark    #131314 ground, #8E918F border, #E3E3E3 text
///   type    Roboto Medium, 14
///   logo    18 high, 12 clear of the text, never recoloured
///   height  at least 40
///
/// The corner radius is the one real choice: Google allows a 4 square or a
/// full pill. Kyron's other buttons are pills, so this is one too.
class GoogleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final GoogleAction action;

  /// Swaps the label for a spinner while the browser is opening. The button
  /// stays exactly the same size, so the column does not jump.
  final bool isLoading;

  const GoogleButton({
    super.key,
    required this.onTap,
    this.action = GoogleAction.continueWith,
    this.isLoading = false,
  });

  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final ground = dark ? const Color(0xFF131314) : const Color(0xFFFFFFFF);
    final edge = dark ? const Color(0xFF8E918F) : const Color(0xFF747775);
    final ink = dark ? const Color(0xFFE3E3E3) : const Color(0xFF1F1F1F);

    return Semantics(
      button: true,
      enabled: onTap != null && !isLoading,
      label: action.label,
      excludeSemantics: true,
      child: Material(
        color: ground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height / 2),
          side: BorderSide(color: edge),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          child: SizedBox(
            height: height,
            child: Padding(
              // Google asks for 12 either side of the content.
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Never given a colorFilter: the mark is four colours and
                  // recolouring it breaks the terms it is used under.
                  SvgPicture.asset(
                    'lib/assets/google_g.svg',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 12),
                  if (isLoading)
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(ink),
                      ),
                    )
                  else
                    Text(
                      action.label,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
