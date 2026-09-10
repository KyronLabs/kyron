import 'dart:io';

import 'package:flutter/semantics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/browser/browser_engine.dart';
import 'package:kyron_app/screens/browser/browser_route.dart';
import 'package:kyron_app/screens/browser/browser_sheet.dart';
import 'package:kyron_app/services/app_browser.dart';
import 'package:kyron_app/services/platform_support.dart';
import 'package:kyron_app/utils/layout.dart';
import 'package:kyron_app/widgets/nav_destinations.dart';
import 'package:kyron_app/widgets/side_rail.dart';
import 'package:kyron_app/widgets/toast.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

void main() {
  tearDown(() {
    PlatformSupport.current = null;
    Toast.dismiss();
  });

  group('the rail', () {
    Widget rail(int current, void Function(int) onSelect) => ProviderScope(
          child: MaterialApp(
            theme: KyronTheme.lightTheme,
            home: Scaffold(
              body: Row(
                children: [
                  SideRail(currentIndex: current, onSelect: onSelect),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        );

    testWidgets('draws the same four places the bottom bar does',
        (tester) async {
      await tester.pumpWidget(rail(0, (_) {}));
      await tester.pumpAndSettle();

      for (final destination in NavDestinations.all) {
        expect(find.text(destination.label), findsOneWidget,
            reason: '${destination.label} is missing from the rail');
      }
      // Four destinations, and compose is not one of them: it opens a sheet
      // and leaves you where you were.
      expect(NavDestinations.all.length, 4);
      expect(
        NavDestinations.all.map((d) => d.index),
        isNot(contains(NavDestinations.composeIndex)),
      );
    });

    testWidgets('says which one you are on, and answers a click',
        (tester) async {
      var chosen = -1;
      await tester.pumpWidget(rail(0, (index) => chosen = index));
      await tester.pumpAndSettle();

      expect(
        tester.getSemantics(find.bySemanticsLabel('Home')).hasFlag(
              SemanticsFlag.isSelected,
            ),
        isTrue,
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Messages')).hasFlag(
              SemanticsFlag.isSelected,
            ),
        isFalse,
      );

      await tester.tap(find.bySemanticsLabel('Messages'));
      expect(chosen, NavDestinations.messages.index);
    });

    testWidgets('is exactly as wide as the layout says', (tester) async {
      await tester.pumpWidget(rail(0, (_) {}));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(SideRail)).width, Layout.railWidth);
    });
  });

  group('where the layout changes', () {
    testWidgets('a window gets the rail and a phone does not', (tester) async {
      late bool wide;
      Widget probe() => MediaQuery(
            data:
                MediaQueryData(size: Size(tester.view.physicalSize.width, 800)),
            child: Builder(builder: (context) {
              wide = Layout.hasRail(context);
              return const SizedBox();
            }),
          );

      tester.view.devicePixelRatio = 1;

      tester.view.physicalSize = const Size(1280, 800);
      await tester.pumpWidget(probe());
      expect(wide, isTrue, reason: 'a 1280 window has room for the rail');

      tester.view.physicalSize = const Size(390, 800);
      await tester.pumpWidget(probe());
      expect(wide, isFalse,
          reason: 'a phone-shaped space keeps the bottom bar');

      // The boundary itself, so the constant and the comparison agree.
      tester.view.physicalSize = Size(Layout.railAt, 800);
      await tester.pumpWidget(probe());
      expect(wide, isTrue);

      tester.view.physicalSize = Size(Layout.railAt - 1, 800);
      await tester.pumpWidget(probe());
      expect(wide, isFalse);

      addTearDown(tester.view.reset);
    });
  });

  group('the reading column', () {
    test('keeps its measure and turns the rest into margin', () {
      // A maximised 1920 window: the column stays at its measure and the
      // spare 1300 points become equal margins rather than line length.
      final gutter = Layout.gutter(1920, Layout.readingWidth);
      expect(gutter, (1920 - Layout.readingWidth) / 2);
      expect(1920 - gutter * 2, Layout.readingWidth);
    });

    test('and takes nothing from a screen with none to spare', () {
      // Every phone. A negative gutter would pull the posts off both edges.
      expect(Layout.gutter(390, Layout.readingWidth), 0);
      expect(Layout.gutter(Layout.readingWidth, Layout.readingWidth), 0);
      expect(Layout.gutter(0, Layout.readingWidth), 0);
      expect(Layout.gutter(double.infinity, Layout.readingWidth), 0,
          reason: 'an unbounded width is not a margin of infinity');
    });
  });

  group('links on a platform with no web view', () {
    /// A tab's engine without a web view under it, so the sheet can be built
    /// at all: a real WebViewController asserts without a platform behind it,
    /// which is the very crash this group is about.
    Widget linkScreen() => MaterialApp(
          theme: KyronTheme.lightTheme,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () =>
                      AppBrowser.open(context, 'https://example.com/a'),
                  child: const Text('go'),
                ),
              ),
            ),
          ),
        );

    setUp(() {
      BrowserRoute.engineFactory = (tab, host) => _NoEngine();
    });

    tearDown(() {
      BrowserRoute.engineFactory = WebViewEngine.new;
      BrowserRoute.forget();
    });

    testWidgets('a phone opens the sheet', (tester) async {
      // The other half of the pair. Without it, an `open` that did nothing at
      // all would pass the Windows case below.
      PlatformSupport.current = PlatformSupport.mobile;
      await tester.pumpWidget(linkScreen());
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      expect(find.byType(BrowserSheet), findsOneWidget);
    });

    testWidgets('Windows does not, because the sheet cannot build there',
        (tester) async {
      PlatformSupport.current = PlatformSupport.desktop;
      await tester.pumpWidget(linkScreen());
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      // webview_flutter ships android, ios and macos. Pushing the sheet on
      // Windows would not have degraded -- it would have asserted on the
      // first tapped link in the feed.
      expect(find.byType(BrowserSheet), findsNothing);
      expect(BrowserRoute.live, isNull);
    });
  });

  group('the Windows runner', () {
    // The runner was untouched Flutter scaffolding: a window titled "app",
    // com.example in its version block, and the Flutter logo in the taskbar.
    // None of that fails a build, which is exactly why it survived this long.
    String read(String path) => File(path).readAsStringSync();

    test('names the window Kyron', () {
      expect(
          read('windows/runner/main.cpp'), contains('window.Create(L"Kyron"'));
      expect(read('windows/runner/main.cpp'), isNot(contains('L"app"')));
    });

    test('says who ships it', () {
      final rc = read('windows/runner/Runner.rc');
      expect(rc, isNot(contains('com.example')));
      expect(rc, contains('"ProductName", "Kyron"'));
      expect(rc, contains('"CompanyName", "Kyron Labs"'));
    });

    test('builds an executable called kyron', () {
      expect(
          read('windows/CMakeLists.txt'), contains('set(BINARY_NAME "kyron")'));
    });

    test('will not let the window be dragged narrower than the layout', () {
      expect(read('windows/runner/win32_window.cpp'),
          contains('WM_GETMINMAXINFO'));
      expect(
          read('windows/runner/win32_window.cpp'), contains('ptMinTrackSize'));
    });

    test('ships Kyron\'s icon rather than Flutter\'s', () {
      final icon = File('windows/runner/resources/app_icon.ico');
      expect(icon.existsSync(), isTrue);
      // The stock template icon, by content. Comparing the bytes rather than
      // the size: a redrawn Kyron icon should not fail this, and the Flutter
      // one should never pass it again.
      final bytes = icon.readAsBytesSync();
      expect(bytes.length, greaterThan(1000));
      expect(
        _md5ish(bytes),
        isNot(_stockFlutterIcon),
        reason: 'this is still the Flutter logo',
      );
    });
  });
}

/// A cheap content fingerprint. Not a hash anyone should trust for anything
/// else -- it exists so one specific file can be recognised.
int _md5ish(List<int> bytes) {
  var hash = 0x811c9dc5;
  for (final byte in bytes) {
    hash ^= byte;
    hash = (hash * 0x01000193) & 0xFFFFFFFF;
  }
  return hash;
}

/// The fingerprint of the icon every `flutter create` writes, taken from the
/// file this repository actually carried until it was replaced. Kyron shipped
/// it for months: nothing about a wrong icon fails a build, so nothing said.
const int _stockFlutterIcon = 0x59AE9775;

/// A browser engine that draws nothing and goes nowhere.
class _NoEngine implements BrowserEngine {
  @override
  Widget view() => const SizedBox.expand();
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
