import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kyron_app/screens/ar_lens_screen.dart';
import 'package:kyron_app/services/lens_catalogue.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tool, not a test. See test/render_browser.dart for the two things worth
/// knowing: wrap toImage in runAsync, and load a font.
///
/// Shot with no camera, which is the state the strip has to look right in
/// anyway -- every tile falls back to its colour chart, and the chrome is the
/// same chrome.
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    final temp = Directory.systemTemp.createTempSync('ar-shot');
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
    tester.view.physicalSize = const Size(390, 844);

    for (final dark in [false, true]) {
      await tester.pumpWidget(RepaintBoundary(
        child: ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
            home: ArLensScreen(
              cameras: const [],
              catalogue: LensCatalogue(
                client: MockClient((_) async => http.Response('', 503)),
                directory: () async => temp,
              ),
            ),
          ),
        ),
      ));
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
      File('$out/ar-${dark ? 'dark' : 'light'}.png').writeAsBytesSync(bytes!);
    }
    exit(0);
  });
}
