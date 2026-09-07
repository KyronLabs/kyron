// lib/repositories/keys_repository.dart
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
  Future<void> withdraw(String deviceId) => _api.dio.delete<void>(
        '/keys',
        queryParameters: {'deviceId': deviceId},
      );

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
}
