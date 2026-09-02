// lib/models/composer_poll.dart

/// A poll while it is being written, before the post exists.
///
/// Separate from [Poll], which is a poll the server has stored and counted
/// votes for. This one has no id, no totals and no closing instant -- only a
/// duration, because "one day" means one day from when the post goes out, not
/// from when the composer was opened.
class ComposerPoll {
  /// Two to four answers. Blank ones are kept while typing -- an empty third
  /// box is how you add a third answer -- and dropped on the way out.
  final List<String> options;

  /// How long voting stays open, in minutes.
  final int durationMinutes;

  const ComposerPoll({
    required this.options,
    this.durationMinutes = defaultDuration,
  });

  /// Matching the server, which rejects anything outside this.
  static const minOptions = 2;
  static const maxOptions = 4;
  static const maxOptionLength = 80;
  static const minDuration = 5;
  static const maxDuration = 7 * 24 * 60;
  static const defaultDuration = 24 * 60;

  /// A fresh poll: two empty answers, open for a day.
  factory ComposerPoll.blank() =>
      const ComposerPoll(options: ['', ''], durationMinutes: defaultDuration);

  /// The answers that would actually be sent.
  List<String> get filled =>
      options.map((o) => o.trim()).where((o) => o.isNotEmpty).toList();

  /// Whether this poll could be posted as it stands.
  bool get isComplete {
    final answers = filled;
    if (answers.length < minOptions) return false;
    if (answers.any((o) => o.length > maxOptionLength)) return false;
    // Two answers with the same words give a reader no way to tell which one
    // they picked, so the server refuses them and so does this.
    return answers.map((o) => o.toLowerCase()).toSet().length == answers.length;
  }

  /// Why it cannot be posted yet, or null when it can.
  String? get problem {
    final answers = filled;
    if (answers.length < minOptions) {
      return 'A poll needs at least two answers.';
    }
    if (answers.any((o) => o.length > maxOptionLength)) {
      return 'An answer can be at most $maxOptionLength characters.';
    }
    if (answers.map((o) => o.toLowerCase()).toSet().length != answers.length) {
      return 'Every answer has to be different.';
    }
    return null;
  }

  bool get canAddOption => options.length < maxOptions;

  /// Removing is only offered above the minimum, so a poll cannot be edited
  /// down into something that will not post.
  bool get canRemoveOption => options.length > minOptions;

  ComposerPoll copyWith({List<String>? options, int? durationMinutes}) =>
      ComposerPoll(
        options: options ?? this.options,
        durationMinutes: durationMinutes ?? this.durationMinutes,
      );

  ComposerPoll withOption(int index, String text) => copyWith(
        options: [
          for (var i = 0; i < options.length; i++)
            i == index ? text : options[i],
        ],
      );

  ComposerPoll addOption() =>
      canAddOption ? copyWith(options: [...options, '']) : this;

  ComposerPoll removeOption(int index) => canRemoveOption
      ? copyWith(options: [
          for (var i = 0; i < options.length; i++)
            if (i != index) options[i],
        ])
      : this;

  Map<String, dynamic> toJson() => {
        'options': filled,
        'durationMinutes': durationMinutes,
      };

  /// How long it runs, as a person would say it.
  String get durationLabel {
    if (durationMinutes % (24 * 60) == 0) {
      final days = durationMinutes ~/ (24 * 60);
      return '$days day${days == 1 ? '' : 's'}';
    }
    if (durationMinutes % 60 == 0) {
      final hours = durationMinutes ~/ 60;
      return '$hours hour${hours == 1 ? '' : 's'}';
    }
    return '$durationMinutes minutes';
  }

  /// The durations the composer offers.
  static const durations = <int>[
    30,
    60,
    6 * 60,
    24 * 60,
    3 * 24 * 60,
    7 * 24 * 60,
  ];
}
