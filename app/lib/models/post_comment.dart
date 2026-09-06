// lib/models/post_comment.dart

import 'feed_post.dart';
import 'post_media.dart';

/// One comment on a post, or one reply to a comment.
class PostComment {
  final String id;
  final String content;
  final DateTime createdAt;
  final FeedAuthor author;

  /// Null on a top-level comment.
  final String? parentId;

  /// How many replies hang off it.
  final int replies;

  /// The first few people who answered it, for the faces on the marker that
  /// opens a folded run. Empty when nobody has: never padded out, because a
  /// face there is a claim that this person is in the conversation.
  final List<FeedAuthor> replyFaces;

  /// Whether you wrote it, and so may delete it.
  final bool mine;

  /// Attachments, in the order they were added.
  final List<PostMedia> media;

  /// How many people liked it, and whether you are one of them.
  final int likes;
  final bool liked;

  const PostComment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
    this.parentId,
    this.replies = 0,
    this.replyFaces = const [],
    this.mine = false,
    this.media = const [],
    this.likes = 0,
    this.liked = false,
  });

  bool get isReply => parentId != null;

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        id: json['id'] as String? ?? '',
        content: json['content'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        author: FeedAuthor.fromJson(
          (json['author'] as Map<String, dynamic>?) ?? const {},
        ),
        parentId: json['parentId'] as String?,
        replies: (json['replies'] as num?)?.toInt() ?? 0,
        replyFaces: ((json['replyFaces'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(FeedAuthor.fromJson)
            .toList(),
        mine: json['mine'] == true,
        media: PostMedia.listFrom(json['media']),
        likes: (json['likes'] as num?)?.toInt() ?? 0,
        liked: json['liked'] == true,
      );

  PostComment copyWith({int? replies, int? likes, bool? liked}) => PostComment(
        id: id,
        content: content,
        createdAt: createdAt,
        author: author,
        parentId: parentId,
        replies: replies ?? this.replies,
        replyFaces: replyFaces,
        mine: mine,
        media: media,
        likes: likes ?? this.likes,
        liked: liked ?? this.liked,
      );
}

/// One comment, everything under it, and which post it belongs to.
class CommentThread {
  final String postId;
  final PostComment root;
  final List<PostComment> replies;

  const CommentThread({
    required this.postId,
    required this.root,
    required this.replies,
  });

  factory CommentThread.fromJson(Map<String, dynamic> json) => CommentThread(
        postId: json['postId'] as String? ?? '',
        root: PostComment.fromJson(
          (json['root'] as Map<String, dynamic>?) ?? const {},
        ),
        replies: ((json['replies'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(PostComment.fromJson)
            .toList(),
      );
}

/// One page of a thread.
class CommentPage {
  final List<PostComment> items;
  final String? nextCursor;

  const CommentPage({required this.items, this.nextCursor});

  factory CommentPage.fromJson(Map<String, dynamic> json) => CommentPage(
        items: ((json['items'] as List<dynamic>?) ?? const [])
            .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}

/// How a post is doing, as its author sees it.
class PostAnalytics {
  /// Distinct people who opened it. Counted once each, not once per open, and
  /// never counting the author.
  final int views;
  final int likes;
  final int saves;
  final int comments;
  final DateTime createdAt;

  /// Views per day since it was posted, oldest first.
  final List<DailyViews> timeline;

  const PostAnalytics({
    required this.views,
    required this.likes,
    required this.saves,
    required this.comments,
    required this.createdAt,
    required this.timeline,
  });

  /// Everyone who did something with it, over everyone who saw it.
  ///
  /// Null when nobody has seen it: a rate over zero is not 0%, it is unknown,
  /// and printing 0% reads as "nobody engaged" rather than "nobody looked".
  double? get engagementRate {
    if (views == 0) return null;
    return (likes + saves + comments) / views;
  }

  factory PostAnalytics.fromJson(Map<String, dynamic> json) => PostAnalytics(
        views: (json['views'] as num?)?.toInt() ?? 0,
        likes: (json['likes'] as num?)?.toInt() ?? 0,
        saves: (json['saves'] as num?)?.toInt() ?? 0,
        comments: (json['comments'] as num?)?.toInt() ?? 0,
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        timeline: ((json['timeline'] as List<dynamic>?) ?? const [])
            .map((e) => DailyViews.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class DailyViews {
  final String date;
  final int views;

  const DailyViews({required this.date, required this.views});

  factory DailyViews.fromJson(Map<String, dynamic> json) => DailyViews(
        date: json['date'] as String? ?? '',
        views: (json['views'] as num?)?.toInt() ?? 0,
      );
}
