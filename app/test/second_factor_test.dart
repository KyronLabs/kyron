import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kyron_app/screens/second_factor_screen.dart';
import 'package:kyron_app/services/second_factor.dart';

/// A one-pixel QR stand-in: the screen only needs something to draw.
const _svg =
    '<svg xmlns="http://www.w3.org/2000/svg" width="1" height="1"></svg>';

class _Fake extends SecondFactor {
  _Fake({this.enrolled = false, this.passed = false})
      : super(auth: Supabase.instance.client.auth);

  bool enrolled;
  bool passed;
  final codes = <String>[];
  int removed = 0;

  @override
  Future<Factor?> verifiedFactor() async => enrolled
      ? Factor(
          id: 'f1',
          friendlyName: 'Authenticator',
          factorType: FactorType.totp,
          status: FactorStatus.verified,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
        )
      : null;

  @override
  bool get sessionPassed => passed;

  @override
  Future<({String factorId, String qrSvg, String secret})> start() async =>
      (factorId: 'f1', qrSvg: _svg, secret: 'ABCDEF123456');

  @override
  Future<void> verify(String factorId, String code) async {
    codes.add(code);
    if (code != '123456') throw const AuthException('Invalid TOTP code');
    passed = true;
  }

  @override
  Future<void> remove(String factorId) async => removed++;
}

Widget _app(Widget home) => MaterialApp(home: home);

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: 'test-anon-key',
      debug: false,
    );
  });

  testWidgets('setting up shows the code and key, and a code confirms it', (
    tester,
  ) async {
    final fake = _Fake();
    await tester.pumpWidget(_app(SecondFactorScreen(service: fake)));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('2fa-start')));
    await tester.pumpAndSettle();
    expect(find.text('ABCDEF123456'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('2fa-code')), '000000');
    await tester.ensureVisible(find.byKey(const ValueKey('2fa-confirm')));
    await tester.tap(find.byKey(const ValueKey('2fa-confirm')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.textContaining("didn't work"));
    expect(find.textContaining("didn't work"), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('2fa-code')), '123456');
    await tester.ensureVisible(find.byKey(const ValueKey('2fa-confirm')));
    await tester.tap(find.byKey(const ValueKey('2fa-confirm')));
    await tester.pumpAndSettle();
    expect(find.text('Two-step sign-in is on.'), findsOneWidget);
  });

  testWidgets('removing it asks for the code first', (tester) async {
    final fake = _Fake(enrolled: true);
    await tester.pumpWidget(_app(SecondFactorScreen(service: fake)));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('2fa-remove')));
    await tester.pumpAndSettle();
    expect(fake.removed, 0);
    await tester.enterText(find.byKey(const ValueKey('2fa-code')), '123456');
    await tester.tap(find.byKey(const ValueKey('2fa-verify')));
    await tester.pumpAndSettle();
    expect(fake.removed, 1);
  });

  group('passStaffSecondFactor', () {
    Future<bool?> run(WidgetTester tester, _Fake fake) async {
      bool? result;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async =>
                  result = await passStaffSecondFactor(context, service: fake),
              child: const Text('go'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      return result;
    }

    testWidgets('asks nothing without an enrolled authenticator', (
      tester,
    ) async {
      expect(await run(tester, _Fake()), isTrue);
    });

    testWidgets('asks nothing once the session has passed', (tester) async {
      expect(await run(tester, _Fake(enrolled: true, passed: true)), isTrue);
    });

    testWidgets('asks for the code, and lets through on the right one', (
      tester,
    ) async {
      final fake = _Fake(enrolled: true);
      bool? result;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async =>
                  result = await passStaffSecondFactor(context, service: fake),
              child: const Text('go'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('2fa-code')), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('2fa-code')), '123456');
      await tester.tap(find.byKey(const ValueKey('2fa-verify')));
      await tester.pumpAndSettle();
      expect(result, isTrue);
      expect(fake.codes, ['123456']);
    });
  });
}
