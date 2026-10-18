// lib/models/key_share.dart

/// A message's key, sealed again for one of the reader's devices that it was
/// not sealed for when it was sent -- by a device that was. See
/// `MessageVault.answerPending` and docs/E2EE.md.
class KeyShare {
  /// The device it is for, by its public key.
  final String publicKey;

  /// `<answering key>.<nonce>.<sealed key>.<mac>`, base64url.
  final String sealed;

  const KeyShare({required this.publicKey, required this.sealed});

  /// Whatever the server sent, skipping anything malformed.
  static List<KeyShare> listFrom(Object? json) => [
        if (json is List)
          for (final item in json.whereType<Map<String, dynamic>>())
            if (item['publicKey'] is String && item['sealed'] is String)
              KeyShare(
                publicKey: item['publicKey'] as String,
                sealed: item['sealed'] as String,
              ),
      ];
}

/// A device asking for the key of a message it was not sealed for, which this
/// device may be able to answer.
class KeyRequest {
  final String id;
  final String conversationId;
  final String messageId;

  /// The sealed message, opened here to reach its key.
  final String body;

  /// Its sealed link card, whose key travels in the same answer.
  final String? linkCard;

  /// The asking device's public key: what the answer is sealed for.
  final String publicKey;

  const KeyRequest({
    required this.id,
    required this.conversationId,
    required this.messageId,
    required this.body,
    required this.publicKey,
    this.linkCard,
  });

  static KeyRequest? tryFrom(Map<String, dynamic> json) {
    final id = json['id'], body = json['body'], key = json['publicKey'];
    if (id is! String || body is! String || key is! String) return null;
    return KeyRequest(
      id: id,
      conversationId: json['conversationId'] as String? ?? '',
      messageId: json['messageId'] as String? ?? '',
      body: body,
      linkCard: json['linkCard'] as String?,
      publicKey: key,
    );
  }
}
