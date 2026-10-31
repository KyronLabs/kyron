// lib/utils/display_url.dart

/// How a link is written in a post: short enough to read, whole enough to
/// recognise.
///
/// A link pasted from a share sheet is mostly tracking -- the New Scientist
/// one that prompted this was 160 characters, 90 of them `utm_` parameters
/// -- and drawn in full it took five lines of a post and said nothing the
/// first line did not. So the scheme, `www.`, tracking parameters and the
/// fragment go, and whatever is still over [max] characters ends in an
/// ellipsis:
///
///     https://www.newscientist.com/article/2595718-this-weeks-new-questions-369/?utm_term=…
///     newscientist.com/article/2595718-this-week…
///
/// A query that is not tracking stays: `youtube.com/watch?v=…` is told from
/// every other video by nothing else.
///
/// Only what is shown changes. Tapping it opens the address as written, and
/// copying the post copies it whole.
String displayUrl(String url, {int max = 40}) {
  var shown = url.replaceFirst(RegExp(r'^https?://', caseSensitive: false), '');
  shown = shown.replaceFirst(RegExp(r'^www\.', caseSensitive: false), '');

  final hash = shown.indexOf('#');
  if (hash >= 0) shown = shown.substring(0, hash);

  final question = shown.indexOf('?');
  if (question >= 0) {
    final kept = shown
        .substring(question + 1)
        .split('&')
        .where((pair) => pair.isNotEmpty && !_tracking.hasMatch(pair))
        .join('&');
    shown = shown.substring(0, question) + (kept.isEmpty ? '' : '?$kept');
  }
  // A lone trailing slash is noise: "example.com/" reads as "example.com".
  if (shown.endsWith('/') && shown.indexOf('/') == shown.length - 1) {
    shown = shown.substring(0, shown.length - 1);
  }

  // Counted and cut by characters, not code units, so an emoji or an
  // accented letter in a path is never split in half.
  final runes = shown.runes.toList();
  if (runes.length <= max) return shown;
  return '${String.fromCharCodes(runes.take(max - 1))}…';
}

/// Query parameters that only say where a link was shared from.
///
/// Not `t` (a YouTube timestamp) or `s` (a WordPress search): short names
/// mean different things on different sites, and showing a parameter that
/// was tracking costs less than hiding one that was not.
final _tracking = RegExp(
  r'^(utm_[a-z_]+|fbclid|gclid|dclid|msclkid|igshid|igsh|mc_cid|mc_eid|'
  r'_hsenc|_hsmi|mkt_tok|ref_src|ref_url|si|feature|share_id)(=|$)',
  caseSensitive: false,
);
