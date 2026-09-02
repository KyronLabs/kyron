import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/video_settings_provider.dart';
import 'package:kyron_app/services/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Waits for the notifier's first read off disk to land.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppPreferences video sound', () {
    test('a fresh install is muted', () async {
      // A feed that starts talking is hostile.
      SharedPreferences.setMockInitialValues({});
      expect(await AppPreferences().readVideoMuted(), isTrue);
    });

    test('round-trips the choice', () async {
      SharedPreferences.setMockInitialValues({});
      final store = AppPreferences();

      await store.writeVideoMuted(false);
      expect(await store.readVideoMuted(), isFalse);

      await store.writeVideoMuted(true);
      expect(await store.readVideoMuted(), isTrue);
    });
  });

  group('VideoMutedNotifier', () {
    test('starts muted and reads the stored answer', () async {
      SharedPreferences.setMockInitialValues({'pref_video_muted': false});
      final notifier = VideoMutedNotifier(AppPreferences());

      // Muted until the disk read lands, so a clip cannot make a noise in the
      // gap on the strength of a value nobody has read yet.
      expect(notifier.state, isTrue);

      await _settle();
      expect(notifier.state, isFalse);
    });

    test('toggling is remembered for every other clip', () async {
      // The whole point: turning the sound on for one clip turns it on for
      // the next one, rather than making somebody unmute a feed post by post.
      SharedPreferences.setMockInitialValues({});
      final store = AppPreferences();
      final notifier = VideoMutedNotifier(store);
      await _settle();

      await notifier.toggle();
      expect(notifier.state, isFalse);
      expect(await store.readVideoMuted(), isFalse);

      // A second player reading the same store agrees with the first.
      final other = VideoMutedNotifier(store);
      await _settle();
      expect(other.state, isFalse);
    });

    test('setting what is already set writes nothing new', () async {
      SharedPreferences.setMockInitialValues({});
      final notifier = VideoMutedNotifier(AppPreferences());
      await _settle();

      await notifier.set(true);
      expect(notifier.state, isTrue);
    });
  });
}
