// lib/widgets/link_preview_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/link_preview.dart';
import '../providers/feed_provider.dart';

/// The card for one link, fetched once and shared by every widget showing it.
///
/// A `.family` keyed on the URL, so the same link in the feed, in the post
/// screen and in the composer is one request rather than three -- and so
/// scrolling a post off screen and back does not fetch it again.
final linkPreviewProvider =
    FutureProvider.family<LinkPreview?, String>((ref, url) async {
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
          : _Card(preview: preview, compact: compact),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _Card extends StatelessWidget {
  final LinkPreview preview;
  final bool compact;

  const _Card({required this.preview, required this.compact});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = preview.title;
    final description = preview.description;
    final image = preview.imageUrl;

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space12),
      child: InkWell(
        onTap: _open,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
          ),
          clipBehavior: Clip.antiAlias,
          child: compact || image == null
              ? _Row(preview: preview, image: image)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.91, // What og:image is authored for.
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => ColoredBox(
                          color: scheme.surfaceContainerHighest,
                          child: Icon(
                            Iconsax.link_copy,
                            color: scheme.onSurface.withValues(alpha: 0.3),
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
                    Padding(
                      padding: const EdgeInsets.all(SpacingTokens.space12),
                      child: _Text(
                        preview: preview,
                        title: title,
                        description: description,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _open() async {
    final uri = Uri.tryParse(preview.url);
    if (uri == null) return;
    // Externally, not in an in-app view: a link in somebody else's post should
    // not look like part of Kyron, and the browser is where a reader can see
    // where they have actually been sent.
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _Row extends StatelessWidget {
  final LinkPreview preview;
  final String? image;

  const _Row({required this.preview, required this.image});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
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
              : Image.network(
                  image!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      ColoredBox(color: scheme.surfaceContainerHighest),
                ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space8),
            child: _Text(
              preview: preview,
              title: preview.title,
              description: preview.description,
              maxDescriptionLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  final LinkPreview preview;
  final String? title;
  final String? description;
  final int maxDescriptionLines;

  const _Text({
    required this.preview,
    required this.title,
    required this.description,
    this.maxDescriptionLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          preview.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: muted,
          ),
        ),
        if (title != null) ...[
          const SizedBox(height: 2),
          Text(
            title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
        ],
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(
            description!,
            maxLines: maxDescriptionLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, height: 1.3, color: muted),
          ),
        ],
      ],
    );
  }
}
