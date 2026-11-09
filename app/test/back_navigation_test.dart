import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/main_container.dart';
import 'package:kyron_app/widgets/nav_destinations.dart';

/// Back on the signed-in app never closes it by accident.
void main() {
  final now = DateTime(2026, 11, 9, 12);
  final home = NavDestinations.home.index;

  BackStep step({
    bool drawer = false,
    int? tab,
    DateTime? asked,
  }) =>
      backStep(drawerOpen: drawer, tab: tab ?? home, askedAt: asked, now: now);

  test('an open drawer closes first, on any tab', () {
    expect(step(drawer: true), BackStep.closeDrawer);
    expect(
      step(drawer: true, tab: NavDestinations.messages.index),
      BackStep.closeDrawer,
    );
  });

  test('from any other tab, back goes Home', () {
    for (final tab in [
      NavDestinations.explore,
      NavDestinations.communities,
      NavDestinations.messages,
    ]) {
      expect(step(tab: tab.index), BackStep.goHome, reason: '${tab.index}');
    }
  });

  test('on Home, the first press asks; only a second, soon, leaves', () {
    expect(step(), BackStep.askAgain);
    expect(
      step(asked: now.subtract(const Duration(milliseconds: 800))),
      BackStep.leave,
    );
    // Too long after: asked again, not gone.
    expect(step(asked: now.subtract(const Duration(seconds: 3))),
        BackStep.askAgain);
  });
}
