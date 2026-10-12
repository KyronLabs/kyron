// lib/widgets/voice_post_player.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
/// Drawn as a card in a post, the height of the reply box: the corner a
/// post's pictures have and the hairline its quoted posts have. The play
/// button is the icon alone, in the text colour -- a coloured disc behind it
/// made a recording the loudest thing in a post.
class VoicePostPlayer extends StatefulWidget {
  final PostMedia media;

  /// Whether it draws its own card. Off inside a message bubble, where the
  /// bubble is already the frame and a card in it is a box in a box.
  final bool framed;

  /// What the player is drawn in: the icon, the played bars and the clock.
  /// The text colour for the icon and the accent for the bars by default. A
  /// bubble filled with the accent hands its own ink, or the bars would be
  /// drawn in the colour they sit on.
  final Color? ink;

  const VoicePostPlayer({
    super.key,
    required this.media,
    this.framed = true,
    this.ink,
  });

  /// The whole card's height: the reply box's, so the two read as the same
  /// size of thing.
  static const double height = 44;

  /// The play button's target. The icon in it is smaller; the target is not.
  static const double buttonSize = 40;

  static const double iconSize = 24;

  /// How tall the waveform is drawn.
  static const double waveformHeight = 24;

  @override
  State<VoicePostPlayer> createState() => _VoicePostPlayerState();
}

class _VoicePostPlayerState extends State<VoicePostPlayer>
    with SingleTickerProviderStateMixin {
  AudioPlayer? _player;

  /// Reads the position every frame while playing. The player's own stream
  /// reports a few times a second, so a fill drawn from it moves in steps;
  /// its `position` is interpolated against the clock, so reading it once a
  /// frame moves the fill continuously, like a progress bar.
  late final Ticker _frames = createTicker(_onFrame);
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

  void _onFrame(Duration _) {
    final player = _player;
    if (player == null || !mounted) return;
    setState(() => _position = player.position);
  }

  @override
  void dispose() {
    _frames.dispose();
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
      // A voice note still going up plays from the file on this phone; a
      // bare path is not a URL, and handed to setUrl it does not play.
      final source = widget.media.url;
      if (source.startsWith('/')) {
        await player.setFilePath(source);
      } else {
        await player.setUrl(source);
      }
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

    // At rest -- after a seek, say -- the stream is what moves the fill;
    // while playing, the frame ticker does.
    _positions = player.positionStream.listen((position) {
      if (mounted && !_frames.isActive) setState(() => _position = position);
    });
    _states = player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() => _playing = state.playing);
      final running =
          state.playing && state.processingState != ProcessingState.completed;
      if (running && !_frames.isActive) {
        unawaited(_frames.start());
      } else if (!running && _frames.isActive) {
        _frames.stop();
        _position = player.position;
      }
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
    final icon = widget.ink ?? scheme.onSurface;
    final bars = widget.ink ?? scheme.primary;
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
          color: icon,
          onPressed: _failure == null ? _toggle : null,
        ),
        const SizedBox(width: SpacingTokens.space4),
        Expanded(
          child: _failure != null
              ? Text(
                  _failure!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
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
                        // Read every frame already; easing on top of that
                        // would only make the fill trail the sound.
                        smoothing: Duration.zero,
                        color: bars,
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
            fontSize: TypographyTokens.fontSize1,
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
        height: VoicePostPlayer.height,
        padding: const EdgeInsets.only(
          left: SpacingTokens.space2,
          right: SpacingTokens.space12,
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
  final VoidCallback? onPressed;

  const _PlayButton({
    required this.playing,
    required this.loading,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label =
        playing ? l10n.ui('ui_pause', 'Pause') : l10n.ui('ui_play', 'Play');
    // Faded with a recording that cannot be played, rather than a button
    // that looks ready and does nothing.
    final ink = onPressed == null ? color.withValues(alpha: 0.35) : color;

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        // The icon and nothing behind it. The splash is the only thing a
        // press draws, and it is round and gone when the finger lifts.
        child: InkResponse(
          onTap: onPressed,
          radius: VoicePostPlayer.buttonSize / 2,
          child: SizedBox.square(
            dimension: VoicePostPlayer.buttonSize,
            child: Center(
              child: loading
                  ? SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ink,
                      ),
                    )
                  : Icon(
                      // The filled glyphs: an outline at this size reads as
                      // a symbol, not a button.
                      playing ? Iconsax.pause : Iconsax.play,
                      size: VoicePostPlayer.iconSize,
                      color: ink,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
