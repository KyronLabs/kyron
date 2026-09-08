import 'dart:convert';

import 'composer_poll.dart';
import 'feed_post.dart';
import 'post_media.dart';

/// An unsent post, kept on the device so leaving the screen does not lose it.
class ComposerDraft {
  final String? id;
  final String content;

  /// Who may reply to it, once it goes out.
  final ReplyPolicy replyPolicy;

  /// The poll attached to it, if any.
  final ComposerPoll? poll;

  /// The topics it is filed under, by slug.
  final List<String> topics;

  /// The post it quotes, if the composer was opened from one.
  final QuotedPost? quoting;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ComposerDraft({
    this.id,
    required this.content,
    this.replyPolicy = ReplyPolicy.everyone,
    this.poll,
    this.topics = const [],
    this.quoting,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Whether there is anything here worth keeping.
  ///
  /// A poll or a quote with no text is still a draft. Judging this by the text
  /// alone threw away a poll somebody had filled in.
  bool get hasContent =>
      content.trim().isNotEmpty ||
      poll != null ||
      quoting != null ||
      topics.isNotEmpty;

  /// The drafts table also has privacy, scheduledAt and mediaPaths columns,
  /// from a composer that offered all three while the API supported none of
  /// them. They are written empty rather than dropped: the columns are NOT
  /// NULL, and migrating the table would throw away whatever unsent draft an
  /// existing install is holding.
  ///
  /// Everything the composer has gained since -- the poll, the topics, the
  /// reply setting, the quote -- goes in `payload` as JSON, for the same
  /// reason: one nullable column added to the table, rather than one per
  /// field and a migration each time the composer grows.
  Map<String, Object?> toMap() => {
        'id': id,
        'content': content,
        'privacy': '',
        'scheduledAt': null,
        'mediaPaths': '[]',
        'payload': jsonEncode(_payload),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  Map<String, Object?> get _payload => {
        'replyPolicy': replyPolicy.wire,
        if (poll != null)
          'poll': {
            // The options as typed, not [ComposerPoll.filled]: a draft is
            // saved mid-edit, and dropping the blank third answer would take
            // away the box somebody was about to type in.
            'options': poll!.options,
            'durationMinutes': poll!.durationMinutes,
          },
        if (topics.isNotEmpty) 'topics': topics,
        if (quoting != null) 'quoting': quoting!.toJson(),
      };

  factory ComposerDraft.fromMap(Map<String, Object?> map) {
    final now = DateTime.now();
    // Rows written before the payload column existed have none, and a row
    // holding something unreadable is still a row holding somebody's text --
    // so the extras are dropped and the words are kept.
    Map<String, dynamic> payload = const {};
    final raw = map['payload'] as String?;
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) payload = decoded;
      } on FormatException {
        payload = const {};
      }
    }

    final poll = payload['poll'];
    final topics = payload['topics'];
    final quoting = payload['quoting'];

    return ComposerDraft(
      id: map['id'] as String?,
      content: map['content'] as String? ?? '',
      replyPolicy: ReplyPolicy.fromJson(payload['replyPolicy']),
      poll: poll is Map<String, dynamic>
          ? ComposerPoll(
              options: [
                for (final option in (poll['options'] as List<dynamic>? ?? []))
                  option as String? ?? '',
              ],
              durationMinutes: (poll['durationMinutes'] as num?)?.toInt() ??
                  ComposerPoll.defaultDuration,
            )
          : null,
      topics: [
        for (final slug in (topics as List<dynamic>? ?? [])) slug as String,
      ],
      quoting:
          quoting is Map<String, dynamic> ? QuotedPost.fromJson(quoting) : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? now,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? '') ?? now,
    );
  }

  ComposerDraft copyWith({String? id, String? content}) => ComposerDraft(
        id: id ?? this.id,
        content: content ?? this.content,
        replyPolicy: replyPolicy,
        poll: poll,
        topics: topics,
        quoting: quoting,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );
}
