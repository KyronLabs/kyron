import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/feed_post.dart';
import 'package:kyron_app/models/post_media.dart';
import 'package:kyron_app/providers/feed_provider.dart';
import 'package:kyron_app/repositories/feed_repository.dart';
import 'package:kyron_app/screens/video_feed_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:kyron_app/services/video_stage.dart';
import 'package:kyron_app/widgets/media_tile_grid.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'support/fake_video_platform.dart';

FeedPost _clip(String id, {int likes = 0}) => FeedPost(
      id: id,
      content: 'caption $id',
      createdAt: DateTime(2026, 1, 1),
      author: const FeedAuthor(id: 'a1', username: 'epigone'),
      likes: likes,
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

  @override
  Future<FeedPage> videos({String? cursor, int limit = 20}) async =>
      FeedPage(items: posts, nextCursor: null);
}

Future<void> _pump(
  WidgetTester tester,
  List<FeedPost> posts, {
  required String startOn,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        feedRepositoryProvider.overrideWithValue(_FakeFeed(posts)),
      ],
      child: MaterialApp(
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
