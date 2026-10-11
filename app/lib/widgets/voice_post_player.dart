// lib/widgets/voice_post_player.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:just_audio/just_audio.dart';

import '../services/platform_support.dart';

import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';
import 'hairline.dart';
import 'voice_waveform.dart';
import '../l10n/app_localizations.dart';

/// A voice post: play, the waveform, and how long is left.
///
/// Never autoplays, unlike a clip. A muted video that starts as you scroll
/// past is unobtrusive; audio that starts on its own is not, and there is no
/// muted state that would still be worth playing.
///
/// Drawn as a card in a post: the corner a post's pictures have and the
/// hairline its quoted posts have, so a recording reads as one more thing a
/// post can carry rather than a control bolted onto it. It used to be a pill,
/// and a full-width pill with a pale button at one end and a waveform in the
/// middle looked like a slider nobody had asked for.
class VoicePostPlayer extends StatefulWidget {
  final PostMedia media;

  /// Whether it draws its own card. Off inside a message bubble, where the
  /// bubble is already the frame and a card in it is a box in a box.
  final bool framed;

  /// What the player is drawn in: the button, the played bars, the clock.
  /// The accent by default. A bubble filled with the accent hands its own
  /// ink, or the waveform would be drawn in the colour it sits on.
  final Color? ink;

  /// The icon on the button, which is filled with [ink].
  final Color? onInk;

  const VoicePostPlayer({
    super.key,
    required this.media,
    this.framed = true,
    this.ink,
    this.onInk,
  });

  /// The play button's size: the design system's small button height, so it
  /// is a comfortable target and the same size as the other small controls.
  static const double buttonSize = 40;

  /// How tall the waveform is drawn, the same as the button beside it.
  static const double waveformHeight = buttonSize;

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

    // just_audio ships android, ios, macos and web. Said here rather than
    // discovered as a missing plugin when the play button is pressed.
    if (!PlatformSupport.current.audio) {
      setState(() {
        _loading = false;
        _failure = 'Voice posts need an audio player Kyron does not have on '
            '${PlatformSupport.current.name} yet.';
      });
      return null;
    }

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
    final ink = widget.ink ?? scheme.primary;
    final quiet = widget.ink ?? scheme.onSurface;
    final total = _total;
    final progress = total.inMilliseconds == 0
        ? 0.0
        : _position.inMilliseconds / total.inMilliseconds;

    final row = Row(
      children: [
        _PlayButton(
          playing: _playing,
          loading: _loading,
          color: ink,
          iconColor: widget.onInk ?? scheme.onPrimary,
          onPressed: _failure == null ? _toggle : null,
        ),
        const SizedBox(width: SpacingTokens.space12),
        Expanded(
          child: _failure != null
              ? Text(
                  _failure!,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    height: TypographyTokens.lineHeightSnug,
                    color: scheme.error,
                  ),
                )
              : SizedBox(
                  height: VoicePostPlayer.waveformHeight,
                  child: LayoutBuilder(
                    builder: (context, constraints) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (details) => _seekTo(
                        details.localPosition.dx / constraints.maxWidth,
                      ),
                      child: VoiceWaveform(
                        levels: widget.media.waveform,
                        progress: progress,
                        color: ink,
                        trackColor: quiet.withValues(
                          alpha: widget.ink == null ? 0.22 : 0.35,
                        ),
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
            fontSize: TypographyTokens.fontSize2,
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: quiet.withValues(alpha: 0.6),
          ),
        ),
      ],
    );

    if (!widget.framed) return row;

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space12,
          SpacingTokens.space12,
          SpacingTokens.space16,
          SpacingTokens.space12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.fromBorderSide(postRule(scheme)),
        ),
        child: row,
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
  final Color color;
  final Color iconColor;
  final VoidCallback? onPressed;

  const _PlayButton({
    required this.playing,
    required this.loading,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label =
        playing ? l10n.ui('ui_pause', 'Pause') : l10n.ui('ui_play', 'Play');
    // Greyed with the rest of a recording that cannot be played, rather than
    // a bright button that does nothing.
    final fill = onPressed == null ? color.withValues(alpha: 0.35) : color;

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: Material(
          color: fill,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: VoicePostPlayer.buttonSize,
              child: loading
                  ? Padding(
                      padding: const EdgeInsets.all(11),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: iconColor,
                      ),
                    )
                  : Padding(
                      // A triangle's weight sits left of its box's centre;
                      // nudged so it looks centred, which is the only centre
                      // anyone sees.
                      padding: EdgeInsets.only(left: playing ? 0 : 2),
                      child: Icon(
                        playing ? Iconsax.pause : Iconsax.play,
                        size: 18,
                        color: iconColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
