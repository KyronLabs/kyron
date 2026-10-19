// lib/repositories/verification_repository.dart
import '../models/verification.dart';
import '../services/api_client.dart';

/// The verified badge: asking for it, and -- for the team -- answering.
class VerificationRepository {
  VerificationRepository(this._api);
  final ApiClient _api;

  Future<VerificationState> status() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/verification');
    return VerificationState.fromJson(res.data ?? const {});
  }

  Future<VerificationRequestView> apply({
    required VerificationCategory category,
    required String about,
    required List<String> links,
  }) async {
    final res = await _api.dio.post<Map<String, dynamic>>(
      '/verification',
      data: {'category': category.wire, 'about': about, 'links': links},
    );
    return VerificationRequestView.fromJson(res.data ?? const {});
  }

  Future<void> withdraw() => _api.dio.delete<void>('/verification');

  // ---- The team's -------------------------------------------------------------

  Future<List<VerificationCase>> queue() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/moderation/verifications');
    return [
      for (final row in (res.data?['items'] as List<dynamic>? ?? const []))
        if (row is Map<String, dynamic>) VerificationCase.fromJson(row),
    ];
  }

  Future<void> decide(
    String requestId, {
    required bool approve,
    String? response,
  }) =>
      _api.dio.post<void>(
        '/moderation/verifications/$requestId/decide',
        data: {
          'approve': approve,
          if (response != null && response.trim().isNotEmpty)
            'response': response,
        },
      );

  Future<void> setVerified(
    String accountId, {
    required bool verified,
    required String reason,
  }) =>
      _api.dio.put<void>(
        '/moderation/accounts/$accountId/verified',
        data: {'verified': verified, 'reason': reason},
      );
}
