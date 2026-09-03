// lib/widgets/media_viewer.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../models/post_media.dart';
import '../providers/video_settings_provider.dart';
import '../services/app_log.dart';
import '../services/video_pool.dart';
import '../services/video_stage.dart';
import '../utils/decode_size.dart';
import '../utils/deferred_rebuild.dart';
import 'inline_video.dart';
import 'playback_bar.dart';
import 'toast.dart';

/// How long the chrome takes to get out of the way.
const Duration _chromeDuration = Duration(milliseconds: 220);

/// Full-screen media, opened from a post.
///
/// Everything a viewer is expected to do: pinch and double-tap to zoom, swipe
/// between attachments, swipe down to dismiss, play a video with a scrubber,
/// read the author's description, copy the link and hand the file to another
/// app.
class MediaViewer extends ConsumerStatefulWidget {
  final List<PostMedia> media;
  final int initialIndex;

  const MediaViewer({
    super.key,
    required this.media,
    this.initialIndex = 0,
  });

  /// Opens the viewer over whatever is on screen, on an opaque black route so
  /// the page behind does not show through while it is being dragged away.
  static Future<void> open(
    BuildContext context,
    List<PostMedia> media, {
    int initialIndex = 0,
  }) {
    if (media.isEmpty) return Future<void>.value();
    return Navigator.of(context, rootNavigator: true).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) =>
            MediaViewer(media: media, initialIndex: initialIndex),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  ConsumerState<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends ConsumerState<MediaViewer> {
  late final PageController _pages =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  /// How far the sheet has been dragged down, for the swipe-to-dismiss.
  double _dragOffset = 0;

  /// Whether the chrome is on screen. Tapping the picture puts it away.
  bool _chromeVisible = true;

  /// The clip on the page being watched, if that page carries one.
  ///
  /// One controller for the whole viewer rather than one per page: a gallery
  /// keeps the pages either side built and ready, so a page owning its own
  /// player left the clip you had swiped away from still holding a decoder --
  /// and taking one back stops whoever has gone longest without it, which was
  /// the clip you had just swiped to.
  VideoPlayerController? _controller;
  bool _opening = false;
  String? _videoError;

  /// Which url [_controller] belongs to, so a rebuild does not reopen it.
  String? _openFor;

  @override
  void initState() {
    super.initState();
    // Full bleed, and put back on the way out.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Takes the stage before anything is loaded. Whatever is playing in the
    // feed underneath stops now rather than when this clip is ready -- the
    // wait for a decoder is not a reason to keep hearing the post you just
    // scrolled past.
    VideoStage.instance.claim(this, (_) {});

    // After the frame: opening takes a decoder off a clip in the feed, and
    // that clip is told so -- which it cannot be from inside a build.
    whenNotBuilding(_syncVideo);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Hands the stage back, so the feed picks up where it left off.
    VideoStage.instance.withdraw(this);
    VideoPool.instance.release(this);
    _pages.dispose();
    super.dispose();
  }

  PostMedia get _current => widget.media[_index];

  /// Points the one controller at whatever the current page is showing.
  Future<void> _syncVideo() async {
    final item = _current;
    final wanted = item.isVideo ? item.url : null;

    if (wanted == _openFor) return;

    // Whatever was playing is not what is on screen any more.
    _openFor = wanted;
    _controller = null;
    _videoError = null;
    VideoPool.instance.release(this);

    if (wanted == null) {
      if (mounted) setState(() => _opening = false);
      return;
    }

    if (mounted) setState(() => _opening = true);

    VideoPlayerController? controller;
    try {
      controller = await VideoPool.instance.open(
        wanted,
        owner: this,
        onEvicted: _onEvicted,
      );
    } catch (error) {
      AppLog.instance.error('media', 'Clip would not open full screen: $error');
      if (mounted) {
        setState(() {
          _opening = false;
          _videoError = 'This clip could not be played.';
        });
      }
      return;
    }

    // Swiped on again while it was opening.
    if (!mounted || _openFor != wanted) {
      VideoPool.instance.release(this);
      return;
    }
    if (controller == null) {
      setState(() {
        _opening = false;
        _videoError = 'This clip could not be played.';
      });
      return;
    }

    await controller.setVolume(ref.read(videoMutedProvider) ? 0 : 1);
    await controller.setLooping(true);
    if (!mounted || _openFor != wanted) {
      VideoPool.instance.release(this);
      return;
    }

    setState(() {
      _controller = controller;
      _opening = false;
    });
    await controller.play();
  }

  void _onEvicted() {
    _controller = null;
    _openFor = null;
    whenNotBuilding(() {
      if (mounted) {
        setState(
            () => _videoError = 'This clip stopped to make room for another.');
      }
    });
  }

  Future<void> _togglePlay() async {
    final controller = _controller;
    if (controller == null) return;
    if (controller.value.isPlaying) {
      await controller.pause();
    } else {
      VideoPool.instance.touch(this);
      await controller.play();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Turning the sound on here turns it on everywhere, and the clip that is
    // already playing has to hear about it.
    ref.listen<bool>(videoMutedProvider, (_, next) {
      _controller?.setVolume(next ? 0 : 1);
    });

    // Fades the backdrop as the sheet is dragged, so the gesture reads as
    // dismissal rather than the page coming apart.
    final progress = (_dragOffset.abs() / 320).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 1 - progress * 0.7),
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, _dragOffset),
            child: PhotoViewGallery.builder(
              pageController: _pages,
              itemCount: widget.media.length,
              onPageChanged: (index) {
                setState(() => _index = index);
                // The one controller follows the page rather than every page
                // opening its own.
                unawaited(_syncVideo());
              },
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              // Dragging vertically dismisses; the gallery keeps the
              // horizontal axis for moving between attachments.
              scrollDirection: Axis.horizontal,
              builder: (context, index) {
                final item = widget.media[index];
                if (item.isVideo) {
                  final controller = _controller;
                  final live = index == _index && controller != null;
                  return PhotoViewGalleryPageOptions.customChild(
                    child: _videoError != null && index == _index
                        ? const _Unavailable()
                        : live
                            ? _ViewerVideo(controller: controller)
                            : _VideoStandIn(media: item),
                    heroAttributes: PhotoViewHeroAttributes(tag: item.id),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained,
                  );
                }
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(item.url),
                  heroAttributes: PhotoViewHeroAttributes(tag: item.id),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 4,
                  errorBuilder: (_, __, ___) => const _Unavailable(),
                );
              },
              loadingBuilder: (_, __) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ),

