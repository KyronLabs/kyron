import 'dart:convert';

class ComposerDraft {
  final String? id;
  final String content;
  final String privacy;
  final DateTime? scheduledAt;
  final List<String> mediaPaths;
  final DateTime createdAt;
  final DateTime updatedAt;

  ComposerDraft({
    this.id,
    required this.content,
    this.privacy = 'Public',
    this.scheduledAt,
    this.mediaPaths = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'privacy': privacy,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'mediaPaths': jsonEncode(mediaPaths),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ComposerDraft.fromMap(Map<String, dynamic> map) {
    return ComposerDraft(
      id: map['id'],
      content: map['content'] ?? '',
      privacy: map['privacy'] ?? 'Public',
      scheduledAt: map['scheduledAt'] != null 
          ? DateTime.parse(map['scheduledAt']) 
          : null,
      mediaPaths: List<String>.from(jsonDecode(map['mediaPaths'] ?? '[]')),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  ComposerDraft copyWith({
    String? id,
    String? content,
    String? privacy,
    DateTime? scheduledAt,
    List<String>? mediaPaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ComposerDraft(
      id: id ?? this.id,
      content: content ?? this.content,
      privacy: privacy ?? this.privacy,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      mediaPaths: mediaPaths ?? this.mediaPaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}