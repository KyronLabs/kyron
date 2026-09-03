import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';
import '../utils/decode_size.dart';
import 'inline_video.dart';
import 'media_viewer.dart';

/// The attachments under a post, laid out by how many there are.
///
/// One fills the width at its own aspect ratio; two sit side by side; three
/// put the first beside a stacked pair; four make a square. Every tile opens
/// the viewer at the one that was tapped.
class MediaGrid extends StatelessWidget {
  final List<PostMedia> media;

  /// Corner rounding. Smaller inside a quoted card than under a post.
  final double radius;

  const MediaGrid({
    super.key,
    required this.media,
    this.radius = RadiusTokens.radiusMd,
  });

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: switch (media.length) {
        1 => _single(context),
        2 => _row(context, [0, 1]),
        3 => _threeUp(context),
        _ => _fourUp(context),
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

    return AspectRatio(
      aspectRatio: ratio,
      child: _tile(context, 0),
    );
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
                Expanded(child: _tile(context, 2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fourUp(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          Expanded(child: _row(context, [0, 1])),
          const SizedBox(height: 2),
          Expanded(child: _row(context, [2, 3])),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, int index) {
    final item = media[index];
    final scheme = Theme.of(context).colorScheme;

    // Both open the viewer; a clip does it through its own tap handler, which
    // sits above this one so the sound button can take its own taps first.
    return GestureDetector(
      onTap: item.isVideo
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
                // A grid of four is drawn at half the width; one on its own
                // fills it.
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
              Positioned(
                left: 6,
                bottom: 6,
                child: _Badge(label: 'GIF'),
              ),
            // Marked, so someone who relies on descriptions can see which
            // attachments carry one.
            if (item.alt != null && item.alt!.trim().isNotEmpty)
              const Positioned(
                right: 6,
                bottom: 6,
                child: _Badge(label: 'ALT'),
              ),
          ],
        ),
      ),
    );
  }
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
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
