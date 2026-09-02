// lib/widgets/create_post/voice_recorder_sheet.dart
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../models/post_media.dart';
import '../action_button.dart';
import '../voice_waveform.dart';

/// Recording a voice post.
///
/// The waveform is sampled here, while the microphone is open, because that is
/// the only place the signal exists. Reading it back off the finished file
/// would mean decoding the audio again, and doing it on the server would mean
/// decoding every upload just to draw a picture of it.
class VoiceRecorderSheet {
  /// Opens the recorder and answers with the recording, or null if it was
  /// cancelled or never started.
  static Future<PendingMedia?> show(BuildContext context) {
    return showModalBottomSheet<PendingMedia>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: true,
      builder: (_) => const _Sheet(),
    );
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet();

  @override
  State<_Sheet> createState() => _SheetState();
}

enum _Stage { idle, recording, recorded }

class _SheetState extends State<_Sheet> {
  final AudioRecorder _recorder = AudioRecorder();

  _Stage _stage = _Stage.idle;
  String? _path;
  String? _failure;

  Duration _elapsed = Duration.zero;
  Timer? _ticker;
  StreamSubscription<Amplitude>? _amplitudes;

  /// One value per bar, 0-100.
  final List<int> _waveform = [];

  /// The longest a voice post may run. Matches the server's cap.
  static const _limit = Duration(minutes: 10);

  /// How often loudness is sampled. Ten a second is smooth enough to look
  /// alive and coarse enough that ten minutes still fits [maxBars].
  static const _sampleEvery = Duration(milliseconds: 100);

  @override
  void dispose() {
    _ticker?.cancel();
    unawaited(_amplitudes?.cancel());
    unawaited(_recorder.dispose());
    super.dispose();
  }

  Future<void> _start() async {
    setState(() => _failure = null);

    if (!await _recorder.hasPermission()) {
      setState(() => _failure =
          'Kyron needs permission to use the microphone to record a voice '
              'post. You can grant it in your device settings.');
      return;
    }

    final directory = await getTemporaryDirectory();
    final path =
        '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    try {
      await _recorder.start(
        // AAC in an m4a container: played by every browser and both phone
        // platforms without a transcode step on our side.
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 96000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: path,
      );
    } catch (error) {
      setState(() => _failure = 'Could not start recording: $error');
      return;
    }

    _path = path;
    _waveform.clear();
    _elapsed = Duration.zero;

    _amplitudes =
        _recorder.onAmplitudeChanged(_sampleEvery).listen(_onAmplitude);
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() => _elapsed += const Duration(milliseconds: 200));
      if (_elapsed >= _limit) unawaited(_stop());
    });

    unawaited(HapticFeedback.selectionClick());
    setState(() => _stage = _Stage.recording);
  }

  void _onAmplitude(Amplitude amplitude) {
    // `current` is decibels, roughly -60 (silence) to 0 (clipping). Mapped
    // onto 0-100 so the bars are a percentage of full height rather than a
    // negative number nobody can draw.
    final db = amplitude.current;
    final normalised = db.isFinite ? ((db + 60) / 60).clamp(0.0, 1.0) : 0.0;

    // Square-rooted, because loudness in decibels is logarithmic and a linear
    // mapping leaves ordinary speech as a barely visible ripple.
    final level = (math.sqrt(normalised) * 100).round();

    if (_waveform.length < VoiceWaveform.maxBars) {
      _waveform.add(level);
    } else {
      // Past the cap, halve the resolution rather than stop drawing: every
      // other bar is dropped and new ones keep arriving, so a long recording
      // stays a picture of the whole thing rather than of its first minute.
      for (var i = 0; i < _waveform.length ~/ 2; i++) {
        _waveform[i] = math.max(_waveform[i * 2], _waveform[i * 2 + 1]);
      }
      _waveform.removeRange(_waveform.length ~/ 2, _waveform.length);
      _waveform.add(level);
    }
  }

  Future<void> _stop() async {
    _ticker?.cancel();
    await _amplitudes?.cancel();
    _amplitudes = null;

    try {
      final path = await _recorder.stop();
      _path = path ?? _path;
    } catch (error) {
      setState(() => _failure = 'Could not finish the recording: $error');
      return;
    }

    unawaited(HapticFeedback.selectionClick());
    if (mounted) setState(() => _stage = _Stage.recorded);
  }

  Future<void> _discard() async {
    final path = _path;
    _path = null;
    setState(() {
      _stage = _Stage.idle;
      _elapsed = Duration.zero;
      _waveform.clear();
    });
    // Deleted rather than left behind: a discarded recording is somebody's
    // voice sitting in a cache directory.
    if (path != null) {
      unawaited(File(path).delete().catchError((_) => File(path)));
    }
  }

  void _use() {
    final path = _path;
    if (path == null) return;
    Navigator.pop(
      context,
      PendingMedia(
        path: path,
        kind: MediaKind.voice,
        duration: _elapsed,
        waveform: List<int>.unmodifiable(_waveform),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        0,
        SpacingTokens.space20,
        SpacingTokens.space24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  switch (_stage) {
                    _Stage.idle => 'Record a voice post',
                    _Stage.recording => 'Recording…',
                    _Stage.recorded => 'Ready to attach',
                  },
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (_stage != _Stage.recording)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space16),
          Container(
            height: 68,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            ),
            child: Center(
              child: _waveform.isEmpty
                  ? Text(
                      _stage == _Stage.idle
                          ? 'Up to ten minutes.'
                          : 'Listening…',
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    )
                  : VoiceWaveform(
                      levels: _waveform,
                      // Nothing has played yet, so nothing is filled in.
                      progress: _stage == _Stage.recording ? 1 : 0,
                      color: scheme.primary,
                      trackColor: scheme.onSurface.withValues(alpha: 0.25),
                    ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            _clock(_elapsed),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: _stage == _Stage.recording
                  ? scheme.error
                  : scheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          if (_failure != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            Text(
              _failure!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: scheme.error),
            ),
          ],
          const SizedBox(height: SpacingTokens.space20),
          switch (_stage) {
            _Stage.idle => ActionButton(
                label: 'Start recording',
                icon: Iconsax.microphone_copy,
                expand: true,
                onPressed: _start,
              ),
            _Stage.recording => ActionButton(
                label: 'Stop',
                icon: Icons.stop_rounded,
                expand: true,
                destructive: true,
                onPressed: _stop,
              ),
            _Stage.recorded => Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      label: 'Record again',
                      icon: Iconsax.refresh_copy,
                      kind: ActionButtonKind.outlined,
                      expand: true,
                      onPressed: _discard,
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: ActionButton(
                      label: 'Attach',
                      icon: Iconsax.tick_circle_copy,
                      expand: true,
                      onPressed: _use,
                    ),
                  ),
                ],
              ),
          },
        ],
      ),
    );
  }

  static String _clock(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
