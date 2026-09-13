import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/draft_service.dart';
import 'package:kyron_app/services/platform_support.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:kyron_app/services/video_still.dart';

/// Kyron's Windows build did not fail on Windows -- it hung. Six of its
/// features are somebody else's native code, none of the six covers every
/// platform, and the app asked for all of them anyway. These are the tests
/// that keep each one asking first.
void main() {
  tearDown(() => PlatformSupport.current = null);

  group('the capability table', () {
    test('a phone has all of it', () {
      const it = PlatformSupport.mobile;
      expect(
        [
          it.webView,
          it.video,
          it.audio,
          it.camera,
          it.videoStills,
          it.localDatabase
        ],
        everyElement(isTrue),
      );
    });

    test('Windows has none of it, and says which platform it is', () {
      const it = PlatformSupport.desktop;
      expect(
        [
          it.webView,
          it.video,
          it.audio,
          it.camera,
          it.videoStills,
          it.localDatabase
        ],
        everyElement(isFalse),
      );
      expect(it.name, 'Windows');
    });

    test('macOS keeps what its plugins actually ship', () {
      // webview_flutter, video_player, just_audio and sqflite all list macos;
      // camera and get_thumbnail_video do not. Getting this wrong in either
      // direction is a feature switched off that works, or a crash.
      const it = PlatformSupport.macOS;
      expect(it.webView, isTrue);
      expect(it.video, isTrue);
      expect(it.audio, isTrue);
      expect(it.localDatabase, isTrue);
      expect(it.camera, isFalse);
      expect(it.videoStills, isFalse);
    });

    test('the web has a browser of its own, and no sqflite', () {
      expect(PlatformSupport.web.webView, isFalse);
      expect(PlatformSupport.web.localDatabase, isFalse);
      expect(PlatformSupport.web.video, isTrue);
    });

    test('only a phone answers the auth redirect', () {
      // Android declares the intent filter for so.kyron.app://auth-callback
      // and iOS the URL type. Nothing else in the repository does, and where
      // it is false a Google sign-in opens a consent screen whose answer has
      // nowhere on the machine to go -- which looks, to the reader, like a
      // browser that simply never came back.
      expect(PlatformSupport.mobile.authRedirect, isTrue);
      expect(PlatformSupport.desktop.authRedirect, isFalse);
      expect(PlatformSupport.linux.authRedirect, isFalse);
      expect(PlatformSupport.macOS.authRedirect, isFalse);
      expect(PlatformSupport.web.authRedirect, isFalse);
    });

    test('the running platform is whatever the test is pretending to be', () {
      // Guards the override itself: every test below leans on it, and one
      // that silently did nothing would pass while testing the host.
      PlatformSupport.current = PlatformSupport.desktop;
      expect(PlatformSupport.current.video, isFalse);
      PlatformSupport.current = PlatformSupport.mobile;
      expect(PlatformSupport.current.video, isTrue);
      PlatformSupport.current = null;
      expect(PlatformSupport.current.name, isNot('Windows'),
          reason: 'a test host is not Windows');
    });
  });

  group('video', () {
    test('the pool refuses with a reason rather than opening nothing',
        () async {
      PlatformSupport.current = PlatformSupport.desktop;

      await expectLater(
        VideoPool.instance.open(
          'https://example.com/clip.mp4',
          owner: Object(),
          onEvicted: () {},
        ),
        throwsA(isA<NoVideoPlayer>()),
      );

      // The reason is shown to a reader, so it has to read as a sentence and
      // name the platform rather than a package.
      try {
        await VideoPool.instance.open(
          'https://example.com/clip.mp4',
          owner: Object(),
          onEvicted: () {},
        );
        fail('expected NoVideoPlayer');
      } on NoVideoPlayer catch (error) {
        expect(error.reason, contains('Windows'));
        expect(error.reason, isNot(contains('video_player')));
        expect(error.toString(), error.reason);
      }
    });

    test('and holds no lease for the clip it refused', () {
      // A lease taken and not released is a decoder slot gone for the run.
      expect(VideoPool.instance.liveCount, 0);
    });

    test('a still is skipped rather than attempted', () async {
      PlatformSupport.current = PlatformSupport.desktop;
      expect(await extractVideoStill('/tmp/whatever.mp4'), isNull);
    });
  });

  group('drafts', () {
    test('answer for a store that is not there instead of throwing', () async {
      PlatformSupport.current = PlatformSupport.desktop;
      final drafts = DraftService();

      expect(drafts.isAvailable, isFalse);
      // Every one of these used to reach sqflite, which on Windows has no
      // implementation at all.
      await expectLater(drafts.saveDraft(content: 'held'), completes);
      expect(await drafts.allDrafts(), isEmpty);
      expect(await drafts.count(), 0);
      expect(await drafts.getLatestDraft(), isNull);
      await expectLater(drafts.deleteDraft('x'), completes);
      await expectLater(drafts.clearAllDrafts(), completes);
    });

    test('and are available where there is a store', () {
      PlatformSupport.current = PlatformSupport.mobile;
      expect(DraftService().isAvailable, isTrue);
    });
  });

  group('the host platform', () {
    test('maps to the right row of the table', () {
      // Read through the same switch the app uses, one platform at a time.
      final seen = <TargetPlatform, String>{};
      for (final platform in TargetPlatform.values) {
        debugDefaultTargetPlatformOverride = platform;
        PlatformSupport.current = null;
        seen[platform] = PlatformSupport.current.name;
      }
      debugDefaultTargetPlatformOverride = null;

      expect(seen[TargetPlatform.windows], 'Windows');
      expect(seen[TargetPlatform.linux], 'Linux');
      expect(seen[TargetPlatform.macOS], 'macOS');
      expect(seen[TargetPlatform.android], 'this device');
      expect(seen[TargetPlatform.iOS], 'this device');
    });
  });
}
