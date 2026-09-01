import 'post_media.dart';

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

  /// Plain reposts. A quote is a post of its own and counted as one.
  final int reposts;

  /// Attachments, in the order the author put them.
  final List<PostMedia> media;

  /// The post this one quotes, one level deep. Null for most posts, and null
  /// when the quoted post has since been deleted.
  final QuotedPost? quotedPost;

  /// Who may reply.
  final ReplyPolicy replyPolicy;

  /// Whether you have. Saves are private, so there is no count for them.
  final bool liked;
  final bool saved;
  final bool reposted;

  const FeedPost({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
    this.likes = 0,
    this.comments = 0,
    this.reposts = 0,
    this.media = const [],
    this.quotedPost,
    this.replyPolicy = ReplyPolicy.everyone,
    this.liked = false,
    this.saved = false,
    this.reposted = false,
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
        reposts: (json['reposts'] as num?)?.toInt() ?? 0,
        media: PostMedia.listFrom(json['media']),
        quotedPost: json['quotedPost'] is Map<String, dynamic>
            ? QuotedPost.fromJson(json['quotedPost'] as Map<String, dynamic>)
            : null,
        replyPolicy: ReplyPolicy.fromJson(json['replyPolicy']),
        liked: json['likedByViewer'] == true,
        saved: json['savedByViewer'] == true,
        reposted: json['repostedByViewer'] == true,
      );

  FeedPost copyWith({
    int? likes,
    int? comments,
    int? reposts,
    bool? liked,
    bool? saved,
    bool? reposted,
  }) =>
      FeedPost(
        id: id,
        content: content,
        createdAt: createdAt,
        author: author,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        reposts: reposts ?? this.reposts,
        media: media,
        quotedPost: quotedPost,
        replyPolicy: replyPolicy,
        liked: liked ?? this.liked,
        saved: saved ?? this.saved,
        reposted: reposted ?? this.reposted,
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

/// A quoted post, without its own quote. One level, so a chain of quotes
/// cannot render into an unbounded stack of cards.
class QuotedPost {
  final String id;
  final String content;
  final DateTime createdAt;
  final FeedAuthor author;
  final List<PostMedia> media;

  const QuotedPost({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
    this.media = const [],
  });

  factory QuotedPost.fromJson(Map<String, dynamic> json) => QuotedPost(
        id: json['id'] as String? ?? '',
        content: json['content'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        author: FeedAuthor.fromJson(
          (json['author'] as Map<String, dynamic>?) ?? const {},
        ),
        media: PostMedia.listFrom(json['media']),
      );
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
