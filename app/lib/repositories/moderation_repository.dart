import '../models/profile_summary.dart';
import '../services/api_client.dart';

/// Why a post, comment or account is being reported.
///
/// The order is the order the sheet lists them, and the wire names match the
/// server's enum exactly -- a mismatch here is a 400 the reporter cannot act
/// on.
enum ReportReason {
  spam('SPAM', 'Spam', 'Repetitive, misleading, or unwanted promotion.'),
  harassment('HARASSMENT', 'Harassment or bullying',
      'Targeted abuse, threats, or unwanted contact.'),
  hate('HATE', 'Hate speech', 'Attacks on people for who they are.'),
  violence('VIOLENCE', 'Violence or threats',
      'Threatening, glorifying, or inciting harm.'),
  selfHarm('SELF_HARM', 'Suicide or self-harm',
      'Encouraging or depicting self-harm.'),
  sexualContent('SEXUAL_CONTENT', 'Adult content',
      'Sexual content shown without warning.'),
  childSafety('CHILD_SAFETY', 'Child safety',
      'Anything endangering or sexualising a minor.'),
  misinformation('MISINFORMATION', 'False information',
      'Misleading claims about health, elections, or events.'),
  impersonation(
      'IMPERSONATION', 'Impersonation', 'Pretending to be someone else.'),
  intellectualProperty('INTELLECTUAL_PROPERTY', 'Intellectual property',
      'Uses your work or trademark without permission.'),
  illegalGoods('ILLEGAL_GOODS', 'Illegal goods or services',
      'Selling or promoting something unlawful.'),
  somethingElse('SOMETHING_ELSE', 'Something else',
      'None of the above. Tell us what is wrong.');

  const ReportReason(this.wire, this.label, this.detail);

  final String wire;
  final String label;
  final String detail;

  /// Reports that need a written explanation to be actionable.
  bool get needsDetail => this == ReportReason.somethingElse;
}

enum ReportTarget {
  post('POST'),
  comment('COMMENT'),
  user('USER');

  const ReportTarget(this.wire);
  final String wire;
}

/// Blocking, muting, hiding and reporting.
class ModerationRepository {
  final ApiClient _api;

  ModerationRepository(this._api);

  Future<void> setBlocked(String userId, bool blocked) => blocked
      ? _api.dio.put<void>('/users/$userId/block')
      : _api.dio.delete<void>('/users/$userId/block');

  Future<void> setUserMuted(String userId, bool muted) => muted
      ? _api.dio.put<void>('/users/$userId/mute')
      : _api.dio.delete<void>('/users/$userId/mute');

  Future<void> setThreadMuted(String postId, bool muted) => muted
      ? _api.dio.put<void>('/feed/posts/$postId/mute')
      : _api.dio.delete<void>('/feed/posts/$postId/mute');

  Future<void> setHidden(String postId, bool hidden) => hidden
      ? _api.dio.put<void>('/feed/posts/$postId/hide')
      : _api.dio.delete<void>('/feed/posts/$postId/hide');

  /// "Show more of this" / "show less of this".
  Future<void> setInterest(String postId, {required bool more}) =>
      _api.dio.put<void>(
        '/feed/posts/$postId/interest',
        data: {'kind': more ? 'MORE' : 'LESS'},
      );

  Future<List<String>> mutedWords() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/mutes/words');
    return ((res.data?['items'] as List<dynamic>?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((row) => row['phrase'] as String? ?? '')
        .where((phrase) => phrase.isNotEmpty)
        .toList();
  }

  Future<void> muteWord(String phrase) =>
      _api.dio.post<void>('/mutes/words', data: {'phrase': phrase});

  // A query parameter, not a path segment: a muted phrase can contain slashes,
  // spaces and '#', none of which survive a path intact.
  Future<void> unmuteWord(String phrase) => _api.dio.delete<void>(
        '/mutes/words',
        queryParameters: {'phrase': phrase},
      );

  Future<List<ProfileSummary>> mutedUsers() => _people('/mutes/users');

  Future<List<ProfileSummary>> blockedUsers() => _people('/blocks');

  Future<List<ProfileSummary>> _people(String path) async {
    final res = await _api.dio.get<Map<String, dynamic>>(path);
    return ((res.data?['items'] as List<dynamic>?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(ProfileSummary.fromJson)
        .toList();
  }

  Future<void> report({
    required ReportTarget target,
    required String targetId,
    required ReportReason reason,
    String? detail,
  }) =>
      _api.dio.post<void>('/reports', data: {
        'target': target.wire,
        'targetId': targetId,
        'reason': reason.wire,
        if (detail != null && detail.trim().isNotEmpty) 'detail': detail.trim(),
      });
}
