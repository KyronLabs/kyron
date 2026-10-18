import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import 'package:kyron_app/screens/settings_screen.dart';

/// Kyron draws edge to edge on every Android version (MainActivity), so the
/// navigation bar is a transparent strip over the bottom of the window rather
/// than a margin below it.
///
/// A modal bottom sheet is the place that shows: Flutter keeps a sheet clear
/// of the status bar but never of the navigation bar, so whatever sits at the
/// bottom of one -- its buttons, nearly always -- lands under the bar unless
/// the sheet makes room itself. With three-button navigation that is 48
/// pixels, and the sign-out sheet's "Log Out" was mostly underneath it.
void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: 'test-anon-key',
      debug: false,
    );
  });

  testWidgets('the sign-out sheet keeps its buttons above the navigation bar', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1.0;
    const height = 4000.0;
    tester.view.physicalSize = const Size(400, height);
    // Three-button navigation: the tallest a navigation bar gets.
    const navigationBar = 48.0;
    tester.view.padding = const FakeViewPadding(bottom: navigationBar);
    tester.view.viewPadding = const FakeViewPadding(bottom: navigationBar);

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );
    await tester.pump();

    await tester.tap(find.text('Log Out').first);
    await tester.pumpAndSettle();

    final logOut = find.widgetWithText(ElevatedButton, 'Log Out');
    final cancel = find.widgetWithText(OutlinedButton, 'Cancel');
    expect(logOut, findsOneWidget);
    expect(
      tester.getRect(logOut).bottom,
      lessThanOrEqualTo(height - navigationBar),
    );
    expect(
      tester.getRect(cancel).bottom,
      lessThanOrEqualTo(height - navigationBar),
    );

    // Closed, and the screen's own requests -- which have no server here --
    // left to give up, so nothing is still waiting when the test ends.
    await tester.tap(cancel);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 30));
  });
}