          // The drag layer sits above the gallery but only claims vertical
          // drags, so pinch-zoom and horizontal paging still reach it.
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() => _chromeVisible = !_chromeVisible),
              onVerticalDragUpdate: (details) =>
                  setState(() => _dragOffset += details.delta.dy),
              onVerticalDragEnd: (details) {
                final flung = details.velocity.pixelsPerSecond.dy.abs() > 700;
                if (flung || _dragOffset.abs() > 140) {
                  Navigator.of(context).pop();
                } else {
                  setState(() => _dragOffset = 0);
                }
              },
              child: const SizedBox.expand(),
            ),
          ),

          // Slid away rather than switched off, so tapping the picture reads
          // as the controls getting out of the way.
          AnimatedSlide(
            offset: Offset(0, _chromeVisible ? 0 : -1),
            duration: _chromeDuration,
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              opacity: _chromeVisible ? 1 : 0,
              duration: _chromeDuration,
              child: IgnorePointer(
                ignoring: !_chromeVisible,
                child: _TopBar(
                  index: _index,
                  total: widget.media.length,
                  onClose: () => Navigator.of(context).pop(),
                  onCopyLink: _copyLink,
                  onShare: _share,
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSlide(
              offset: Offset(0, _chromeVisible ? 0 : 1),
              duration: _chromeDuration,
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: _chromeVisible ? 1 : 0,
                duration: _chromeDuration,
                child: IgnorePointer(
                  ignoring: !_chromeVisible,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0xCC000000)],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_current.alt != null &&
                            _current.alt!.trim().isNotEmpty)
                          _AltText(text: _current.alt!),
                        if (_controller != null)
                          _VideoControls(
                            controller: _controller!,
                            muted: ref.watch(videoMutedProvider),
                            onPlayPause: _togglePlay,
                            onToggleSound:
                                ref.read(videoMutedProvider.notifier).toggle,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (_opening)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
    );
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: _current.url));
    if (!mounted) return;
    // In the middle: the viewer is a black screen with nothing at the
    // bottom to tie a message to, and the eye is already in the middle of it.
    Toast.show(
      context,
      'Link copied',
      spot: ToastSpot.middle,
      icon: Iconsax.copy_copy,
    );
  }

  Future<void> _share() async {
    // The URL rather than the bytes: the file is already public, and
    // downloading it first to share it would make the sheet wait on a network
    // round trip for no gain.
    await Share.shareUri(Uri.parse(_current.url));
  }
}

class _TopBar extends StatelessWidget {
  final int index;
  final int total;
  final VoidCallback onClose;
  final VoidCallback onCopyLink;
  final VoidCallback onShare;

