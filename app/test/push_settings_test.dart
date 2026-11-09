import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/push_provider.dart';
import 'package:kyron_app/repositories/devices_repository.dart';
import 'package:kyron_app/screens/settings_subscreens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/push_registrar.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The Notifications screen: a switch that does what it says, and a test
/// that names which part of push is not working.
class _Push extends PushRegistrar {
  _Push() : super(DevicesRepository(ApiClient()));
  int starts = 0;
  int stops = 0;

  @override
  Future<void> start() async => starts++;

  @override
  Future<void> stop() async => stops++;
}

class _Devices extends DevicesRepository {
  _Devices(this.answer, {this.remind = true})
      : super(ApiClient()..dio.interceptors.clear());
  final PushTest answer;
  bool remind;
  final saved = <bool>[];

  @override
  Future<PushTest> test() async => answer;

  @override
  Future<bool> reminders() async => remind;

  @override
  Future<bool> setReminders(bool on) async {
    saved.add(on);
    return remind = on;
  }
}

Future<_Push> _pump(
  WidgetTester tester,
  PushTest answer, {
  _Devices? devices,
}) async {
  final push = _Push();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        pushRegistrarProvider.overrideWithValue(push),
        devicesRepositoryProvider.overrideWithValue(
          devices ?? _Devices(answer),
        ),
      ],
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: const SettingsNotificationsScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return push;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('turning notifications off takes this phone off the list', (
    tester,
  ) async {
    final push = await _pump(
      tester,
      const PushTest(configured: true, devices: 1, delivered: 1),
    );

    await tester.tap(find.byKey(const ValueKey('push-switch')));
    await tester.pumpAndSettle();
    expect(push.stops, 1);

    await tester.tap(find.byKey(const ValueKey('push-switch')));
    await tester.pumpAndSettle();
    expect(push.starts, 1);
  });

  for (final (answer, says) in [
    (
      const PushTest(configured: false, devices: 1, delivered: 0),
      "server is not set up",
    ),
    (
      const PushTest(configured: true, devices: 0, delivered: 0),
      'not registered',
    ),
    (const PushTest(configured: true, devices: 1, delivered: 1), 'Sent.'),
  ]) {
    testWidgets('a test notification says "$says"', (tester) async {
      await _pump(tester, answer);

      await tester.tap(find.byKey(const ValueKey('push-test')));
      await tester.pumpAndSettle();

      expect(find.textContaining(says), findsOneWidget);
      await tester.pump(const Duration(seconds: 7));
    });
  }

  testWidgets('reminders show what the account has, and change it', (
    tester,
  ) async {
    const ok = PushTest(configured: true, devices: 1, delivered: 1);
    final devices = _Devices(ok, remind: false);
    await _pump(tester, ok, devices: devices);

    SwitchListTile tile() => tester.widget<SwitchListTile>(
          find.byKey(const ValueKey('reminders-switch')),
        );
    expect(tile().value, isFalse);
    expect(find.text('Reminders'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('reminders-switch')));
    await tester.pumpAndSettle();
    expect(devices.saved, [true]);
    expect(tile().value, isTrue);
  });
}
