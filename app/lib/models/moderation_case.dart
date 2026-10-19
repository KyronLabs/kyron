// lib/models/moderation_case.dart
import '../repositories/moderation_repository.dart';
import 'account_standing.dart';

DateTime? _date(Object? value) =>
    value is String ? DateTime.tryParse(value)?.toLocal() : null;

String? _text(Object? value) =>
    value is String && value.trim().isNotEmpty ? value : null;

/// An account as the team sees it beside a case.
class CaseAccount {
  final String id;
  final String? name;
  final String? username;
  final String? avatarUrl;
  final String role;
  final StandingStatus status;
  final DateTime? suspendedUntil;
  final DateTime? createdAt;

  /// Carries the verified badge.
  final bool verified;

  /// Decisions against it that still stand.
  final int standingActions;

  const CaseAccount({
    required this.id,
    this.name,
    this.username,
    this.avatarUrl,
    this.role = 'USER',
    this.status = StandingStatus.active,
    this.suspendedUntil,
    this.createdAt,
    this.verified = false,
    this.standingActions = 0,
  });

  String get handle => username == null ? 'an account' : '@$username';

  bool get onTeam => role != 'USER';

  factory CaseAccount.fromJson(Map<String, dynamic> json) => CaseAccount(
        id: json['id'] as String,
        name: _text(json['name']),
        username: _text(json['username']),
        avatarUrl: _text(json['avatarUrl']),
        role: json['role'] as String? ?? 'USER',
        status: StandingStatus.fromWire(json['status']),
        suspendedUntil: _date(json['suspendedUntil']),
        createdAt: _date(json['createdAt']),
        verified: json['verified'] == true,
        standingActions: (json['standingActions'] as num?)?.toInt() ?? 0,
      );
}

/// One report, of the several a reported thing can have.
class CaseReport {
  final String id;
  final ReportReason reason;
  final String? detail;
  final DateTime createdAt;
  final String? reporter;

  const CaseReport({
    required this.id,
    required this.reason,
    required this.createdAt,
    this.detail,
    this.reporter,
  });

  factory CaseReport.fromJson(Map<String, dynamic> json) {
    final reporter = json['reporter'];
    return CaseReport(
      id: json['id'] as String,
      reason: ReportReason.fromWire(json['reason']),
      detail: _text(json['detail']),
      createdAt: _date(json['createdAt']) ?? DateTime.now(),
      reporter: reporter is Map ? _text(reporter['username']) : null,
    );
  }
}

/// One reported thing, with everything said about it.
class ReportCase {
  final ReportTarget target;
  final String targetId;
  final CaseAccount? subject;

  /// What it says now. Null once it has been deleted.
  final String? content;

  /// What it said when first reported.
  final String? snapshot;

  /// The post a reply is on, to open it in place.
  final String? postId;
  final List<({ReportReason reason, int count})> reasons;
  final List<CaseReport> reports;
  final DateTime firstAt;
  final bool urgent;

  const ReportCase({
    required this.target,
    required this.targetId,
    required this.reasons,
    required this.reports,
    required this.firstAt,
    this.subject,
    this.content,
    this.snapshot,
    this.postId,
    this.urgent = false,
  });

  /// The reason most of its reports give: what a decision starts from.
  ReportReason get likelyRule =>
      reasons.isEmpty ? ReportReason.somethingElse : reasons.first.reason;

  bool get isContent => target != ReportTarget.user;

  factory ReportCase.fromJson(Map<String, dynamic> json) {
    final subject = json['subject'];
    return ReportCase(
      target: ReportTarget.fromWire(json['target']) ?? ReportTarget.post,
      targetId: json['targetId'] as String,
      subject: subject is Map<String, dynamic>
          ? CaseAccount.fromJson(subject)
          : null,
      content: _text(json['content']),
      snapshot: _text(json['snapshot']),
      postId: _text(json['postId']),
      reasons: [
        for (final row in (json['reasons'] as List<dynamic>? ?? const []))
          if (row is Map)
            (
              reason: ReportReason.fromWire(row['reason']),
              count: (row['count'] as num?)?.toInt() ?? 1,
            ),
      ],
      reports: [
        for (final row in (json['reports'] as List<dynamic>? ?? const []))
          if (row is Map<String, dynamic>) CaseReport.fromJson(row),
      ],
      firstAt: _date(json['firstAt']) ?? DateTime.now(),
      urgent: json['urgent'] as bool? ?? false,
    );
  }
}

/// A decision as the team sees it: the notice, plus what only they see.
class CaseAction {
  final ModerationNotice notice;

  /// For the team only.
  final String? note;

  /// Who decided. Null once their account is gone.
  final String? moderator;
  final String? moderatorId;
  final CaseAccount? subject;

  const CaseAction({
    required this.notice,
    this.note,
    this.moderator,
    this.moderatorId,
    this.subject,
  });

  factory CaseAction.fromJson(Map<String, dynamic> json) {
    final moderator = json['moderator'];
    final subject = json['subject'];
    return CaseAction(
      notice: ModerationNotice.fromJson(json),
      note: _text(json['note']),
      moderator: moderator is Map ? _text(moderator['username']) : null,
      moderatorId: moderator is Map ? _text(moderator['id']) : null,
      subject: subject is Map<String, dynamic>
          ? CaseAccount.fromJson(subject)
          : null,
    );
  }
}

/// An appeal waiting for somebody on the team.
class AppealCase {
  final String id;
  final String statement;
  final DateTime createdAt;
  final CaseAction action;

  /// Whoever is looking made the decision being appealed.
  final bool ownDecision;

  const AppealCase({
    required this.id,
    required this.statement,
    required this.createdAt,
    required this.action,
    this.ownDecision = false,
  });

  factory AppealCase.fromJson(Map<String, dynamic> json) => AppealCase(
        id: json['id'] as String,
        statement: json['statement'] as String? ?? '',
        createdAt: _date(json['createdAt']) ?? DateTime.now(),
        action: CaseAction.fromJson(json['action'] as Map<String, dynamic>),
        ownDecision: json['ownDecision'] as bool? ?? false,
      );
}

/// One account's record, for the team.
class AccountRecord {
  final CaseAccount account;
  final int openReports;
  final List<CaseAction> actions;

  const AccountRecord({
    required this.account,
    required this.openReports,
    required this.actions,
  });

  factory AccountRecord.fromJson(Map<String, dynamic> json) => AccountRecord(
        account: CaseAccount.fromJson(json['account'] as Map<String, dynamic>),
        openReports: (json['openReports'] as num?)?.toInt() ?? 0,
        actions: [
          for (final row in (json['actions'] as List<dynamic>? ?? const []))
            if (row is Map<String, dynamic>) CaseAction.fromJson(row),
        ],
      );
}
