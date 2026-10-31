import 'dart:io';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/lens.dart';
import 'package:kyron_app/screens/ar_lens_screen.dart';
import 'package:kyron_app/services/lens_catalogue.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A catalogue that reaches nothing.
///
/// Without this the screen builds a real one, which asks the platform for a
/// directory and the network for a file -- so the test would be measuring
/// whether those fail rather than what the screen does, and would drift the
/// day a catalogue is actually reachable from CI.
LensCatalogue offline(Directory temp) => LensCatalogue(
      client: MockClient((_) async => http.Response('', 503)),
      directory: () async => temp,
    );

Widget screen(List<CameraDescription> cameras, Directory temp) => ProviderScope(
      child: MaterialApp(
        home: ArLensScreen(cameras: cameras, catalogue: offline(temp)),
      ),
    );

void main() {
  late Directory temp;

  setUp(() => temp = Directory.systemTemp.createTempSync('ar'));
  tearDown(() => temp.deleteSync(recursive: true));

  testWidgets('says so on a device with no camera, rather than spinning', (
    tester,
  ) async {
    // The state a tablet without one lands in. A viewfinder that never
    // arrives reads as the app having hung.
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    expect(find.text('The camera is closed'), findsOneWidget);
    expect(find.text('This device has no camera.'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('offers the lenses, with none selected first', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    // The strip scrolls through the shutter, so only the lenses near it are
    // built at once. The first few are enough to show the order and labels.
    for (final lens in Lens.builtIn.take(4)) {
      final label = lens.needsFace ? '${lens.name}, face lens' : lens.name;
      expect(find.bySemanticsLabel(label), findsOneWidget, reason: lens.id);
    }
    expect(find.text(Lens.builtIn.first.name), findsOneWidget);
  });

  testWidgets('glasses are in the strip, as face lenses', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();
    expect(find.bySemanticsLabel('Specs, face lens'), findsOneWidget);
  });

  testWidgets('keeps the shutter inert while there is no camera', (
    tester,
  ) async {
    // Tapping it would take a picture with nothing to take it from.
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('Take a picture'));
    await tester.pump();

    // Still on the same screen, with the same message, and nothing thrown.
    expect(find.text('The camera is closed'), findsOneWidget);
  });

  testWidgets('does not offer to switch when there is only one camera', (
    tester,
  ) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    expect(find.byTooltip('Switch camera'), findsNothing);
  });

  testWidgets('swiping to a lens, or tapping it, puts it on', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    /// The ring around a tile, which is the whole visible signal.
    Color ringOf(String label) {
      final box = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.bySemanticsLabel(label),
          matching: find.byType(AnimatedContainer),
        ),
      );
      return (box.decoration! as BoxDecoration).border!.top.color;
    }

    expect(ringOf('None'), Colors.white);
    expect(ringOf('Specs, face lens'), Colors.white24);

    await tester.tap(find.bySemanticsLabel('Specs, face lens'));
    // Past the strip's slide to the middle and the tile's transition.
    await tester.pumpAndSettle();

    expect(ringOf('Specs, face lens'), Colors.white);
    expect(ringOf('None'), Colors.white24);
    // And the name over the shutter follows the selection.
    expect(find.text('Specs'), findsOneWidget);
    expect(find.text('None'), findsNothing);
  });

  testWidgets('has no title bar: the picture is the whole screen', (
    tester,
  ) async {
    for (final theme in [KyronTheme.lightTheme, KyronTheme.darkTheme]) {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: theme,
            home: ArLensScreen(cameras: const [], catalogue: offline(temp)),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AppBar), findsNothing);
      expect(find.text('AR Lens'), findsNothing);
      // The way out is still there, floating on the picture.
      expect(find.byTooltip('Close'), findsOneWidget);
    }
  });

  testWidgets('video mode takes the lens off and says so', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.text('Video'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.bySemanticsLabel('Record a video'), findsOneWidget);
    expect(find.text('Lenses are for photos, for now'), findsOneWidget);

    await tester.tap(find.text('Photo'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.bySemanticsLabel('Take a picture'), findsOneWidget);
  });
}
