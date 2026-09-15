import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/api_client_provider.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/screens/composer_screen.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/fake_drafts.dart';

/// The composer's top bar had no Post button on it at all, and Drafts sat on
/// top of the close button.
///
/// One cause for both. The design system's button themes set
/// `minimumSize: Size.fromHeight(40)`, which is Flutter's way of writing
/// *infinite width* -- right for the full-width call to action at the foot of
/// a form, fatal in an app bar, where the actions row hands its children an
/// unbounded width. The button asked for an infinite one, failed
/// `BoxConstraints.debugAssertIsValid`, and was never drawn; the toolbar it
/// broke put everything else in the wrong place.
void main() {
  Future<void> open(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    // The request interceptor asks Supabase for a token, and Supabase is not
    // initialised in a widget test.
    final api = ApiClient()..dio.interceptors.clear();
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // sqflite has no platform to run on under a widget test, so the
          // real draft store throws before the screen has drawn anything.
          draftServiceProvider.overrideWithValue(FakeDrafts()),
          apiClientProvider.overrideWithValue(api),
        ],
        child: MaterialApp(
          theme: KyronTheme.lightTheme,
          home: const ComposerScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('the bar lays out without an infinite width', (tester) async {
    await open(tester);
    expect(tester.takeException(), isNull,
        reason: 'the toolbar threw while laying itself out');
  });

  testWidgets('Post is on the bar and can be seen', (tester) async {
    await open(tester);

    final post = find.widgetWithText(AppBar, 'Post');
    expect(post, findsOneWidget, reason: 'there is no Post button');

    final rect = tester.getRect(find.text('Post'));
    final bar = tester.getRect(find.byType(AppBar));
    expect(rect.width, greaterThan(0));
    expect(bar.contains(rect.topLeft) && bar.contains(rect.bottomRight), isTrue,
        reason: 'Post is not inside the bar: $rect against $bar');
  });

  testWidgets('Drafts and close do not sit on top of each other',
      (tester) async {
    await open(tester);

    final drafts = tester.getRect(find.text('Drafts'));
    final close = tester.getRect(find.byTooltip('Close'));
    final post = tester.getRect(find.text('Post'));

    expect(drafts.overlaps(close), isFalse,
        reason: 'Drafts is drawn over the close button: $drafts and $close');
    expect(drafts.overlaps(post), isFalse,
        reason: 'Drafts is drawn over the Post button: $drafts and $post');

    // Close on the left, Drafts then Post on the right, in that order.
    expect(close.right, lessThan(drafts.left));
    expect(drafts.right, lessThanOrEqualTo(post.left));
  });

  testWidgets('Post is off until there is something to post', (tester) async {
    await open(tester);

    final button = tester.widget<TextButton>(
      find.ancestor(
        of: find.text('Post'),
        matching: find.byType(TextButton),
      ),
    );
    expect(button.onPressed, isNull, reason: 'an empty composer can post');

    await tester.enterText(find.byType(TextField).first, 'Tomatoes, mostly.');
    await tester.pump(const Duration(milliseconds: 200));

    final live = tester.widget<TextButton>(
      find.ancestor(
        of: find.text('Post'),
        matching: find.byType(TextButton),
      ),
    );
    expect(live.onPressed, isNotNull, reason: 'a written post cannot be sent');
  });
}