  const _TopBar({
    required this.index,
    required this.total,
    required this.onClose,
    required this.onCopyLink,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.close_circle_copy, color: Colors.white),
            tooltip: 'Close',
            onPressed: onClose,
          ),
          const Spacer(),
          if (total > 1)
            Text(
              '${index + 1} of $total',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          const Spacer(),
          IconButton(
            icon: const Icon(Iconsax.copy_copy, color: Colors.white),
            tooltip: 'Copy link',
            onPressed: onCopyLink,
          ),
          IconButton(
            icon: const Icon(Iconsax.share_copy, color: Colors.white),
            tooltip: 'Share',
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}

/// The author's description, along the bottom.
class _AltText extends StatelessWidget {
  final String text;

  const _AltText({required this.text});

  @override
  Widget build(BuildContext context) {
    // No scrim of its own: it sits inside the chrome's, which already darkens
    // the bottom of the picture for the controls under it.
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space16,
        SpacingTokens.space20,
        SpacingTokens.space8,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

/// The one clip the viewer is playing.
///
/// Owned by the viewer rather than by the page showing it. Each page used to
/// open its own: a gallery keeps the pages either side of the one you are on
/// built and ready, so swiping to the next clip left the previous one holding
/// a decoder -- and since decoders are taken from whoever has gone longest
/// without one, the clip you had just swiped to was stopped so the one behind
/// you could keep going. One controller, moved as you move, cannot do that.
class _ViewerVideo extends StatelessWidget {
  final VideoPlayerController controller;

  const _ViewerVideo({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        // Its own layer: a playing clip pushes a frame sixty times a second,
        // and the chrome over it should not be repainted at that rate.
        child: RepaintBoundary(child: VideoPlayer(controller)),
      ),
    );
  }
}

/// What a clip looks like on a page that is not the one being watched.
class _VideoStandIn extends StatelessWidget {
  final PostMedia media;

  const _VideoStandIn({required this.media});

  @override
  Widget build(BuildContext context) {
    final still = media.thumbnailUrl;

    return Center(
      child: AspectRatio(
        aspectRatio: SizedInlineVideo.ratioFor(media),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (still != null)
              Image.network(
                still,
                fit: BoxFit.contain,
                cacheWidth: decodeWidth(context),
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            const Center(
              child: Icon(Iconsax.play, size: 44, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

/// Play, the scrubber, and sound -- in that order, along the bottom.
class _VideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final bool muted;
  final VoidCallback onPlayPause;
  final VoidCallback onToggleSound;

  const _VideoControls({
    required this.controller,
    required this.muted,
    required this.onPlayPause,
    required this.onToggleSound,
  });

  @override
  Widget build(BuildContext context) {
    // Only this row is rebuilt as the clip plays, not the page around it.
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final total = value.duration;
        final position = value.position;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            SpacingTokens.space12,
            SpacingTokens.space8,
            SpacingTokens.space12,
            MediaQuery.paddingOf(context).bottom + SpacingTokens.space16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _RoundButton(
                    icon: value.isPlaying ? Iconsax.pause : Iconsax.play,
                    tooltip: value.isPlaying ? 'Pause' : 'Play',
                    onPressed: onPlayPause,
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: PlaybackBar(
                      position: position,
                      buffered: _bufferedTo(value),
                      total: total,
                      onSeek: (to) => controller.seekTo(to),
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  _RoundButton(
                    icon: muted ? Iconsax.volume_slash : Iconsax.volume_high,
                    tooltip: muted ? 'Turn sound on' : 'Turn sound off',
                    onPressed: onToggleSound,
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_clock(position), style: _timeStyle),
                    Text(_clock(total), style: _timeStyle),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static const _timeStyle = TextStyle(
    color: Colors.white70,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// How far the clip has downloaded. The ranges arrive in order, so the end
  /// of the last one is the end of what is ready to play.
  static Duration _bufferedTo(VideoPlayerValue value) =>
      value.buffered.isEmpty ? Duration.zero : value.buffered.last.end;

  static String _clock(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

/// A control on the viewer's chrome.
class _RoundButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _RoundButton({
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
          onTap: () {
            HapticFeedback.selectionClick();
            onPressed();
          },
          customBorder: const CircleBorder(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.14),
            ),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Unavailable extends StatelessWidget {
  const _Unavailable();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.gallery_slash_copy, color: Colors.white54, size: 40),
          SizedBox(height: SpacingTokens.space12),
          Text(
            'This attachment could not be loaded.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
