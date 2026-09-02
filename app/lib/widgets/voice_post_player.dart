// lib/widgets/voice_post_player.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';
import 'voice_waveform.dart';

/// A voice post: play, the waveform, and how long is left.
///
/// Never autoplays, unlike a clip. A muted video that starts as you scroll
/// past is unobtrusive; audio that starts on its own is not, and there is no
/// muted state that would still be worth playing.
class VoicePostPlayer extends StatefulWidget {
  final PostMedia media;

  const VoicePostPlayer({super.key, required this.media});

  @override
  State<VoicePostPlayer> createState() => _VoicePostPlayerState();
}

class _VoicePostPlayerState extends State<VoicePostPlayer> {
  AudioPlayer? _player;
  StreamSubscription<Duration>? _positions;
  StreamSubscription<PlayerState>? _states;

  Duration _position = Duration.zero;
  bool _playing = false;
  bool _loading = false;
  String? _failure;

  /// The recorded length, which is known before anything is loaded -- so the
  /// row shows a real duration rather than 0:00 until you press play.
  Duration get _total =>
      _player?.duration ?? widget.media.duration ?? Duration.zero;

  @override
  void dispose() {
    unawaited(_positions?.cancel());
    unawaited(_states?.cancel());
    unawaited(_player?.dispose());
    super.dispose();
  }

  /// Loads on first press rather than on build.
  ///
  /// A feed of voice posts would otherwise open a player and fetch a file for
  /// every one on screen, for audio nobody has asked to hear.
  Future<AudioPlayer?> _ensure() async {
    final existing = _player;
    if (existing != null) return existing;

    setState(() {
      _loading = true;
      _failure = null;
    });

    final player = AudioPlayer();
    try {
      await player.setUrl(widget.media.url);
    } catch (_) {
      await player.dispose();
      if (!mounted) return null;
      setState(() {
        _loading = false;
        _failure = 'This recording could not be played.';
      });
      return null;
    }

    if (!mounted) {
      await player.dispose();
      return null;
    }

    _positions = player.positionStream.listen((position) {
      if (mounted) setState(() => _position = position);
    });
    _states = player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() => _playing = state.playing);
      // Back to the start when it ends, so pressing play again replays it
      // rather than doing nothing at the tail.
      if (state.processingState == ProcessingState.completed) {
        unawaited(player.pause());
        unawaited(player.seek(Duration.zero));
      }
    });

    setState(() {
      _player = player;
      _loading = false;
    });
    return player;
  }

  Future<void> _toggle() async {
    unawaited(HapticFeedback.selectionClick());
    final player = await _ensure();
    if (player == null) return;

    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  /// Seeks to wherever along the waveform was tapped.
  Future<void> _seekTo(double fraction) async {
    final player = await _ensure();
    if (player == null) return;
    final total = player.duration;
    if (total == null) return;
    await player.seek(total * fraction.clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final total = _total;
    final progress = total.inMilliseconds == 0
        ? 0.0
        : _position.inMilliseconds / total.inMilliseconds;

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space12,
          vertical: SpacingTokens.space8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            _PlayButton(
              playing: _playing,
              loading: _loading,
              onPressed: _failure == null ? _toggle : null,
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: _failure != null
                  ? Text(
                      _failure!,
                      style: TextStyle(fontSize: 12, color: scheme.error),
                    )
                  : SizedBox(
                      height: 32,
                      child: LayoutBuilder(
                        builder: (context, constraints) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: (details) => _seekTo(
                            details.localPosition.dx / constraints.maxWidth,
                          ),
                          child: VoiceWaveform(
                            levels: widget.media.waveform,
                            progress: progress,
                            color: scheme.primary,
                            trackColor:
                                scheme.onSurface.withValues(alpha: 0.25),
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Text(
              // Counts down while playing and shows the full length at rest,
              // which is what tells you whether a post is worth starting.
              _clock(_playing ? total - _position : total),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _clock(Duration d) {
    final clamped = d.isNegative ? Duration.zero : d;
    final minutes = clamped.inMinutes;
    final seconds = clamped.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _PlayButton extends StatelessWidget {
  final bool playing;
  final bool loading;
  final VoidCallback? onPressed;

  const _PlayButton({
    required this.playing,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = playing ? 'Pause' : 'Play';

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.primary.withValues(alpha: 0.12),
            ),
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(9),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: scheme.primary,
                    ),
                  )
                : Icon(
                    playing ? Iconsax.pause : Iconsax.play,
                    size: 17,
                    color: scheme.primary,
                  ),
          ),
        ),
      ),
    );
  }
}
