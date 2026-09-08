// lib/repositories/identity_repository.dart
import '../services/api_client.dart';

/// The account's portable identifier.
class IdentityRepository {
  final ApiClient _api;

  IdentityRepository(this._api);

  /// The identifier this account has claimed, or null if it has none.
  Future<String?> mine() async {
    final res = await _api.dio.get<Map<String, dynamic>>('/identity/did');
    return res.data?['did'] as String?;
  }

  /// The exact string to sign. Good for five minutes, spent by one attempt.
  ///
  /// The server assembles it rather than the app: the format is one thing in
  /// two languages, and a client rebuilding it with a character out of place
  /// would produce a signature that verifies against nothing, on every device,
  /// with nothing saying why.
  Future<String> challenge() async {
    final res =
        await _api.dio.get<Map<String, dynamic>>('/identity/did/challenge');
    final message = res.data?['message'] as String?;
    if (message == null || message.isEmpty) {
      throw StateError('The server did not answer with a challenge.');
    }
    return message;
  }

  /// Claims [did], proving it with a signature over the challenge.
  Future<void> claim({required String did, required String signature}) =>
      _api.dio.put<void>(
        '/identity/did',
        data: {'did': did, 'signature': signature},
      );
}
