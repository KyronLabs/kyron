// lib/widgets/inline_video.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_media.dart';
import '../providers/video_settings_provider.dart';
import '../utils/decode_size.dart';
import '../utils/deferred_rebuild.dart';
import '../services/app_log.dart';
import '../services/video_pool.dart';
import '../services/video_stage.dart';

/// A clip as it appears in the feed.
///
/// Shows the still the composer uploaded, and only opens a decoder when the
/// clip is on screen -- through [VideoPool], which holds the number open at
/// any moment to a handful. A phone will only decode so many videos at once;
/// opening one per clip on screen is what made a scrolling feed and a wall of
/// tiles paint for a moment and then go black.
///
/// It is not a player. A tap anywhere on it opens the clip full screen, where
/// there is room for a scrubber and a reason to want one. A play button on a
/// tile puts a control people hit by accident on top of the one thing they
/// want the tile to do.
///
/// Whether it plays is not its own decision either: it reports where it is to
/// [VideoStage], which plays exactly one clip -- the one nearest the middle of
/// the screen. Deciding per tile meant every clip that was on screen enough
/// started, and the one arriving from the bottom stopped the one being watched
/// in the middle.
///
/// Nothing here rebuilds per frame of playback either. Driving a scrubber from
/// a tile meant a setState on every frame of every visible clip, which is a
/// rebuild of the post around it sixty times a second while somebody is trying
/// to scroll past it.
///
/// Sizes itself to whatever box it is given. Picking that box from the clip's
/// own shape is [SizedInlineVideo]'s job, so a tile in a grid can still be
/// square when the grid needs it to be.
class InlineVideo extends ConsumerStatefulWidget {
  final PostMedia media;

  /// Start playing, muted, once enough of the tile is on screen.
  final bool autoplay;

  /// Draw the sound button. False on a wall of tiles, where a control on every
  /// thumbnail is noise: there the tile is a link to a post, not a player.
  final bool chrome;

  /// Opens the clip full screen. Null leaves the tile inert, so the tap
  /// belongs to whatever is underneath it.
  final VoidCallback? onOpen;

  const InlineVideo({
    super.key,
    required this.media,
    this.autoplay = true,
    this.chrome = true,
    this.onOpen,
  });

  @override
  ConsumerState<InlineVideo> createState() => _InlineVideoState();
}

class _InlineVideoState extends ConsumerState<InlineVideo> {
  VideoPlayerController? _controller;

  /// True between asking the pool for a decoder and getting one.
  bool _opening = false;

