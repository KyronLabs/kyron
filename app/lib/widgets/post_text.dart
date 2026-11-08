import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../routes.dart';
import '../utils/emoji_only.dart';
import 'selection_menu.dart';
import 'post_action_colors.dart';
import '../services/app_browser.dart';
import '../utils/display_url.dart';
import 'create_post/url_preview.dart'
    show isLinkableHost, trimTrailingPunctuation;

/// A post's text, with its hashtags, mentions and links picked out.
///
/// The feed rendered posts as one flat string, so "#running" was grey prose
/// and tapping it did nothing. Parsed here rather than on the server: the
/// server stores what was written, and how it is drawn is the client's
/// business.
class PostText extends StatefulWidget {
  /// A mention's colour. Yellow as far as each page allows and still reads
  /// as text: a true yellow on black (12.6:1), and on white a deep gold
  /// (4.65:1, over the 4.5:1 that body text needs) -- any brighter yellow
  /// on white is a smudge.
  static Color mentionColourOf(Brightness brightness) =>
      brightness == Brightness.dark
          ? const Color(0xFFFFC93C)
          : const Color(0xFF9C6B00);

  final String content;
  final TextStyle? style;
  final int? maxLines;

  /// A hashtag to pick out from the others, without its leading #.
  ///
  /// Set by the screen showing one tag's posts. A post often carries four or
  /// five tags, all of them the same accent blue, and finding the one you
  /// searched for means reading every tag on every post. The one you asked for
  /// gets a highlighter behind it.
  final String? highlightTag;

  /// Whether a long press selects the words, with a menu to copy them,
  /// search for them or select the lot. On, wherever a post, comment or reply
  /// is read; off only where the text is a preview inside something else
  /// that is itself the thing to press.
  final bool selectable;

  /// What a tap on the words does: open the post or comment they belong to.
  ///
  /// Given here rather than left to a tap handler around the text, because a
  /// selectable text answers its own taps -- one around it never hears them.
  final VoidCallback? onTap;

  const PostText({
    super.key,
    required this.content,
    this.style,
    this.maxLines,
    this.highlightTag,
    this.selectable = true,
    this.onTap,
  });

  /// How large a post of nothing but [count] emoji draws them.
  ///
  /// Smaller than a chat's: a message of one emoji is the whole bubble, but a
  /// post sits in a feed between other posts, and at the chat's 60 points one
  /// 😂 out-shouted the photographs around it. Still unmistakably a post made
  /// of emoji -- two and a half times the words, and more for one alone.
  static double jumboSize(int count) =>
      count == 1 ? TypographyTokens.fontSize9 : TypographyTokens.fontSize8;

  @override
  State<PostText> createState() => _PostTextState();

  /// Hashtags, @mentions and bare links.
  ///
  /// The hashtag half matches the server's own extraction: a tag must start at
  /// a word boundary, so "#ffffff" written mid-sentence and "a#b" are not
  /// swept up, and the client highlights exactly what the server indexed.
  /// A hashtag that is only digits is a number somebody wrote, not a tag.
  /// Compiled once: this used to be built inside the loop, so a post with
  /// twenty tags compiled twenty identical regular expressions.
  static final RegExp _digitsOnly = RegExp(r'^\d+$');

  static final RegExp pattern = RegExp(
    r'(?<![\w#])#[\p{L}\p{N}_]{1,50}'
    r'|(?<![\w@])@[A-Za-z0-9_]{1,30}'
    r'|https?://[^\s]+'
    // A bare host -- "kubernetes.io", "edx.org/learn/devops" -- checked
    // against real top-level domains before it is drawn as a link
    // (isLinkableHost), so "Node.js" stays a word.
    r'|(?<![\w@./-])(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+'
    r'[A-Za-z]{2,24}(?:/[^\s<>"]*)?',
    unicode: true,
  );

  /// The hashtags in a piece of text, lower-cased, matching the server.
  static List<String> hashtagsIn(String content) {
    final found = <String>{};
    for (final match in pattern.allMatches(content)) {
      final token = match.group(0)!;
      if (!token.startsWith('#')) continue;
      final tag = token.substring(1).toLowerCase();
      // "ranked #1" is not a topic, and the server does not index it either.
      if (_digitsOnly.hasMatch(tag)) continue;
      found.add(tag);
    }
    return found.toList();
  }
}

class _PostTextState extends State<PostText> {
  /// Held so each span's recogniser can be disposed; a TapGestureRecognizer
  /// that outlives its span leaks.
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = widget.style ??
        const TextStyle(fontSize: TypographyTokens.fontSize3, height: 1.35);

    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    // A few emoji and nothing else are a reaction, drawn large -- the rule
    // the chat already uses (utils/emoji_only.dart), at a feed's size.
    final jumbo = jumboEmojiCount(widget.content);
    final spans = jumbo != null ? null : _spans(context, base, scheme);
    // Everything there is to select, as the selection reports it -- the
    // words as drawn, so a shortened link counts as its short form.
    _whole = spans == null
        ? widget.content.trim()
        : TextSpan(children: spans).toPlainText();
    final Widget text = jumbo != null
        ? Text(
            widget.content.trim(),
            style: base.copyWith(
              fontSize: PostText.jumboSize(jumbo),
              height: 1.2,
              letterSpacing: 2,
            ),
          )
        : Text.rich(
            TextSpan(children: spans),
            maxLines: widget.maxLines,
            overflow: widget.maxLines == null
                ? TextOverflow.clip
                : TextOverflow.ellipsis,
          );
    if (!widget.selectable) {
      return widget.onTap == null
          ? text
          : GestureDetector(onTap: widget.onTap, child: text);
    }

