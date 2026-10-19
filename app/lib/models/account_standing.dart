// lib/models/account_standing.dart
import '../repositories/moderation_repository.dart';

/// What a decision did to an account.
enum ModerationKind {
  remove('REMOVE'),
  warn('WARN'),
  suspend('SUSPEND'),
  ban('BAN');

  const ModerationKind(this.wire);
  final String wire;

  static ModerationKind fromWire(Object? wire) => values.firstWhere(
        (kind) => kind.wire == wire,
        // Something a newer server does that this build has no word for is
        // shown as the mildest thing it could be, never as a ban.
        orElse: () => ModerationKind.warn,
      );
}

enum AppealStatus {
  open('OPEN'),
  upheld('UPHELD'),
  overturned('OVERTURNED');

  const AppealStatus(this.wire);
  final String wire;

  static AppealStatus fromWire(Object? wire) => values.firstWhere(
        (status) => status.wire == wire,
        orElse: () => AppealStatus.open,
      );
}

/// Where an account stands: as it is, suspended until a time, or banned.
enum StandingStatus {
  active,
  suspended,
  banned;

  static StandingStatus fromWire(Object? wire) => switch (wire) {
        'SUSPENDED' => StandingStatus.suspended,
        'BANNED' => StandingStatus.banned,
        _ => StandingStatus.active,
      };
}

DateTime? _date(Object? value) =>
    value is String ? DateTime.tryParse(value)?.toLocal() : null;

String? _text(Object? value) =>
    value is String && value.trim().isNotEmpty ? value : null;

/// An appeal, as the account that made it sees it.
class AppealView {
  final AppealStatus status;
  final String statement;
  final String? response;
  final DateTime createdAt;
  final DateTime? decidedAt;

  const AppealView({
    required this.status,
    required this.statement,
    required this.createdAt,
    this.response,
    this.decidedAt,
  });

  factory AppealView.fromJson(Map<String, dynamic> json) => AppealView(
        status: AppealStatus.fromWire(json['status']),
        statement: json['statement'] as String? ?? '',
        response: _text(json['response']),
        createdAt: _date(json['createdAt']) ?? DateTime.now(),
        decidedAt: _date(json['decidedAt']),
      );
}

/// One decision the team made about an account, as that account sees it.
class ModerationNotice {
  final String id;
  final int number;
  final ModerationKind kind;
  final ReportReason rule;

  /// What the team said, in their own words.
  final String message;
  final ReportTarget? target;
  final String? targetId;

  /// What the post or reply said when the decision was made.
  final String? snapshot;
  final DateTime? endsAt;
  final DateTime createdAt;
  final bool seen;
  final DateTime? reversedAt;
  final String? reversal;
  final AppealView? appeal;

  /// Until when it can be appealed. Null once it cannot.
  final DateTime? appealBy;

  const ModerationNotice({
    required this.id,
    required this.number,
    required this.kind,
    required this.rule,
    required this.message,
    required this.createdAt,
    this.target,
    this.targetId,
    this.snapshot,
    this.endsAt,
    this.seen = true,
    this.reversedAt,
    this.reversal,
    this.appeal,
    this.appealBy,
  });

  bool get reversed => reversedAt != null;

  /// Whether this decision is still restricting the account.
  bool get inForce {
    if (reversed) return false;
    return switch (kind) {
      ModerationKind.ban => true,
      ModerationKind.suspend => endsAt?.isAfter(DateTime.now()) ?? false,
      _ => false,
    };
  }

