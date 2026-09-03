// lib/services/video_stage.dart
import 'dart:async';

/// Told to a clip when it takes or loses the stage.
typedef StageChanged = void Function(bool active);

class _Candidate {
  double visibleFraction;

  /// How far this clip's middle is from the middle of the screen, in pixels.
  double distance;

  final StageChanged onChanged;

  _Candidate({
    required this.visibleFraction,
    required this.distance,
    required this.onChanged,
  });
}

/// Decides which single clip is playing.
///
/// Every tile used to decide for itself: on screen enough, so play. Two or
/// three clips can be on screen enough at once, so a list of them started all
/// of them -- and because they take turns for a decoder, the one arriving from
/// the bottom of the screen stopped the one being watched in the middle of it.
///
/// This is how the apps that get it right do it. The decision is not the
/// tile's; it belongs to the list. Each clip reports how much of it is showing
/// and how far its middle is from the middle of the screen, and exactly one --
/// the most central -- is told to play.
///
/// Handing over takes a margin. Without one, two clips a few pixels apart swap
/// the stage back and forth on every frame of a slow scroll, which is worse
/// than either of them playing.
class VideoStage {
  VideoStage._();

  static final VideoStage instance = VideoStage._();

  /// How much of a clip has to be showing before it is worth playing at all.
  static const double minVisible = 0.55;

  /// How much closer to the middle a challenger has to be before it takes the
  /// stage from whatever holds it.
  static const double switchMargin = 40;

  final Map<Object, _Candidate> _candidates = {};
  Object? _active;
  bool _scheduled = false;

  /// Which clip is playing, or null when none is. Read by tests.
  Object? get active => _active;

  /// Says where [owner] is. Called as a clip scrolls.
  void report(
    Object owner, {
    required double visibleFraction,
    required double distance,
    required StageChanged onChanged,
  }) {
    final existing = _candidates[owner];
    if (existing == null) {
      _candidates[owner] = _Candidate(
        visibleFraction: visibleFraction,
        distance: distance,
        onChanged: onChanged,
      );
    } else {
      existing.visibleFraction = visibleFraction;
      existing.distance = distance;
    }
    _schedule();
  }

  /// Takes [owner] out of the running -- it has scrolled away, or gone.
  void withdraw(Object owner) {
    if (_candidates.remove(owner) == null) return;
    if (identical(_active, owner)) _active = null;
    _schedule();
  }

  /// Recomputes once per turn rather than once per report. A scroll moves
  /// every clip on screen at once, and each of them reports.
  void _schedule() {
    if (_scheduled) return;
    _scheduled = true;
    scheduleMicrotask(() {
      _scheduled = false;
      _settle();
    });
  }

  void _settle() {
    final next = _pick();
    if (identical(next, _active)) return;

    final previous = _active;
    _active = next;

    // Stopped first, so two clips are never both playing across the handover.
    if (previous != null) _candidates[previous]?.onChanged(false);
    if (next != null) _candidates[next]?.onChanged(true);
  }

  /// The clip that should be playing.
  Object? _pick() {
    Object? best;
    var bestDistance = double.infinity;

    for (final entry in _candidates.entries) {
      if (entry.value.visibleFraction < minVisible) continue;
      if (entry.value.distance < bestDistance) {
        best = entry.key;
        bestDistance = entry.value.distance;
      }
    }

    final current = _active;
    final holding = current == null ? null : _candidates[current];
    // Whoever holds the stage keeps it while they are still worth watching,
    // unless the challenger is clearly more central. Otherwise two clips a few
    // pixels apart trade it on every frame.
    if (holding != null && holding.visibleFraction >= minVisible) {
      if (best == null || bestDistance > holding.distance - switchMargin) {
        return current;
      }
    }
    return best;
  }

  /// Clears the stage. Used by tests between cases.
  void reset() {
    _candidates.clear();
    _active = null;
  }
}
