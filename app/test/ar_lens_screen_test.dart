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

  testWidgets('offers every lens, with none selected first', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    // The strip is tiles now, not names -- each one showing what its lens
    // does -- so the name of every lens is in its label rather than on it,
    // and only the chosen one is written out above the row.
    for (final lens in Lens.builtIn) {
      final label = lens.needsFace ? '${lens.name}, face lens' : lens.name;
      expect(find.bySemanticsLabel(label), findsOneWidget, reason: lens.id);
    }
    expect(find.text(Lens.builtIn.first.name), findsOneWidget);
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

  testWidgets('changing the lens changes what is selected', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    /// The ring around a tile, which is the whole visible signal.
    BorderSide ringOf(String label) {
      final box = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.bySemanticsLabel(label),
          matching: find.byType(AnimatedContainer),
        ),
      );
      final shape = (box.decoration! as ShapeDecoration).shape
          as ContinuousRectangleBorder;
      return shape.side;
    }

    expect(ringOf('None').color, Colors.white);
    expect(ringOf('Mono').color, Colors.white24);

    await tester.tap(find.bySemanticsLabel('Mono'));
    // Past the tile's 180ms transition. A single pump lands mid-animation and
    // reads the colour it is on its way *from*.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(ringOf('Mono').color, Colors.white);
    expect(ringOf('None').color, Colors.white24);
    // And the name above the row follows the selection.
    expect(find.text('Mono'), findsOneWidget);
    expect(find.text('None'), findsNothing);
  });

  testWidgets('writes the top bar in white, under either theme', (
    tester,
  ) async {
    // The bar sits on black. The design system's AppBarTheme sets
    // titleTextStyle and iconTheme, and a theme's colours beat the widget's
    // foregroundColor -- so under the light theme this screen drew near-black
    // text and a near-black back arrow on a black bar, and the top of the
    // screen was blank.
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

      // What actually gets painted, first: an AppBar that sets only
      // foregroundColor leaves titleTextStyle null and the theme's near-black
      // wins, which is the bug and is invisible to any check of the widget's
      // own fields.
      final title = tester.widget<Text>(find.text('AR Lens'));
      final painted = DefaultTextStyle.of(tester.element(find.text('AR Lens')))
          .style
          .merge(title.style);
      expect(painted.color, Colors.white, reason: '$theme');

      final bar = tester.widget<AppBar>(find.byType(AppBar));
      expect(bar.iconTheme?.color, Colors.white);
      expect(bar.actionsIconTheme?.color, Colors.white);
    }
  });
}
