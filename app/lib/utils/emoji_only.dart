// lib/utils/emoji_only.dart
//
// Whether a message is nothing but a few emoji, which a chat draws large and
// without a bubble -- a 😂 on its own is a reaction, and at text size inside a
// bubble it reads as a typo. Mixed with words, emoji stay the size of the
// words around them.
//
// Counted in grapheme clusters, never in code units or code points: 👩🏽‍💻 is
// five code points and one emoji, 🇳🇬 is two and one, and a count that got
// either wrong would draw a single emoji at the size meant for three, or call
// three emoji one.
import 'package:characters/characters.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The most emoji a message can hold and still be drawn large. Past this it is
/// a row of pictures, not a reaction, and it goes back in a bubble.
const int maxJumboEmoji = 3;

// The analyzer's valid_regexps check does not know Unicode property escapes,
// which are only legal with `unicode: true` -- it reports these as invalid.
// They are not: test/emoji_only_test.dart exercises both.
// ignore: valid_regexps
final RegExp _presentation = RegExp(r'\p{Emoji_Presentation}', unicode: true);
final RegExp _pictographic = RegExp(
  // ignore: valid_regexps
  r'\p{Extended_Pictographic}',
  unicode: true,
);

/// Variation selector 16: "draw the one before me as an emoji".
const String _emojiStyle = '\u{FE0F}';

/// Combining enclosing keycap, as in 1️⃣ and #️⃣.
const String _keycap = '\u{20E3}';

/// Whether one grapheme cluster is drawn as an emoji.
///
/// Three ways to be one. A code point that is an emoji by default -- 😀, and
/// the regional-indicator pairs that make flags. A pictograph explicitly asked
/// to be drawn as an emoji with U+FE0F, which is how a keyboard sends ❤️ and
/// ☺️. Or a keycap. What is left out matters as much: © and a bare ☺ are
/// pictographs that render as text, and a digit is an emoji only inside a
/// keycap -- a message saying "1" is not a jumbo one.
bool isEmojiGrapheme(String grapheme) {
  if (_presentation.hasMatch(grapheme)) return true;
  if (grapheme.contains(_emojiStyle) && _pictographic.hasMatch(grapheme)) {
    return true;
  }
  return grapheme.contains(_keycap);
}

/// How many emoji [text] is, when it is nothing else and few enough to draw
/// large; null otherwise.
///
/// Whitespace between them is allowed and not counted -- "😂 😂" is two.
/// Anything else, a letter or a full stop, means it is a sentence that
/// happens to contain emoji.
int? jumboEmojiCount(String text) {
  var count = 0;
  for (final grapheme in text.trim().characters) {
    if (grapheme.trim().isEmpty) continue;
    if (!isEmojiGrapheme(grapheme)) return null;
    count++;
    if (count > maxJumboEmoji) return null;
  }
  return count == 0 ? null : count;
}

/// The font size for a message of [count] emoji: the fewer, the larger, the
/// way every messaging app that does this scales them, so one emoji is a
/// statement and three still fit on a narrow phone without wrapping.
///
/// The top three steps of the type scale rather than sizes of their own. One
/// emoji at 37.5 is two and a half times body text, which is about where the
/// apps people already use draw it.
double jumboEmojiSize(int count) => switch (count) {
      1 => TypographyTokens.fontSize9,
      2 => TypographyTokens.fontSize8,
      _ => TypographyTokens.fontSize7,
    };
