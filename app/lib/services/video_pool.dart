// lib/services/video_pool.dart
import 'dart:async';

import 'package:video_player/video_player.dart';

/// Called when a clip's decoder is taken away, so the tile can go back to
/// showing its still.
typedef VideoEviction = void Function();

enum _LeaseState {
  /// The controller is still being opened.
  opening,

  /// Open and in use.
  ready,

  /// Given up on -- the tile went away, or the lease was taken back -- but
  /// still opening, so there is nothing to dispose yet.
  cancelled,
}

class _Lease {
  final Object owner;
  final VideoPlayerController controller;
  final VideoEviction onEvicted;

  _LeaseState state = _LeaseState.opening;

  /// When this lease was last used. Highest is most recent.
  int stamp;

  _Lease({
    required this.owner,
    required this.controller,
    required this.onEvicted,
    required this.stamp,
  });
}

/// A bounded set of open video decoders.
///
/// A phone will only decode so many videos at once -- the hardware has a fixed
/// number of decoder instances, and once they are gone the next one fails.
/// What that looks like from the outside is a tile that paints for a moment
/// and then turns black, or a whole screen that does, which is exactly what a
/// feed of clips and a wall of them were doing.
///
/// So a decoder is a leased resource rather than something a widget owns.
/// Every clip on screen shows its still; the handful that are actually being
/// watched hold a lease, and the least recently used one is taken back when a
/// new clip needs it. The ceiling is the app's, not the hardware's, so it is
/// reached predictably and handled rather than crashed into.
class VideoPool {
  VideoPool._();

  static final VideoPool instance = VideoPool._();

  /// How many clips may hold a decoder at once.
  ///
  /// Three: the one being watched, the one either side of it. Well under any
  /// device's ceiling, and low enough to leave room for whatever else on the
  /// phone is decoding something.
  static const int budget = 3;

  final List<_Lease> _leases = [];
  int _clock = 0;

  /// How many decoders are accounted for, including ones still opening and
  /// ones being given up. Read by tests.
  int get liveCount => _leases.length;

  /// Opens a decoder for [url] on behalf of [owner].
  ///
  /// Returns null when there was no decoder to be had, or when the lease was
  /// given up while it was still opening. Either way the caller has nothing to
  /// show and should stay on its still; it is free to ask again in a moment.
  /// Throws if the clip itself cannot be played, which is a different thing
  /// and worth saying out loud.
  Future<VideoPlayerController?> open(
    String url, {
    required Object owner,
    required VideoEviction onEvicted,
  }) async {
    final existing = _leaseFor(owner);
    if (existing != null) {
      existing.stamp = ++_clock;
      return existing.controller;
    }

    if (!_makeRoom()) return null;

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    // The lease is taken before the await, not after: two tiles scrolling into
    // view together would otherwise both see room and both open a decoder,
    // which is how a budget of three becomes five.
    final lease = _Lease(
      owner: owner,
      controller: controller,
      onEvicted: onEvicted,
      stamp: ++_clock,
    );
    _leases.add(lease);

    try {
      await controller.initialize();
    } catch (_) {
      _leases.remove(lease);
      unawaited(controller.dispose());
      rethrow;
    }

    if (lease.state == _LeaseState.cancelled) {
      // Given up on while it was opening. Disposing it now rather than then is
      // the whole reason cancellation is a state: disposing a controller
      // mid-initialise leaves initialize() waiting on an event the disposed
      // controller will never act on, and this future would never complete.
      _leases.remove(lease);
      unawaited(controller.dispose());
      return null;
    }

    lease.state = _LeaseState.ready;
    return controller;
  }

  /// Marks [owner]'s lease as the most recently used, so it is the last to be
  /// taken back.
  void touch(Object owner) {
    final lease = _leaseFor(owner);
    if (lease != null) lease.stamp = ++_clock;
  }

  /// Gives back [owner]'s decoder. Safe to call when it holds none.
  void release(Object owner) {
    final lease = _leaseFor(owner);
    if (lease == null) return;
    _retire(lease);
  }

  /// The lease [owner] holds, if it is still theirs to use.
  _Lease? _leaseFor(Object owner) {
    for (final lease in _leases) {
      if (identical(lease.owner, owner) &&
          lease.state != _LeaseState.cancelled) {
        return lease;
      }
    }
    return null;
  }

  /// Ends a lease: disposed now if it is open, marked for disposal by [open]
  /// if it is still being opened.
  ///
  /// A cancelled lease keeps its place in the list until it settles. It is a
  /// decoder the hardware still has open, and pretending otherwise is how a
  /// budget of three becomes six on a fast scroll.
  void _retire(_Lease lease) {
    if (lease.state == _LeaseState.opening) {
      lease.state = _LeaseState.cancelled;
      return;
    }
    _leases.remove(lease);
    unawaited(lease.controller.dispose());
  }

  /// Frees a slot if the budget is already spent.
  ///
  /// False when it could not: every lease is still opening, so there is
  /// nothing that can safely be taken back yet.
  bool _makeRoom() {
    while (_leases.length >= budget) {
      final victim = _oldest();
      if (victim == null) return false;
      _retire(victim);
      victim.onEvicted();
    }
    return true;
  }

  /// The lease to take back first: the least recently used *open* one that is
  /// not playing, or failing that the least recently used open one at all.
  /// Taking a clip away from someone watching it is the last resort, not the
  /// first, and one that is still opening cannot be taken at all.
  _Lease? _oldest() {
    _Lease? idle;
    _Lease? any;
    for (final lease in _leases) {
      if (lease.state != _LeaseState.ready) continue;
      if (any == null || lease.stamp < any.stamp) any = lease;
      if (!lease.controller.value.isPlaying &&
          (idle == null || lease.stamp < idle.stamp)) {
        idle = lease;
      }
    }
    return idle ?? any;
  }

  /// Drops every decoder. Used when a screen carrying clips is torn down and
  /// by tests between cases.
  void releaseAll() {
    for (final lease in List<_Lease>.of(_leases)) {
      _retire(lease);
    }
  }
}
