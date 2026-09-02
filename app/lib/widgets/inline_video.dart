// lib/widgets/inline_video.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_media.dart';

/// A clip as it appears in the feed.
///
/// What stood here drew a grey rectangle with a play glyph on it and nothing
/// else -- no first frame, no controls, and no playback until the attachment
/// was opened in the full-screen viewer. Which is why every video post read as
/// blank.
///
/// This initialises the player in place, which is what produces a poster: the
/// first frame is what `VideoPlayer` paints before anything is playing. It
/// then plays and pauses itself as it scrolls in and out of view.
class InlineVideo extends StatefulWidget {
  final PostMedia media;

  /// Start playing, muted, once enough of the tile is on screen.
  ///
  /// Muted because an autoplaying clip that makes noise while someone is
  /// reading is hostile; tapping the speaker turns it on deliberately.
  final bool autoplay;

  /// Opens the full-screen viewer. Null leaves the tile playing in place.
  final VoidCallback? onExpand;

  const InlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
    this.onExpand,
  });

  @override
  State<InlineVideo> createState() => _InlineVideoState();
}

class _InlineVideoState extends State<InlineVideo> {
  VideoPlayerController? _controller;

  /// Non-null once initialisation failed. Kept so the tile can say so rather
  /// than spinning forever on a clip that will never load.
  String? _failure;

  bool _muted = true;

  /// Whether the user has taken control. Once they have, scrolling the tile
  /// out of view still pauses it, but scrolling back does not resume: a clip
  /// somebody deliberately paused must stay paused.
  bool _manual = false;

  /// Hides the controls a moment after they appear, the way a player does.
  bool _controlsVisible = true;
  Timer? _hideControls;

  @override
  void initState() {
    super.initState();
    unawaited(_open());
  }

  Future<void> _open() async {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.media.url),
    );
    _controller = controller;

    try {
      await controller.initialize();
      await controller.setVolume(0);
      await controller.setLooping(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _failure = 'This clip could not be played.');
      return;
    }

    if (!mounted) {
      unawaited(controller.dispose());
      return;
    }
    // Rebuilds on every frame of playback, which is what moves the scrubber.
    controller.addListener(_onTick);
    setState(() {});
    _scheduleHide();
  }

  void _onTick() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _hideControls?.cancel();
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  void _scheduleHide() {
    _hideControls?.cancel();
    _hideControls = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _controlsVisible = false);
    });
  }

  void _onVisibility(VisibilityInfo info) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    // Half on screen before it starts. Lower and two clips either side of a
    // boundary would both be playing.
    final visible = info.visibleFraction > 0.5;

    if (!visible && controller.value.isPlaying) {
      unawaited(controller.pause());
    } else if (visible &&
        widget.autoplay &&
        !_manual &&
        !controller.value.isPlaying) {
      unawaited(controller.play());
    }
  }

  Future<void> _togglePlay() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    _manual = true;
    if (controller.value.isPlaying) {
      await controller.pause();
      _hideControls?.cancel();
      if (mounted) setState(() => _controlsVisible = true);
    } else {
      await controller.play();
      _scheduleHide();
    }
    if (mounted) setState(() {});
  }

  Future<void> _toggleMute() async {
    final controller = _controller;
    if (controller == null) return;
    _muted = !_muted;
    await controller.setVolume(_muted ? 0 : 1);
    if (mounted) setState(() {});
    _scheduleHide();
  }

  void _showControls() {
    setState(() => _controlsVisible = true);
    _scheduleHide();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final controller = _controller;

    if (_failure != null) {
      return _Placeholder(
        scheme: scheme,
        icon: Iconsax.video_slash_copy,
        label: _failure!,
      );
    }

    if (controller == null || !controller.value.isInitialized) {
      return _Placeholder(scheme: scheme, icon: Iconsax.video_copy);
    }

    final playing = controller.value.isPlaying;

    return VisibilityDetector(
      // Keyed by the attachment, so two clips in one post are tracked apart.
      key: Key('inline-video-${widget.media.id}'),
      onVisibilityChanged: _onVisibility,
      child: GestureDetector(
        onTap: _controlsVisible ? _togglePlay : _showControls,
        child: ColoredBox(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),

              // A scrim under the controls, so white glyphs stay legible over
              // a bright frame.
              AnimatedOpacity(
                opacity: _controlsVisible ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00000000), Color(0x8C000000)],
                    ),
                  ),
                ),
              ),

              // Filled, not outlined. An outline play triangle reads as a
              // button that has not been pressed yet; this is the state of the
              // clip, so it is solid.
              AnimatedOpacity(
                opacity: _controlsVisible || !playing ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: Center(
                  child: _RoundControl(
                    icon: playing ? Icons.pause_rounded : Icons.play_arrow,
                    size: 30,
                    diameter: 52,
                    tooltip: playing ? 'Pause' : 'Play',
                    onPressed: _togglePlay,
                  ),
                ),
              ),

              Positioned(
                right: SpacingTokens.space8,
                top: SpacingTokens.space8,
                child: AnimatedOpacity(
                  opacity: _controlsVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: _RoundControl(
                    icon: _muted ? Icons.volume_off : Icons.volume_up,
                    size: 18,
                    diameter: 32,
                    tooltip: _muted ? 'Unmute' : 'Mute',
                    onPressed: _toggleMute,
                  ),
                ),
              ),

              if (widget.onExpand != null)
                Positioned(
                  left: SpacingTokens.space8,
                  top: SpacingTokens.space8,
                  child: AnimatedOpacity(
                    opacity: _controlsVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: _RoundControl(
                      icon: Icons.fullscreen,
                      size: 20,
                      diameter: 32,
                      tooltip: 'Full screen',
                      onPressed: widget.onExpand!,
                    ),
                  ),
                ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedOpacity(
                      opacity: _controlsVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: SpacingTokens.space8,
                          bottom: SpacingTokens.space4,
                        ),
                        child: Text(
                          _clock(controller.value),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Always visible: it is how you tell a playing clip from a
                    // stalled one once the controls have faded.
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      padding: EdgeInsets.zero,
                      colors: VideoProgressColors(
                        playedColor: scheme.primary,
                        bufferedColor: Colors.white24,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// `1:04 / 3:12`, or just the duration before playback starts.
  static String _clock(VideoPlayerValue value) {
    String format(Duration d) {
      final minutes = d.inMinutes;
      final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }

    return '${format(value.position)} / ${format(value.duration)}';
  }
}

class _RoundControl extends StatelessWidget {
  final IconData icon;
  final double size;
  final double diameter;
  final String tooltip;
  final VoidCallback onPressed;

  const _RoundControl({
    required this.icon,
    required this.size,
    required this.diameter,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: diameter,
            height: diameter,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x8C000000),
            ),
            child: Icon(icon, size: size, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final ColorScheme scheme;
  final IconData icon;
  final String? label;

  const _Placeholder({required this.scheme, required this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: scheme.onSurface.withValues(alpha: .4)),
            if (label != null) ...[
              const SizedBox(height: SpacingTokens.space8),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space16),
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface.withValues(alpha: .6),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
