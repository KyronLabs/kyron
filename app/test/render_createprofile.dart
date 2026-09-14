import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/onboarding_model.dart';
import 'package:kyron_app/screens/onboard_step1_screen.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A tool, not a test: photographs the create-profile screen so the
/// redesign can be looked at rather than described. See test/render_browser.dart
/// for the two things worth knowing: wrap toImage in runAsync, and load a font.
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    SharedPreferences.setMockInitialValues({});
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family)
        ..addFont(Future.value(
            File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
                .readAsBytesSync()
                .buffer
                .asByteData()));
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;

    /// Waits for every [Image] in the tree to actually decode.
    ///
    /// `pumpAndSettle` runs on a fake clock, and image decoding is real async
    /// on the engine's task runner, so without this every asset renders as
    /// nothing and the shot comes out empty -- which is exactly what happened
    /// the first time this hero was photographed.
    Future<void> settleImages() async {
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      await tester.pumpAndSettle();
    }

    Future<void> shoot(String name) async {
      await settleImages();
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

    // A tall phone, and a short window, because the sheet has to survive both.
    for (final size in [const Size(390, 844), const Size(420, 560)]) {
      for (final dark in [false, true]) {
        tester.view.physicalSize = size;
        await tester.pumpWidget(RepaintBoundary(
          child: ProviderScope(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: OnboardStep1Screen(model: OnboardingModel()),
            ),
          ),
        ));
        await shoot(
          'createprofile-${size.height.toInt()}-${dark ? 'dark' : 'light'}',
        );
      }
    }
    exit(0);
  });
}
