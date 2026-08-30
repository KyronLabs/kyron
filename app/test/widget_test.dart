import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kyron_app/main.dart';

void main() {
  // KyronApp's startup calls the auth bootstrap, which reads the Supabase
  // session. main() initialises Supabase before runApp; this test builds the
  // widget directly, so it has to do the same or the first auth call throws.
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // supabase_flutter persists sessions through SharedPreferences, whose
    // platform channel is absent under flutter_test. Empty mock values give it
    // a working store with no session to restore.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: 'test-anon-key',
      debug: false,
    );
  });

  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: const KyronApp(enableLocalDatabase: false),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);

    // Complete KyronApp's startup delay so the test leaves no pending fake timers.
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();
  });
}