  factory ModerationNotice.fromJson(Map<String, dynamic> json) {
    final appeal = json['appeal'];
    return ModerationNotice(
      id: json['id'] as String,
      number: (json['number'] as num?)?.toInt() ?? 0,
      kind: ModerationKind.fromWire(json['kind']),
      rule: ReportReason.fromWire(json['rule']),
      message: json['message'] as String? ?? '',
      target: ReportTarget.fromWire(json['target']),
      targetId: _text(json['targetId']),
      snapshot: _text(json['snapshot']),
      endsAt: _date(json['endsAt']),
      createdAt: _date(json['createdAt']) ?? DateTime.now(),
      seen: json['seen'] as bool? ?? true,
      reversedAt: _date(json['reversedAt']),
      reversal: _text(json['reversal']),
      appeal:
          appeal is Map<String, dynamic> ? AppealView.fromJson(appeal) : null,
      appealBy: _date(json['appealBy']),
    );
  }
}

enum ReportOutcome { pending, actioned, dismissed }

/// Something this account reported, and what came of it.
class ReportUpdate {
  final String id;
  final ReportTarget? target;
  final ReportReason reason;

  /// What was reported, in words, when the server kept a copy.
  final String? about;
  final DateTime createdAt;
  final ReportOutcome outcome;
  final DateTime? resolvedAt;

  const ReportUpdate({
    required this.id,
    required this.reason,
    required this.createdAt,
    required this.outcome,
    this.target,
    this.about,
    this.resolvedAt,
  });

  factory ReportUpdate.fromJson(Map<String, dynamic> json) => ReportUpdate(
        id: json['id'] as String,
        target: ReportTarget.fromWire(json['target']),
        reason: ReportReason.fromWire(json['reason']),
        about: _text(json['about']),
        createdAt: _date(json['createdAt']) ?? DateTime.now(),
        outcome: switch (json['outcome']) {
          'ACTIONED' => ReportOutcome.actioned,
          'DISMISSED' => ReportOutcome.dismissed,
          _ => ReportOutcome.pending,
        },
        resolvedAt: _date(json['resolvedAt']),
      );
}

/// Everything decided about this account, and what came of its reports.
class AccountStanding {
  final StandingStatus status;

  /// When a suspension ends.
  final DateTime? until;
  final int appealDays;
  final List<ModerationNotice> notices;
  final List<ReportUpdate> reports;

  /// Decisions, and answers to appeals, not looked at yet.
  final int unseen;

  const AccountStanding({
    required this.status,
    this.until,
    this.appealDays = 180,
    this.notices = const [],
    this.reports = const [],
    this.unseen = 0,
  });

  factory AccountStanding.fromJson(Map<String, dynamic> json) =>
      AccountStanding(
        status: StandingStatus.fromWire(json['status']),
        until: _date(json['until']),
        appealDays: (json['appealDays'] as num?)?.toInt() ?? 180,
        notices: [
          for (final row in (json['actions'] as List<dynamic>? ?? const []))
            if (row is Map<String, dynamic>) ModerationNotice.fromJson(row),
        ],
        reports: [
          for (final row in (json['reports'] as List<dynamic>? ?? const []))
            if (row is Map<String, dynamic>) ReportUpdate.fromJson(row),
        ],
        unseen: (json['unseen'] as num?)?.toInt() ?? 0,
      );

  /// The decision behind a ban or suspension in force, the latest first.
  ModerationNotice? get restrictedBy {
    for (final notice in notices) {
      if (notice.inForce) return notice;
    }
    return null;
  }
}

/// The refusal the API sends when a restricted account tries something it
/// may not: what restricts it, and until when.
class AccountRestriction {
  final StandingStatus status;
  final DateTime? until;
  final String message;

  const AccountRestriction({
    required this.status,
    required this.message,
    this.until,
  });

  bool get banned => status == StandingStatus.banned;

  /// The restriction in a 403 body, or null if the body is something else.
  static AccountRestriction? fromResponse(Object? data) {
    if (data is! Map || data['code'] != 'ACCOUNT_RESTRICTED') return null;
    final message = data['message'];
    return AccountRestriction(
      status: StandingStatus.fromWire(data['status']),
      until: _date(data['until']),
      message: message is String ? message : '',
    );
  }
}
