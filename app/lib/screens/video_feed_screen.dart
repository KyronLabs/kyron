// lib/screens/video_feed_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';

import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../providers/feed_provider.dart';
import '../providers/video_settings_provider.dart';
import '../routes.dart';
import '../services/app_log.dart';
import '../services/video_pool.dart';
import '../services/video_stage.dart';
import '../utils/decode_size.dart';
import '../utils/deferred_rebuild.dart';
import '../utils/format_count.dart';
import '../widgets/playback_bar.dart';
import '../widgets/post_action_colors.dart';
import '../widgets/post_card.dart';
import '../widgets/post_options_sheet.dart';
import '../widgets/post_text.dart';
import '../widgets/repost_sheet.dart';
import '../widgets/share_post_sheet.dart';

/// Which list to page through, and which post to start on.
class VideoFeedArgs {
  final PostListSource source;

  /// Named rather than an index. A list can be refreshed or paged while this
  /// screen is open, and an index into it means something different afterwards.
  final String postId;

  const VideoFeedArgs({required this.source, required this.postId});
}

/// Clips, one screen each, swiped through vertically.
///
/// Reads the same list the tiles that opened it came from, so a like here is
/// the same like there, and paging to the end of it asks for the next page
/// exactly as the wall would have.
class VideoFeedScreen extends ConsumerStatefulWidget {
  final VideoFeedArgs args;

  const VideoFeedScreen({super.key, required this.args});

  @override
  ConsumerState<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends ConsumerState<VideoFeedScreen> {
  PageController? _pages;
  int _index = 0;

  /// The clip on the page being watched.
  ///
  /// One controller for the whole screen, moved as the pages move. A player
  /// per page would leave the clip above still holding a decoder, and a
  /// decoder taken back stops whoever has gone longest without one -- which
  /// would be the clip just swiped to.
  VideoPlayerController? _controller;
  String? _openFor;
  bool _opening = false;
  String? _failure;

  /// How close to the end before the next page of posts is asked for.
  static const int _loadMoreWithin = 3;

  @override
  void initState() {
    super.initState();
    // Takes the stage before anything is loaded, so whatever was playing in
    // the feed underneath stops now rather than when this clip is ready.
    VideoStage.instance.claim(this, (_) {});
  }

  @override
  void dispose() {
    VideoStage.instance.withdraw(this);
    VideoPool.instance.release(this);
    _pages?.dispose();
    super.dispose();
  }

  /// The posts in this list that carry a clip, in order.
  List<FeedPost> _clipsIn(FeedState state) => [
        for (final post in state.posts)
          if (post.media.any((m) => m.isVideo)) post,
      ];

  /// The clip a page shows: the first video on that post.
  PostMedia _clipOf(FeedPost post) => post.media.firstWhere((m) => m.isVideo);

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(videoMutedProvider, (_, next) {
      _controller?.setVolume(next ? 0 : 1);
    });

    final state = ref.watch(postListProvider(widget.args.source));
    final clips = _clipsIn(state);

    if (clips.isEmpty) {
      return _Frame(child: _Message(text: _emptyMessage(state)));
    }

    // Opened on the post that was tapped. Done here rather than in initState
    // because the list is read from a provider, and the first build is where
    // it is known.
    if (_pages == null) {
      final start = clips.indexWhere((p) => p.id == widget.args.postId);
      _index = start < 0 ? 0 : start;
      _pages = PageController(initialPage: _index);
      whenNotBuilding(_syncVideo);
    }

    // The list can shrink under this screen -- a post hidden or blocked from
    // the sheet -- so the page being shown may no longer exist.
    if (_index >= clips.length) _index = clips.length - 1;

    return _Frame(
      child: Stack(
        children: [
          PageView.builder(
            controller: _pages,
            scrollDirection: Axis.vertical,
            itemCount: clips.length,
            onPageChanged: _onPage,
            itemBuilder: (context, index) => _Page(
              post: clips[index],
              media: _clipOf(clips[index]),
              source: widget.args.source,
              // Only the page being watched has a player; the rest show the
              // clip's own still.
              controller: index == _index ? _controller : null,
              opening: index == _index && _opening,
              failure: index == _index ? _failure : null,
              onTogglePlay: _togglePlay,
            ),
          ),
          const _TopBar(),
        ],
      ),
    );
  }

