import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/composer_screen.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Not a test -- a tool, like render_community.dart:
///
///     flutter test test/render_composer.dart --dart-define=shots=/tmp/shots
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    SharedPreferences.setMockInitialValues({});
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family)
        ..addFont(Future.value(
          File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
              .readAsBytesSync()
              .buffer
              .asByteData(),
        ));
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);

    Future<void> shoot(String name) async {
      await tester.pump(const Duration(milliseconds: 400));
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 2);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/$name.png').writeAsBytesSync(bytes!);
    }

    for (final dark in [false, true]) {
      for (final typed in [false, true]) {
        await tester.pumpWidget(
          RepaintBoundary(
            child: ProviderScope(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
                home: const ComposerScreen(),
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        if (typed) {
          final field = find.byType(TextField);
          if (field.evaluate().isNotEmpty) {
            await tester.enterText(field.first, 'Tomatoes, mostly.');
            await tester.pump(const Duration(milliseconds: 200));
          }
        }
        await shoot(
            'composer-${dark ? 'dark' : 'light'}-${typed ? 'typed' : 'empty'}');
      }
    }

    exit(0);
  });
}
