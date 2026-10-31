import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/rooster_art.dart';

/// A tool, not a test: draws frames of the welcome picture's loop to PNGs,
/// the arrival, a hold and the flips, to judge them by eye.
///
///     flutter test test/render_welcome_cast.dart --dart-define=shots=/tmp/x
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 380);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(
          child: SizedBox(width: 390, height: 380, child: RoosterArt()),
        ),
      ),
    );
    await tester.runAsync(() async {
      for (final who in RoosterArt.cast) {
        await precacheImage(
          AssetImage(who.asset),
          tester.element(find.byType(RoosterArt)),
        );
      }
    });

    Future<void> shoot(String name) async {
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

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await shoot('0-arriving');
    await tester.pump(RoosterArt.arriving);
    await shoot('1-rooster');
    await tester.pump(RoosterArt.holding);
    for (final ms in [225, 225, 225, 225, 225, 225]) {
      await tester.pump(Duration(milliseconds: ms));
      await shoot(
          '2-flip-${tester.binding.clock.now().millisecondsSinceEpoch}');
    }
    await tester.pump(RoosterArt.flipping);
    await shoot('3-cat');
    // On round to the butterfly, and catch its wings mid-beat.
    for (var i = 0; i < 2; i++) {
      await tester.pump(RoosterArt.visiting);
      await tester.pump(RoosterArt.flipping);
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pump(const Duration(milliseconds: 600));
    await shoot('4-butterfly-flap');
    await tester.pumpWidget(const SizedBox());
    exit(0);
  });
}
