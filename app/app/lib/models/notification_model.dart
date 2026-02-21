import 'package:intl/intl.dart';

enum NotificationType { like, comment, follow, repost, mention }

class NotificationModel {
  final String id;
  final String actorDid;
  final String actorHandle;
  final String actorAvatarUrl;
  final NotificationType type;
  final String content;
  final String? postSnippet;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.actorDid,
    required this.actorHandle,
    required this.actorAvatarUrl,
    required this.type,
    required this.content,
    this.postSnippet,
    required this.timestamp,
    required this.isRead,
  });

  String get displayTimestamp {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormat('MMM d').format(timestamp);
  }

  String get groupKey {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return 'This Week';
    return 'Older';
  }

  String get actionText {
    switch (type) {
      case NotificationType.like:
        return 'liked your post';
      case NotificationType.comment:
        return 'commented: "$content"';
      case NotificationType.follow:
        return 'followed you';
      case NotificationType.repost:
        return 'reposted your post';
      case NotificationType.mention:
        return 'mentioned you';
    }
  }
}