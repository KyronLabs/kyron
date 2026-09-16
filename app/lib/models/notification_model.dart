import 'package:intl/intl.dart';

/// What somebody did. The screen's tabs narrow to one of the first three.
enum NotificationType { like, comment, follow, repost }

/// Who did it.
class NotificationActor {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  const NotificationActor({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
  });

  factory NotificationActor.fromJson(Map<String, dynamic> json) =>
      NotificationActor(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );

  /// What the row calls them. Falls back through the display name and the
  /// handle rather than showing a blank where a name should be.
  String get label {
    final name = this.name?.trim();
    if (name != null && name.isNotEmpty) return name;
    final username = this.username?.trim();
    if (username != null && username.isNotEmpty) return '@$username';
    return 'Someone';
  }
}

class NotificationModel {
  final String id;
  final NotificationType type;
  final NotificationActor actor;

  /// The post it happened to. Null for a follow.
  final String? postId;

  /// The start of that post, so the row says which one.
  final String? postSnippet;

  /// What was written, for a comment.
  final String? content;

  final DateTime timestamp;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.actor,
    required this.timestamp,
    required this.isRead,
    this.postId,
    this.postSnippet,
    this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final at = DateTime.tryParse(json['createdAt'] as String? ?? '');
    return NotificationModel(
      id: json['id'] as String? ?? '',
      type: switch (json['kind'] as String?) {
        'comment' => NotificationType.comment,
        'follow' => NotificationType.follow,
        'repost' => NotificationType.repost,
        _ => NotificationType.like,
      },
      actor: NotificationActor.fromJson(
        (json['actor'] as Map<String, dynamic>?) ?? const {},
      ),
      postId: json['postId'] as String?,
      postSnippet: json['postSnippet'] as String?,
      content: json['content'] as String?,
      timestamp: (at ?? DateTime.now()).toLocal(),
      isRead: json['unread'] != true,
    );
  }

  String get displayTimestamp {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormat('MMM d').format(timestamp);
  }

  String get groupKey {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return 'This week';
    return 'Older';
  }

  String get actionText => switch (type) {
        NotificationType.like => 'liked your post',
        NotificationType.comment => 'replied to your post',
        NotificationType.follow => 'followed you',
        NotificationType.repost => 'reposted your post',
      };
}

/// One page of them.
class NotificationPage {
  final List<NotificationModel> items;
  final String? nextCursor;

  const NotificationPage({required this.items, this.nextCursor});

  factory NotificationPage.fromJson(Map<String, dynamic> json) =>
      NotificationPage(
        items: ((json['items'] as List<dynamic>?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(NotificationModel.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
