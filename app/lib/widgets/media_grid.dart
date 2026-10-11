import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';
import '../utils/decode_size.dart';
import 'inline_video.dart';
import 'media_viewer.dart';

/// Attachments -- under a post, in a comment, in a message -- laid out by how
/// many there are.
///
/// One fills the width at its own aspect ratio; two sit side by side; three
/// or more put the first beside a stacked pair, and anything past three is
/// folded into the third tile: darkened, with "+n" for how many more there
/// are, and a tap there opens the viewer where all of them can be swiped
/// through. Every tile opens the viewer at the one that was tapped.
///
/// There used to be a square of four. It reused the two-across row, which
/// carries its own 16:9 shape, so inside the square each row shrank to 16:9
/// and centred itself: the photos came out narrower than the post and short
/// of the rounded clip, which is why their corners looked square. Three and
/// a count also means the number a post can carry is no longer the number of
/// tiles that fit.
class MediaGrid extends StatelessWidget {
  final List<PostMedia> media;

  /// Corner rounding. Smaller inside a quoted card than under a post.
  final double radius;

  const MediaGrid({
    super.key,
    required this.media,
    this.radius = RadiusTokens.radiusMd,
  });

  /// The most tiles drawn.
  static const maxTiles = 3;

  /// How many are not drawn, and are counted on the last tile instead.
  int get hidden => media.length > maxTiles ? media.length - maxTiles : 0;

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: switch (media.length) {
        1 => _single(context),
        2 => _row(context, [0, 1]),
        _ => _threeUp(context),
      },
    );
  }

  Widget _single(BuildContext context) {
    final item = media.first;

    // The attachment's own shape, not a box it has to fit into. A single clip
    // was being poured into a 4:3 default and clamped at 0.6, so a portrait
    // video -- which is most of them -- came out letterboxed with a black bar
    // down each side, and a tall one was cropped.
    //
    // Videos get the wider bounds, because a 9:16 clip is normal and a 9:16
    // photograph usually is not.
    final ratio = item.isVideo
        ? SizedInlineVideo.ratioFor(item)
        : (item.aspectRatio ?? 4 / 3).clamp(0.6, 2.0);

    return AspectRatio(aspectRatio: ratio, child: _tile(context, 0));
  }

  Widget _row(BuildContext context, List<int> indices) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Row(
        children: [
          for (final index in indices) ...[
            if (index != indices.first) const SizedBox(width: 2),
            Expanded(child: _tile(context, index)),
          ],
        ],
      ),
    );
  }

  Widget _threeUp(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Row(
        children: [
          Expanded(child: _tile(context, 0)),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _tile(context, 1)),
                const SizedBox(height: 2),
                Expanded(child: _tile(context, 2, more: hidden)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// One attachment. [more], on the last tile drawn, is how many there are
  /// past it.
  Widget _tile(BuildContext context, int index, {int more = 0}) {
    final item = media[index];
    final scheme = Theme.of(context).colorScheme;

    // Both open the viewer; a clip does it through its own tap handler, which
    // sits above this one so the sound button can take its own taps first.
    return GestureDetector(
      // With more behind it the tile is a way into all of them, clip or not.
      onTap: item.isVideo && more == 0
          ? null
          : () => MediaViewer.open(context, media, initialIndex: index),
      child: Hero(
        tag: item.id,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // A clip plays in place, and paints its own first frame as the
            // poster. It used to be a grey rectangle with a play glyph and no
            // player behind it, which is why a video post read as blank until
            // it was opened.
            if (item.isVideo)
              InlineVideo(
                media: item,
                // One clip at a time. Four autoplaying videos in one post is
                // four decoders and four streams for a post nobody has
                // stopped to watch yet.
                autoplay: media.length == 1,
                onOpen: () =>
                    MediaViewer.open(context, media, initialIndex: index),
              )
            else
              Image.network(
                item.url,
                fit: BoxFit.cover,
                // A tile of the grid is drawn at half the width or less; one
                // on its own fills it.
                cacheWidth: decodeWidth(
                  context,
                  fraction: media.length == 1 ? 1.0 : 0.5,
                ),
                filterQuality: FilterQuality.low,
                errorBuilder: (_, __, ___) => ColoredBox(
                  color: scheme.surfaceContainerHighest,
                  child: Icon(
                    Iconsax.gallery_slash_copy,
                    color: scheme.onSurface.withValues(alpha: .4),
                  ),
                ),
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : ColoredBox(color: scheme.surfaceContainerHighest),
              ),
            if (item.kind == MediaKind.gif)
              Positioned(left: 6, bottom: 6, child: _Badge(label: 'GIF')),
            // Marked, so someone who relies on descriptions can see which
            // attachments carry one.
            if (item.alt != null && item.alt!.trim().isNotEmpty)
              Positioned(right: 6, bottom: 6, child: _Badge(label: 'ALT')),
            if (more > 0) _More(count: more),
          ],
        ),
      ),
    );
  }
}

/// The scrim and count over the last tile when there are more than fit.
///
/// Over everything, a clip's controls included: the tile is now a way into
/// the rest, and the whole of it answers the tap.
class _More extends StatelessWidget {
  const _More({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.55),
          child: Center(
            child: Text(
              '+$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: TypographyTokens.fontSize7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(RadiusTokens.radius4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: TypographyTokens.fontSize0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
