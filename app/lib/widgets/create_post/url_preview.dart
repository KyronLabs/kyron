// lib/widgets/create_post/url_preview.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../../providers/composer_provider.dart';
import '../link_preview_card.dart';

/// The card for the first link in whatever is being written.
///
/// What stood here was six hundred lines that fetched the page **on the
/// device**: an isolate, a full HTML parse, three regex strategies for finding
/// a URL, and a hand-rolled cache. Three things were wrong with it.
///
/// It told the linked site who was writing about them -- the request came from
/// the author's own address, before the post existed. It could not be trusted
/// to agree with what readers would eventually see, because readers get their
/// card from the API. And it spent an isolate and a DOM parse on a phone for
/// four short strings.
///
/// This asks the server, which is where the card comes from for everyone else,
/// so what the author sees while writing is what the post will actually carry.
class UrlPreview extends ConsumerWidget {
  const UrlPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(composerProvider.select((s) => s.content));
    final url = firstLinkIn(content);
    if (url == null) return const SizedBox.shrink();

    final card = ref.watch(linkPreviewProvider(url));

    return card.when(
      // The composer, unlike the feed, does show a placeholder: the author is
      // waiting to find out whether their link will carry a card, and an empty
      // space does not answer that.
      loading: () => _Pending(url: url),
      error: (_, __) => _None(url: url),
      data: (preview) => preview == null || !preview.isRenderable
          ? _None(url: url)
          : LinkPreviewCard(url: url),
    );
  }
}

/// The first http(s) link in a piece of text, or null.
///
/// Deliberately narrower than what the old detector accepted. It guessed at
/// bare domains and at `ftp://`, so typing "1.5" or "e.g." conjured a card for
/// a site nobody meant to link -- and the server will not fetch anything but
/// http and https anyway, so offering more here only produces failures.
String? firstLinkIn(String text) {
  final match = RegExp(
    r'https?://[^\s<>"]+',
    caseSensitive: false,
  ).firstMatch(text);
  if (match == null) return null;

  // Trailing punctuation belongs to the sentence, not the address.
  final url = match.group(0)!.replaceAll(RegExp(r'[.,;:!?)\]]+$'), '');
  return url.length < 12 ? null : url;
}

class _Pending extends StatelessWidget {
  final String url;

  const _Pending({required this.url});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _Frame(
      child: Row(
        children: [
          SizedBox.square(
            dimension: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: scheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Text(
              'Looking up ${_host(url)}…',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Said plainly rather than left blank: the author should know their post will
/// carry a bare link, not wonder whether the card is still loading.
class _None extends StatelessWidget {
  final String url;

  const _None({required this.url});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _Frame(
      child: Row(
        children: [
          Icon(
            Iconsax.link_copy,
            size: 15,
            color: scheme.onSurface.withValues(alpha: 0.45),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              '${_host(url)} has no preview. Your post will show the link on '
              'its own.',
              style: TextStyle(
                fontSize: 12,
                height: 1.3,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Frame extends StatelessWidget {
  final Widget child;

  const _Frame({required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space12),
      child: Container(
        padding: const EdgeInsets.all(SpacingTokens.space12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
        ),
        child: child,
      ),
    );
  }
}

String _host(String url) {
  final host = Uri.tryParse(url)?.host ?? url;
  return host.startsWith('www.') ? host.substring(4) : host;
}
