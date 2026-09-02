// lib/widgets/video_tile_grid.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../models/post_media.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import 'inline_video.dart';

/// Videos as a staggered two-column wall, the way a board of pins reads.
///
/// Staggered rather than a uniform grid because clips are not all the same
/// shape: forcing a portrait clip into a square crops the subject out of it,
/// and letterboxing every tile to a common ratio wastes half the screen. Each
/// tile keeps its own aspect ratio, which is what makes the columns uneven and
/// the wall readable.
///
/// Built as a sliver so a profile can put it inside the same scroll view as
/// its header rather than nesting a second scrollable.
class VideoTileGrid extends StatelessWidget {
  final List<FeedPost> posts;

  const VideoTileGrid({super.key, required this.posts});

  /// Widest a tile is allowed to be relative to its height.
  ///
  /// A clip with a broken or absurd ratio would otherwise produce a tile
  /// either one pixel tall or taller than the screen.
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
      final video = post.media.where((m) => m.isVideo).firstOrNull;
      if (video == null) continue;

      final ratio = _ratioOf(video);
      final tile = _Tile(post: post, media: video, ratio: ratio);
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
              // Never autoplaying: a wall of tiles would start every clip on
              // screen at once. The player still paints its first frame, which
              // is the poster, and playing one is a tap away.
              child: InlineVideo(media: media, autoplay: false),
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
