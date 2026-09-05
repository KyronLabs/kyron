import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/video_feed_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:kyron_app/services/video_stage.dart';
import 'package:video_player/video_player.dart';
import 'package:kyron_app/utils/route_watch.dart';
import 'package:kyron_app/widgets/media_tile_grid.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'support/fake_video_platform.dart';

FeedPost _clip(String id, {int likes = 0, bool liked = false}) => FeedPost(
      id: id,
      content: 'caption $id',
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'a1', username: 'epigone'),
      likes: likes,
      liked: liked,
      media: [
        PostMedia(
          id: 'm-$id',
          kind: MediaKind.video,
          url: 'https://example.com/$id.mp4',
          thumbnailUrl: 'https://example.com/$id.jpg',
        ),
      ],
    );

FeedPost _photo(String id) => FeedPost(
      id: id,
      content: 'a picture',
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'a1'),
      media: [
        PostMedia(
          id: 'm-$id',
          kind: MediaKind.image,
          url: 'https://example.com/$id.png',
        ),
      ],
    );

/// A repository that answers with a fixed page and never touches a network.
class _FakeFeed extends FeedRepository {
  final List<FeedPost> posts;

  _FakeFeed(this.posts) : super(ApiClient());

  /// Every like and unlike it was asked for, in order.
  final List<bool> liking = [];

  @override
  Future<FeedPage> videos({String? cursor, int limit = 20}) async =>
      FeedPage(items: posts, nextCursor: null);

  @override
  Future<int> setLiked(String postId, bool liked) async {
    liking.add(liked);
    final post = posts.firstWhere((p) => p.id == postId);
    return post.likes + (liked ? 1 : 0);
  }
}

Future<_FakeFeed> _pump(
  WidgetTester tester,
  List<FeedPost> posts, {
  required String startOn,
}) async {
  final feed = _FakeFeed(posts);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedRepositoryProvider.overrideWithValue(feed),
      ],
      child: MaterialApp(
        // The same observer the app registers: without it nothing tells this
        // screen it has been covered.
        navigatorObservers: [routeObserver],
        home: VideoFeedScreen(
          args: VideoFeedArgs(
            source: PostListSource.videos,
            postId: startOn,
          ),
        ),
      ),
    ),
  );
  // The first page lands, then the screen opens a player for it.
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
  return feed;
}