  /// Non-null once the clip itself turned out to be unplayable. Kept so the
  /// tile can say so rather than retrying forever on something broken.
  String? _failure;

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
      _cancelSettle();
      _retry?.cancel();
      _controller = null;
      VideoStage.instance.withdraw(this);
      VideoPool.instance.release(this);
      _opening = false;
      _onStage = false;
      _failure = null;
      _retriesLeft = _maxRetries;
    }
  }

  @override
  void dispose() {
    _cancelSettle();
    _retry?.cancel();
    VideoStage.instance.withdraw(this);
    // The pool owns the controller and disposes it. Releasing here rather than
    // disposing directly is what keeps its count of open decoders honest.
    VideoPool.instance.release(this);
    super.dispose();
  }

  /// Stops a pending settle and forgets it, so the next time this tile comes
  /// into view it can start a new one.
  void _cancelSettle() {
    _settle?.cancel();
    _settle = null;
  }

  /// Whether this clip currently holds the stage.
  bool _onStage = false;

  /// The stage has handed this clip the floor, or taken it back.
  void _onStageChanged(bool active) {
    if (!mounted) return;
    _onStage = active;

    final controller = _controller;
    if (!active) {
      _cancelSettle();
      if (controller != null && controller.value.isPlaying) {
        unawaited(controller.pause());
      }
      return;
    }

    if (controller != null) {
      VideoPool.instance.touch(this);
      unawaited(controller.play());
      return;
    }

    // Waits for the clip to settle before asking for a decoder. A fast scroll
    // hands the stage to each clip it passes for a frame or two, and opening
    // one for each of those is a burst of work for clips nobody looked at.
    _settle ??= Timer(_settleDelay, () {
      _settle = null;
      if (mounted && _onStage) unawaited(_ensure());
    });
  }

  /// Gets hold of a decoder, opening one if this tile has none.
  Future<void> _ensure() async {
    if (_failure != null || _opening || _controller != null) return;

    _opening = true;
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
      if (_retriesLeft > 0 && _onStage) {
        _retriesLeft--;
        _retry?.cancel();
        _retry = Timer(const Duration(milliseconds: 450), () {
          if (mounted && _onStage && _controller == null) unawaited(_ensure());
        });
      }
      return;
    }

    _retriesLeft = _maxRetries;
    await controller.setVolume(ref.read(videoMutedProvider) ? 0 : 1);
    await controller.setLooping(true);
    if (!mounted) {
      VideoPool.instance.release(this);
      return;
    }

    setState(() {
      _controller = controller;
      _opening = false;
    });

    // Only if it still holds the stage. Opening takes long enough for the
    // scroll to have moved on and given the floor to something else.
    if (_onStage) await controller.play();
  }

  /// The pool took this tile's decoder back for a clip closer to the reader.
  ///
  /// Reached from inside a build: opening a clip full screen takes a decoder
  /// off one in the feed, and does it from the viewer's initState. The field
  /// is cleared straight away -- a build in between must not draw a disposed
  /// controller -- and the repaint waits for the frame to finish.
  void _onEvicted() {
    _controller = null;
    whenNotBuilding(() {
      if (mounted) setState(() {});
    });
  }

  void _onVisibility(VisibilityInfo info) {
    if (!mounted || !widget.autoplay) return;
    final fraction = info.visibleFraction;

    if (fraction <= 0) {
      // Off screen entirely: out of the running, and give the decoder back.
      // Nobody is watching it, and holding it starves whoever is on stage.
      _cancelSettle();
      VideoStage.instance.withdraw(this);
      _onStage = false;
      if (_controller != null || _opening) {
        _retry?.cancel();
        _controller = null;
        _opening = false;
        VideoPool.instance.release(this);
        setState(() {});
      }
      _retriesLeft = _maxRetries;
      return;
    }

    VideoStage.instance.report(
      this,
      visibleFraction: fraction,
      distance: _distanceFromMiddle(),
      onChanged: _onStageChanged,
    );
  }

  /// How far this clip's middle is from the middle of the screen.
  ///
  /// What decides which clip is worth playing. Visible fraction alone cannot:
  /// three clips can each be most of the way on screen, and only one of them
  /// is the one being looked at.
  double _distanceFromMiddle() {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return double.infinity;
    final middle = box.localToGlobal(box.size.center(Offset.zero)).dy;
    return (middle - MediaQuery.sizeOf(context).height / 2).abs();
  }

  @override
  Widget build(BuildContext context) {
    // One answer for the whole app, so turning the sound on for one clip turns
    // it on for the next one too -- rather than making somebody unmute every
    // post in a feed.
    final muted = ref.watch(videoMutedProvider);
    ref.listen<bool>(videoMutedProvider, (_, next) {
      unawaited(_controller?.setVolume(next ? 0 : 1) ?? Future<void>.value());
    });

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
          // Its own layer. A playing clip pushes a new frame sixty times a
          // second; without a boundary around it the list around it is
          // repainted at the same rate.
          RepaintBoundary(
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          ),
          if (widget.chrome)
            Positioned(
              right: SpacingTokens.space8,
              bottom: SpacingTokens.space8,
              child: _SoundButton(
                muted: muted,
                onPressed: ref.read(videoMutedProvider.notifier).toggle,
              ),
            ),
        ],
      );
    }

    return VisibilityDetector(
      // Keyed by the attachment, so two clips in one post are tracked apart.
      key: Key('inline-video-${widget.media.id}-$_instance'),
      onVisibilityChanged: _onVisibility,
      child: widget.onOpen == null
          ? body
          : GestureDetector(
              // The whole clip opens the clip. Nothing here toggles playback:
              // a tile that stops when you touch it is a tile that fights the
              // one thing you wanted from it.
              onTap: () {
                unawaited(HapticFeedback.selectionClick());
                widget.onOpen!();
              },
              child: body,
            ),
    );
  }
}

/// Sound on or off, for every clip in the app.
class _SoundButton extends StatelessWidget {
  final bool muted;
  final VoidCallback onPressed;

  const _SoundButton({required this.muted, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final label = muted ? 'Turn sound on' : 'Turn sound off';

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: GestureDetector(
          // Its own tap, so turning the sound on does not also open the clip.
          onTap: () {
            unawaited(HapticFeedback.selectionClick());
            onPressed();
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x73000000),
            ),
            child: Icon(
              muted ? Iconsax.volume_slash : Iconsax.volume_high,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
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
            cacheWidth: decodeWidth(context),
            filterQuality: FilterQuality.low,
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
