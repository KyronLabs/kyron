// test/language_test.dart
//
// The language settings used to be one picker over six languages that wrote a
// code nothing read. There were no localization delegates, no supportedLocales
// and no .arb file anywhere in the tree, so the app was hard-coded English
// whatever the picker said.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/language.dart';
import 'package:kyron_app/providers/preferences_provider.dart';
import 'package:kyron_app/screens/settings_subscreens.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:kyron_app/widgets/language_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the catalogue', () {
    test('codes are unique', () {
      final codes = Languages.all.map((l) => l.code).toSet();
      expect(codes, hasLength(Languages.all.length));
    });

    test('every language has a code and both names', () {
      for (final language in Languages.all) {
        expect(language.code, isNotEmpty, reason: language.englishName);
        expect(language.englishName, isNotEmpty, reason: language.code);
        expect(language.nativeName, isNotEmpty, reason: language.code);
      }
    });

    test('is sorted by English name, which is the order it is drawn in', () {
      // The list's order *is* its display order, so a list that is sorted
      // cannot drift from what the sheet shows.
      final names = [for (final l in Languages.all) l.englishName];
      expect(names, orderedEquals(List.of(names)..sort()));
    });

    test('carries the endonym, not a transliteration of it', () {
      // The detail that says whether anybody was paying attention. Somebody
      // looking for their language looks for the name they write it in.
      String native(String code) => Languages.fromCode(code).nativeName;
      expect(native('de'), 'Deutsch');
      expect(native('sw'), 'Kiswahili');
      expect(native('yo'), 'Yorùbá');
      expect(native('zu'), 'isiZulu');
      expect(native('ja'), '日本語');
    });

    test('knows which languages are read right to left', () {
      for (final code in ['ar', 'he', 'fa', 'ur']) {
        expect(Languages.fromCode(code).rtl, isTrue, reason: code);
      }
      expect(Languages.fromCode('en').rtl, isFalse);
      expect(Languages.fromCode('sw').rtl, isFalse);
    });

    test('falls back to English rather than throwing', () {
      // A code stored by a build with a longer list than this one must not
      // stop the app from starting.
      expect(Languages.fromCode('xx'), Languages.fallback);
      expect(Languages.fromCode(null), Languages.fallback);
      expect(Languages.fromCode(''), Languages.fallback);
    });

    test('drops stored codes it no longer knows, rather than blanking a row',
        () {
      final kept = Languages.fromCodes(['sw', 'not-a-language', 'de']);
      expect([for (final l in kept) l.code], ['de', 'sw']);
    });

    test('searches the endonym, the English name and the code alike', () {
      // Three ways of asking the same question -- "German", "Deutsch", "de".
      for (final query in ['German', 'deutsch', 'de']) {
        expect(
          Languages.search(query).map((l) => l.code),
          contains('de'),
          reason: query,
        );
      }
    });

    test('an empty search is every language, not none', () {
      expect(Languages.search(''), hasLength(Languages.all.length));
      expect(Languages.search('   '), hasLength(Languages.all.length));
    });
  });

  group('what is remembered', () {
    setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

    test('a fresh install is English, with no content filter', () async {
      final store = AppPreferences();
      expect(await store.readLanguage(), Languages.fallback);
      expect(await store.readPrimaryLanguage(), Languages.fallback);
      // Empty is "I have not said". Reading it as "show nothing" would leave
      // a new account looking at an empty feed.
      expect(await store.readContentLanguages(), isEmpty);
    });

    test('the app language and the primary language are kept apart', () async {
      // Plenty of people run their phone in English and would still rather
      // read Kiswahili.
      final store = AppPreferences();
      await store.writeLanguage(Languages.fromCode('en'));
      await store.writePrimaryLanguage(Languages.fromCode('sw'));

      expect((await store.readLanguage()).code, 'en');
      expect((await store.readPrimaryLanguage()).code, 'sw');
    });

    test('content languages round-trip in the list order', () async {
      final store = AppPreferences();
      await store.writeContentLanguages(Languages.fromCodes(['sw', 'ar']));
      expect(
        [for (final l in await store.readContentLanguages()) l.code],
        ['ar', 'sw'],
      );
    });

    test('a choice survives the next launch', () async {
      final first = PreferencesNotifier(AppPreferences());
      await _settle();
      await first.setLanguage(Languages.fromCode('ja'));
      await first.setContentLanguages(Languages.fromCodes(['ja', 'ko']));

      final second = PreferencesNotifier(AppPreferences());
      await _settle();
      expect(second.state.language.code, 'ja');
      expect(
        [for (final l in second.state.contentLanguages) l.code],
        ['ja', 'ko'],
      );
    });
  });

  group('the app language reaches the widget tree', () {
    // The whole point. A stored code that no widget reads is the bug this
    // replaced, so these assert on what is rendered, not on what is stored.
    Widget app(Language language) => MaterialApp(
          locale: language.locale,
          supportedLocales: [for (final l in Languages.all) l.locale],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) => Scaffold(
              body: Text(
                MaterialLocalizations.of(context).backButtonTooltip,
              ),
            ),
          ),
        );

    testWidgets('Flutter\'s own strings follow the choice', (tester) async {
      await tester.pumpWidget(app(Languages.fromCode('en')));
      expect(find.text('Back'), findsOneWidget);

      await tester.pumpWidget(app(Languages.fromCode('fr')));
      await tester.pumpAndSettle();
      expect(
        find.text('Back'),
        findsNothing,
        reason: 'the app stayed in English, which is the bug this replaced',
      );
    });

    testWidgets('an RTL language lays the whole app out the other way round',
        (tester) async {
      await tester.pumpWidget(app(Languages.fromCode('en')));
      final ltr = Directionality.of(tester.element(find.byType(Scaffold)));
      expect(ltr, TextDirection.ltr);

      await tester.pumpWidget(app(Languages.fromCode('ar')));
      await tester.pumpAndSettle();
      expect(
        Directionality.of(tester.element(find.byType(Scaffold))),
        TextDirection.rtl,
        reason: 'Arabic read left to right is not a cosmetic problem',
      );
    });
  });

  group('the picker', () {
    /// A surface tall enough to build the whole sheet.
    ///
    /// A ListView only builds what is on screen, so on a phone-sized surface
    /// `findsNothing` is true of every language below the fold whether or not
    /// the search actually narrowed anything.
    Future<void> pump(WidgetTester tester, Widget child) {
      addTearDown(tester.view.reset);
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(500, 6000);
      return tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: Scaffold(body: child))),
      );
    }

    testWidgets('searching narrows the list to what was asked for',
        (tester) async {
      late BuildContext ctx;
      await pump(tester, Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }));

      LanguageSheet.pickOne(
        ctx,
        title: 'App language',
        current: Languages.fallback,
      ).ignore();
      await tester.pumpAndSettle();

      // Every language is offered before anything is typed.
      expect(find.text('Kiswahili'), findsOneWidget);
      expect(find.text('Deutsch'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'swa');
      await tester.pumpAndSettle();

      expect(find.text('Kiswahili'), findsOneWidget);
      expect(find.text('Deutsch'), findsNothing);
    });

    testWidgets('says so when a search finds nothing', (tester) async {
      // Rather than an empty sheet, which reads as a list that failed to load.
      late BuildContext ctx;
      await pump(tester, Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }));

      LanguageSheet.pickOne(
        ctx,
        title: 'App language',
        current: Languages.fallback,
      ).ignore();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'zzzz');
      await tester.pumpAndSettle();

      expect(find.textContaining('No language here matches'), findsOneWidget);
    });

    testWidgets('picking one answers with it and closes', (tester) async {
      late BuildContext ctx;
      await pump(tester, Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }));

      final picking = LanguageSheet.pickOne(
        ctx,
        title: 'App language',
        current: Languages.fallback,
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'swahili');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Kiswahili'));
      await tester.pumpAndSettle();

      expect((await picking)?.code, 'sw');
    });

    testWidgets('a multi-select keeps taking taps until Done', (tester) async {
      late BuildContext ctx;
      await pump(tester, Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }));

      final picking = LanguageSheet.pickMany(
        ctx,
        title: 'Content languages',
        current: const [],
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'swahili');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Kiswahili'));
      await tester.pumpAndSettle();
      // Still open: choosing one of several must not close the sheet.
      expect(find.byType(TextField), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'german');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Deutsch'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect([for (final l in (await picking)!) l.code], ['de', 'sw']);
    });

    testWidgets('dismissing is not the same as choosing none', (tester) async {
      // The caller has to be able to tell "I want no filter" from "I changed
      // my mind", or backing out of the sheet wipes the setting.
      late BuildContext ctx;
      await pump(tester, Builder(builder: (c) {
        ctx = c;
        return const SizedBox();
      }));

      final picking = LanguageSheet.pickMany(
        ctx,
        title: 'Content languages',
        current: Languages.fromCodes(['sw']),
      );
      await tester.pumpAndSettle();
      Navigator.of(ctx).pop();
      await tester.pumpAndSettle();

      expect(await picking, isNull);
    });
  });

  group('the Languages screen', () {
    Future<void> pumpScreen(WidgetTester tester) async {
      addTearDown(tester.view.reset);
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(420, 2400);
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: SettingsLanguageScreen()),
        ),
      );
      await tester.pump();
    }

    testWidgets('draws all three sections', (tester) async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await pumpScreen(tester);
      await tester.pump();

      expect(find.text('App language'), findsOneWidget);
      expect(find.text('Primary language'), findsOneWidget);
      expect(find.text('Content languages'), findsOneWidget);
      expect(find.textContaining('Add more languages'), findsOneWidget);
    });

    testWidgets('says what does not work yet rather than implying it does',
        (tester) async {
      // The translation feature is not built, posts carry no language, and
      // Kyron's own words are not translated. Three settings that quietly do
      // nothing is what the settings audit just finished removing; these say
      // so instead.
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await pumpScreen(tester);
      await tester.pump();

      expect(
        find.textContaining('Translation is not built yet'),
        findsOneWidget,
        reason: 'a row offering to translate and then not is worse than one '
            'that says it cannot yet',
      );
      expect(
        find.textContaining('Posts do not carry a language yet'),
        findsOneWidget,
      );
      expect(find.textContaining('still being translated'), findsOneWidget);
    });

    testWidgets('shows the languages already chosen for content',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'pref_content_languages': ['sw', 'ar'],
      });
      await pumpScreen(tester);
      await tester.pump();
      await tester.pump();

      expect(find.text('Kiswahili'), findsOneWidget);
      expect(find.text('\u0627\u0644\u0639\u0631\u0628\u064A\u0629'),
          findsOneWidget);
    });
  });
}