/// Pushes a screen over whatever is showing, the way tapping through to a
/// profile from the caption does.
Future<void> _cover(WidgetTester tester) async {
  final navigator = tester.state<NavigatorState>(find.byType(Navigator));
  unawaited(
    navigator.push(
      MaterialPageRoute<void>(
        builder: (_) => const Scaffold(body: Text('a profile')),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Whether the clip on screen is stopped: the glyph over the middle of it is
/// only ever there while it is.
bool _isPaused() => find.byIcon(Iconsax.play).evaluate().isNotEmpty;

/// Whether sound is actually coming out of the player, rather than what the
/// screen is drawing about it. A covered route is offstage, so this is read
/// off the controller rather than looked for.
bool _isPlaying(WidgetTester tester) => tester
    .widget<VideoPlayer>(find.byType(VideoPlayer, skipOffstage: false))
    .controller
    .value
    .isPlaying;

/// A phone held the way this screen is used. The test surface is a landscape
/// 800x600, on which every clip is the wrong shape.
void _portrait(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // The sound setting is read off disk the moment a player is built.
    SharedPreferences.setMockInitialValues({});
    VideoPlayerPlatform.instance = FakeVideoPlatform();
    VideoStage.instance.reset();
  });

  tearDown(() {
    VideoPool.instance.releaseAll();
    VideoStage.instance.reset();
  });

  testWidgets('opens on the clip that was tapped, not the first',
      (tester) async {
    await _pump(
      tester,
      [_clip('a'), _clip('b'), _clip('c')],
      startOn: 'c',
    );

    expect(find.text('caption c'), findsOneWidget);
    expect(find.text('caption a'), findsNothing);
  });

  testWidgets('starts at the top when that post is no longer in the list',
      (tester) async {
    // The list can be refreshed between the tap and this screen reading it.
    await _pump(tester, [_clip('a'), _clip('b')], startOn: 'gone');
    expect(find.text('caption a'), findsOneWidget);
  });

  testWidgets('pages through only the posts carrying a clip', (tester) async {
    // The list it reads is the feed's, which is not only videos.
    await _pump(
      tester,
      [_clip('a'), _photo('p'), _clip('b')],
      startOn: 'a',
    );

    await tester.fling(find.byType(PageView), const Offset(0, -600), 1000);
    await tester.pumpAndSettle();

    expect(find.text('caption b'), findsOneWidget);
    expect(find.text('a picture'), findsNothing);
  });

  testWidgets('only one clip has a player, however far it is paged',
      (tester) async {
    // A player per page would leave the clip above holding a decoder, and a
    // decoder taken back stops whoever has gone longest without one.
    await _pump(
      tester,
      [_clip('a'), _clip('b'), _clip('c'), _clip('d')],
      startOn: 'a',
    );

    for (var i = 0; i < 3; i++) {
      await tester.fling(find.byType(PageView), const Offset(0, -600), 1000);
      await tester.pumpAndSettle();
      expect(VideoPool.instance.liveCount, lessThanOrEqualTo(1));
    }
  });

  testWidgets('takes the stage, so the feed underneath stops', (tester) async {
    await _pump(tester, [_clip('a')], startOn: 'a');
    expect(VideoStage.instance.active, isNotNull);
  });

  testWidgets('says who posted it and what they said', (tester) async {
    await _pump(tester, [_clip('a', likes: 12)], startOn: 'a');

    expect(find.text('@epigone'), findsOneWidget);
    expect(find.text('caption a'), findsOneWidget);
    expect(find.text('12'), findsOneWidget, reason: 'the like count');
  });

  testWidgets('says so when there is nothing to play', (tester) async {
    await _pump(tester, [_photo('p')], startOn: 'p');
    expect(find.text('There are no clips here yet.'), findsOneWidget);
    expect(find.byType(PageView), findsNothing);
  });

  group('another screen over the top', () {
    testWidgets('stops the clip, and hands back the stage', (tester) async {
      // A pushed route leaves this screen built and playing underneath it, so
      // the clip is heard from a profile page that has nothing to do with it.
      await _pump(tester, [_clip('a')], startOn: 'a');
      expect(_isPlaying(tester), isTrue);

      await _cover(tester);

      expect(_isPlaying(tester), isFalse);
      expect(
        VideoStage.instance.active,
        isNull,
        reason: 'the clips on the screen that covered this one can play now',
      );
    });

    testWidgets('picks it back up on the way back', (tester) async {
      await _pump(tester, [_clip('a')], startOn: 'a');
      await _cover(tester);

      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      expect(_isPlaying(tester), isTrue);
      expect(VideoStage.instance.active, isNotNull);
    });

    testWidgets('leaves a clip that was already stopped alone', (tester) async {
      await _pump(tester, [_clip('a')], startOn: 'a');
      await tester.tap(find.byType(PageView));
      await tester.pump(const Duration(milliseconds: 400));
      expect(_isPaused(), isTrue);

      await _cover(tester);
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      expect(
        _isPlaying(tester),
        isFalse,
        reason: 'it was stopped before it was left',
      );
    });
  });

  group('tapping', () {
    testWidgets('stops it on the tap, not once the double-tap window is out',
        (tester) async {
      await _pump(tester, [_clip('a')], startOn: 'a');

      await tester.tap(find.byType(PageView));
      await tester.pump();

      // A pause that lands a third of a second late is a pause that feels
      // broken, so it happens now and a second tap undoes it.
      expect(_isPaused(), isTrue);
    });

    testWidgets('twice likes it, and leaves playback where it was',
        (tester) async {
      final feed = await _pump(tester, [_clip('a', likes: 4)], startOn: 'a');

      await tester.tap(find.byType(PageView));
      await tester.pump(const Duration(milliseconds: 40));
      await tester.tap(find.byType(PageView));
      await tester.pumpAndSettle();

      expect(feed.liking, [true]);
      expect(find.text('5'), findsOneWidget);
      expect(_isPaused(), isFalse, reason: 'the pause was undone by the like');
    });

    testWidgets('twice on something already liked does not take it back',
        (tester) async {
      final feed = await _pump(
        tester,
        [_clip('a', likes: 4, liked: true)],
        startOn: 'a',
      );

      await tester.tap(find.byType(PageView));
      await tester.pump(const Duration(milliseconds: 40));
      await tester.tap(find.byType(PageView));
      await tester.pumpAndSettle();

      expect(feed.liking, isEmpty);
      expect(find.text('4'), findsOneWidget);
    });
  });

  group('how the clip is fitted', () {
    BoxFit fitOfClip(WidgetTester tester) => tester
        .widget<FittedBox>(
          find.ancestor(
            of: find.byType(VideoPlayer),
            matching: find.byType(FittedBox),
          ),
        )
        .fit;

    testWidgets('a portrait clip fills the screen', (tester) async {
      // Losing a sliver off the top and bottom beats two black bars.
      _portrait(tester);
      (VideoPlayerPlatform.instance as FakeVideoPlatform).reportedSize =
          const Size(1080, 1920);
      await _pump(tester, [_clip('a')], startOn: 'a');
      expect(fitOfClip(tester), BoxFit.cover);
    });

    testWidgets('a landscape clip is shown whole', (tester) async {
      // Filling the screen with this would throw away three quarters of the
      // width, and a strip out of the middle of a clip is not the clip.
      _portrait(tester);
      (VideoPlayerPlatform.instance as FakeVideoPlatform).reportedSize =
          const Size(1920, 1080);
      await _pump(tester, [_clip('a')], startOn: 'a');
      expect(fitOfClip(tester), BoxFit.contain);
    });

    testWidgets('a tap on the black beside a letterboxed clip still counts',
        (tester) async {
      _portrait(tester);
      (VideoPlayerPlatform.instance as FakeVideoPlatform).reportedSize =
          const Size(1920, 1080);
      await _pump(tester, [_clip('a')], startOn: 'a');

      // Well above the middle, where a 16:9 clip on a phone is not.
      await tester.tapAt(const Offset(180, 120));
      await tester.pump();
      expect(_isPaused(), isTrue);
    });
  });

  group('swiping', () {
    testWidgets('a short drag is enough to move on', (tester) async {
      await _pump(tester, [_clip('a'), _clip('b')], startOn: 'a');

      // A fifth of the page, let go rather than flicked. The stock page
      // physics wants half of it before it will commit.
      await tester.drag(find.byType(PageView), const Offset(0, -140));
      await tester.pumpAndSettle();

      expect(find.text('caption b'), findsOneWidget);
    });

    testWidgets('a nudge is not', (tester) async {
      await _pump(tester, [_clip('a'), _clip('b')], startOn: 'a');

      await tester.drag(find.byType(PageView), const Offset(0, -55));
      await tester.pumpAndSettle();

      expect(find.text('caption a'), findsOneWidget);
    });

    testWidgets('and it goes back the same way', (tester) async {
      await _pump(tester, [_clip('a'), _clip('b')], startOn: 'b');

      await tester.drag(find.byType(PageView), const Offset(0, 140));
      await tester.pumpAndSettle();

      expect(find.text('caption a'), findsOneWidget);
    });
  });

  group('what a tile opens', () {
    testWidgets('the post, when nothing else is asked for', (tester) async {
      var opened = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                MediaTileGrid(posts: [_clip('a')])
              ],
            ),
          ),
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (_) {
              opened++;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      expect(opened, 1);
    });

    testWidgets('whatever the caller says, when it says', (tester) async {
      FeedPost? opened;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                MediaTileGrid(
                  posts: [_clip('a')],
                  videosOnly: true,
                  onOpen: (post) => opened = post,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
      expect(opened?.id, 'a');
    });
  });
}
