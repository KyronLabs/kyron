import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/link_preview.dart';
import 'package:kyron_app/screens/browser/browser_chrome.dart';
import 'package:kyron_app/screens/browser/browser_engine.dart';
import 'package:kyron_app/screens/browser/browser_route.dart';
import 'package:kyron_app/screens/browser/browser_sheet.dart';
import 'package:kyron_app/screens/browser/browser_tab.dart';
import 'package:kyron_app/services/app_browser.dart';
import 'package:kyron_app/widgets/link_preview_card.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// A tab's engine, without a web view under it.
///
/// A real `WebViewController` asserts on construction unless a platform
/// implementation is registered, which is exactly why the browser this
/// replaced had no tests. Everything the chrome does is above this line.
class _FakeEngine implements BrowserEngine {
  final BrowserTab tab;
  final EngineHost host;
  final List<String> did = <String>[];
  Uri? loaded;

  _FakeEngine(this.tab, this.host);

  @override
  Widget view() => const SizedBox.expand();

  @override
  Future<void> load(Uri url) async {
    loaded = url;
    did.add('load');
  }

  @override
  Future<void> reload() async => did.add('reload');

  @override
  Future<void> stop() async => did.add('stop');

  @override
  Future<void> goBack() async => did.add('back');

  @override
  Future<void> goForward() async => did.add('forward');

  @override
  void dispose() => did.add('dispose');
}

