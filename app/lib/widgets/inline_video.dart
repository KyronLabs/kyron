// lib/widgets/inline_video.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_media.dart';
import '../services/app_log.dart';
import '../services/video_pool.dart';

/// A clip as it appears in the feed.
///
/// Shows the still the composer uploaded with the clip, and only opens a
/// decoder when the clip is actually being watched -- through [VideoPool],
/// which holds the number open at any moment to a handful. A phone will only
/// decode so many videos at once; opening one per clip on screen is what made
/// a scrolling feed and a wall of tiles paint for a moment and then go black.
///
/// Sizes itself to whatever box it is given. Picking that box from the clip's
/// own shape is [SizedInlineVideo]'s job, so a tile in a grid can still be
/// square when the grid needs it to be.
class InlineVideo extends StatefulWidget {
  final PostMedia media;

  /// Start playing, muted, once enough of the tile is on screen.
  ///
  /// Muted because an autoplaying clip that makes noise while someone is
  /// reading is hostile; tapping the speaker turns it on deliberately.
  final bool autoplay;

  /// Draw the controls. False on a wall of tiles, where a scrubber and a
  /// volume button on every thumbnail is noise -- the tile is a link to the
  /// post, not a player.
  final bool chrome;

  const InlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
    this.chrome = true,
  });

  @override
  State<InlineVideo> createState() => _InlineVideoState();
}

class _InlineVideoState extends State<InlineVideo> {
  VideoPlayerController? _controller;

  /// True between asking the pool for a decoder and getting one.
  bool _opening = false;

  /// Non-null once the clip itself turned out to be unplayable. Kept so the
  /// tile can say so rather than retrying forever on something broken.
  String? _failure;

  bool _muted = true;

  /// Whether the user has taken control. Once they have, scrolling the tile
  /// away still stops it, but scrolling back does not start it again: a clip
  /// somebody deliberately paused must stay paused.
  bool _manual = false;

  /// Set while a decoder is being opened for a clip that should play the
  /// moment it arrives.
  bool _wantsPlayback = false;

  /// Hides the controls a moment after they appear, the way a player does.
  bool _controlsVisible = true;
  Timer? _hideControls;

  /// Waits for the tile to settle before asking for a decoder.
  ///
  /// A fast scroll takes a clip past the threshold and out again inside a few
  /// frames. Opening one for each of those is a burst of work for clips nobody
  /// looked at, and it is what makes a list of them stutter.
  Timer? _settle;

  /// Set when every decoder was busy being opened and this tile has to ask
  /// again in a moment. Bounded, so a tile cannot sit in a retry loop.
  Timer? _retry;
  int _retriesLeft = _maxRetries;
  static const int _maxRetries = 3;

  /// How long a clip has to stay on screen before it is worth a decoder.
  static const Duration _settleDelay = Duration(milliseconds: 220);

  /// How much of the tile has to be on screen before a clip is worth a
  /// decoder. High enough that two clips either side of a boundary do not
  /// both claim one.
  static const double _playThreshold = 0.6;

  /// Distinguishes this tile from every other one alive.
  ///
  /// The visibility key cannot be the attachment's id alone: the same post can
  /// be on screen in two places at once -- a feed behind an open profile, say
  /// -- and two detectors sharing a key report over each other.
  static int _nextInstance = 0;
  late final int _instance = _nextInstance++;

  @override
  void didUpdateWidget(InlineVideo old) {
    super.didUpdateWidget(old);
    // Recycled onto a different clip. Without this the tile would keep
    // playing the previous one behind the new one's still.
    if (old.media.url != widget.media.url) {
      _hideControls?.cancel();
      _retry?.cancel();
      _cancelSettle();
      _controller?.removeListener(_onTick);
      _controller = null;
      VideoPool.instance.release(this);
      _opening = false;
      _failure = null;
      _manual = false;
      _wantsPlayback = false;
      _controlsVisible = true;
      _retriesLeft = _maxRetries;
    }
  }