  String _emptyMessage(FeedState state) {
    if (state.isLoadingFirstPage) return 'Loading…';
    return state.error ?? 'There are no clips here yet.';
  }

  void _onPage(int index) {
    setState(() => _index = index);
    unawaited(_syncVideo());

    // Near the end: ask for more, exactly as the wall of tiles would have.
    final clips = _clipsIn(ref.read(postListProvider(widget.args.source)));
    if (clips.length - index <= _loadMoreWithin) {
      unawaited(
        ref.read(postListProvider(widget.args.source).notifier).loadMore(),
      );
    }
  }

  /// Points the one controller at whatever page is showing.
  Future<void> _syncVideo() async {
    final clips = _clipsIn(ref.read(postListProvider(widget.args.source)));
    if (_index >= clips.length) return;

    final wanted = _clipOf(clips[_index]).url;
    if (wanted == _openFor) return;

    _openFor = wanted;
    _controller = null;
    _failure = null;
    VideoPool.instance.release(this);
    if (mounted) setState(() => _opening = true);

    VideoPlayerController? controller;
    try {
      controller = await VideoPool.instance.open(
        wanted,
        owner: this,
        onEvicted: _onEvicted,
      );
    } catch (error) {
      AppLog.instance.error('media', 'Clip would not open: $error');
      if (mounted) {
        setState(() {
          _opening = false;
          _failure = 'This clip could not be played.';
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
        _failure = 'This clip could not be played.';
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
      if (mounted) setState(() {});
    });
  }

  Future<void> _togglePlay() async {
    final controller = _controller;
    if (controller == null) return;
    unawaited(HapticFeedback.selectionClick());
    if (controller.value.isPlaying) {
      await controller.pause();
    } else {
      VideoPool.instance.touch(this);
      await controller.play();
    }
    if (mounted) setState(() {});
  }
}

/// The black screen everything here is drawn on.
class _Frame extends StatelessWidget {
  final Widget child;

  const _Frame({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // White status bar icons: this screen is black whatever the theme is.
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(backgroundColor: Colors.black, body: child),
    );
  }
}

class _Message extends StatelessWidget {
  final String text;

  const _Message({required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space32),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ),
        ),
        const _TopBar(),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left_copy, color: Colors.white),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Videos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// One clip, filling the screen.
class _Page extends ConsumerWidget {
  final FeedPost post;
  final PostMedia media;
  final PostListSource source;
  final VideoPlayerController? controller;
  final bool opening;
  final String? failure;
  final VoidCallback onTogglePlay;

  const _Page({
    required this.post,
    required this.media,
    required this.source,
    required this.controller,
    required this.opening,
    required this.failure,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = controller != null && controller!.value.isInitialized;
    final playing = live && controller!.value.isPlaying;

    return GestureDetector(
      // The whole screen is the play button, which is what a screen with one
      // clip on it should be.
      onTap: onTogglePlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (live)
            // Filling the screen, cropped rather than letterboxed: a clip
            // shown small in the middle of a black screen is a clip nobody
            // came here to watch.
            RepaintBoundary(
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: controller!.value.size.width,
                  height: controller!.value.size.height,
                  child: VideoPlayer(controller!),
                ),
              ),
            )
          else
            _Still(media: media),

          if (opening)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          if (failure != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(SpacingTokens.space32),
                child: Text(
                  failure!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ),

          // Only while stopped, and never while it is still opening -- a play
          // glyph over a spinner says two different things at once.
          if (live && !playing)
            const Center(
              child: Icon(Iconsax.play, size: 56, color: Colors.white70),
            ),

          // Reads over a bright frame.
          const IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xB3000000)],
                ),
              ),
            ),
          ),

          _Rail(post: post, source: source),
          _Caption(post: post),

          if (live)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: controller!,
                  builder: (context, value, _) => PlaybackBar(
                    position: value.position,
                    buffered: value.buffered.isEmpty
                        ? Duration.zero
                        : value.buffered.last.end,
                    total: value.duration,
                    onSeek: controller!.seekTo,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The clip's own still, shown until its decoder arrives.
class _Still extends StatelessWidget {
  final PostMedia media;

  const _Still({required this.media});

  @override
  Widget build(BuildContext context) {
    final still = media.thumbnailUrl;
    if (still == null) return const ColoredBox(color: Colors.black);

    return Image.network(
      still,
      fit: BoxFit.cover,
      cacheWidth: decodeWidth(context),
      errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black),
    );
  }
}

