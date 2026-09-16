// lib/utils/mention_token.dart
//
// Where a mention is being typed, and how to put one into a piece of text.
//
// Kept apart from the composers because both of them need it and because the
// edge cases are the whole job: a caret one character to the left of where it
// was assumed, and the picker replaces the wrong span of somebody's post.
import 'package:flutter/widgets.dart';

/// The `@token` the caret is inside, with the span it occupies.
class MentionToken {
  /// Index of the '@'.
  final int start;

  /// One past the last character of the token.
  final int end;

  /// The token without its '@'. Empty when only the '@' has been typed.
  final String query;

  const MentionToken({
    required this.start,
    required this.end,
    required this.query,
  });
}

/// What a handle may contain, matching `PostText.pattern`, which is what
/// decides whether the finished mention is highlighted and tappable.
bool _isHandleChar(int code) =>
    (code >= 0x30 && code <= 0x39) || // 0-9
    (code >= 0x41 && code <= 0x5A) || // A-Z
    (code >= 0x61 && code <= 0x7A) || // a-z
    code == 0x5F; // _

const int _at = 0x40;

/// The longest handle `PostText.pattern` will highlight.
const int _maxHandle = 30;

/// The mention being typed at [caret], or null if the caret is not in one.
///
/// Matches the same shape the renderer highlights: a run of handle characters
/// after an '@' that is itself not preceded by a word character or another
/// '@'. So the caret in `you@example.com` is not in a mention -- an email
/// address is not a tag, and treating it as one would rewrite it.
MentionToken? mentionAt(String text, int caret) {
  if (caret < 0 || caret > text.length) return null;

  var start = caret;
  while (start > 0 && _isHandleChar(text.codeUnitAt(start - 1))) {
    start--;
  }

  // The run has to be preceded by an '@'.
  if (start == 0 || text.codeUnitAt(start - 1) != _at) return null;
  final at = start - 1;

  // Which in turn must not be preceded by a word character or another '@'.
  if (at > 0) {
    final before = text.codeUnitAt(at - 1);
    if (_isHandleChar(before) || before == _at) return null;
  }

  if (caret - start > _maxHandle) return null;

  // The whole token, not just the part before the caret: somebody editing the
  // middle of `@adalovelace` is completing all of it.
  var end = caret;
  while (end < text.length && _isHandleChar(text.codeUnitAt(end))) {
    end++;
  }
  if (end - start > _maxHandle) return null;

  return MentionToken(start: at, end: end, query: text.substring(start, end));
}

/// [value] with [handle] written in as a mention.
///
/// Replaces the mention being typed when there is one, so picking somebody
/// after typing `@ad` leaves `@adalovelace` rather than `@ad@adalovelace`.
/// Otherwise it goes in at the caret, with a space in front of it when it
/// would otherwise run into the previous word.
///
/// A trailing space either way: the next thing typed is a word, not more of
/// the handle, and without it the renderer takes it as part of the mention.
TextEditingValue insertMention(TextEditingValue value, String handle) {
  final text = value.text;
  final tag = '@${handle.replaceFirst('@', '')}';

  final selection = value.selection;
  final caret = selection.isValid ? selection.end : text.length;
  final anchor = selection.isValid ? selection.start : text.length;

  final token = mentionAt(text, caret);
  var start = token?.start ?? anchor;
  final end = token?.end ?? caret;

  if (start > text.length) start = text.length;
  final stop = end.clamp(start, text.length);

  // Nothing before it, or whitespace already: no separator needed.
  final before =
      start > 0 && !_isSpace(text.codeUnitAt(start - 1)) && token == null
          ? ' '
          : '';
  // And none after it when the text already carries one -- tagging somebody
  // in the middle of a sentence otherwise leaves a double space behind.
  final after =
      stop < text.length && _isSpace(text.codeUnitAt(stop)) ? '' : ' ';
  final insert = '$before$tag$after';

  final updated = text.replaceRange(start, stop, insert);

  return TextEditingValue(
    text: updated,
    selection: TextSelection.collapsed(offset: start + insert.length),
  );
}

bool _isSpace(int code) =>
    code == 0x20 || code == 0x09 || code == 0x0A || code == 0x0D;
