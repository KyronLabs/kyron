import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// One of the four places the app can be.
class NavDestination {
  final IconData icon;

  /// Drawn instead of [icon] for the destination being read. Colour alone is
  /// a weak signal, and no signal at all to a reader who cannot separate the
  /// two hues.
  final IconData activeIcon;

  final String label;

  /// Which page [MainContainer] shows for it. Two and only two things know
  /// these numbers -- this list and the switch that reads it.
  final int index;

  String localizedLabel(BuildContext context) => switch (index) {
        0 => AppLocalizations.of(context).home,
        1 => AppLocalizations.of(context).explore,
        3 => AppLocalizations.of(context).communities,
        4 => AppLocalizations.of(context).messages,
        _ => label,
      };

  const NavDestination({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
  });
}

/// Where Kyron can go, written once.
///
/// The bar along the bottom of a phone and the rail down the side of a window
/// are two drawings of the same four places. They were one list hard-coded
/// inside the bar, which is fine until there are two of them and a destination
/// is added to one.
abstract final class NavDestinations {
  static const home = NavDestination(
    icon: Iconsax.home_copy,
    activeIcon: Iconsax.home,
    label: 'Home',
    index: 0,
  );

  static const explore = NavDestination(
    icon: Iconsax.discover_copy,
    activeIcon: Iconsax.discover,
    label: 'Explore',
    index: 1,
  );

  // 2 is the compose button, which is not a destination: it opens a sheet and
  // leaves you where you were.

  static const communities = NavDestination(
    icon: Iconsax.people_copy,
    activeIcon: Iconsax.people,
    label: 'Communities',
    index: 3,
  );

  static const messages = NavDestination(
    icon: Iconsax.message_copy,
    activeIcon: Iconsax.message,
    label: 'Messages',
    index: 4,
  );

  static const all = <NavDestination>[home, explore, communities, messages];

  /// The index the compose button sits at in the bottom bar.
  static const int composeIndex = 2;
}

/// How many of something are waiting behind a destination, on its icon.
///
/// Red, which is what every phone has taught people a waiting count looks
/// like, with a ring of the bar's own colour round it so it reads as sitting
/// on the icon rather than smudged into it. Nothing at all at zero. Nine and
/// over is "9+": past that the number is not news, the fact is.
class NavBadge extends StatelessWidget {
  final int count;
  final Widget child;

  const NavBadge({super.key, required this.count, required this.child});

  static const red = Color(0xFFFF3B30);

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    final dark = Theme.of(context).brightness == Brightness.dark;
    // The bar's and the rail's own surface.
    final ring = dark ? KyronTheme.darkSurface : KyronTheme.lightSurface;
    final text = count > 9 ? '9+' : '$count';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -5,
          right: -9,
          child: Container(
            key: const ValueKey('nav-badge'),
            constraints: const BoxConstraints(minWidth: 18),
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: ring, width: 2),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9.5,
                height: 1,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
