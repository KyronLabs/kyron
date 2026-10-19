// lib/repositories/enforcement_repository.dart
import '../models/account_standing.dart';
import '../models/moderation_case.dart';
import '../services/api_client.dart';
import 'moderation_repository.dart';

/// Enforcement: an account's own standing and appeals, and -- for the team --
/// the queues and the decisions.
///
/// The team's calls answer 404 to anybody else, so the app offers them only
/// to an account /profile/me says is on the team; the server decides anyway.
class EnforcementRepository {
  EnforcementRepository(this._api);
  final ApiClient _api;

  // ---- The account's own ----------------------------------------------------

  Future<AccountStanding> standing() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/moderation/standing');
    return AccountStanding.fromJson(res.data ?? const {});
  }

  Future<void> markSeen() => _api.dio.put<void>('/moderation/standing/seen');

  Future<ModerationNotice> appeal(String actionId, String statement) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/moderation/actions/$actionId/appeal',
      data: {'statement': statement},
    );
    return ModerationNotice.fromJson(res.data ?? const {});
  }

  // ---- The team's -------------------------------------------------------------

  Future<List<ReportCase>> reportQueue() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/moderation/reports');
    return [
      for (final row in (res.data?['items'] as List<dynamic>? ?? const []))
        if (row is Map<String, dynamic>) ReportCase.fromJson(row),
    ];
  }

  Future<List<AppealCase>> appealQueue() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/moderation/appeals');
    return [
      for (final row in (res.data?['items'] as List<dynamic>? ?? const []))
        if (row is Map<String, dynamic>) AppealCase.fromJson(row),
    ];
  }

  Future<AccountRecord> account(String id) async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/moderation/accounts/$id');
    return AccountRecord.fromJson(res.data ?? const {});
  }

  Future<void> dismiss(ReportTarget target, String targetId) =>
      _api.dio.post<void>(
        '/moderation/reports/dismiss',
        data: {'target': target.wire, 'targetId': targetId},
      );

  Future<CaseAction> act({
    required ModerationKind kind,
    required ReportReason rule,
    required String message,
    String? subjectId,
    String? note,
    ReportTarget? target,
    String? targetId,
    bool removeContent = true,
    int? days,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/moderation/actions',
      data: {
        'kind': kind.wire,
        'rule': rule.wire,
        'message': message,
        if (subjectId != null) 'subjectId': subjectId,
        if (note != null && note.trim().isNotEmpty) 'note': note,
        if (target != null && target != ReportTarget.user) ...{
          'target': target.wire,
          'targetId': targetId,
          'removeContent': removeContent,
        },
        if (kind == ModerationKind.suspend) 'days': days,
      },
    );
    return CaseAction.fromJson(res.data ?? const {});
  }

  Future<void> reverse(String actionId, String reason) => _api.dio.post<void>(
        '/moderation/actions/$actionId/reverse',
        data: {'reason': reason},
      );

  Future<void> decide(
    String appealId, {
    required bool overturn,
    required String response,
  }) =>
      _api.dio.post<void>(
        '/moderation/appeals/$appealId/decide',
        data: {'overturn': overturn, 'response': response},
      );
}
