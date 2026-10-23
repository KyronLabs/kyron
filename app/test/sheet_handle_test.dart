import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/app_sheet.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Every sheet's handle: a short bar with eight pixels above it and eight
/// under it.
///
/// Material's own centres the bar in a 48-pixel box, which opened every sheet
/// in the app on 22 pixels of nothing, the bar, and 22 more.
void main() {
  Future<void> open(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: KyronTheme.lightTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => showAppSheet<void>(
                  context: context,
                  builder: (_) => const SizedBox(
                    key: ValueKey('content'),
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('eight above the bar, eight under it, then the sheet', (
    tester,
  ) async {
    await open(tester);

    final sheet = tester.getRect(find.byType(BottomSheet));
    final bar = tester.getRect(
      find.descendant(
        of: find.byKey(const ValueKey('sheet-handle')),
        matching: find.byType(Container),
      ),
    );
    final content = tester.getRect(find.byKey(const ValueKey('content')));

    expect(bar.size, const Size(SheetHandle.width, SheetHandle.thickness));
    expect(bar.center.dx, closeTo(sheet.center.dx, 0.5));
    expect(bar.top - sheet.top, 8);
    expect(content.top - bar.bottom, 8);
  });

  testWidgets('the sheet still closes by dragging it down', (tester) async {
    await open(tester);

    await tester.drag(find.byType(BottomSheet), const Offset(0, 400));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('a sheet that cannot be dismissed is not closed from it', (
    tester,
  ) async {
    // The voice recorder: closing it mid-recording loses the recording.
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showAppSheet<void>(
                context: context,
                isDismissible: false,
                enableDrag: false,
                builder: (_) => const SizedBox(height: 120),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final handle = tester.widget<Semantics>(
      find.byKey(const ValueKey('sheet-handle')),
    );
    expect(handle.properties.onTap, isNull);
  });

  test("nothing in the app asks for Material's handle", () {
    final offenders = [
      for (final file in Directory('lib').listSync(recursive: true))
        if (file is File &&
            file.path.endsWith('.dart') &&
            !file.path.endsWith('app_sheet.dart') &&
            file.readAsStringSync().contains('showDragHandle: true'))
          file.path,
    ];
    expect(offenders, isEmpty, reason: 'use showAppSheet');
  });
}
