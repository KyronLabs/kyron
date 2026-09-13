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
        ..addFont(Future.value(
            File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
                .readAsBytesSync()
                .buffer
                .asByteData()));
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 380);

    Future<void> shoot(String name) async {
      await tester.pumpAndSettle();
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
      await tester.pumpWidget(RepaintBoundary(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
          home: const Scaffold(body: GetStartedArt()),
        ),
      ));
      await shoot('hero-${dark ? 'dark' : 'light'}');
    }
    exit(0);
  });
}