  @override
  void dispose() {
    _hideControls?.cancel();
    _retry?.cancel();
    _cancelSettle();
    _controller?.removeListener(_onTick);
    // The pool owns the controller and disposes it. Releasing here rather than
    // disposing directly is what keeps its count of open decoders honest.
    VideoPool.instance.release(this);
    super.dispose();
  }

  /// Gets hold of a decoder, opening one if this tile has none.
  Future<void> _ensure({required bool play}) async {
    if (_failure != null) return;

    final existing = _controller;
    if (existing != null) {
      VideoPool.instance.touch(this);
      if (play && !existing.value.isPlaying) await existing.play();
      return;
    }

    if (_opening) {
      // Already on its way. Remember whether it should be playing when it
      // lands rather than queueing a second request for the same clip.
      _wantsPlayback = _wantsPlayback || play;
      return;
    }

    _opening = true;
    _wantsPlayback = play;
    if (mounted) setState(() {});

    VideoPlayerController? controller;
    try {
      controller = await VideoPool.instance.open(
        widget.media.url,
        owner: this,
        onEvicted: _onEvicted,
      );
    } catch (error) {
      AppLog.instance.error('media', 'Clip would not open: $error');
      if (!mounted) return;
      setState(() {
        _opening = false;
        _failure = 'This clip could not be played.';
      });
      return;
    }

    if (!mounted) {
      VideoPool.instance.release(this);
      return;
    }
    if (controller == null) {
      // Either every decoder was busy opening, or this tile's lease was given
      // up while it waited. The still stands in; ask again shortly, because
      // both of those settle within a moment and the tile may never move
      // again to trigger another attempt.
      setState(() => _opening = false);
      if (_wantsPlayback && _retriesLeft > 0) {
        _retriesLeft--;
        _retry?.cancel();
        _retry = Timer(const Duration(milliseconds: 450), () {
          if (mounted && _controller == null) unawaited(_ensure(play: true));
        });
      }
      return;
    }

    _retriesLeft = _maxRetries;

    await controller.setVolume(_muted ? 0 : 1);
    await controller.setLooping(true);
    if (!mounted) {
      VideoPool.instance.release(this);
      return;
    }

    // Rebuilds on every frame of playback, which is what moves the scrubber.
    controller.addListener(_onTick);
    setState(() {
      _controller = controller;
      _opening = false;
    });

    if (_wantsPlayback) {
      await controller.play();
      _scheduleHide();
    }
  }

  /// The pool took this tile's decoder back for a clip closer to the reader.
  void _onEvicted() {
    _controller?.removeListener(_onTick);
    _controller = null;
    // A clip that was taken away was not paused by anyone, so it is fair to
    // start it again when it next comes into view.
    _manual = false;
    if (mounted) setState(() {});
  }

  void _onTick() {
    if (mounted) setState(() {});
  }

  /// Stops a pending settle and forgets it, so the next time this tile comes
  /// into view it can start a new one. Cancelling without clearing the handle
  /// left it non-null, and the guard against a second timer then blocked every
  /// later attempt -- the clip would never open again.
  void _cancelSettle() {
    _settle?.cancel();
    _settle = null;
  }

