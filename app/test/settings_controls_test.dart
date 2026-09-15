// test/settings_controls_test.dart
//
// The settings screen carried five switches that persisted nothing and drove
// nothing: Private Account, Dark Mode, Auto-Download, Data Saver and Location.
// Each moved under the finger, so each looked like it worked.
//
// Two of them could not be made to work at all -- there is no private-account
// field anywhere in the API, and no geolocation package or location permission
// in the app -- and are gone. The rest are here, doing what they say.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/app_theme.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/preferences_provider.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:kyron_app/screens/settings_screen.dart';
import 'package:kyron_app/services/video_stage.dart';
import 'package:kyron_app/widgets/inline_video.dart';
import 'package:kyron_app/widgets/kyron_toggle.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'support/fake_video_platform.dart';

/// Waits for a notifier's first read off disk to land.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTheme', () {
    test('codes are unique', () {
      final codes = AppTheme.values.map((t) => t.code).toSet();
      expect(codes, hasLength(AppTheme.values.length));
    });

    test('every choice has a code, a label and a line saying what it does', () {
      for (final theme in AppTheme.values) {
        expect(theme.code, isNotEmpty);
        expect(theme.label, isNotEmpty);
        expect(theme.detail, isNotEmpty);
      }
    });

    test('falls back to system rather than throwing', () {
      // A code written by a build that offered a palette this one does not
      // must not stop the app from starting.
      expect(AppTheme.fromCode('solarized'), AppTheme.system);
      expect(AppTheme.fromCode(null), AppTheme.system);
      expect(AppTheme.fromCode(''), AppTheme.system);
      expect(AppTheme.fromCode('dim'), AppTheme.dim);
    });
  });

  group('the palette a choice asks for', () {
    test('only System follows the phone', () {
      // The whole complaint. themeMode was a hard-coded ThemeMode.system, so
      // the switch next to it could not have changed anything.
      expect(AppTheme.system.mode, ThemeMode.system);
      expect(AppTheme.light.mode, ThemeMode.light);
      expect(AppTheme.dark.mode, ThemeMode.dark);
    });

    test('Dim is a dark mode, not a third one', () {
      // There is no ThemeMode.dim. Asking for it and being left following the
      // phone is how it would silently do nothing on a light phone.
      expect(AppTheme.dim.mode, ThemeMode.dark);
    });

    test('Dim and Dark hand MaterialApp different palettes', () {
      final dim = AppTheme.dim.darkPalette;
      final dark = AppTheme.dark.darkPalette;

      expect(dim.colorScheme.surface, isNot(dark.colorScheme.surface));
      expect(dim.colorScheme.surface, KyronTheme.dimTheme.colorScheme.surface);
      expect(
        dark.colorScheme.surface,
        KyronTheme.darkTheme.colorScheme.surface,
      );
    });

    test('every choice answers with a dark palette', () {
      // Including Light: darkTheme is still consulted, and a stale one shows
      // the wrong dark through anything that asks for it directly.
      for (final theme in AppTheme.values) {
        expect(theme.darkPalette.colorScheme.brightness, Brightness.dark);
      }
    });
  });

  group('AppPreferences', () {
    setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

    test('a fresh install follows the phone and does not save data', () async {
      final store = AppPreferences();
      expect(await store.readTheme(), AppTheme.system);
      // Off by default: holding back autoplay for everybody to spare the few
      // who are metered is the wrong way round.
      expect(await store.readDataSaver(), isFalse);
    });

    test('round-trips every palette', () async {
      final store = AppPreferences();
      for (final theme in AppTheme.values) {
        await store.writeTheme(theme);
        expect(await store.readTheme(), theme);
      }
    });

    test('round-trips data saver', () async {
      final store = AppPreferences();
      await store.writeDataSaver(true);
      expect(await store.readDataSaver(), isTrue);
      await store.writeDataSaver(false);
      expect(await store.readDataSaver(), isFalse);
    });
  });

  group('PreferencesNotifier', () {
    test('reads both back off disk at startup', () async {
      SharedPreferences.setMockInitialValues({
        'pref_theme': 'dim',
        'pref_data_saver': true,
      });
      final notifier = PreferencesNotifier(AppPreferences());
      await _settle();

      expect(notifier.state.theme, AppTheme.dim);
      expect(notifier.state.dataSaver, isTrue);
    });

    test('a choice survives the next launch', () async {
      // What the old switches did not do. They were "local state for toggles
      // (batch save on exit)" with no save on exit.
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final store = AppPreferences();
      final first = PreferencesNotifier(store);
      await _settle();

      await first.setTheme(AppTheme.light);
      await first.setDataSaver(true);

      final second = PreferencesNotifier(AppPreferences());
      await _settle();
      expect(second.state.theme, AppTheme.light);
      expect(second.state.dataSaver, isTrue);
    });
  });

  group('Data Saver', () {
    setUp(() {
      VideoPlayerPlatform.instance = FakeVideoPlatform();
      VideoStage.instance.reset();
      VisibilityDetectorController.instance.updateInterval = Duration.zero;
    });

    tearDown(() {
      VideoPool.instance.releaseAll();
      VideoStage.instance.reset();
    });

    const clip = PostMedia(
      id: 'a',
      url: 'https://example.com/a.mp4',
      kind: MediaKind.video,
      width: 720,
      height: 1280,
    );

    Future<void> pumpClip(WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  height: 400,
                  child: SizedInlineVideo(media: clip),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    }

    testWidgets('off, a clip still starts by itself', (tester) async {
      SharedPreferences.setMockInitialValues({'pref_data_saver': false});
      await pumpClip(tester);

      expect(
        VideoPool.instance.liveCount,
        1,
        reason: 'the feed autoplaying is what the app is for; this guard is '
            'what proves the one below is measuring something',
      );
    });

    testWidgets('on, no decoder is opened at all', (tester) async {
      SharedPreferences.setMockInitialValues({'pref_data_saver': true});
      await pumpClip(tester);

      expect(
        VideoPool.instance.liveCount,
        0,
        reason: 'a clip that downloads and plays anyway is the switch doing '
            'nothing, which is what it did before',
      );
    });

    testWidgets('switching it on stops the clip already playing',
        (tester) async {
      // Settings is a pushed route over the feed. A reader who turns this on
      // and comes back to a feed still playing has been ignored.
      SharedPreferences.setMockInitialValues({'pref_data_saver': false});
      late WidgetRef captured;
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, _) {
                  captured = ref;
                  return const Center(
                    child: SizedBox(
                      height: 400,
                      child: SizedInlineVideo(media: clip),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(VideoPool.instance.liveCount, 1);

      await captured.read(preferencesProvider.notifier).setDataSaver(true);
      await tester.pumpAndSettle();

      expect(VideoPool.instance.liveCount, 0);
    });
  });

  group('the settings screen itself', () {
    // The screen reads the signed-in address straight off Supabase, so the
    // client has to exist even though there is no session to find.
    setUpAll(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await Supabase.initialize(
        url: 'http://localhost:54321',
        anonKey: 'test-anon-key',
        debug: false,
      );
    });

    /// Renders the screen on a surface tall enough to hold all of it.
    ///
    /// A ListView only builds what is on screen, so on a phone-sized surface
    /// `findsNothing` is true of every row below the fold whether or not it
    /// is there -- which is exactly how the check below would have passed
    /// while still offering a dead Location switch further down.
    Future<void> pumpSettings(WidgetTester tester) async {
      addTearDown(tester.view.reset);
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(400, 4000);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: SettingsScreen()),
        ),
      );
      await tester.pump();
    }

    testWidgets('offers no switch that nothing is behind', (tester) async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await pumpSettings(tester);

      // Private Account: there is no such field on the account and nothing in
      // the API asks about one, so it protected nothing.
      expect(find.text('Private Account'), findsNothing);
      // Location: no geolocation package, no manifest permission. It granted
      // nothing and denied nothing.
      expect(find.text('Location'), findsNothing);
      // Auto-Download: the same concern as Data Saver under the opposite
      // name, with no answer for a phone that had both switched on.
      expect(find.text('Auto-Download'), findsNothing);

      // Proof the surface really did build the whole page: the last row on it
      // is present, so the three above are absent rather than merely unbuilt.
      expect(find.text('Log Out'), findsOneWidget);
    });

    testWidgets('shows the palette in use and offers the rest in a sheet',
        (tester) async {
      SharedPreferences.setMockInitialValues({'pref_theme': 'dim'});
      await pumpSettings(tester);
      await tester.pump();

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Dim'), findsOneWidget);

      await tester.tap(find.text('Appearance'));
      await tester.pumpAndSettle();

      // A sheet, never a dropdown -- and every palette in it, not a switch
      // that cannot say "follow the phone".
      for (final theme in AppTheme.values) {
        expect(find.text(theme.label), findsWidgets, reason: theme.label);
      }

      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();

      expect(await AppPreferences().readTheme(), AppTheme.light);
    });

    testWidgets('writes Data Saver down where the feed will read it',
        (tester) async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      await pumpSettings(tester);
      await tester.pump();

      final row = find
          .ancestor(of: find.text('Data Saver'), matching: find.byType(Row))
          .first;
      await tester.tap(
        find.descendant(of: row, matching: find.byType(KyronToggle)),
      );
      await tester.pumpAndSettle();

      // The old switch was "local state for toggles (batch save on exit)"
      // with no save on exit: this is the assertion it could never pass.
      expect(await AppPreferences().readDataSaver(), isTrue);
    });
  });
}
