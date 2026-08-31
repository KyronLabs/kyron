/// An unsent post, kept on the device so leaving the screen does not lose it.
class ComposerDraft {
  final String? id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ComposerDraft({
    this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  /// The drafts table also has privacy, scheduledAt and mediaPaths columns,
  /// from a composer that offered all three while the API supported none of
  /// them. They are written empty rather than dropped: the columns are NOT
  /// NULL, and migrating the table would throw away whatever unsent draft an
  /// existing install is holding.
  Map<String, Object?> toMap() => {
        'id': id,
        'content': content,
        'privacy': '',
        'scheduledAt': null,
        'mediaPaths': '[]',
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory ComposerDraft.fromMap(Map<String, Object?> map) {
    final now = DateTime.now();
    return ComposerDraft(
      id: map['id'] as String?,
      content: map['content'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? now,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? '') ?? now,
    );
  }

  ComposerDraft copyWith({String? id, String? content}) => ComposerDraft(
        id: id ?? this.id,
        content: content ?? this.content,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );
}
