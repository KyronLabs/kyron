import 'dart:io';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

    /// Whether a tile says it is the one on. The shutter's ring is what
    /// shows it, and that ring is drawn round the middle of the strip.
    Matcher chosen(bool on) => containsSemantics(isSelected: on);
    SemanticsNode tile(String label) =>
        tester.getSemantics(find.bySemanticsLabel(label));

    expect(tile('None'), chosen(true));
    expect(tile('Specs, face lens'), chosen(false));

    await tester.tap(find.bySemanticsLabel('Specs, face lens'));
    // Past the strip's slide to the middle and the tile's transition.
    await tester.pumpAndSettle();

    expect(tile('Specs, face lens'), chosen(true));
    expect(tile('None'), chosen(false));
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

  testWidgets('a swipe that starts on the shutter moves the strip', (
    tester,
  ) async {
    // The shutter used to be a button over the strip, and the strip never
    // saw a finger that landed on it.
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    final shutter = tester.getCenter(find.bySemanticsLabel('Take a picture'));
    await tester.dragFrom(shutter, const Offset(-150, 0));
    await tester.pumpAndSettle();

    expect(find.text('None'), findsNothing);
  });

  testWidgets('pressing the shutter does not change the lens', (
    tester,
  ) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('Take a picture'));
    await tester.pumpAndSettle();
    expect(find.text('None'), findsOneWidget);
  });

  testWidgets('video mode keeps the lens on', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('Specs, face lens'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Video'));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Record a video'), findsOneWidget);
    expect(find.text('Specs'), findsOneWidget);

    await tester.tap(find.text('Photo'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Take a picture'), findsOneWidget);
    expect(find.text('Specs'), findsOneWidget);
  });
}
