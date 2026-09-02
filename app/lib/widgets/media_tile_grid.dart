// lib/widgets/media_tile_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import 'inline_video.dart';

/// Posts as a staggered two-column wall, the way a board of pins reads.
///
/// Staggered rather than a uniform grid because attachments are not all the
/// same shape: forcing a portrait clip into a square crops the subject out of
/// it, and letterboxing everything to one ratio wastes half the screen. Each
/// tile keeps its own aspect ratio, which is what makes the columns uneven and
/// the wall readable.
///
/// Built as a sliver so a screen can put it inside the same scroll view as its
/// header rather than nesting a second scrollable, and as a *lazy* one: it
/// used to lay both columns out inside a single box adapter, which builds
/// every tile whether or not it is on screen. Two hundred posts meant two
/// hundred live tiles.
class MediaTileGrid extends StatelessWidget {
  final List<FeedPost> posts;

  /// Only tile posts carrying a video. Used by the feed's Videos tab.
  final bool videosOnly;

  const MediaTileGrid({
    super.key,
    required this.posts,
    this.videosOnly = false,
  });

  /// Bounds on how extreme a tile's shape may get.
  ///
  /// An attachment with a broken or absurd ratio would otherwise produce a
  /// tile either one pixel tall or taller than the screen.
  static const double minRatio = 0.5;
  static const double maxRatio = 1.6;

  @override
  Widget build(BuildContext context) {
    final tiles = <_Entry>[];
    for (final post in posts) {
      final media = _pick(post);
      if (media != null) {
        tiles.add(_Entry(post: post, media: media));
      }
    }

    if (tiles.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.all(SpacingTokens.space8),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: SpacingTokens.space8,
        crossAxisSpacing: SpacingTokens.space8,
        childCount: tiles.length,
        itemBuilder: (context, index) => _Tile(
          post: tiles[index].post,
          media: tiles[index].media,
          ratio: ratioOf(tiles[index].media),
        ),
      ),
    );
  }

  /// The attachment a tile shows: the first video when the wall is videos
  /// only, otherwise the first attachment worth looking at.
  PostMedia? _pick(FeedPost post) {
    if (videosOnly) {
      for (final media in post.media) {
        if (media.isVideo) return media;
      }
      return null;
    }
    for (final media in post.media) {
      // A voice recording has nothing to show, so a post carrying only one
      // does not belong on a wall of pictures.
      if (media.isVisual) return media;
    }
    return null;
  }

  static double ratioOf(PostMedia media) {
    final width = media.width;
    final height = media.height;
    if (width == null || height == null || width <= 0 || height <= 0) {
      // Nothing recorded: assume portrait, which is what most clips are.
      return 0.75;
    }
    return (width / height).clamp(minRatio, maxRatio);
  }
}

class _Entry {
  final FeedPost post;
  final PostMedia media;

  const _Entry({required this.post, required this.media});
}

class _Tile extends StatelessWidget {
  final FeedPost post;
  final PostMedia media;
  final double ratio;

  const _Tile({required this.post, required this.media, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final caption = post.content.trim();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postDetail,
        arguments: post.id,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: ratio,
              child: media.isVideo
                  // A still, never a player. A wall shows a dozen tiles at
                  // once and a phone will not decode a dozen clips; this is
                  // where it used to run out and the tiles went black. A clip
                  // posted before the composer started sending a still falls
                  // back to a decoder, which the pool holds to a handful.
                  ? (media.thumbnailUrl != null
                      ? VideoPoster(media: media, badge: VideoPosterBadge.none)
                      : InlineVideo(
                          media: media,
                          autoplay: false,
                          chrome: false,
                        ))
                  : Image.network(
                      media.url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color: scheme.surfaceContainerHighest,
                        child: Icon(
                          Iconsax.gallery_slash_copy,
                          color: scheme.onSurface.withValues(alpha: 0.35),
                        ),
                      ),
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                              ? child
                              : ColoredBox(
                                  color: scheme.surfaceContainerHighest,
                                ),
                    ),
            ),

            // Marks a clip on a wall that also carries stills.
            if (media.isVideo)
              const Positioned(
                right: 8,
                top: 8,
                child: _Chip(icon: Icons.play_arrow_rounded, label: 'Video'),
              ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 6),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00000000), Color(0xB3000000)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (caption.isNotEmpty)
                        Text(
                          caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Iconsax.heart_copy,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 3),
                          Text(
                            formatCount(post.likes),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: SpacingTokens.space8),
                          const Icon(Iconsax.message_copy,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 3),
                          Text(
                            formatCount(post.comments),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
