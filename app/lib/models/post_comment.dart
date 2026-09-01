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

  /// How many replies hang off it. Always 0 on a reply.
  final int replies;

  /// Whether you wrote it, and so may delete it.
  final bool mine;

  /// Attachments, in the order they were added.
  final List<PostMedia> media;

  const PostComment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
    this.parentId,
    this.replies = 0,
    this.mine = false,
    this.media = const [],
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
        mine: json['mine'] == true,
        media: PostMedia.listFrom(json['media']),
      );

  PostComment copyWith({int? replies}) => PostComment(
        id: id,
        content: content,
        createdAt: createdAt,
        author: author,
        parentId: parentId,
        replies: replies ?? this.replies,
        mine: mine,
        media: media,
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
