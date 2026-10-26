// lib/models/interest_signal.dart

/// One "Show more posts like this" or "Not interested in this", as Settings
/// lists it: what was said, about which post, and how much of it the feeds
/// still read.
class InterestSignal {
  const InterestSignal({
    required this.postId,
    required this.more,
    required this.givenAt,
    required this.strength,
    required this.excerpt,
    required this.authorName,
    required this.topics,
    required this.hashtags,
    this.authorUsername,
    this.authorAvatarUrl,
  });

  final String postId;

  /// True for "show more", false for "not interested".
  final bool more;
  final DateTime givenAt;

  /// 1 when new, fading towards 0 over a few months.
  final double strength;
  final String excerpt;
  final String authorName;
  final String? authorUsername;
  final String? authorAvatarUrl;
  final List<String> topics;
  final List<String> hashtags;

  /// Null for anything that is not a signal, rather than a throw: one bad
  /// row should not empty the screen.
  static InterestSignal? tryFrom(Map<String, dynamic> json) {
    final postId = json['postId'];
    final kind = json['kind'];
    final givenAt = DateTime.tryParse(json['givenAt'] as String? ?? '');
    final author = json['author'];
    if (postId is! String ||
        (kind != 'MORE' && kind != 'LESS') ||
        givenAt == null ||
        author is! Map<String, dynamic>) {
      return null;
    }
    final username = author['username'] as String?;
    return InterestSignal(
      postId: postId,
      more: kind == 'MORE',
      givenAt: givenAt,
      strength: ((json['strength'] as num?) ?? 0).toDouble().clamp(0, 1),
      excerpt: json['excerpt'] as String? ?? '',
      authorName: (author['name'] as String?)?.trim().isNotEmpty == true
          ? author['name'] as String
          : (username ?? ''),
      authorUsername: username,
      authorAvatarUrl: author['avatarUrl'] as String?,
      topics: [
        for (final t in (json['topics'] as List<dynamic>?) ?? const [])
          if (t is String) t,
      ],
      hashtags: [
        for (final h in (json['hashtags'] as List<dynamic>?) ?? const [])
          if (h is String) h,
      ],
    );
  }
}
