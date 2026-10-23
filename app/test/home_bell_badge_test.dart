import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/notifications_provider.dart';
import 'package:kyron_app/widgets/nav_destinations.dart';
import 'package:kyron_app/widgets/top_edge.dart';

/// The bell at the top of the home screen counts the way the Messages tab
/// does.
///
/// It drew a badge of its own: the theme's error colour, two pixels smaller,
/// and pinned to the corner of its 32-pixel button rather than to the bell,
/// so it sat off to the side of the icon.
class _Me extends CurrentUserNotifier {
  _Me(super.ref);

  @override
  Future<void> load({bool force = false}) async {
    state = const AsyncData(
      CurrentUser(
        id: 'me',
        username: 'me',
        followers: 0,
        following: 0,
        posts: 0,
      ),
    );
  }
}

void main() {
  Future<void> bar(WidgetTester tester, int unread) => tester.pumpWidget(
        ProviderScope(
          // A scope of its own each time: the same one would keep the count
          // it read first.
          key: ValueKey(unread),
          overrides: [
            currentUserProvider.overrideWith(_Me.new),
            unreadNotificationsProvider.overrideWith((ref) async => unread),
          ],
          child: const MaterialApp(home: Scaffold(body: TopEdge())),
        ),
      );

  testWidgets('it is the Messages tab badge: the same red, the same size', (
    tester,
  ) async {
    await bar(tester, 3);
    await tester.pump();

    final bell = find.byKey(const ValueKey('home-notifications'));
    final badge = find.descendant(
      of: bell,
      matching: find.byKey(const ValueKey('nav-badge')),
    );
    expect(badge, findsOneWidget);
    expect(find.descendant(of: badge, matching: find.text('3')), findsOne);

    final box = tester.widget<Container>(badge).decoration! as BoxDecoration;
    expect(box.color, NavBadge.red);
    expect(tester.getSize(badge).height, 18);
  });

  testWidgets('it sits on the bell, where the tab puts its own', (
    tester,
  ) async {
    await bar(tester, 3);
    await tester.pump();

    final icon = tester.getRect(
      find.descendant(
        of: find.byKey(const ValueKey('home-notifications')),
        matching: find.byType(Icon),
      ),
    );
    final badge = tester.getRect(find.byKey(const ValueKey('nav-badge')));
    // Measured from the icon, not from the button around it.
    expect(badge.top - icon.top, -5);
    expect(badge.right - icon.right, 9);
  });

  testWidgets('past nine it says 9+, and at none it is not there', (
    tester,
  ) async {
    await bar(tester, 40);
    await tester.pump();
    expect(find.text('9+'), findsOneWidget);

    await bar(tester, 0);
    await tester.pump();
    expect(find.byKey(const ValueKey('nav-badge')), findsNothing);
  });
}
