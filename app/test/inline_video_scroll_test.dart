// test/inline_video_scroll_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:kyron_app/services/video_stage.dart';
import 'package:kyron_app/widgets/inline_video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'support/fake_video_platform.dart';

/// A decoder must not be opened while the list is being dragged.
///
/// Opening one is not all Dart: on Android it starts a player and allocates a
/// surface for it, which lands on the raster thread. Done mid-drag it is felt
/// directly -- the feed hitched at the moment a clip reached the middle of the
/// screen, which is exactly when it used to fire.
///
/// The settle timer that was there did not prevent it: it waits for a clip to
/// hold the stage, not for the list to be still, and a feed read at any
/// ordinary pace holds a clip there far longer than its 220ms with the finger
/// still down.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    VideoPlayerPlatform.instance = FakeVideoPlatform();
    VideoStage.instance.reset();
    // Reported as it happens, rather than on the package's own timer, so a
    // test does not have to wait half a second for a tile to be noticed.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  tearDown(() {
    VideoPool.instance.releaseAll();
    VideoStage.instance.reset();
  });

  PostMedia clip(String id) => PostMedia(
        id: id,
        url: 'https://example.com/$id.mp4',
        kind: MediaKind.video,
        width: 720,
        height: 1280,
      );

  /// A clip in the middle of a list long enough to scroll.
  Future<void> pumpFeed(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                const SizedBox(height: 300),
                SizedBox(
                  height: 400,
                  child: SizedInlineVideo(media: clip('a')),
                ),
                const SizedBox(height: 2000),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('no decoder is opened while a finger is dragging the list', (
    tester,
  ) async {
    await pumpFeed(tester);

    // Drag the clip up to the middle of the screen and hold it there, which
    // is the moment the stage hands it the floor.
    final drag = await tester.startGesture(const Offset(200, 400));
    await drag.moveBy(const Offset(0, -200));
    await tester.pump();

    // Well past the settle delay, with the finger still down.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(
      VideoPool.instance.liveCount,
      0,
      reason: 'starting a player mid-drag is the hitch this exists to stop',
    );

    // Lifting the finger settles the list, and now it may open one.
    await drag.up();
    await tester.pumpAndSettle();

    expect(
      VideoPool.instance.liveCount,
      1,
      reason: 'and it must still open once the list is still, or the clip '
          'never plays at all',
    );
  });

  testWidgets('a clip with no list above it opens straight away', (
    tester,
  ) async {
    // A post's own page has nothing scrolling, so there is nothing to wait
    // for and waiting would mean never playing.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 400,
                child: SizedInlineVideo(media: clip('solo')),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(VideoPool.instance.liveCount, 1);
  });
}