/// Who posted it, and what they said.
class _Caption extends StatelessWidget {
  final FeedPost post;

  const _Caption({required this.post});

  @override
  Widget build(BuildContext context) {
    final handle = post.author.handle;
    final caption = post.content.trim();

    return Positioned(
      left: SpacingTokens.space16,
      // Clear of the rail on the right and the scrubber underneath.
      right: 88,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          // Clear of the scrubber, whose touch strip is taller than the line
          // it draws: at less than this a tap on the last line of a caption
          // scrubs the clip instead.
          padding: const EdgeInsets.only(bottom: SpacingTokens.space32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => openAuthor(context, post.author),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PostAvatar(author: post.author, radius: 16),
                    const SizedBox(width: SpacingTokens.space8),
                    Flexible(
                      child: Text(
                        handle ?? post.author.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (caption.isNotEmpty) ...[
                const SizedBox(height: SpacingTokens.space8),
                // The same text widget as everywhere else, so a hashtag here
                // is still a hashtag you can tap.
                PostText(
                  content: caption,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Like, reply, repost, save, share and sound, down the right-hand edge.
class _Rail extends ConsumerWidget {
  final FeedPost post;
  final PostListSource source;

  const _Rail({required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(postListProvider(source).notifier);
    final muted = ref.watch(videoMutedProvider);

    return Positioned(
      right: SpacingTokens.space8,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RailButton(
                icon: post.liked ? Iconsax.heart : Iconsax.heart_copy,
                label: post.likes > 0 ? formatCount(post.likes) : null,
                colour: post.liked ? PostActionColors.like : Colors.white,
                tooltip: post.liked ? 'Unlike' : 'Like',
                onTap: () => report(context, notifier.toggleLike(post.id)),
              ),
              _RailButton(
                icon: Iconsax.message_text_copy,
                label: post.comments > 0 ? formatCount(post.comments) : null,
                tooltip: 'Reply',
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.postDetail,
                  arguments: post.id,
                ),
              ),
              _RailButton(
                icon: post.reposted
                    ? Iconsax.repeat_circle_copy
                    : Iconsax.repeat_copy,
                label: post.reposts > 0 ? formatCount(post.reposts) : null,
                colour: post.reposted ? PostActionColors.repost : Colors.white,
                tooltip: 'Repost',
                onTap: () => RepostSheet.show(
                  context,
                  post: post,
                  onRepost: () => notifier.toggleRepost(post.id),
                ),
              ),
              _RailButton(
                icon: post.saved
                    ? Iconsax.archive_tick
                    : Iconsax.archive_add_copy,
                colour: post.saved ? PostActionColors.save : Colors.white,
                tooltip: post.saved ? 'Remove from saved' : 'Save',
                onTap: () => report(context, notifier.toggleSave(post.id)),
              ),
              _RailButton(
                icon: Iconsax.export_1_copy,
                tooltip: 'Share',
                onTap: () => SharePostSheet.show(context, post),
              ),
              _RailButton(
                icon: muted ? Iconsax.volume_slash : Iconsax.volume_high,
                tooltip: muted ? 'Turn sound on' : 'Turn sound off',
                onTap: ref.read(videoMutedProvider.notifier).toggle,
              ),
              _RailButton(
                icon: Iconsax.more_copy,
                tooltip: 'More',
                onTap: () => PostOptionsSheet.show(
                  context,
                  ref,
                  post: post,
                  source: source,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final Color colour;
  final String tooltip;
  final VoidCallback onTap;

  const _RailButton({
    required this.icon,
    this.label,
    this.colour = Colors.white,
    required this.tooltip,
    required this.onTap,
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
            onTap();
          },
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space8,
              vertical: SpacingTokens.space8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 26, color: colour),
                if (label != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    label!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
