// lib/widgets/inline_video.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_media.dart';

/// A clip as it appears in the feed.
///
/// Sizes itself to the video, rather than the other way round. It used to be
/// dropped into a box of a fixed ratio, so a portrait clip was letterboxed
/// with a black bar down each side and a landscape one was cropped -- the
/// reason a video post looked wrong whatever shape the video was.
///
/// The player also *is* the poster: `VideoPlayer` paints the first frame once
/// initialised, so there is nothing to fetch separately and nothing to show
/// before the clip is ready to play.
class InlineVideo extends StatefulWidget {
  final PostMedia media;

  /// Start playing, muted, once enough of the tile is on screen.
  ///
  /// Muted because an autoplaying clip that makes noise while someone is
  /// reading is hostile; tapping the speaker turns it on deliberately.
  final bool autoplay;

  /// Opens the full-screen viewer. Null leaves the tile playing in place.
  final VoidCallback? onExpand;

  /// Draw the controls. False on a wall of tiles, where a scrubber and a
  /// volume button on every thumbnail is noise -- the tile is a link to the
  /// post, not a player.
  final bool chrome;

  const InlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
    this.onExpand,
    this.chrome = true,
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
    } catch (_) {
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
    unawaited(HapticFeedback.selectionClick());
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
    unawaited(HapticFeedback.selectionClick());
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

    // The video fills the frame it is given. Sizing to the clip's own ratio is
    // the caller's job -- see InlineVideo.sized -- so that a tile in a grid can
    // still be square if the grid needs it to be.
    final surface = Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
        if (widget.chrome) ..._chrome(scheme, controller, playing),
      ],
    );

    return VisibilityDetector(
      // Keyed by the attachment, so two clips in one post are tracked apart.
      key: Key('inline-video-${widget.media.id}'),
      onVisibilityChanged: _onVisibility,
      child: widget.chrome
          ? GestureDetector(
              onTap: _controlsVisible ? _togglePlay : _showControls,
              child: surface,
            )
          : surface,
    );
  }

  List<Widget> _chrome(
    ColorScheme scheme,
    VideoPlayerController controller,
    bool playing,
  ) {
    return [
      // A scrim under the controls, so white glyphs stay legible over a
      // bright frame.
      AnimatedOpacity(
        opacity: _controlsVisible ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0x00000000), Color(0x99000000)],
            ),
          ),
        ),
      ),

      // Filled, not outlined. An outline play triangle reads as a button that
      // has not been pressed yet; this is the state of the clip, so it is
      // solid.
      AnimatedOpacity(
        opacity: _controlsVisible || !playing ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        child: Center(
          child: _RoundControl(
            icon: playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 30,
            diameter: 52,
            tooltip: playing ? 'Pause' : 'Play',
            onPressed: _togglePlay,
          ),
        ),
      ),

      if (widget.onExpand != null)
        Positioned(
          right: SpacingTokens.space8,
          top: SpacingTokens.space8,
          child: AnimatedOpacity(
            opacity: _controlsVisible ? 1 : 0,
            duration: const Duration(milliseconds: 180),
            child: _RoundControl(
              icon: Icons.open_in_full_rounded,
              size: 17,
              diameter: 32,
              tooltip: 'Full screen',
              onPressed: widget.onExpand!,
            ),
          ),
        ),

      // Time, scrubber and volume on one line along the bottom, rather than
      // scattered into three corners.
      Positioned(
        left: SpacingTokens.space8,
        right: SpacingTokens.space8,
        bottom: SpacingTokens.space8,
        child: AnimatedOpacity(
          opacity: _controlsVisible ? 1 : 0,
          duration: const Duration(milliseconds: 180),
          child: Row(
            children: [
              Text(
                _clock(controller.value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.zero,
                  colors: VideoProgressColors(
                    playedColor: Colors.white,
                    bufferedColor: Colors.white38,
                    backgroundColor: Colors.white24,
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              _FlatControl(
                icon:
                    _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                tooltip: _muted ? 'Unmute' : 'Mute',
                onPressed: _toggleMute,
              ),
            ],
          ),
        ),
      ),
    ];
  }

  /// `1:04 / 3:12`.
  static String _clock(VideoPlayerValue value) {
    String format(Duration d) {
      final minutes = d.inMinutes;
      final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }

    return '${format(value.position)} / ${format(value.duration)}';
  }
}

/// A clip at its own shape, ready to drop straight into a post.
///
/// The ratio comes from what the uploader's device measured, so the box is the
/// right shape before a single byte of video has arrived and the post does not
/// jump when it does. Bounded, because a corrupt or absurd pair of dimensions
/// would otherwise produce a post one pixel tall or three screens high.
class SizedInlineVideo extends StatelessWidget {
  final PostMedia media;
  final bool autoplay;
  final VoidCallback? onExpand;

  const SizedInlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
    this.onExpand,
  });

  /// Narrower than this and a clip is a sliver; wider and it is a strip.
  static const double minRatio = 0.5;
  static const double maxRatio = 1.9;

  /// What to assume when the upload recorded no dimensions. Portrait, because
  /// most clips people post are.
  static const double fallbackRatio = 0.75;

  static double ratioFor(PostMedia media) {
    final width = media.width;
    final height = media.height;
    if (width == null || height == null || width <= 0 || height <= 0) {
      return fallbackRatio;
    }
    return (width / height).clamp(minRatio, maxRatio);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratioFor(media),
      child: InlineVideo(
        media: media,
        autoplay: autoplay,
        onExpand: onExpand,
      ),
    );
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
              color: Color(0x66000000),
            ),
            child: Icon(icon, size: size, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// A control on the scrubber line, with no disc behind it -- the scrim under
/// the row is already doing that job.
class _FlatControl extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _FlatControl({
    required this.icon,
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
          child: SizedBox(
            width: 26,
            height: 26,
            child: Icon(icon, size: 18, color: Colors.white),
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
                  horizontal: SpacingTokens.space16,
                ),
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
