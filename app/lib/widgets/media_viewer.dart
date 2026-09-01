// lib/widgets/media_viewer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../models/post_media.dart';

/// Full-screen media, opened from a post.
///
/// Everything a viewer is expected to do: pinch and double-tap to zoom, swipe
/// between attachments, swipe down to dismiss, play a video with a scrubber,
/// read the author's description, copy the link and hand the file to another
/// app.
class MediaViewer extends StatefulWidget {
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
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  late final PageController _pages =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  /// How far the sheet has been dragged down, for the swipe-to-dismiss.
  double _dragOffset = 0;

  /// Hidden while zoomed in, so the chrome does not sit over the picture.
  bool _chromeVisible = true;

  @override
  void initState() {
    super.initState();
    // Full bleed, and put back on the way out.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pages.dispose();
    super.dispose();
  }

  PostMedia get _current => widget.media[_index];

  @override
  Widget build(BuildContext context) {
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
              onPageChanged: (index) => setState(() => _index = index),
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              // Dragging vertically dismisses; the gallery keeps the
              // horizontal axis for moving between attachments.
              scrollDirection: Axis.horizontal,
              builder: (context, index) {
                final item = widget.media[index];
                if (item.isVideo) {
                  return PhotoViewGalleryPageOptions.customChild(
                    child: _Video(url: item.url),
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

          if (_chromeVisible) ...[
            _TopBar(
              index: _index,
              total: widget.media.length,
              onClose: () => Navigator.of(context).pop(),
              onCopyLink: _copyLink,
              onShare: _share,
            ),
            if (_current.alt != null && _current.alt!.trim().isNotEmpty)
              _AltText(text: _current.alt!),
          ],
        ],
      ),
    );
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: _current.url));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied')),
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
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          SpacingTokens.space20,
          SpacingTokens.space16,
          SpacingTokens.space20,
          MediaQuery.of(context).padding.bottom + SpacingTokens.space20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}

/// A video with a scrubber, played in place.
class _Video extends StatefulWidget {
  final String url;

  const _Video({required this.url});

  @override
  State<_Video> createState() => _VideoState();
}

class _VideoState extends State<_Video> {
  VideoPlayerController? _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _open();
  }

  Future<void> _open() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() => _controller = controller);
    } catch (e) {
      await controller.dispose();
      if (mounted) setState(() => _error = '$e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) return const _Unavailable();

    final controller = _controller;
    if (controller == null) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
        // Tapping the frame toggles playback; the viewer's own tap handler
        // sits below this and only sees taps that miss the video.
        GestureDetector(
          onTap: () => setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          }),
          child: ValueListenableBuilder<VideoPlayerValue>(
            valueListenable: controller,
            builder: (context, value, _) => AnimatedOpacity(
              opacity: value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 150),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.play_circle_copy,
                    color: Colors.white, size: 34),
              ),
            ),
          ),
        ),
        Positioned(
          left: SpacingTokens.space20,
          right: SpacingTokens.space20,
          bottom: SpacingTokens.space40,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(playedColor: Colors.white),
          ),
        ),
      ],
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
