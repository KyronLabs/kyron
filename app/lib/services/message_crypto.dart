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
// A message is sealed once, under a key made for it alone, and that key is
// then sealed again for every device in the conversation -- the other
// person's, and the sender's own -- so each can open it and nobody else can.
// That is the `k2` envelope below. The first version, `k1`, sealed a message
// under one pairwise key, and which key was chosen depended on the order the
// server listed them in; too often it was the sender's own, and the person
// the message was for could never read it. `k1` is still opened, never
// written.
//
// What this is not: losing the device loses the history, and there is no
// forward secrecy -- a compromised device key opens every message it ever
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

/// A message sealed once, with the key that opens it sealed again for every
/// device that may read it.
///
/// On the wire: `k2.<sender>.<nonce>.<body>.<mac>.<keys>`, where `<keys>` is
/// one `<device id>:<nonce>:<body>:<mac>` per device, joined by `~`. Every
/// part is base64url, whose alphabet has none of `.`, `:` or `~`, so the
/// separators cannot occur inside a part.
class SealedEnvelope {
  /// The sender's public key: what each device derives its unwrapping key
  /// from, together with its own secret half.
  final String sender;

  /// The message, under a key made for it alone.
  final SealedMessage content;

  /// That key, sealed for each device, by device id ([MessageCrypto.keyId]).
  final Map<String, SealedMessage> keys;

  const SealedEnvelope({
    required this.sender,
    required this.content,
    required this.keys,
  });

  String encode() => [
        'k2',
        sender,
        base64Url.encode(content.nonce),
        base64Url.encode(content.body),
        base64Url.encode(content.mac),
        [
          for (final entry in keys.entries)
            [
              entry.key,
              base64Url.encode(entry.value.nonce),
              base64Url.encode(entry.value.body),
              base64Url.encode(entry.value.mac),
            ].join(':'),
        ].join('~'),
      ].join('.');

  static SealedEnvelope? tryDecode(String value) {
    final parts = value.split('.');
    if (parts.length != 6 || parts.first != 'k2') return null;
    try {
      final keys = <String, SealedMessage>{};
      for (final entry in parts[5].split('~')) {
        final bits = entry.split(':');
        if (bits.length != 4) return null;
        keys[bits[0]] = SealedMessage(
          nonce: base64Url.decode(bits[1]),
          body: base64Url.decode(bits[2]),
          mac: base64Url.decode(bits[3]),
        );
      }
      return SealedEnvelope(
        sender: parts[1],
        content: SealedMessage(
          nonce: base64Url.decode(parts[2]),
          body: base64Url.decode(parts[3]),
          mac: base64Url.decode(parts[4]),
        ),
        keys: keys,
      );
    } catch (_) {
      return null;
    }
  }

  /// Whether [value] is sealed in any version this app can read -- which is
  /// also what decides whether to show it or to try opening it.
  static bool looksSealed(String value) =>
      tryDecode(value) != null || SealedMessage.tryDecode(value) != null;
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
    String purpose = 'kyron/dm/v1',
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
      // from the same exchange for anything else -- which is exactly what
      // [_wrapPurpose] relies on.
      nonce: utf8.encode(purpose),
    );
  }

  /// What a device's unwrapping key is derived for. Different from the `k1`
  /// message key, so the same pair of keys never yields the same secret for
  /// two jobs.
  static const _wrapPurpose = 'kyron/dm/v2/wrap';

  /// A short, stable name for a device's public key, so an envelope can say
  /// which sealed key is whose without carrying every key whole. Eight bytes
  /// of its SHA-256.
  static Future<String> keyId(SimplePublicKey key) async {
    final hash = await Sha256().hash(key.bytes);
    return base64Url.encode(hash.bytes.sublist(0, 8));
  }

  /// Seals [plain] so that every device in [devices] can open it.
  ///
  /// The sender's own device belongs in [devices] too, or the sender cannot
  /// read their own message after a restart. [unwrapKeys] caches the derived
  /// per-device keys across messages: deriving one is an X25519 exchange, and
  /// a chat seals for the same few devices every time.
  Future<SealedEnvelope> sealForDevices(
    String plain, {
    required SimpleKeyPair mine,
    required Iterable<SimplePublicKey> devices,
    Map<String, SecretKey>? unwrapKeys,
  }) async {
    final contentKey = await _cipher.newSecretKey();
    final content = await _sealBytes(utf8.encode(plain), contentKey);
    final keyBytes = await contentKey.extractBytes();

    final keys = <String, SealedMessage>{};
    for (final device in devices) {
      final id = await keyId(device);
      if (keys.containsKey(id)) continue;
      final unwrap = unwrapKeys?[id] ??
          await sharedSecret(mine: mine, theirs: device, purpose: _wrapPurpose);
      unwrapKeys?[id] = unwrap;
      keys[id] = await _sealBytes(keyBytes, unwrap);
    }

    return SealedEnvelope(
      sender: encodePublicKey(await mine.extractPublicKey()),
      content: content,
      keys: keys,
    );
  }

  /// Opens an envelope with this device's key, or answers null: when it was
  /// not sealed for this device, or was altered on the way.
  ///
  /// Needs nothing from the network. The envelope carries the sender's
  /// public key, and this device's secret half is all the rest -- which is
  /// what lets a conversation list show the last message without fetching
  /// anybody's keys.
  Future<String?> openEnvelope(
    SealedEnvelope envelope, {
    required SimpleKeyPair mine,
  }) async {
    final wrapped = envelope.keys[await keyId(await mine.extractPublicKey())];
    final sender = tryDecodePublicKey(envelope.sender);
    if (wrapped == null || sender == null) return null;
    try {
      final unwrap = await sharedSecret(
        mine: mine,
        theirs: sender,
        purpose: _wrapPurpose,
      );
      final contentKey = SecretKey(await _openBytes(wrapped, unwrap));
      return utf8.decode(await _openBytes(envelope.content, contentKey));
    } catch (_) {
      return null;
    }
  }

  Future<SealedMessage> _sealBytes(List<int> bytes, SecretKey key) async {
    final box = await _cipher.encrypt(
      bytes,
      secretKey: key,
      nonce: _cipher.newNonce(),
    );
    return SealedMessage(
      nonce: box.nonce,
      body: box.cipherText,
      mac: box.mac.bytes,
    );
  }

  Future<List<int>> _openBytes(SealedMessage sealed, SecretKey key) =>
      _cipher.decrypt(
        SecretBox(sealed.body, nonce: sealed.nonce, mac: Mac(sealed.mac)),
        secretKey: key,
      );

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
