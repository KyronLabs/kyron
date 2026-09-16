import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/get_started_art.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test. See test/render_browser.dart for the two things worth
/// knowing: wrap toImage in runAsync, and load a font.
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family)
        ..addFont(
          Future.value(
            File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
                .readAsBytesSync()
                .buffer
                .asByteData(),
          ),
        );
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

    // The tall phone, and the letterbox a short desktop window leaves. The
    // second is the one that catches a composition that only works square.
    for (final size in [const Size(390, 380), const Size(420, 160)]) {
      for (final dark in [false, true]) {
        tester.view.physicalSize = size;
        await tester.pumpWidget(
          RepaintBoundary(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
              home: const Scaffold(body: GetStartedArt()),
            ),
          ),
        );
        await shoot('hero-${size.height.toInt()}-${dark ? 'dark' : 'light'}');
      }
    }
    exit(0);
  });
}
