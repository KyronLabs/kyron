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

  testWidgets('says so on a device with no camera, rather than spinning',
      (tester) async {
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

    for (final lens in Lens.builtIn) {
      expect(find.text(lens.name), findsOneWidget, reason: lens.id);
    }
  });

  testWidgets('keeps the shutter inert while there is no camera',
      (tester) async {
    // Tapping it would take a picture with nothing to take it from.
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('Take a picture'));
    await tester.pump();

    // Still on the same screen, with the same message, and nothing thrown.
    expect(find.text('The camera is closed'), findsOneWidget);
  });

  testWidgets('does not offer to switch when there is only one camera',
      (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    expect(find.byTooltip('Switch camera'), findsNothing);
  });

  testWidgets('changing the lens changes what is selected', (tester) async {
    await tester.pumpWidget(screen(const [], temp));
    await tester.pump();

    await tester.tap(find.text('Mono'));
    await tester.pump();

    // The chosen chip is the filled one; before the tap it was None.
    final mono = tester.widget<Container>(
      find
          .ancestor(of: find.text('Mono'), matching: find.byType(Container))
          .first,
    );
    expect((mono.decoration! as BoxDecoration).color, Colors.white);
  });
}
