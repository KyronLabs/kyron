import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/browser/browser_engine.dart';
import 'package:kyron_app/screens/browser/browser_route.dart';
import 'package:kyron_app/screens/browser/browser_tab.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

const out =
    '/tmp/claude-0/-home-user/90f12f04-7e23-54ff-a1f4-57f7b7d4c519/scratchpad/browser';

/// A page that draws something, so the frame is judged against content.
class _PaperEngine implements BrowserEngine {
  final BrowserTab tab;
  final EngineHost host;
  _PaperEngine(this.tab, this.host);

  @override
  Widget view() => Builder(builder: (context) {
        final dark = Theme.of(context).brightness == Brightness.dark;
        final ink = dark ? const Color(0xFFE5EBF5) : const Color(0xFF1A202C);
        Widget bar(double w, double h, double o) => Container(
              width: w,
              height: h,
              margin: const EdgeInsets.only(bottom: 11),
              decoration: BoxDecoration(
                color: ink.withValues(alpha: o),
                borderRadius: BorderRadius.circular(3),
              ),
            );
        return ColoredBox(
          color: dark ? const Color(0xFF15161A) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(210, 22, 0.85),
                const SizedBox(height: 8),
                bar(300, 9, 0.30),
                bar(288, 9, 0.30),
                bar(196, 9, 0.30),
                const SizedBox(height: 10),
                Container(
                  height: 132,
                  decoration: BoxDecoration(
                    color: ink.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                bar(300, 9, 0.30),
                bar(272, 9, 0.30),
                bar(296, 9, 0.30),
                bar(150, 9, 0.30),
              ],
            ),
          ),
        );
      });

  @override
  Future<void> load(Uri url) async {}
  @override
  Future<void> reload() async {}
  @override
  Future<void> stop() async {}
  @override
  Future<void> goBack() async {}
  @override
  Future<void> goForward() async {}
  @override
  void dispose() {}
}

void main() {
  testWidgets('render', (tester) async {
    Directory(out).createSync(recursive: true);
    // The app declares Inter but ships no font files, and a headless test has
    // none either: every string would render as a black box. Any real face
    // makes the layout judgeable.
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
    tester.view.devicePixelRatio = 2;
    tester.view.physicalSize = const Size(390 * 2, 844 * 2);
    tester.view.padding = const FakeViewPadding(top: 47 * 2, bottom: 34 * 2);

    final made = <_PaperEngine>[];
    BrowserRoute.engineFactory = (tab, host) {
      final engine = _PaperEngine(tab, host);
      made.add(engine);
      return engine;
    };

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
      final theme = dark ? KyronTheme.darkTheme : KyronTheme.lightTheme;
      final label = dark ? 'dark' : 'light';

      await tester.pumpWidget(
        RepaintBoundary(
          child: MaterialApp(
            theme: theme,
            home: Builder(
              builder: (context) => Scaffold(
                body: Container(
                  color:
                      dark ? const Color(0xFF0D0D0F) : const Color(0xFFF0F4F8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Kyron behind it',
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            navigatorKey: GlobalKey<NavigatorState>(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final navigator =
          tester.state<NavigatorState>(find.byType(Navigator).first);
      navigator.push(
        BrowserRoute.route(Uri.parse('https://thegreenhouse.press/almanac')),
      );
      await tester.pumpAndSettle();

      // One tab, page still coming in.
      made.last.tab.progressed(58);
      await shoot('01-loading-$label');

      // One tab, settled with a title.
      made.last.tab.finished(
        Uri.parse('https://thegreenhouse.press/almanac'),
        title: 'A Gardener’s Almanac',
      );
      made.last.tab.historyChanged(back: true, forward: false);
      await shoot('02-read-$label');

      // Three tabs, the strip earning its place.
      made.last.host.openTab(Uri.parse('https://slowradio.fm/nightshift'));
      await tester.pumpAndSettle();
      made.last.tab.finished(Uri.parse('https://slowradio.fm/nightshift'),
          title: 'Night Shift');
      made.last.host.openTab(Uri.parse('http://ledger.example/txn/88120'));
      await tester.pumpAndSettle();
      made.last.tab.finished(Uri.parse('http://ledger.example/txn/88120'));
      await shoot('03-tabs-$label');

      // A page that did not load.
      made.last.tab.failed('That address does not resolve to a server.');
      await shoot('04-failed-$label');
    }

    // testWidgets wedges on teardown after toImage; the renders are done.
    exit(0);
  });
}
