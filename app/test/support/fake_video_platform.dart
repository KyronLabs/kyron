// test/support/fake_video_platform.dart
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

/// A video platform that opens instantly and remembers what was opened.
///
/// Nothing here decodes anything. The point is the bookkeeping: how many
/// players the pool asks for, and whether it gives them back.
class FakeVideoPlatform extends VideoPlayerPlatform
    with MockPlatformInterfaceMixin {
  int _next = 1;

  /// Ids handed out, in order.
  final List<int> created = [];

  /// Ids disposed, in order.
  final List<int> disposed = [];

  /// Fails every open, to stand in for a clip that will not play.
  bool failOnCreate = false;

  /// The frame size every clip reports. Landscape by default, which is the
  /// shape the screen has to letterbox rather than crop.
  Size reportedSize = const Size(640, 360);

  final Map<int, StreamController<VideoEvent>> _events = {};

  int get live => created.length - disposed.length;

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    if (failOnCreate) throw FakeVideoFailure();
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
        size: reportedSize,
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

class FakeVideoFailure implements Exception {
  @override
  String toString() => 'no decoder available';
}
