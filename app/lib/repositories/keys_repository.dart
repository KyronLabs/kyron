// lib/repositories/keys_repository.dart
import '../models/key_share.dart';
import '../services/api_client.dart';

/// One install's published public half.
class PublishedKey {
  final String userId;
  final String deviceId;
  final String publicKey;

  const PublishedKey({
    required this.userId,
    required this.deviceId,
    required this.publicKey,
  });

  factory PublishedKey.fromJson(Map<String, dynamic> json) => PublishedKey(
        userId: json['userId'] as String? ?? '',
        deviceId: json['deviceId'] as String? ?? '',
        publicKey: json['publicKey'] as String? ?? '',
      );
}

/// The public halves people need to write to each other in private.
class KeysRepository {
  final ApiClient _api;

  KeysRepository(this._api);

  /// Publishes this install's key, or replaces it.
  Future<void> publish(String publicKey, String deviceId) => _api.dio.put<void>(
        '/keys',
        data: {'publicKey': publicKey, 'deviceId': deviceId},
      );

  /// Withdraws it, on sign-out.
  Future<void> withdraw(String deviceId) =>
      _api.dio.delete<void>('/keys', queryParameters: {'deviceId': deviceId});

  /// Everybody's keys in one conversation.
  Future<List<PublishedKey>> forConversation(String conversationId) async {
    final res = await _api.dio.get<List<dynamic>>(
      '/keys/conversation/$conversationId',
    );
    return (res.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(PublishedKey.fromJson)
        .toList();
  }

  /// Asks, for this device, for the keys of messages it was not sealed for.
  Future<void> requestShares(
    String conversationId,
    String deviceId,
    List<String> messageIds,
  ) =>
      _api.dio.post<void>(
        '/messages/$conversationId/keys/requests',
        data: {'deviceId': deviceId, 'messageIds': messageIds},
      );

  /// Requests that this account's devices may be able to answer.
  Future<List<KeyRequest>> pendingRequests() async {
    final res = await _api.dio.get<List<dynamic>>('/messages/keys/requests');
    return [
      for (final item
          in (res.data ?? const []).whereType<Map<String, dynamic>>())
        if (KeyRequest.tryFrom(item) case final request?) request,
    ];
  }

  /// Answers them.
  Future<void> shareKeys(List<({String id, String sealed})> shares) =>
      _api.dio.post<void>(
        '/messages/keys/shares',
        data: {
          'shares': [
            for (final s in shares) {'id': s.id, 'sealed': s.sealed},
          ],
        },
      );
}
