import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'support/fake_video_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeVideoPlatform platform;

  setUp(() {
    platform = FakeVideoPlatform();
    VideoPlayerPlatform.instance = platform;
  });

  tearDown(() {
    VideoPool.instance.releaseAll();
  });

  Future<VideoPlayerController?> openFor(Object owner, String url) =>
      VideoPool.instance.open(url, owner: owner, onEvicted: () {});

  test('opens one decoder per clip', () async {
    final a = Object();
    await openFor(a, 'https://example.com/a.mp4');

    expect(platform.live, 1);
    expect(VideoPool.instance.liveCount, 1);
  });

  test('asking twice for the same tile does not open a second', () async {
    final a = Object();
    final first = await VideoPool.instance
        .open('https://example.com/a.mp4', owner: a, onEvicted: () {});
    final second = await VideoPool.instance
        .open('https://example.com/a.mp4', owner: a, onEvicted: () {});

    expect(identical(first, second), isTrue);
    expect(platform.live, 1);
  });

  test('never holds more than the budget open', () async {
    // The whole point. A phone fails the next decoder once its handful are
    // gone, and what that looks like is a tile that goes black.
    final owners = List.generate(VideoPool.budget + 4, (_) => Object());
    for (var i = 0; i < owners.length; i++) {
      await openFor(owners[i], 'https://example.com/$i.mp4');
      expect(VideoPool.instance.liveCount, lessThanOrEqualTo(VideoPool.budget));
      expect(platform.live, lessThanOrEqualTo(VideoPool.budget));
    }

    expect(VideoPool.instance.liveCount, VideoPool.budget);
  });

  test('takes back the least recently used one', () async {
    final owners = List.generate(VideoPool.budget, (_) => Object());
    for (var i = 0; i < owners.length; i++) {
      await openFor(owners[i], 'https://example.com/$i.mp4');
    }

    // The first one opened is now the oldest, so touching it should save it
    // and condemn the second instead.
    VideoPool.instance.touch(owners.first);

    await openFor(Object(), 'https://example.com/new.mp4');

    // Player 2 is the second one opened, and the one that was oldest after
    // the touch.
    await pumpEventQueue();
    expect(platform.disposed, [2]);
  });

  test('tells the tile its clip was taken away', () async {
    final first = Object();
    var told = false;
    await VideoPool.instance.open(
      'https://example.com/a.mp4',
      owner: first,
      onEvicted: () => told = true,
    );
    for (var i = 0; i < VideoPool.budget; i++) {
      await openFor(Object(), 'https://example.com/$i.mp4');
    }

    expect(told, isTrue);
  });

  test('releasing gives the decoder back', () async {
    final a = Object();
    await openFor(a, 'https://example.com/a.mp4');
    VideoPool.instance.release(a);
    // The controller reaches the platform one turn later; the pool's own
    // count is right immediately, which is what the budget is measured on.
    expect(VideoPool.instance.liveCount, 0);

    await pumpEventQueue();
    expect(platform.live, 0);
  });

  test('releasing something that holds nothing is not an error', () {
    expect(() => VideoPool.instance.release(Object()), returnsNormally);
  });

  test('a clip that will not open holds no slot', () async {
    platform.failOnCreate = true;

    await expectLater(
      VideoPool.instance.open('https://example.com/bad.mp4',
          owner: Object(), onEvicted: () {}),
      throwsA(isA<Object>()),
    );

    // The failed attempt must not leave a lease behind, or three bad clips
    // would use up the budget and no good one could ever open.
    expect(VideoPool.instance.liveCount, 0);
  });

  test('several tiles opening at once cannot beat the budget', () async {
    // Scrolling brings several into view in the same frame. Each takes its
    // slot before waiting on the platform, so they cannot all see room -- and
    // the ones that miss out are told no rather than being handed a fourth
    // decoder.
    final owners = List.generate(VideoPool.budget + 3, (_) => Object());
    final got = await Future.wait([
      for (var i = 0; i < owners.length; i++)
        VideoPool.instance.open(
          'https://example.com/$i.mp4',
          owner: owners[i],
          onEvicted: () {},
        ),
    ]);

    expect(VideoPool.instance.liveCount, lessThanOrEqualTo(VideoPool.budget));
    expect(platform.live, lessThanOrEqualTo(VideoPool.budget));
    expect(
      got.where((c) => c != null).length,
      VideoPool.budget,
      reason: 'the ones past the budget are refused, not queued forever',
    );
  });

  test('a tile that goes away mid-open does not strand the decoder', () async {
    // Scrolling fast opens a clip and abandons it before it is ready. The
    // controller cannot be disposed while it is initialising -- doing that
    // leaves initialize() waiting on an event it will never get -- so the
    // lease is marked and cleaned up when it settles.
    final a = Object();
    final opening = VideoPool.instance
        .open('https://example.com/a.mp4', owner: a, onEvicted: () {});
    VideoPool.instance.release(a);

    expect(await opening, isNull);
    await pumpEventQueue();

    expect(VideoPool.instance.liveCount, 0);
    expect(platform.live, 0);
  });

  group('a lease taken back while its owner is still setting it up', () {
    test('is no longer held by that owner', () async {
      // The window this closes: a tile opens a decoder, then spends three
      // awaits on volume, looping and the first play. The pool can hand its
      // slot to a clip nearer the middle of the screen across any of them, and
      // a tile that puts the controller back into its state afterwards mounts
      // a player on a decoder that has already been disposed.
      final a = Object();
      final controller = await openFor(a, 'https://example.com/a.mp4');
      expect(VideoPool.instance.holds(a, controller!), isTrue);

      // Fill the budget, which takes the oldest lease back.
      for (var i = 0; i < VideoPool.budget; i++) {
        await openFor(Object(), 'https://example.com/$i.mp4');
      }

      expect(VideoPool.instance.holds(a, controller), isFalse);
    });

    test('tells its owner before the controller is disposed', () async {
      // The other way round leaves a window in which the owner still has the
      // controller and anything that rebuilds draws a player around nothing.
      int? liveWhenTold;
      final a = Object();
      await VideoPool.instance.open(
        'https://example.com/a.mp4',
        owner: a,
        onEvicted: () => liveWhenTold = platform.live,
      );

      for (var i = 0; i < VideoPool.budget; i++) {
        await openFor(Object(), 'https://example.com/$i.mp4');
      }

      expect(liveWhenTold, isNotNull, reason: 'the owner was told at all');
      expect(
        liveWhenTold,
        VideoPool.budget,
        reason: 'its decoder was still open when it was told',
      );
    });

    test('holds is false for a controller that was never this owner\'s',
        () async {
      final a = Object();
      final b = Object();
      final theirs = await openFor(b, 'https://example.com/b.mp4');
      await openFor(a, 'https://example.com/a.mp4');

      expect(VideoPool.instance.holds(a, theirs!), isFalse);
    });
  });

  test('releaseAll drops everything', () async {
    for (var i = 0; i < VideoPool.budget; i++) {
      await openFor(Object(), 'https://example.com/$i.mp4');
    }
    VideoPool.instance.releaseAll();
    expect(VideoPool.instance.liveCount, 0);

    await pumpEventQueue();
    expect(platform.live, 0);
  });
}
