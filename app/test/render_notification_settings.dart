import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/push_provider.dart';
import 'package:kyron_app/repositories/devices_repository.dart';
import 'package:kyron_app/screens/settings_subscreens.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A tool, not a test: Settings, Notifications, with the reminders switch,
/// light and dark.
///
///     flutter test test/render_notification_settings.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

class _Devices extends DevicesRepository {
  _Devices() : super(ApiClient()..dio.interceptors.clear());
  @override
  Future<bool> reminders() async => true;
}

void main() {
  testWidgets('render', (tester) async {
    SharedPreferences.setMockInitialValues({});
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family);
      for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
        loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
      }
      await loader.load();
    }
    final icons = FontLoader('packages/iconsax_flutter/FlutterIconsax');
    icons.addFont(
      rootBundle.load('packages/iconsax_flutter/fonts/FlutterIconsax.ttf'),
    );
    await icons.load();

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.reset);

    for (final dark in [false, true]) {
      await tester.pumpWidget(
        RepaintBoundary(
          child: ProviderScope(
            key: ValueKey(dark),
            overrides: [
              devicesRepositoryProvider.overrideWithValue(_Devices())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: const SettingsNotificationsScreen(),
            ),
          ),
        ),
      );
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 32));
      }
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/settings-${dark ? 'dark' : 'light'}.png')
          .writeAsBytesSync(bytes!);
    }
    exit(0);
  });
}
