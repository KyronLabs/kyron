// lib/services/impression_reporter.dart
import 'dart:async';

import 'package:flutter/widgets.dart';

/// Tells the server which For You posts have been on screen.
///
/// The feed ranked on what somebody had opened, and nothing else, so a post
/// they scrolled past every day looked unseen to it and headed For You every
/// session. This is the other half: a post counts as shown once it has been
/// at least half on screen for [dwell], and is reported once per session --
/// a session being one ranking of the feed, from a refresh to the next.
///
/// Best effort. Reports are batched, and a batch that fails is dropped rather
/// than retried: a missed impression costs one post one place in a later
/// feed, and a queue of retries on a bad connection costs more than that.
class ImpressionReporter with WidgetsBindingObserver {
  ImpressionReporter(this._send);

  final Future<void> Function(List<String> postIds) _send;

  /// Watching for the app going to the background starts with the first
  /// post shown, not on construction: the feed's state is built in places
  /// with no widget binding at all, and before anything is shown there is
  /// nothing to send.
  bool _observing = false;

  /// How long a card has to stay on screen to count. Long enough that a fast
  /// flick through the feed does not mark everything it passed.
  static const dwell = Duration(milliseconds: 700);

  /// How long reports gather before they are sent together.
  static const batchDelay = Duration(seconds: 4);

  /// The server takes at most fifty at once.
  static const batchSize = 50;

  final _reported = <String>{};
  final _pending = <String>{};
  Timer? _timer;

  /// A new ranking of the feed has begun: what was shown before may be shown
  /// again, and counts again.
  void startSession() {
    _flush();
    _reported.clear();
  }

  /// [postId] has been on screen long enough to count.
  void shown(String postId) {
    if (!_reported.add(postId)) return;
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    _pending.add(postId);
    if (_pending.length >= batchSize) {
      _flush();
    } else {
      _timer ??= Timer(batchDelay, _flush);
    }
  }

  void _flush() {
    _timer?.cancel();
    _timer = null;
    if (_pending.isEmpty) return;
    final batch = _pending.take(batchSize).toList();
    _pending.removeAll(batch);
    unawaited(_send(batch).catchError((Object _) {}));
    if (_pending.isNotEmpty) _timer = Timer(batchDelay, _flush);
  }

  /// Sends what has gathered when the app goes to the background, which is
  /// often the last chance: a phone may never bring it back.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _flush();
    }
  }

  void dispose() {
    _flush();
    if (_observing) WidgetsBinding.instance.removeObserver(this);
  }
}
