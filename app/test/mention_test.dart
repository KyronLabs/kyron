import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/mention_token.dart';
import 'package:kyron_app/widgets/post_text.dart';

/// What `insertMention` did to [text] with the caret at [caret].
({String text, int caret}) _insert(String text, int caret, String handle) {
  final value = insertMention(
    TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: caret),
    ),
    handle,
  );
  return (text: value.text, caret: value.selection.baseOffset);
}

void main() {
  group('mentionAt', () {
    test('finds the mention being typed', () {
      final token = mentionAt('hello @ada', 10);

      expect(token, isNotNull);
      expect(token!.query, 'ada');
      expect(token.start, 6);
      expect(token.end, 10);
    });

    test('finds a bare @ with nothing after it yet', () {
      final token = mentionAt('hello @', 7);

      expect(token, isNotNull);
      expect(token!.query, '');
    });

    test('covers the whole token when the caret is inside it', () {
      // Somebody who went back to fix the middle of a handle is completing
      // all of it, not the three letters to the left of the caret.
      final token = mentionAt('hi @adalovelace there', 6);

      expect(token!.query, 'adalovelace');
      expect(token.end, 15);
    });

    test('is not fooled by an email address', () {
      // Rewriting the domain of somebody's email would be worse than doing
      // nothing at all.
      expect(mentionAt('write to me@example.com', 13), isNull);
    });

    test('is not fooled by a second @', () {
      expect(mentionAt('@@ada', 5), isNull);
    });

    test('is nothing outside a mention', () {
      expect(mentionAt('just words', 4), isNull);
      expect(mentionAt('', 0), isNull);
    });

    test('refuses a token longer than a handle can be', () {
      final long = 'a' * 31;
      expect(mentionAt('@$long', long.length + 1), isNull);
    });

    test('agrees with what the renderer highlights', () {
      // The two have to match: a token this accepts and the renderer does not
      // is grey text that looked like a tag while it was being written.
      const text = 'hey @ada';
      final token = mentionAt(text, text.length)!;
      final rendered =
          PostText.pattern.allMatches(text).map((m) => m.group(0)).toList();

      expect(rendered, contains(text.substring(token.start, token.end)));
    });
  });

  group('insertMention', () {
    test('replaces the mention being typed', () {
      // Not appending: '@ad' + '@adalovelace' is what a naive insert gives.
      final result = _insert('hey @ad', 7, 'adalovelace');

      expect(result.text, 'hey @adalovelace ');
      expect(result.caret, result.text.length);
    });

    test('replaces the whole token when the caret is inside it', () {
      final result = _insert('hey @ad there', 7, 'adalovelace');

      expect(result.text, 'hey @adalovelace there');
    });

    test('puts a space in front when it would run into a word', () {
      final result = _insert('hello', 5, 'ada');

      expect(result.text, 'hello @ada ');
    });

    test('adds no second space after one', () {
      final result = _insert('hello ', 6, 'ada');

      expect(result.text, 'hello @ada ');
    });

    test('inserts at the caret, not at the end', () {
      final result = _insert('hi  there', 3, 'ada');

      expect(result.text, 'hi @ada there');
      // Straight after the handle, before the space that was already there.
      expect(result.caret, 7);
    });

    test('takes a handle that already carries its @', () {
      expect(_insert('', 0, '@ada').text, '@ada ');
    });

    test('what it writes is what the renderer highlights', () {
      final result = _insert('hey', 3, 'ada');
      final rendered =
          PostText.pattern.allMatches(result.text).map((m) => m.group(0));

      expect(rendered, contains('@ada'));
    });

    test('survives an invalid selection', () {
      // A controller that has never been focused has selection offset -1.
      final value = insertMention(
        const TextEditingValue(
          text: 'hello',
          selection: TextSelection.collapsed(offset: -1),
        ),
        'ada',
      );

      expect(value.text, 'hello @ada ');
    });
  });
}
