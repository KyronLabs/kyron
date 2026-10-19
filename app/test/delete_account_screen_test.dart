import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;
import 'package:kyron_app/providers/account_provider.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/repositories/account_repository.dart';
import 'package:kyron_app/routes.dart';
import 'package:kyron_app/screens/delete_account_screen.dart';
import 'package:kyron_app/screens/settings_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/toast.dart';

import 'support/signed_in_as.dart';

/// Deleting an account from Settings: what the page says goes, the second
/// question, and what happens on either answer.
class _Account extends AccountRepository {
  _Account({this.fails = false}) : super(ApiClient()..dio.interceptors.clear());

  bool fails;
  int deletes = 0;

  @override
  Future<void> delete() async {
    deletes++;
    if (fails) throw StateError('server unavailable');
  }
}

class _Auth extends AuthNotifier {
  int signedOut = 0;

  @override
  AuthState build() => AuthState.unauth();

  @override
  Future<void> accountDeleted() async => signedOut++;
}

Future<(_Account, _Auth)> _pump(WidgetTester tester,
    {bool fails = false}) async {
  final account = _Account(fails: fails);
  final auth = _Auth();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        accountRepositoryProvider.overrideWithValue(account),
        authNotifierProvider.overrideWith(() => auth),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) => MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => Scaffold(body: Text('route ${settings.name}')),
        ),
        home: const DeleteAccountScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (account, auth);
}

Future<void> _askToDelete(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('delete-account-confirm')));
  await tester.pumpAndSettle();
}

void main() {
  tearDown(Toast.dismiss);

  // Settings reads the signed-in address straight off Supabase, so the client
  // has to exist even with no session in it.
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: 'test-anon-key',
      debug: false,
    );
  });

  testWidgets('says what is deleted before anything is', (tester) async {
    await _pump(tester);

    expect(
      find.text(
        "This permanently deletes your Kyron account. It can't be undone.",
      ),
      findsOneWidget,
    );
    expect(
      find.text('Your profile, posts, replies, likes and reposts'),
      findsOneWidget,
    );
    expect(find.textContaining('including the ones you sent'), findsOneWidget);
    expect(find.textContaining('Communities you started'), findsOneWidget);
  });

  testWidgets('asks once more, and Cancel deletes nothing', (tester) async {
    final (account, auth) = await _pump(tester);

    await _askToDelete(tester);
    expect(find.text('Delete your account?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(account.deletes, 0);
    expect(auth.signedOut, 0);
    expect(find.byType(DeleteAccountScreen), findsOneWidget);
  });

  testWidgets('deletes, signs out and goes back to the start', (tester) async {
    final (account, auth) = await _pump(tester);

    await _askToDelete(tester);
    await tester.tap(find.byKey(const ValueKey('delete-account-final')));
    await tester.pump();
    await tester.pump();

    expect(account.deletes, 1);
    expect(auth.signedOut, 1);
    await tester.pumpAndSettle();
    expect(find.text('route ${Routes.home}'), findsOneWidget);
    expect(find.text('Your account has been deleted.'), findsOneWidget);

    await tester.pump(Toast.stay + const Duration(seconds: 1));
  });

  testWidgets('a failure says so, signs nobody out, and can be tried again', (
    tester,
  ) async {
    final (account, auth) = await _pump(tester, fails: true);

    await _askToDelete(tester);
    await tester.tap(find.byKey(const ValueKey('delete-account-final')));
    await tester.pumpAndSettle();

    expect(account.deletes, 1);
    expect(auth.signedOut, 0);
    expect(Toast.isShowing, isTrue);
    expect(find.byType(DeleteAccountScreen), findsOneWidget);
    await tester.pump(Toast.stay + const Duration(seconds: 1));

    // From the same screen, as the server's message tells them to.
    account.fails = false;
    await _askToDelete(tester);
    await tester.tap(find.byKey(const ValueKey('delete-account-final')));
    await tester.pumpAndSettle();

    expect(account.deletes, 2);
    expect(auth.signedOut, 1);
    await tester.pump(Toast.stay + const Duration(seconds: 1));
  });

  testWidgets('Settings has it beside signing out, and it opens this page', (
    tester,
  ) async {
    // Play requires it to be findable in the app; Settings is where people
    // look, and where a reviewer will.
    SharedPreferences.setMockInitialValues(<String, Object>{});
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(400, 4000);
    final pushed = <String?>[];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [signedInAs()],
        child: MaterialApp(
          onGenerateRoute: (settings) {
            pushed.add(settings.name);
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => const SizedBox(),
            );
          },
          home: const SettingsScreen(),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('settings-delete-account')));
    await tester.pumpAndSettle();

    expect(pushed, [Routes.deleteAccount]);
  });
}
