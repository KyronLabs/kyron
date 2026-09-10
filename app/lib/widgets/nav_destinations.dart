// lib/widgets/nav_destinations.dart
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
