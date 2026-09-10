import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/layout.dart';
import 'package:kyron_app/widgets/nav_destinations.dart';
import 'package:kyron_app/widgets/side_rail.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Not a test -- a tool. `flutter test` only collects `*_test.dart`, so this
/// stays out of the suite and is run by name:
///
///     flutter test test/render_desktop.dart
///
/// Wrap `toImage` in `tester.runAsync` or only the first shot in a run
/// completes, and load a font or every string renders as a black box.
const out = String.fromEnvironment('shots', defaultValue: '/tmp/kyron-shots');

/// A stand-in for whatever page the rail is sitting next to.
class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = scheme.onSurface;

    Widget bar(double w, double h, double o) => Container(
          width: w,
          height: h,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: ink.withValues(alpha: o),
            borderRadius: BorderRadius.circular(4),
          ),
        );

    Widget post() => Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ink.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: ink.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                bar(120, 10, 0.55),
              ]),
              const SizedBox(height: 12),
              bar(double.infinity, 9, 0.28),
              bar(520, 9, 0.28),
              bar(400, 9, 0.28),
            ],
          ),
        );

    return ColoredBox(
      color: Theme.of(context).brightness == Brightness.dark
          ? KyronTheme.darkBackground
          : const Color(0xFFEFF3F7),
      child: Center(
        child: SizedBox(
          width: Layout.readingWidth,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [for (var i = 0; i < 5; i++) post()],
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    for (final family in ['Inter', 'Roboto']) {
      final loader = FontLoader(family)
        ..addFont(Future.value(
          File('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf')
              .readAsBytesSync()
              .buffer
              .asByteData(),
        ));
      await loader.load();
    }

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1280, 820);
    tester.view.padding = FakeViewPadding.zero;

    Future<void> shoot(String name) async {
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(RepaintBoundary).first,
      );
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 1.5);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return data!.buffer.asUint8List();
      });
      File('$out/$name.png').writeAsBytesSync(bytes!);
    }

    for (final dark in [false, true]) {
      for (final index in [
        NavDestinations.home.index,
        NavDestinations.messages.index
      ]) {
        await tester.pumpWidget(
          RepaintBoundary(
            child: ProviderScope(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
                home: Scaffold(
                  body: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SideRail(currentIndex: index, onSelect: (_) {}),
                      const Expanded(child: _Page()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        final where = index == 0 ? 'home' : 'messages';
        await shoot('rail-$where-${dark ? 'dark' : 'light'}');
      }
    }

    exit(0);
  });
}
