// lib/widgets/media_tile_grid.dart
import 'package:flutter/material.dart';
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
/// header rather than nesting a second scrollable.
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
  static const double _minRatio = 0.5;
  static const double _maxRatio = 1.6;

  @override
  Widget build(BuildContext context) {
    // Two columns filled shortest-first, which is what keeps a staggered wall
    // level instead of letting one column run away.
    final left = <_Tile>[];
    final right = <_Tile>[];
    var leftHeight = 0.0;
    var rightHeight = 0.0;

    for (final post in posts) {
      final media = _pick(post);
      if (media == null) continue;

      final ratio = _ratioOf(media);
      final tile = _Tile(post: post, media: media, ratio: ratio);
      // Height for a unit-width column, which is all that is needed to
      // compare the two.
      final height = 1 / ratio;

      if (leftHeight <= rightHeight) {
        left.add(tile);
        leftHeight += height;
      } else {
        right.add(tile);
        rightHeight += height;
      }
    }

    if (left.isEmpty && right.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.all(SpacingTokens.space8),
      sliver: SliverToBoxAdapter(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _Column(tiles: left)),
            const SizedBox(width: SpacingTokens.space8),
            Expanded(child: _Column(tiles: right)),
          ],
        ),
      ),
    );
  }

  /// The attachment a tile shows: the first video when the wall is videos
  /// only, otherwise the first attachment of any kind.
  PostMedia? _pick(FeedPost post) {
    if (videosOnly) {
      for (final media in post.media) {
        if (media.isVideo) return media;
      }
      return null;
    }
    return post.media.isEmpty ? null : post.media.first;
  }

  static double _ratioOf(PostMedia media) {
    final width = media.width;
    final height = media.height;
    if (width == null || height == null || width <= 0 || height <= 0) {
      // Nothing recorded: assume portrait, which is what most clips are.
      return 0.75;
    }
    return (width / height).clamp(_minRatio, _maxRatio);
  }
}

class _Column extends StatelessWidget {
  final List<_Tile> tiles;

  const _Column({required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final tile in tiles)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
            child: tile,
          ),
      ],
    );
  }
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
                  // Never autoplaying: a wall of tiles would start every clip
                  // on screen at once. The player still paints its first
                  // frame, which is the poster, and playing one is a tap away.
                  ? InlineVideo(media: media, autoplay: false, chrome: false)
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
                child: _Chip(icon: Icons.play_arrow, label: 'Video'),
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
