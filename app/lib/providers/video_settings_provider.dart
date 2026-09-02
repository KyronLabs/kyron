// lib/providers/video_settings_provider.dart
import 'package:flutter_riverpod/legacy.dart';

import '../services/app_preferences.dart';
import 'preferences_provider.dart';

/// Whether video plays silently, for every clip everywhere.
///
/// One answer rather than one per player. Sound used to be a property of
/// whichever tile you had tapped, so watching a feed of clips meant unmuting
/// each one in turn, and opening a clip full screen started it silent again
/// however loudly it had just been playing.
///
/// Muted on a fresh install: a feed that starts talking is hostile.
final videoMutedProvider =
    StateNotifierProvider<VideoMutedNotifier, bool>((ref) {
  return VideoMutedNotifier(ref.read(appPreferencesProvider));
});

class VideoMutedNotifier extends StateNotifier<bool> {
  final AppPreferences _store;

  VideoMutedNotifier(this._store) : super(true) {
    _load();
  }

  Future<void> _load() async {
    final muted = await _store.readVideoMuted();
    if (mounted) state = muted;
  }

  Future<void> toggle() => set(!state);

  Future<void> set(bool muted) async {
    if (state == muted) return;
    // Set first, written after: the button has to answer the tap, and a slow
    // disk write is not a reason for it to sit there looking unpressed.
    state = muted;
    await _store.writeVideoMuted(muted);
  }
}
