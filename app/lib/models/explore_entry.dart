// lib/models/explore_entry.dart

/// One hashtag on the Explore wall.
class TrendingTag {
  /// Without its leading #, which is how every tag is stored.
  final String tag;

  /// Posts carrying it, all time. What you find when you tap through.
  final int posts;

  /// How many of those are from the last few days. What ranked it.
  final int recent;

  const TrendingTag({
    required this.tag,
    this.posts = 0,
    this.recent = 0,
  });

  factory TrendingTag.fromJson(Map<String, dynamic> json) => TrendingTag(
        tag: json['tag'] as String? ?? '',
        posts: (json['posts'] as num?)?.toInt() ?? 0,
        recent: (json['recent'] as num?)?.toInt() ?? 0,
      );
}

/// One row of the topic catalogue: what a reader can say they are into.
class Topic {
  /// The stable name, sent when following or unfollowing.
  final String slug;

  /// What it is called on screen.
  final String name;

  /// How many accounts have chosen it.
  final int people;

  /// Whether the reader is one of them.
  final bool following;

  const Topic({
    required this.slug,
    required this.name,
    this.people = 0,
    this.following = false,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        slug: json['slug'] as String? ?? '',
        name: json['name'] as String? ?? '',
        people: (json['people'] as num?)?.toInt() ?? 0,
        following: json['following'] == true,
      );

  Topic copyWith({int? people, bool? following}) => Topic(
        slug: slug,
        name: name,
        people: people ?? this.people,
        following: following ?? this.following,
      );
}
