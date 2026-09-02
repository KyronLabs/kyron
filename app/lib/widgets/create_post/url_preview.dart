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

/// The first web link in a piece of text, or null.
///
/// Handles a bare host as well as a full URL: someone writing
/// "m.facebook.com" means a link, and requiring them to type the scheme is
/// requiring them to think about something nobody thinks about. A bare host is
/// returned with `https://` in front, which is what the server would have to
/// assume anyway.
///
/// The risk with bare hosts is conjuring a link out of ordinary prose --
/// "1.5", "e.g.", "etc.", a sentence with no space after the full stop. Three
/// things guard against it:
///
///  * the last label has to be a plausible TLD: letters only, at least two of
///    them, so "1.5" and "8.30" cannot match;
///  * the label before it has to contain a letter, so "1.co" does not match;
///  * a short list of abbreviations people actually write is excluded outright.
///
/// It is still a guess, which is why a bare host only ever produces a preview
/// card -- never a rewritten link in the post's text.
String? firstLinkIn(String text) {
  final explicit = _explicit.firstMatch(text);
  final bare = _bare.firstMatch(text);

  // Whichever comes first in the text, so a post that opens with a bare host
  // and later carries a full URL still previews the one the reader meets first.
  final match = switch ((explicit, bare)) {
    (null, null) => null,
    (final e?, null) => e,
    (null, final b?) => b,
    (final e?, final b?) => e.start <= b.start ? e : b,
  };
  if (match == null) return null;

  final raw = _trimTrailing(match.group(0)!);
  if (raw.isEmpty) return null;

  if (match == explicit) {
    // "https://" on its own is not a link to anything.
    return raw.length < 12 ? null : raw;
  }

  if (_notALink.contains(raw.toLowerCase())) return null;
  return 'https://$raw';
}

/// A URL that names its own scheme.
final _explicit = RegExp(r'https?://[^\s<>"]+', caseSensitive: false);

/// A bare host, optionally with a path: `example.com`, `m.facebook.com/x`.
///
/// `(?<![\w@./-])` stops it matching inside something longer -- the tail of a
/// URL already matched, an email address, or a file name.
final _bare = RegExp(
  r'(?<![\w@./-])'
  r'(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+' // labels, dot-separated
  r'[a-z]{2,24}' // the TLD: letters only
  r'(?:/[^\s<>"]*)?', // an optional path
  caseSensitive: false,
);

/// Abbreviations that look like hosts and are not.
const _notALink = {
  'e.g',
  'i.e',
  'etc',
  'vs',
  'a.m',
  'p.m',
  'u.s',
  'u.k',
};

/// Trailing punctuation belongs to the sentence, not the address.
String _trimTrailing(String url) {
  var trimmed = url.replaceAll(RegExp(r'[.,;:!?]+$'), '');
  // A closing bracket is only part of the address if the address opened one --
  // Wikipedia URLs do, "(see example.com)" does not.
  while (trimmed.endsWith(')') && !trimmed.contains('(')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  while (trimmed.endsWith(']') && !trimmed.contains('[')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed;
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
