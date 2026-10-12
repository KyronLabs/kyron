import 'package:flutter_test/flutter_test.dart';
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
    const bare = RemoteWallpaper(id: '07.png', url: 'u');

    expect(dunes.label, 'Quiet dunes');
    expect(bare.label, 'Wallpaper');
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
}
