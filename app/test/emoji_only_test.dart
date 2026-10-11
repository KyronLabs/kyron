import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:kyron_app/utils/emoji_only.dart';

/// A message that is only a few emoji is drawn large and without a bubble.
///
/// The cases worth pinning are the ones a naive count gets wrong: emoji built
/// from several code points, and characters that look like emoji in a font
/// table but render as text.
void main() {
  group('jumboEmojiCount', () {
    test('counts one, two and three emoji', () {
      expect(jumboEmojiCount('😂'), 1);
      expect(jumboEmojiCount('😂😂'), 2);
      expect(jumboEmojiCount('😂🔥🫠'), 3);
    });

    test('stops being jumbo past three', () {
      expect(jumboEmojiCount('😂😂😂😂'), isNull);
    });

    test('ignores the space around and between them', () {
      expect(jumboEmojiCount('  😂 '), 1);
      expect(jumboEmojiCount('😂 😂'), 2);
      expect(jumboEmojiCount('😂\n🔥'), 2);
    });

    test('is not jumbo once there are words', () {
      expect(jumboEmojiCount('lol 😂'), isNull);
      expect(jumboEmojiCount('😂!'), isNull);
      expect(jumboEmojiCount('Oop'), isNull);
    });

    test('is not jumbo for an empty or blank message', () {
      expect(jumboEmojiCount(''), isNull);
      expect(jumboEmojiCount('   '), isNull);
    });

    test('counts an emoji made of several code points as one', () {
      // A skin tone, a ZWJ sequence, a family, a flag.
      expect(jumboEmojiCount('👍🏾'), 1);
      expect(jumboEmojiCount('👩🏽‍💻'), 1);
      expect(jumboEmojiCount('👨‍👩‍👧‍👦'), 1);
      expect(jumboEmojiCount('🇳🇬'), 1);
      expect(jumboEmojiCount('🇳🇬🇬🇭'), 2);
    });

    test('counts what the keyboard sends with the emoji selector', () {
      expect(jumboEmojiCount('❤️'), 1);
      expect(jumboEmojiCount('☺️'), 1);
      expect(jumboEmojiCount('#️⃣'), 1);
      expect(jumboEmojiCount('1️⃣2️⃣'), 2);
    });

    test('leaves alone what renders as text', () {
      // Pictographs by default drawn as text, and plain digits.
      expect(jumboEmojiCount('©'), isNull);
      expect(jumboEmojiCount('☺'), isNull);
      expect(jumboEmojiCount('1'), isNull);
      expect(jumboEmojiCount('42'), isNull);
    });
  });

  test('draws fewer emoji larger', () {
    expect(jumboEmojiSize(1), greaterThan(jumboEmojiSize(2)));
    expect(jumboEmojiSize(2), greaterThan(jumboEmojiSize(3)));
  });

  test('draws them large enough to read as the message', () {
    // One at 37.5 read as a slightly big emoji, not a message made of one.
    expect(jumboEmojiSize(1),
        greaterThanOrEqualTo(TypographyTokens.fontSize3 * 4));
    expect(jumboEmojiSize(3), greaterThanOrEqualTo(TypographyTokens.fontSize9));
  });
}
