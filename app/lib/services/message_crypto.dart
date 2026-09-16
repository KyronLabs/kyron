// lib/services/message_crypto.dart
//
// End-to-end encryption for one-to-one messages.
//
// The shape is deliberately the simplest one that is actually end to end:
//
//   * every install makes an X25519 keypair and keeps the secret half on the
//     device, in the same secure storage the session token lives in;
//   * the public half goes to the server, which hands it to whoever wants to
//     write to you;
//   * a message is sealed with XChaCha20-Poly1305 under a key derived from
//     your secret and their public half, so the server carries ciphertext it
//     has no key for.
//
// What this is not: it is one key per install, so a second device cannot read
// what the first received, and losing the device loses the history. There is
// no forward secrecy -- a compromised device key opens every message it ever
// received. Both are real limits and both are written down in docs/E2EE.md
// rather than implied away.
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// A sealed message, in the shape the wire carries it.
class SealedMessage {
  /// The number used once, fresh for every message.
  final List<int> nonce;

  /// The ciphertext.
  final List<int> body;

  /// What proves nobody altered it.
  final List<int> mac;

  const SealedMessage({
    required this.nonce,
    required this.body,
    required this.mac,
  });

  /// One string, so a sealed message fits the column a plain one used.
  ///
  /// Prefixed with a version, because a scheme that cannot be changed is one
  /// that has to be right first time.
  String encode() => [
        'k1',
        base64Url.encode(nonce),
        base64Url.encode(body),
        base64Url.encode(mac),
      ].join('.');

  /// Reads one back, or null if this is not a sealed message at all -- which
  /// is what every message written before this existed looks like.
  static SealedMessage? tryDecode(String value) {
    final parts = value.split('.');
    if (parts.length != 4 || parts.first != 'k1') return null;
    try {
      return SealedMessage(
        nonce: base64Url.decode(parts[1]),
        body: base64Url.decode(parts[2]),
        mac: base64Url.decode(parts[3]),
      );
    } catch (_) {
      return null;
    }
  }
}

/// Sealing and opening, and the keys both need.
class MessageCrypto {
  MessageCrypto({Xchacha20? cipher, X25519? exchange})
      : _cipher = cipher ?? Xchacha20.poly1305Aead(),
        _exchange = exchange ?? X25519();

  final Xchacha20 _cipher;
  final X25519 _exchange;

  /// A new identity for this install.
  Future<SimpleKeyPair> newKeyPair() => _exchange.newKeyPair();

  /// The key two people share, from your secret half and their public one.
  ///
  /// Run through HKDF rather than used raw: the raw X25519 output is not
  /// uniformly distributed, and feeding it straight to a cipher is the
  /// classic way to weaken an otherwise sound exchange.
  Future<SecretKey> sharedSecret({
    required SimpleKeyPair mine,
    required SimplePublicKey theirs,
  }) async {
    final shared = await _exchange.sharedSecretKey(
      keyPair: mine,
      remotePublicKey: theirs,
    );

    final hkdf = Hkdf(hmac: Hmac.sha256(), outputLength: 32);
    return hkdf.deriveKey(
      secretKey: shared,
      // Fixed and public. A salt's job here is domain separation, not secrecy:
      // it keeps a key derived for messages from colliding with one derived
      // from the same exchange for anything else.
      nonce: utf8.encode('kyron/dm/v1'),
    );
  }

  /// Seals one message.
  Future<SealedMessage> seal(String plain, SecretKey key) async {
    final box = await _cipher.encrypt(
      utf8.encode(plain),
      secretKey: key,
      // Left to the library, which draws it from a secure source. A nonce
      // reused under the same key is what breaks this cipher outright.
      nonce: _cipher.newNonce(),
    );
    return SealedMessage(
      nonce: box.nonce,
      body: box.cipherText,
      mac: box.mac.bytes,
    );
  }

  /// Opens one, or throws if it was altered or is not for this key.
  Future<String> open(SealedMessage sealed, SecretKey key) async {
    final plain = await _cipher.decrypt(
      SecretBox(sealed.body, nonce: sealed.nonce, mac: Mac(sealed.mac)),
      secretKey: key,
    );
    return utf8.decode(plain);
  }

  /// A public key as it travels: raw bytes, base64url.
  static String encodePublicKey(SimplePublicKey key) =>
      base64Url.encode(key.bytes);

  /// And back. Null for anything that is not a key of the right length,
  /// which is what a truncated or tampered value looks like.
  static SimplePublicKey? tryDecodePublicKey(String value) {
    try {
      final bytes = base64Url.decode(value);
      if (bytes.length != 32) return null;
      return SimplePublicKey(bytes, type: KeyPairType.x25519);
    } catch (_) {
      return null;
    }
  }

  /// A secret key as it is stored on the device.
  static Future<String> encodeSecret(SimpleKeyPair pair) async =>
      base64Url.encode(await pair.extractPrivateKeyBytes());

  static Future<SimpleKeyPair?> tryDecodeSecret(String value) async {
    try {
      final bytes = base64Url.decode(value);
      if (bytes.length != 32) return null;
      return X25519().newKeyPairFromSeed(Uint8List.fromList(bytes));
    } catch (_) {
      return null;
    }
  }
}
