import 'package:intl/intl.dart';

import '../repositories/moderation_repository.dart';
import 'account_standing.dart';
import 'gift.dart';

/// What somebody did. The screen's tabs narrow to one of the first three.
///
/// [account] and [report] are Kyron's, not a person's: a decision about this
/// account, an appeal answered or a decision reversed, and what came of
/// something this account reported.
enum NotificationType { like, comment, follow, repost, account, report, gift }

/// What the team decided, as a row says it. The words are the app's, in the
/// reader's language; this is only what happened.
class AccountNoticeRow {
  /// decision, appeal or reversal.
  final String event;
  final String actionId;
  final int number;
  final ModerationKind kind;
  final ReportReason rule;
  final ReportTarget? target;
  final DateTime? endsAt;

  /// For an appeal: accepted, and the decision undone.
  final bool overturned;

  const AccountNoticeRow({
    required this.event,
    required this.actionId,
    required this.number,
    required this.kind,
    required this.rule,
    this.target,
    this.endsAt,
    this.overturned = false,
  });

  factory AccountNoticeRow.fromJson(Map<String, dynamic> json) =>
      AccountNoticeRow(
        event: json['event'] as String? ?? 'decision',
        actionId: json['actionId'] as String? ?? '',
        number: (json['number'] as num?)?.toInt() ?? 0,
        kind: ModerationKind.fromWire(json['kind']),
        rule: ReportReason.fromWire(json['rule']),
        target: ReportTarget.fromWire(json['target']),
        endsAt: DateTime.tryParse(json['endsAt'] as String? ?? '')?.toLocal(),
        overturned: json['overturned'] == true,
      );
}

/// What came of something the reader reported. Never who looked at it.
class ReportOutcomeRow {
  final bool actioned;
  final ReportTarget? target;
  final ReportReason reason;

  const ReportOutcomeRow({
    required this.actioned,
    required this.reason,
    this.target,
  });

  factory ReportOutcomeRow.fromJson(Map<String, dynamic> json) =>
      ReportOutcomeRow(
        actioned: json['outcome'] == 'ACTIONED',
        target: ReportTarget.fromWire(json['target']),
        reason: ReportReason.fromWire(json['reason']),
      );
}

/// Who did it.
class NotificationActor {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;

  /// Somebody on the Kyron team checked it is who it says it is.
  final bool verified;

  const NotificationActor({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
    this.verified = false,
  });

  factory NotificationActor.fromJson(Map<String, dynamic> json) =>
      NotificationActor(
        id: json['id'] as String? ?? '',
        name: json['name'] as String?,
        username: json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        verified: json['verified'] == true,
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

  /// Who did it. Null for [NotificationType.account] and
  /// [NotificationType.report], which are Kyron's.
  final NotificationActor? actor;

  /// The post it happened to. Null for a follow.
  final String? postId;

  /// The start of that post, so the row says which one.
  final String? postSnippet;

  /// What was written, for a comment.
  final String? content;

  final DateTime timestamp;
  final bool isRead;

  final AccountNoticeRow? account;
  final ReportOutcomeRow? report;

  /// Which gift, for a [NotificationType.gift] row.
  final GiftNote? gift;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.actor,
    this.postId,
    this.postSnippet,
    this.content,
    this.account,
    this.report,
    this.gift,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final at = DateTime.tryParse(json['createdAt'] as String? ?? '');
    return NotificationModel(
      id: json['id'] as String? ?? '',
      type: switch (json['kind'] as String?) {
        'comment' => NotificationType.comment,
        'follow' => NotificationType.follow,
        'repost' => NotificationType.repost,
        'account' => NotificationType.account,
        'report' => NotificationType.report,
        'gift' => NotificationType.gift,
        _ => NotificationType.like,
      },
      actor: json['actor'] is Map<String, dynamic>
          ? NotificationActor.fromJson(json['actor'] as Map<String, dynamic>)
          : null,
      account: json['account'] is Map<String, dynamic>
          ? AccountNoticeRow.fromJson(json['account'] as Map<String, dynamic>)
          : null,
      report: json['report'] is Map<String, dynamic>
          ? ReportOutcomeRow.fromJson(json['report'] as Map<String, dynamic>)
          : null,
      gift: json['gift'] is Map<String, dynamic>
          ? GiftNote.fromJson(json['gift'] as Map<String, dynamic>)
          : null,
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

  /// Kyron's, not a person's.
  bool get fromKyron =>
      type == NotificationType.account || type == NotificationType.report;
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
