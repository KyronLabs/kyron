import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/profile_screen.dart';
import 'package:kyron_app/widgets/sliding_drawer_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/signed_in_as.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  for (final followers in [true, false]) {
    testWidgets(
        'the drawer opens your ${followers ? 'followers' : 'following'}', (
      tester,
    ) async {
      var closed = 0;
      final opened = <RouteSettings>[];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [signedInAs()],
          child: MaterialApp(
            onGenerateRoute: (settings) {
              opened.add(settings);
              return MaterialPageRoute(builder: (_) => const SizedBox());
            },
            home: Scaffold(
              body: SlidingDrawerContent(onCloseDrawer: () => closed++),
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(
        find.byKey(
          ValueKey(followers ? 'drawer-followers' : 'drawer-following'),
        ),
      );
      await tester.pump();

      expect(closed, 1);
      final route = opened.last;
      expect(route.name, followers ? Routes.followers : Routes.following);
      final args = route.arguments as FollowListArgs;
      expect(args.userId, 'me');
      expect(args.followers, followers);
    });
  }
}