  void _scheduleHide() {
    _hideControls?.cancel();
    _hideControls = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _controlsVisible = false);
    });
  }

  void _onVisibility(VisibilityInfo info) {
    if (!mounted) return;
    final fraction = info.visibleFraction;
    final controller = _controller;

    if (fraction <= 0) {
      // Off screen entirely: give the decoder back. Nobody is watching it, and
      // holding it is what starves the clip somebody is watching.
      _cancelSettle();
      if (controller != null || _opening) {
        _hideControls?.cancel();
        _retry?.cancel();
        _controller?.removeListener(_onTick);
        _controller = null;
        _opening = false;
        _wantsPlayback = false;
        VideoPool.instance.release(this);
        if (mounted) setState(() {});
      }
      _retriesLeft = _maxRetries;
      return;
    }

    if (fraction < _playThreshold) {
      _cancelSettle();
      if (controller != null && controller.value.isPlaying) {
        unawaited(controller.pause());
      }
      return;
    }

    if (controller != null) {
      VideoPool.instance.touch(this);
      if (widget.autoplay && !_manual && !controller.value.isPlaying) {
        unawaited(controller.play());
      }
      return;
    }

    if (widget.autoplay && !_manual && _settle == null) {
      _settle = Timer(_settleDelay, () {
        _settle = null;
        if (mounted) unawaited(_ensure(play: true));
      });
    }
  }

  Future<void> _togglePlay() async {
    final controller = _controller;
    unawaited(HapticFeedback.selectionClick());

    if (controller == null) {
      // Tapping a still is how a clip that is not autoplaying gets started.
      _manual = true;
      if (mounted) setState(() => _controlsVisible = true);
      await _ensure(play: true);
      return;
    }

    _manual = true;
    if (controller.value.isPlaying) {
      await controller.pause();
      _hideControls?.cancel();
      if (mounted) setState(() => _controlsVisible = true);
    } else {
      VideoPool.instance.touch(this);
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
    final ready = controller != null && controller.value.isInitialized;

    final Widget body;
    if (_failure != null) {
      body = VideoPoster(
        media: widget.media,
        badge: VideoPosterBadge.none,
        label: _failure,
      );
    } else if (!ready) {
      // The still, with the play badge on it unless a decoder is already on
      // its way -- in which case a spinner says so rather than a button that
      // has already been pressed.
      body = VideoPoster(
        media: widget.media,
        badge: _opening ? VideoPosterBadge.busy : VideoPosterBadge.play,
      );
    } else {
      body = Stack(
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
          if (widget.chrome)
            ..._chrome(scheme, controller, controller.value.isPlaying),
        ],
      );
    }

    return VisibilityDetector(
      // Keyed by the attachment, so two clips in one post are tracked apart.
      key: Key('inline-video-${widget.media.id}-$_instance'),
      onVisibilityChanged: _onVisibility,
      child: widget.chrome && _failure == null
          ? GestureDetector(
              onTap: _controlsVisible || !ready ? _togglePlay : _showControls,
              child: body,
            )
          : body,
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
            icon: playing ? Iconsax.pause : Iconsax.play,
            size: 24,
            diameter: 52,
            tooltip: playing ? 'Pause' : 'Play',
            onPressed: _togglePlay,
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

/// What to draw over a still.
enum VideoPosterBadge {
  /// A filled play button, for a clip waiting to be started.
  play,

  /// A spinner, while a decoder is being opened.
  busy,

  /// Nothing.
  none,
}

/// A clip's still: the picture the composer pulled out of it on upload.
///
/// This is what a list of clips is made of. Drawing the video itself would
/// mean a decoder per tile, and a phone runs out of those long before it runs
/// out of tiles.
class VideoPoster extends StatelessWidget {
  final PostMedia media;
  final VideoPosterBadge badge;

  /// Said under the badge. Used to explain a clip that will not play.
  final String? label;

  const VideoPoster({
    super.key,
    required this.media,
    this.badge = VideoPosterBadge.play,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final still = media.thumbnailUrl;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (still != null)
          Image.network(
            still,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _ground(scheme),
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : _ground(scheme),
          )
        else
          _ground(scheme),

        // A scrim, so a white glyph stays readable over a bright frame.
        if (badge != VideoPosterBadge.none && still != null)
          const DecoratedBox(
            decoration: BoxDecoration(color: Color(0x33000000)),
          ),

        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              switch (badge) {
                VideoPosterBadge.play => Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x66000000),
                    ),
                    child: const Icon(
                      Iconsax.play,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                VideoPosterBadge.busy => const SizedBox.square(
                    dimension: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  ),
                VideoPosterBadge.none => const SizedBox.shrink(),
              },
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
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// What stands behind a clip with no still: clips posted before the composer
  /// started sending one, and stills that fail to load.
  Widget _ground(ColorScheme scheme) => ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Iconsax.video_copy,
            color: scheme.onSurface.withValues(alpha: 0.28),
          ),
        ),
      );
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

  const SizedInlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
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
      child: InlineVideo(media: media, autoplay: autoplay),
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
