/// A post exactly as GET /feed/recent returns it.
///
/// Deliberately not PostModel. That one carries likes, reposts, reach,
/// bookmarks and media, none of which the API knows about; constructing it
/// here would mean inventing those numbers, and a fabricated engagement count
/// is dummy data whether it comes from List.generate or from a default value.
/// This grows a field when the API grows one.
class FeedPost {
  final String id;
  final String content;
  final DateTime createdAt;
  final FeedAuthor author;

  /// How many people have liked it.
  final int likes;

  /// How many comments and replies it has.
  final int comments;

  /// Whether you have. Saves are private, so there is no count for them.
  final bool liked;
  final bool saved;

  const FeedPost({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
    this.likes = 0,
    this.comments = 0,
    this.liked = false,
    this.saved = false,
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) => FeedPost(
        id: json['id'] as String,
        content: json['content'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        author: FeedAuthor.fromJson(
          (json['author'] as Map<String, dynamic>?) ?? const {},
        ),
        likes: (json['likes'] as num?)?.toInt() ?? 0,
        comments: (json['comments'] as num?)?.toInt() ?? 0,
        liked: json['likedByViewer'] == true,
        saved: json['savedByViewer'] == true,
      );

  FeedPost copyWith({
    int? likes,
    int? comments,
    bool? liked,
    bool? saved,
  }) =>
      FeedPost(
        id: id,
        content: content,
        createdAt: createdAt,
        author: author,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        liked: liked ?? this.liked,
        saved: saved ?? this.saved,
      );
}

class FeedAuthor {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  const FeedAuthor({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
  });

  factory FeedAuthor.fromJson(Map<String, dynamic> json) => FeedAuthor(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );

  /// What to show above a post.
  ///
  /// Falls back through name, then handle, then a neutral label -- never to a
  /// placeholder like "@user", which is what the old feed rendered for
  /// everyone and made a real account indistinguishable from filler.
  String get displayName {
    final n = name?.trim();
    if (n != null && n.isNotEmpty) return n;
    final u = username?.trim();
    if (u != null && u.isNotEmpty) return u;
    return 'Someone on Kyron';
  }

  /// The @handle, or null when the account has none set.
  String? get handle {
    final u = username?.trim();
    return (u == null || u.isEmpty) ? null : '@$u';
  }
}

/// One page of the feed.
class FeedPage {
  final List<FeedPost> items;

  /// Pass back as `cursor` for the next page; null means this is the end.
  final String? nextCursor;

  const FeedPage({required this.items, this.nextCursor});

  factory FeedPage.fromJson(Map<String, dynamic> json) => FeedPage(
        items: ((json['items'] as List<dynamic>?) ?? const [])
            .map((e) => FeedPost.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
