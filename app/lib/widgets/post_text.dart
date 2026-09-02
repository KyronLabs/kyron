import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes.dart';
import 'post_action_colors.dart';

/// A post's text, with its hashtags, mentions and links picked out.
///
/// The feed rendered posts as one flat string, so "#running" was grey prose
/// and tapping it did nothing. Parsed here rather than on the server: the
/// server stores what was written, and how it is drawn is the client's
/// business.
class PostText extends StatefulWidget {
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

  const PostText({
    super.key,
    required this.content,
    this.style,
    this.maxLines,
    this.highlightTag,
  });

  @override
  State<PostText> createState() => _PostTextState();

  /// Hashtags, @mentions and bare links.
  ///
  /// The hashtag half matches the server's own extraction: a tag must start at
  /// a word boundary, so "#ffffff" written mid-sentence and "a#b" are not
  /// swept up, and the client highlights exactly what the server indexed.
  static final RegExp pattern = RegExp(
    r'(?<![\w#])#[\p{L}\p{N}_]{1,50}'
    r'|(?<![\w@])@[A-Za-z0-9_]{1,30}'
    r'|https?://[^\s]+',
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
      if (RegExp(r'^\d+$').hasMatch(tag)) continue;
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
    final base = widget.style ?? const TextStyle(fontSize: 15, height: 1.35);

    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    return Text.rich(
      TextSpan(
        children: _spans(context, base, scheme),
      ),
      maxLines: widget.maxLines,
      overflow:
          widget.maxLines == null ? TextOverflow.clip : TextOverflow.ellipsis,
    );
  }

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

    var last = 0;
    for (final match in PostText.pattern.allMatches(widget.content)) {
      if (match.start > last) {
        spans.add(
          TextSpan(
              text: widget.content.substring(last, match.start), style: base),
        );
      }

      final text = match.group(0)!;
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _open(context, text);
      _recognizers.add(recognizer);

      final highlighted = widget.highlightTag != null &&
          text.startsWith('#') &&
          text.substring(1).toLowerCase() == widget.highlightTag!.toLowerCase();

      spans.add(
        TextSpan(
          text: text,
          style: highlighted
              // Dark text on the highlighter, not the accent colour: blue on
              // yellow is unreadable, and the point is to be spotted.
              ? linkStyle.copyWith(
                  color: const Color(0xFF1A1A1A),
                  backgroundColor: PostActionColors.highlight,
                  fontWeight: FontWeight.w700,
                )
              : linkStyle,
          recognizer: recognizer,
        ),
      );
      last = match.end;
    }

    if (last < widget.content.length) {
      spans.add(TextSpan(text: widget.content.substring(last), style: base));
    }
    return spans;
  }

  Future<void> _open(BuildContext context, String token) async {
    if (token.startsWith('#')) {
      Navigator.pushNamed(context, Routes.hashtag,
          arguments: token.substring(1));
      return;
    }
    if (token.startsWith('@')) {
      Navigator.pushNamed(context, Routes.profile,
          arguments: token.substring(1));
      return;
    }

    final uri =
        Uri.tryParse(token.startsWith('http') ? token : 'https://$token');
    if (uri == null) return;
    // In the browser rather than the in-app view: a link in someone else's
    // post should not look like part of Kyron.
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
