import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/screens/chat_wallpaper_screen.dart';
import 'package:kyron_app/widgets/skeleton.dart';
import 'package:kyron_app/models/chat_wallpaper.dart';
import 'package:kyron_app/providers/chat_wallpaper_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('a stored wallpaper', () {
    test('reads back what was written', () {
      for (final wallpaper in [
        ChatWallpaper.none,
        ChatWallpaper.builtIn(BuiltInWallpaper.sage),
        ChatWallpaper.image('https://cdn.invalid/wallpapers/a.jpg'),
      ]) {
        expect(ChatWallpaper.fromKey(wallpaper.key), wallpaper);
      }
    });

    test('is the plain page when it names something that is gone', () {
      // A built-in removed in a later version, or a value from a newer one,
      // draws the plain page rather than failing.
      expect(ChatWallpaper.fromKey('builtin:aurora'), ChatWallpaper.none);
      expect(ChatWallpaper.fromKey('url:'), ChatWallpaper.none);
      expect(ChatWallpaper.fromKey('something-else'), ChatWallpaper.none);
      expect(ChatWallpaper.fromKey(null), ChatWallpaper.none);
    });
  });

  test('a folder image is named after its file, without its order number', () {
    const dunes = RemoteWallpaper(id: '02-quiet_dunes.jpg', url: 'u');
    const copy = RemoteWallpaper(id: 'harbour lights (1).jpg', url: 'u');

    expect(dunes.label, 'Quiet dunes');
    expect(copy.label, 'Harbour lights');
  });

  test('a file named by a machine has no caption at all', () {
    // A hash under a picture says nothing about it; the picture does.
    for (final id in [
      '01704f15a5ff689c6488e46c13f09149.jpg',
      '46ddbdd31cf15e82e94e4135d1758030 (1).jpg',
      'IMG_20260101_120000.jpg',
      '07.png',
    ]) {
      expect(RemoteWallpaper(id: id, url: 'u').label, isNull, reason: id);
    }
  });

  test('the choice is kept per conversation, on this phone', () async {
    SharedPreferences.setMockInitialValues({});
    final first = ChatWallpaperNotifier('c1');
    await first.choose(ChatWallpaper.builtIn(BuiltInWallpaper.dots));

    final again = ChatWallpaperNotifier('c1');
    final other = ChatWallpaperNotifier('c2');
    await Future<void>.delayed(Duration.zero);

    expect(again.state.builtIn, BuiltInWallpaper.dots);
    expect(other.state, ChatWallpaper.none);

    // Back to the plain page leaves nothing stored.
    await again.choose(ChatWallpaper.none);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(ChatWallpaperNotifier.keyFor('c1')), isNull);
  });

  group('the picker', () {
    Future<void> pump(
      WidgetTester tester,
      Future<List<RemoteWallpaper>> remote,
    ) async {
      tester.view.physicalSize = const Size(1170, 2532);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            remoteWallpapersProvider.overrideWith((ref) => remote),
          ],
          child: const MaterialApp(
            home: ChatWallpaperScreen(conversationId: 'c1'),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('shows placeholders while the folder loads', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final never = Completer<List<RemoteWallpaper>>();
      await pump(tester, never.future);

      expect(find.byType(SkeletonBox), findsWidgets);
      // The built-in ones are there already; only the folder waits.
      expect(find.text('Mist'), findsOneWidget);
    });

    testWidgets('marks the one in use apart from the one being looked at',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        ChatWallpaperNotifier.keyFor('c1'): 'builtin:sage',
      });
      await pump(tester, Future.value(const []));
      await tester.pumpAndSettle();

      expect(find.text('Current'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('wallpaper-builtin:sage')),
          matching: find.text('Current'),
        ),
        findsOneWidget,
      );

      // Looking at another one leaves Current where it was, and the
      // conversation unchanged until Apply.
      await tester.tap(find.text('Dusk'));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('wallpaper-builtin:sage')),
          matching: find.text('Current'),
        ),
        findsOneWidget,
      );
      final prefs = await SharedPreferences.getInstance();
      expect(
          prefs.getString(ChatWallpaperNotifier.keyFor('c1')), 'builtin:sage');
    });
  });
}
