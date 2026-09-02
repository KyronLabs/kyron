import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/composer_poll.dart';

void main() {
  group('ComposerPoll', () {
    test('a fresh poll has two empty answers and runs for a day', () {
      final poll = ComposerPoll.blank();
      expect(poll.options, ['', '']);
      expect(poll.durationMinutes, ComposerPoll.defaultDuration);
      expect(poll.durationLabel, '1 day');
    });

    test('is incomplete until two answers are written', () {
      var poll = ComposerPoll.blank();
      expect(poll.isComplete, isFalse);

      poll = poll.withOption(0, 'Yes');
      expect(poll.isComplete, isFalse, reason: 'one answer is not a poll');

      poll = poll.withOption(1, 'No');
      expect(poll.isComplete, isTrue);
    });

    test('ignores blank answers when deciding whether it can post', () {
      // A third empty box is how you add a third answer, so it must not stop
      // the poll being postable.
      final poll = ComposerPoll(options: const ['Yes', 'No', '', '']);
      expect(poll.filled, ['Yes', 'No']);
      expect(poll.isComplete, isTrue);
    });

    test('rejects two answers that differ only by case', () {
      final poll = ComposerPoll(options: const ['Yes', 'YES']);
      expect(poll.isComplete, isFalse);
      expect(poll.problem, 'Every answer has to be different.');
    });

    test('rejects an answer over the length the server accepts', () {
      final poll = ComposerPoll(
        options: ['a' * (ComposerPoll.maxOptionLength + 1), 'b'],
      );
      expect(poll.isComplete, isFalse);
      expect(poll.problem, contains('80 characters'));
    });

    test('names the problem, and stops naming one once it is fixed', () {
      expect(ComposerPoll.blank().problem, isNotNull);
      expect(ComposerPoll(options: const ['a', 'b']).problem, isNull);
    });

    test('adds answers up to four and no further', () {
      var poll = ComposerPoll.blank();
      poll = poll.addOption().addOption();
      expect(poll.options.length, 4);
      expect(poll.canAddOption, isFalse);

      // Silently does nothing rather than throwing: the button is hidden, but
      // the model should not be a trap either.
      expect(poll.addOption().options.length, 4);
    });

    test('will not remove an answer below the minimum', () {
      final poll = ComposerPoll.blank();
      expect(poll.canRemoveOption, isFalse);
      expect(poll.removeOption(0).options.length, 2);
    });

    test('removes the answer at the index given, keeping the others', () {
      final poll = ComposerPoll(options: const ['a', 'b', 'c']);
      expect(poll.removeOption(1).options, ['a', 'c']);
    });

    test('edits one answer without touching the rest', () {
      final poll = ComposerPoll(options: const ['a', 'b', 'c']);
      expect(poll.withOption(1, 'B!').options, ['a', 'B!', 'c']);
    });

    test('sends only the filled answers and the duration', () {
      final poll = ComposerPoll(
        options: const [' Yes ', 'No', '  '],
        durationMinutes: 60,
      );
      expect(poll.toJson(), {
        'options': ['Yes', 'No'],
        'durationMinutes': 60,
      });
    });

    test('phrases every offered duration in whole units', () {
      for (final minutes in ComposerPoll.durations) {
        final label = ComposerPoll(
          options: const [],
          durationMinutes: minutes,
        ).durationLabel;
        expect(label, isNot(contains('.')), reason: '$minutes -> $label');
        expect(label, matches(RegExp(r'^\d+ (minutes|hours?|days?)$')));
      }
    });

    test('every offered duration is one the server will accept', () {
      for (final minutes in ComposerPoll.durations) {
        expect(minutes, greaterThanOrEqualTo(ComposerPoll.minDuration));
        expect(minutes, lessThanOrEqualTo(ComposerPoll.maxDuration));
      }
    });
  });
}