void main() {
  late List<_FakeEngine> engines;

  setUp(() {
    engines = <_FakeEngine>[];
    BrowserRoute.engineFactory = (tab, host) {
      final engine = _FakeEngine(tab, host);
      engines.add(engine);
      return engine;
    };
  });

  tearDown(() {
    BrowserRoute.engineFactory = WebViewEngine.new;
    // testWidgets leaves the last tree standing, so the sheet's dispose has
    // not run yet and its session is still the live one.
    BrowserRoute.forget();
  });

  /// A screen with one link on it, so a tap is the thing under test rather
  /// than a route pushed by the test itself.
  /// A phone with a status bar and a gesture inset, so the sheet's frame and
  /// the foot's tap targets are measured against something real.
  void useAPhone(WidgetTester tester) {
    tester.view.devicePixelRatio = 1;
    tester.view.padding = const FakeViewPadding(top: 44, bottom: 34);
    addTearDown(tester.view.reset);
  }

  Widget screen(List<String> links) {
    return ProviderScope(
      child: MaterialApp(
        theme: KyronTheme.lightTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 200),
                for (final link in links)
                  TextButton(
                    onPressed: () => AppBrowser.open(context, link),
                    child: Text('tap $link'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tapLink(WidgetTester tester, String link) async {
    await tester.tap(find.text('tap $link'));
    await tester.pumpAndSettle();
  }

  /// What a page does when one of its links asks for a window of its own.
  /// The only way a second tab is reached in the app, since the sheet covers
  /// everything that could have been tapped to open one.
  Future<void> pageAsksForATab(WidgetTester tester, String link) async {
    engines.last.host.openTab(Uri.parse(link));
    await tester.pumpAndSettle();
  }

  /// Text inside the address bar, rather than anywhere on the screen: the app
  /// is still built behind the sheet and its link labels contain hosts too.
  Finder inTheBar(String text) => find.descendant(
        of: find.byType(AddressPill),
        matching: find.text(text),
      );

  Finder barContaining(String text) => find.descendant(
        of: find.byType(AddressPill),
        matching: find.textContaining(text),
      );

  group('a tapped link stays inside Kyron', () {
    testWidgets('it opens the app browser, not another app', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      expect(find.byType(BrowserSheet), findsOneWidget);
      // And the engine was actually pointed at the link, rather than a sheet
      // opening on nothing.
      expect(engines.single.loaded, Uri.parse('https://example.com/a'));
    });

    testWidgets('the host is named on the bar for as long as it is open',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      expect(inTheBar('example.com'), findsOneWidget);

      // Still named after the page redirects somewhere else, which is the
      // case that matters: the bar has to follow the page, not the tap.
      engines.single.tab.finished(
        Uri.parse('https://tracker.example.net/landing'),
        title: 'Somewhere Else',
      );
      await tester.pumpAndSettle();

      expect(inTheBar('tracker.example.net'), findsOneWidget);
      expect(inTheBar('Somewhere Else'), findsOneWidget);
      expect(inTheBar('example.com'), findsNothing);
    });

    testWidgets('the host is not printed twice before a page names itself',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      // With no title, the tab's label is the host, and a bar reading the host
      // over the host looks like a fault rather than two facts.
      expect(inTheBar('example.com'), findsOneWidget);

      engines.single.tab
          .finished(Uri.parse('https://example.com/a'), title: 'Example');
      await tester.pumpAndSettle();
      expect(inTheBar('Example'), findsOneWidget);
      expect(inTheBar('example.com'), findsOneWidget);
    });

    testWidgets('www. is dropped, because nobody reads it', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://www.example.com/']));
      await tapLink(tester, 'https://www.example.com/');

      expect(inTheBar('example.com'), findsOneWidget);
      expect(inTheBar('www.example.com'), findsNothing);
    });

    testWidgets('the app shows behind it, so the page reads as a guest',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      // The route is not opaque: what it opened from is still on screen. That
      // gap is the whole reason a stranger's page can stay inside Kyron.
      expect(find.text('tap https://example.com/a'), findsOneWidget);

      // The card starts below the status bar rather than under it.
      final rail = tester.getRect(find.byType(BrowserRail));
      expect(rail.top, greaterThan(44));

      // And it reaches the bottom, with the gesture inset held under the foot
      // rather than eaten out of it.
      engines.single.tab.finished(Uri.parse('https://example.com/a'));
      await tester.pumpAndSettle();
      final foot = tester.getRect(find.byType(BrowserFoot));
      expect(foot.bottom, tester.getSize(find.byType(MaterialApp)).height);
      expect(foot.height, BrowserFoot.rowHeight + BrowserFoot.hairline + 34);
      for (final label in ['Back', 'Forward', 'Reload', 'Share this page']) {
        expect(tester.getSize(find.bySemanticsLabel(label)).height,
            BrowserFoot.rowHeight,
            reason: '$label must not shrink to fit the gesture bar');
      }
    });

    testWidgets('a post link preview opens it too -- the reported bug',
        (tester) async {
      const url = 'https://news.example.org/story';
      const preview = LinkPreview(
        url: url,
        host: 'news.example.org',
        title: 'A story',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            linkPreviewProvider(url).overrideWith((ref) async => preview),
          ],
          child: const MaterialApp(
            home: Scaffold(body: LinkPreviewCard(url: url)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('A story'), findsOneWidget);

      await tester.tap(find.text('A story'));
      await tester.pumpAndSettle();

      expect(find.byType(BrowserSheet), findsOneWidget);
      expect(engines.single.loaded, Uri.parse(url));
    });
  });

  group('tabs', () {
    testWidgets('a page asking for a window of its own gets a tab',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      expect(find.byType(TabStrip), findsNothing,
          reason: 'one page needs no strip');

      await pageAsksForATab(tester, 'https://other.example/b');

      expect(find.byType(BrowserSheet), findsOneWidget,
          reason: 'a tab, not a second browser stacked on the first');
      expect(find.byType(TabStrip), findsOneWidget);
      expect(engines.length, 2);
      expect(find.byType(TabChip), findsNWidgets(2));
      // And it is reading the new one.
      expect(inTheBar('other.example'), findsOneWidget);
    });

    testWidgets('a link tapped while it is open joins it', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      // What a deep link arriving over the top of an open browser does.
      BrowserRoute.open(
        tester.element(find.byType(BrowserSheet)),
        Uri.parse('https://other.example/b'),
      );
      await tester.pumpAndSettle();

      expect(find.byType(BrowserSheet), findsOneWidget);
      expect(find.byType(TabChip), findsNWidgets(2));
    });

    testWidgets('the same page twice comes back to the tab it already has',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      await pageAsksForATab(tester, 'https://other.example/b');
      await pageAsksForATab(tester, 'https://example.com/a');

      expect(engines.length, 2, reason: 'no third engine for a page it holds');
      expect(find.byType(TabChip), findsNWidgets(2));
      expect(inTheBar('example.com'), findsOneWidget,
          reason: 'and it went back to the one it already had');
    });

    testWidgets('closing the last tab closes the browser', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      await pageAsksForATab(tester, 'https://other.example/b');

      await tester.tap(find.bySemanticsLabel('Close other.example'));
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsOneWidget);
      expect(find.byType(TabStrip), findsNothing);

      await tester.tap(find.bySemanticsLabel('Close the browser'));
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsNothing);
    });

    testWidgets('a browser that has gone does not take the next link',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      await pageAsksForATab(tester, 'https://other.example/b');

      await tester.tap(find.bySemanticsLabel('Close the browser'));
      await tester.pumpAndSettle();
      expect(BrowserRoute.live, isNull);

      await tapLink(tester, 'https://example.com/a');
      expect(find.byType(BrowserSheet), findsOneWidget);
      expect(find.byType(TabStrip), findsNothing,
          reason: 'a fresh browser, not the closed one\'s two tabs');
    });

    testWidgets('the counter says how many are open', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      expect(find.bySemanticsLabel('1 page open'), findsOneWidget);

      await pageAsksForATab(tester, 'https://other.example/b');
      expect(find.bySemanticsLabel('2 pages open'), findsOneWidget);
    });
  });

  group('the bar tells the truth about the page', () {
    testWidgets('http says so', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['http://plain.example/x']));
      await tapLink(tester, 'http://plain.example/x');

      expect(barContaining('Not private'), findsOneWidget);
      expect(barContaining('plain.example'), findsOneWidget);
    });

    testWidgets('https is quiet about it', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://safe.example/x']));
      await tapLink(tester, 'https://safe.example/x');

      expect(barContaining('Not private'), findsNothing);
      expect(inTheBar('safe.example'), findsOneWidget);
    });

    testWidgets('progress is the real number, and goes when it is done',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      double barWidth() => tester
          .widget<FractionallySizedBox>(find.descendant(
            of: find.byType(LoadBar),
            matching: find.byType(FractionallySizedBox),
          ))
          .widthFactor!;

      double opacity() => tester
          .widget<AnimatedOpacity>(find.descendant(
            of: find.byType(LoadBar),
            matching: find.byType(AnimatedOpacity),
          ))
          .opacity;

      engines.single.tab.progressed(40);
      await tester.pumpAndSettle();
      expect(barWidth(), closeTo(0.4, 0.001));
      expect(opacity(), 1);

      engines.single.tab.progressed(85);
      await tester.pumpAndSettle();
      expect(barWidth(), closeTo(0.85, 0.001));

      engines.single.tab.finished(Uri.parse('https://example.com/a'));
      await tester.pumpAndSettle();
      expect(opacity(), 0, reason: 'a bar that is always there means nothing');
    });
  });

  group('a page that does not load', () {
    testWidgets('says which host failed and why, and can retry',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://gone.example/x']));
      await tapLink(tester, 'https://gone.example/x');

      expect(find.byType(PageFailure), findsNothing);

      engines.single.tab.failed('That address does not resolve to a server.');
      await tester.pumpAndSettle();

      expect(find.byType(PageFailure), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PageFailure),
          matching: find.text('gone.example'),
        ),
        findsOneWidget,
      );
      expect(find.text('That address does not resolve to a server.'),
          findsOneWidget);

      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(engines.single.did, contains('reload'));
      expect(find.byType(PageFailure), findsNothing,
          reason: 'a retry in progress is not still a failure');
    });
  });

  group('navigation', () {
    testWidgets('back and forward answer only when there is history',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      await tester.tap(find.bySemanticsLabel('Back'));
      await tester.pumpAndSettle();
      expect(engines.single.did, isNot(contains('back')),
          reason: 'nothing to go back to');

      engines.single.tab.historyChanged(back: true, forward: false);
      await tester.pumpAndSettle();

      await tester.tap(find.bySemanticsLabel('Back'));
      await tester.pumpAndSettle();
      expect(engines.single.did, contains('back'));

      await tester.tap(find.bySemanticsLabel('Forward'));
      await tester.pumpAndSettle();
      expect(engines.single.did, isNot(contains('forward')));
    });

    testWidgets('the system back gesture unwinds the page before the browser',
        (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      engines.single.tab.historyChanged(back: true, forward: false);
      await tester.pumpAndSettle();

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(engines.single.did, contains('back'));
      expect(find.byType(BrowserSheet), findsOneWidget,
          reason: 'back in the page, not out of the browser');

      engines.single.tab.historyChanged(back: false, forward: false);
      await tester.pumpAndSettle();

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsNothing);
    });

    testWidgets('and unwinds a tab before the browser', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');
      await pageAsksForATab(tester, 'https://other.example/b');

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsOneWidget);
      expect(find.byType(TabChip), findsNothing, reason: 'one tab left');
      expect(inTheBar('example.com'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsNothing);
    });

    testWidgets('reload becomes stop while a page is loading', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      expect(find.bySemanticsLabel('Stop loading'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Stop loading'));
      await tester.pumpAndSettle();
      expect(engines.single.did, contains('stop'));

      // And a stopped page is not still loading, or the bar sits at whatever
      // it reached for ever.
      expect(find.bySemanticsLabel('Reload'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Reload'));
      await tester.pumpAndSettle();
      expect(engines.single.did, contains('reload'));
    });

    testWidgets('dragging the rail down closes it', (tester) async {
      useAPhone(tester);
      await tester.pumpWidget(screen(['https://example.com/a']));
      await tapLink(tester, 'https://example.com/a');

      // Not far enough: it springs back.
      await tester.drag(find.byType(BrowserRail), const Offset(0, 60));
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsOneWidget);

      await tester.drag(find.byType(BrowserRail), const Offset(0, 200));
      await tester.pumpAndSettle();
      expect(find.byType(BrowserSheet), findsNothing);
    });
  });

  group('the origin mark', () {
    test('is the same colour for a host every time, and differs between', () {
      final a = OriginMark.colour('example.com', dark: false);
      expect(OriginMark.colour('example.com', dark: false), a);
      expect(OriginMark.colour('other.example', dark: false), isNot(a));
    });

    test('takes the first letter that is one', () {
      expect(OriginMark.letter('example.com'), 'E');
      expect(OriginMark.letter('-.news.org'), 'N');
      expect(OriginMark.letter('...'), '?');
    });
  });
}
