// lib/widgets/create_post/url_preview.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../../providers/composer_provider.dart';
import '../link_preview_card.dart';
import '../hairline.dart';

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
/// And the last label has to be a real top-level domain ([isLinkableHost]),
/// so "Node.js", "notes.txt" and "README.md" are left as words. With that,
/// a bare host is linked in the post's text too -- people write
/// "kubernetes.io", not "https://kubernetes.io", and a list of resources
/// that could not be tapped read as broken.
String? firstLinkIn(String text) {
  final explicit = _explicit.firstMatch(text);
  final bare = _bare
      .allMatches(text)
      .where((m) => isLinkableHost(trimTrailingPunctuation(m.group(0)!)))
      .firstOrNull;

  // Whichever comes first in the text, so a post that opens with a bare host
  // and later carries a full URL still previews the one the reader meets first.
  final match = switch ((explicit, bare)) {
    (null, null) => null,
    (final e?, null) => e,
    (null, final b?) => b,
    (final e?, final b?) => e.start <= b.start ? e : b,
  };
  if (match == null) return null;

  final raw = trimTrailingPunctuation(match.group(0)!);
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

/// [_bare], for the post text to find bare hosts with.
RegExp get bareHostPattern => _bare;

/// Whether [candidate] -- a bare host, perhaps with a path -- ends in a top
/// level domain that is really one, and not a file's extension.
///
/// Every country's domain counts ([_countries]), but for the few that are
/// far more often a file than a website: .md, .py, .sh, .rs, .ps, .cc. Longer ones count
/// when they are in [_generic], the ones people link to; "Node.js" and
/// "notes.txt" are not domains at all. The letters before the domain must
/// hold a letter, and an abbreviation people write ("e.g", "a.m") is out.
bool isLinkableHost(String candidate) {
  final host = candidate.split('/').first.toLowerCase();
  if (_notALink.contains(host)) return false;
  final labels = host.split('.');
  if (labels.length < 2) return false;
  final tld = labels.last;
  final before = labels[labels.length - 2];
  if (!RegExp('[a-z]').hasMatch(before)) return false;
  if (tld.length == 2) {
    return _countries.contains(tld) && !_fileLike.contains(tld);
  }
  return _generic.contains(tld);
}

/// Country domains that are much more often a file's extension.
const _fileLike = {'md', 'py', 'sh', 'rs', 'ps', 'cc'};

/// Every country's domain, as IANA lists them. Two letters are not enough
/// on their own: ".js", ".ts" and ".go" are not domains at all.
const _countries = {
  'ac',
  'ad',
  'ae',
  'af',
  'ag',
  'ai',
  'al',
  'am',
  'ao',
  'aq',
  'ar',
  'as',
  'at',
  'au',
  'aw',
  'ax',
  'az',
  'ba',
  'bb',
  'bd',
  'be',
  'bf',
  'bg',
  'bh',
  'bi',
  'bj',
  'bm',
  'bn',
  'bo',
  'br',
  'bs',
  'bt',
  'bw',
  'by',
  'bz',
  'ca',
  'cc',
  'cd',
  'cf',
  'cg',
  'ch',
  'ci',
  'ck',
  'cl',
  'cm',
  'cn',
  'co',
  'cr',
  'cu',
  'cv',
  'cw',
  'cx',
  'cy',
  'cz',
  'de',
  'dj',
  'dk',
  'dm',
  'do',
  'dz',
  'ec',
  'ee',
  'eg',
  'er',
  'es',
  'et',
  'eu',
  'fi',
  'fj',
  'fk',
  'fm',
  'fo',
  'fr',
  'ga',
  'gd',
  'ge',
  'gf',
  'gg',
  'gh',
  'gi',
  'gl',
  'gm',
  'gn',
  'gp',
  'gq',
  'gr',
  'gs',
  'gt',
  'gu',
  'gw',
  'gy',
  'hk',
  'hm',
  'hn',
  'hr',
  'ht',
  'hu',
  'id',
  'ie',
  'il',
  'im',
  'in',
  'io',
  'iq',
  'ir',
  'is',
  'it',
  'je',
  'jm',
  'jo',
  'jp',
  'ke',
  'kg',
  'kh',
  'ki',
  'km',
  'kn',
  'kp',
  'kr',
  'kw',
  'ky',
  'kz',
  'la',
  'lb',
  'lc',
  'li',
  'lk',
  'lr',
  'ls',
  'lt',
  'lu',
  'lv',
  'ly',
  'ma',
  'mc',
  'md',
  'me',
  'mg',
  'mh',
  'mk',
  'ml',
  'mm',
  'mn',
  'mo',
  'mp',
  'mq',
  'mr',
  'ms',
  'mt',
  'mu',
  'mv',
  'mw',
  'mx',
  'my',
  'mz',
  'na',
  'nc',
  'ne',
  'nf',
  'ng',
  'ni',
  'nl',
  'no',
  'np',
  'nr',
  'nu',
  'nz',
  'om',
  'pa',
  'pe',
  'pf',
  'pg',
  'ph',
  'pk',
  'pl',
  'pm',
  'pn',
  'pr',
  'ps',
  'pt',
  'pw',
  'py',
  'qa',
  're',
  'ro',
  'rs',
  'ru',
  'rw',
  'sa',
  'sb',
  'sc',
  'sd',
  'se',
  'sg',
  'sh',
  'si',
  'sk',
  'sl',
  'sm',
  'sn',
  'so',
  'sr',
  'ss',
  'st',
  'su',
  'sv',
  'sx',
  'sy',
  'sz',
  'tc',
  'td',
  'tf',
  'tg',
  'th',
  'tj',
  'tk',
  'tl',
  'tm',
  'tn',
  'to',
  'tr',
  'tt',
  'tv',
  'tw',
  'tz',
  'ua',
  'ug',
  'uk',
  'us',
  'uy',
  'uz',
  'va',
  'vc',
  've',
  'vg',
  'vi',
  'vn',
  'vu',
  'wf',
  'ws',
  'ye',
  'yt',
  'za',
  'zm',
  'zw',
};

/// The longer top-level domains linked to often enough to recognise bare.
/// Not every one there is: a word after a full stop with no space is far
/// more often a typo than ".pizza".
const _generic = {
  'com',
  'net',
  'org',
  'edu',
  'gov',
  'mil',
  'int',
  'info',
  'biz',
  'name',
  'pro',
  'app',
  'dev',
  'page',
  'io',
  'xyz',
  'tech',
  'site',
  'online',
  'store',
  'shop',
  'blog',
  'news',
  'live',
  'cloud',
  'link',
  'wiki',
  'aws',
  'google',
  'art',
  'design',
  'studio',
  'media',
  'world',
  'today',
  'space',
  'website',
  'agency',
  'global',
  'network',
  'systems',
  'software',
  'tools',
  'codes',
  'academy',
  'education',
  'school',
  'church',
  'africa',
  'music',
  'social',
  'fyi',
  'one',
  'top',
  'club',
  'icu',
  'vip',
  'fun',
  'life',
  'email',
  'run',
  'build',
  'ninja',
  'guru',
  'company',
  'digital',
  'events',
  'community',
};

/// Abbreviations that look like hosts and are not.
const _notALink = {'e.g', 'i.e', 'etc', 'vs', 'a.m', 'p.m', 'u.s', 'u.k'};

/// Trailing punctuation belongs to the sentence, not the address.
String trimTrailingPunctuation(String url) {
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
                fontSize: TypographyTokens.fontSize2,
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
                fontSize: TypographyTokens.fontSize1,
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
          border: Border.fromBorderSide(postRule(scheme)),
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