    // The accent, lightly, behind what is chosen, and the accent on its
    // handles: the theme's default was a grey wash that vanished on black.
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: scheme.primary.withValues(alpha: 0.22),
          selectionHandleColor: scheme.primary,
        ),
      ),
      child: SelectionArea(
        key: _area,
        onSelectionChanged: (content) => _selected = content?.plainText,
        contextMenuBuilder: (menuContext, state) => SelectionMenu.forRegion(
          menuContext,
          state,
          selected: _selected,
          // Select all once everything is selected is a button that does
          // nothing, so it goes.
          everything: _selected != null &&
              _selected!.trim().isNotEmpty &&
              _selected!.trim() == _whole.trim(),
          onSearch: (query) =>
              Navigator.pushNamed(context, Routes.search, arguments: query),
        ),
        // Inside the selection area, so this tap is the one that wins: a
        // tap on a tag or a link still goes to the tag, and a tap anywhere
        // else opens what the words belong to -- or, with words chosen,
        // lets them go.
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _tapped,
          child: text,
        ),
      ),
    );
  }

  final _area = GlobalKey<SelectionAreaState>();

  void _tapped() {
    if (_selected?.isNotEmpty ?? false) {
      _area.currentState?.selectableRegion.clearSelection();
      ContextMenuController.removeAny();
      _selected = null;
      return;
    }
    widget.onTap?.call();
  }

  /// What is selected now, for the menu's Search.
  String? _selected;

  /// All of the words, as drawn.
  String _whole = '';

  List<InlineSpan> _spans(
    BuildContext context,
    TextStyle base,
    ColorScheme scheme,
  ) {
    final spans = <InlineSpan>[];
    // Bold and in the accent colour, which is what makes a tag read as
    // something you can act on rather than as part of the sentence.
    final linkStyle = base.copyWith(
      color: scheme.primary,
      fontWeight: FontWeight.w600,
    );
    // People in gold, so a post is not all one blue: tags and links are
    // places to go, a mention is someone.
    final mentionStyle = linkStyle.copyWith(
      color: PostText.mentionColourOf(Theme.of(context).brightness),
    );

    var last = 0;
    for (final match in PostText.pattern.allMatches(widget.content)) {
      if (match.start > last) {
        spans.add(
          TextSpan(
            text: widget.content.substring(last, match.start),
            style: base,
          ),
        );
      }

      var text = match.group(0)!;
      // A link's closing full stop or bracket belongs to the sentence: left
      // in, it was part of what was opened, and of what is shortened below.
      var after = '';
      final bare = !text.startsWith('#') &&
          !text.startsWith('@') &&
          !text.toLowerCase().startsWith('http');
      if (bare && !isLinkableHost(trimTrailingPunctuation(text))) {
        // Looked like a host and is not one: words, as written.
        spans.add(TextSpan(text: text, style: base));
        last = match.end;
        continue;
      }
      final link = bare || text.startsWith('http');
      if (link) {
        final trimmed = trimTrailingPunctuation(text);
        after = text.substring(trimmed.length);
        text = trimmed;
      }
      final target = bare ? 'https://$text' : text;
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _open(context, target);
      _recognizers.add(recognizer);

      final highlighted = widget.highlightTag != null &&
          text.startsWith('#') &&
          text.substring(1).toLowerCase() == widget.highlightTag!.toLowerCase();

      spans.add(
        TextSpan(
          // A link is shown short and opened whole: see displayUrl. A bare
          // host is shown exactly as it was written.
          text: link && !bare ? displayUrl(text) : text,
          style: highlighted
              // Dark text on the highlighter, not the accent colour: blue on
              // yellow is unreadable, and the point is to be spotted.
              ? linkStyle.copyWith(
                  color: const Color(0xFF1A1A1A),
                  backgroundColor: PostActionColors.highlight,
                  fontWeight: FontWeight.w700,
                )
              : text.startsWith('@')
                  ? mentionStyle
                  : linkStyle,
          recognizer: recognizer,
        ),
      );
      if (after.isNotEmpty) spans.add(TextSpan(text: after, style: base));
      last = match.end;
    }

    if (last < widget.content.length) {
      spans.add(TextSpan(text: widget.content.substring(last), style: base));
    }
    return spans;
  }

  Future<void> _open(BuildContext context, String token) async {
    if (token.startsWith('#')) {
      Navigator.pushNamed(
        context,
        Routes.hashtag,
        arguments: token.substring(1),
      );
      return;
    }
    if (token.startsWith('@')) {
      Navigator.pushNamed(
        context,
        Routes.profile,
        arguments: token.substring(1),
      );
      return;
    }

    // Kyron's own browser, not the phone's. Where the link goes is shown
    // across the top of it for as long as the page is open, which is the
    // thing handing the reader to Chrome was ever really for.
    await AppBrowser.open(context, token);
  }
}
