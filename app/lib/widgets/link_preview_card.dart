// lib/widgets/link_preview_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/link_preview.dart';
import '../providers/feed_provider.dart';
import '../services/app_browser.dart';
import 'hairline.dart';

/// The card for one link, fetched once and shared by every widget showing it.
///
/// A `.family` keyed on the URL, so the same link in the feed, in the post
/// screen and in the composer is one request rather than three -- and so
/// scrolling a post off screen and back does not fetch it again.
final linkPreviewProvider = FutureProvider.family<LinkPreview?, String>((
  ref,
  url,
) async {
  // Held after the last listener goes, so returning to a post does not refetch
  // a card that has not changed.
  ref.keepAlive();
  return ref.read(feedRepositoryProvider).linkPreview(url);
});

/// The Open Graph card under a post that links somewhere.
///
/// Renders nothing at all while the card is loading, when the link has no
/// card, and when the fetch fails. A skeleton would reserve space that may
/// never be filled, which makes the post jump as the feed scrolls; a card that
/// simply is not there for a link that has none is the correct outcome.
class LinkPreviewCard extends ConsumerWidget {
  final String url;

  /// Compact form: no image banner, for a quoted post or a comment.
  final bool compact;

  const LinkPreviewCard({super.key, required this.url, this.compact = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(linkPreviewProvider(url));

    return card.maybeWhen(
      data: (preview) => preview == null || !preview.isRenderable
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(top: SpacingTokens.space12),
              child: LinkCard(
                preview: preview,
                image: preview.imageUrl == null
                    ? null
                    : NetworkImage(preview.imageUrl!),
                compact: compact,
              ),
            ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

/// One link's card: the picture as a banner, then the site, the title and a
/// line or two of description.
///
/// Drawn the same wherever a link is shown -- under a post, where the
/// server read the page, and in a message, where the sender's phone did and
/// the picture arrived with it. [image] is whichever of those it is.
class LinkCard extends StatelessWidget {
  final LinkPreview preview;
  final ImageProvider? image;

  /// No banner: the picture as a square at the start, for a quoted post or a
  /// comment.
  final bool compact;

  /// The text's colour, for a card drawn on something other than the page:
  /// inside the sender's own bubble, which is filled with the accent.
  final Color? ink;

  /// Filled rather than outlined. A hairline is an edge on the page; inside
  /// a bubble, which already has one, a card is a shade instead.
  final Color? fill;

  /// The corner, which inside a bubble follows the bubble's own.
  final double radius;

  /// Whether a card with no picture keeps a square for one. Under a post it
  /// does, so cards line up down the feed; inside a message bubble an empty
  /// square is only weight.
  final bool placeholder;

  const LinkCard({
    super.key,
    required this.preview,
    this.image,
    this.compact = false,
    this.ink,
    this.fill,
    this.radius = RadiusTokens.radiusMd,
    this.placeholder = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shape = BorderRadius.circular(radius);

    return InkWell(
      onTap: () => AppBrowser.open(context, preview.url),
      borderRadius: shape,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: shape,
          border: fill == null ? Border.fromBorderSide(postRule(scheme)) : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: compact || image == null
            ? _Row(
                preview: preview,
                image: image,
                ink: ink,
                placeholder: placeholder,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1.91, // What og:image is authored for.
                    child: _Picture(image: image!, iconSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SpacingTokens.space12),
                    child: _Text(preview: preview, ink: ink),
                  ),
                ],
              ),
      ),
    );
  }
}

/// A card's picture, with a quiet tile while it loads and if it fails.
class _Picture extends StatelessWidget {
  final ImageProvider image;
  final double iconSize;

  const _Picture({required this.image, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Image(
      image: image,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: Icon(
          Iconsax.link_copy,
          size: iconSize,
          color: scheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
      frameBuilder: (context, child, frame, synchronous) =>
          synchronous || frame != null
              ? child
              : ColoredBox(color: scheme.surfaceContainerHighest),
    );
  }
}

class _Row extends StatelessWidget {
  final LinkPreview preview;
  final ImageProvider? image;
  final Color? ink;
  final bool placeholder;

  const _Row({
    required this.preview,
    required this.image,
    this.ink,
    this.placeholder = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (image == null && !placeholder) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space12,
          vertical: SpacingTokens.space8,
        ),
        child: _Text(preview: preview, ink: ink),
      );
    }

    // As tall as the taller of the picture and the words, with the picture
    // stretched to it. Without IntrinsicHeight a stretched row inside a
    // scrolling list is asked to be infinitely tall, and every card with no
    // picture of its own -- a title-only page -- failed to lay out in the
    // feed.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: image == null
                ? ColoredBox(
                    color: scheme.surfaceContainerHighest,
                    child: Icon(
                      Iconsax.link_copy,
                      size: 20,
                      color: scheme.onSurface.withValues(alpha: 0.35),
                    ),
                  )
                : _Picture(image: image!, iconSize: 20),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(SpacingTokens.space8),
              child: _Text(preview: preview, ink: ink, maxDescriptionLines: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final LinkPreview preview;
  final Color? ink;
  final int maxDescriptionLines;

  const _Text({
    required this.preview,
    this.ink,
    this.maxDescriptionLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final strong = ink ?? scheme.onSurface;
    final muted = strong.withValues(alpha: 0.6);
    final title = preview.title;
    final description = preview.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          preview.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: muted,
          ),
        ),
        if (title != null) ...[
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: strong,
            ),
          ),
        ],
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description,
            maxLines: maxDescriptionLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              height: 1.3,
              color: muted,
            ),
          ),
        ],
      ],
    );
  }
}
