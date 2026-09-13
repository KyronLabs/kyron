import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Kyron's mark.
///
/// Drawn in its own colours by default. The leaf is a gradient from teal
/// through green, and flattening it to a single flat colour throws away the
/// only thing that makes it recognisable -- which is what the home screen's
/// app bar was doing, in the accent blue, on a mark that has no blue in it
/// anywhere.
class AppLogo extends StatelessWidget {
  final double size;

  /// Flattens the mark to one colour. Null draws it as it is.
  final Color? color;

  /// Draws the mark as a silhouette against the app's own background, rather
  /// than in its own colours.
  ///
  /// Near-black in daylight; at night barely a shade off the background it
  /// sits on. That asymmetry is deliberate: a splash screen is a held breath,
  /// not a billboard, and a bright logo on a dark ground at the moment the
  /// app opens is the one thing nobody wants to look at.
  final bool silhouette;

  const AppLogo({super.key, this.size = 84, this.color}) : silhouette = false;

  const AppLogo.silhouette({super.key, this.size = 84})
      : color = null,
        silhouette = true;

  /// The silhouette colour for a given theme, named so a test can assert on
  /// it without rendering.
  static Color silhouetteColor({required bool dark}) => dark
      // KyronTheme.darkBackground is 0D0D0F. This is a few steps up from it
      // and nothing more: present, not announced.
      ? const Color(0xFF2B2C2F)
      : KyronTheme.lightTextPrimary;

  @override
  Widget build(BuildContext context) {
    final tint = silhouette
        ? silhouetteColor(
            dark: Theme.of(context).brightness == Brightness.dark,
          )
        : color;

    return SvgPicture.asset(
      'lib/assets/logo.svg',
      width: size,
      height: size,
      colorFilter:
          tint == null ? null : ColorFilter.mode(tint, BlendMode.srcIn),
    );
  }
}
