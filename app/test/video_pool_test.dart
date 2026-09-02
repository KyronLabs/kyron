import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/video_pool.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

/// A video platform that opens instantly and remembers what was opened.
///
/// Nothing here decodes anything. The point is the bookkeeping: how many
/// players the pool asks for, and whether it gives them back.
class _FakeVideoPlatform extends VideoPlayerPlatform
    with MockPlatformInterfaceMixin {
  int _next = 1;

  /// Ids handed out, in order.
  final List<int> created = [];

  /// Ids disposed, in order.
  final List<int> disposed = [];

  /// Fails every open, to stand in for a clip that will not play.
  bool failOnCreate = false;

  final Map<int, StreamController<VideoEvent>> _events = {};

  int get live => created.length - disposed.length;

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    if (failOnCreate) throw PlatformException_();
    final id = _next++;
    created.add(id);
    // Not a broadcast controller: the initialised event is queued here, before
    // the controller has subscribed, and a broadcast stream would drop it --
    // which leaves initialize() waiting forever.
    final events = StreamController<VideoEvent>();
    _events[id] = events;
    events.add(
      VideoEvent(
        eventType: VideoEventType.initialized,
        duration: const Duration(seconds: 10),
        size: const Size(640, 360),
      ),
    );
    return id;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) =>
      _events[playerId]?.stream ?? const Stream<VideoEvent>.empty();

  @override
  Future<void> dispose(int playerId) async {
    disposed.add(playerId);
    await _events.remove(playerId)?.close();
  }

  @override
  Future<void> setLooping(int playerId, bool looping) async {}

  @override
  Future<void> setVolume(int playerId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async {}

  @override
  Future<void> play(int playerId) async {}

  @override
  Future<void> pause(int playerId) async {}

  @override
  Future<void> seekTo(int playerId, Duration position) async {}

  @override
  Future<Duration> getPosition(int playerId) async => Duration.zero;

  @override
  Future<void> setMixWithOthers(bool mixWithOthers) async {}

  @override
  Widget buildView(int playerId) => const SizedBox.shrink();
}

class PlatformException_ implements Exception {
  @override
  String toString() => 'no decoder available';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeVideoPlatform platform;

  setUp(() {
    platform = _FakeVideoPlatform();
    VideoPlayerPlatform.instance = platform;
  });

  tearDown(() {
    VideoPool.instance.releaseAll();
  });

  Future<void> openFor(Object owner, String url) =>
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
