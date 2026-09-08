// lib/services/did_keys.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// The account's own identifier, and the proof that it is the account's.
///
/// A `did:key` *is* a public key, written down. That is what makes it worth
/// having: the identifier carries everything needed to check a signature made
/// with it, so somebody can verify that this account controls this identifier
/// without asking Kyron -- or trusting Kyron -- at all.
///
/// The secret half is made on the device and never leaves it, exactly like the
/// message key in [MessageCrypto]. What the server stores is the identifier,
/// which is public by design.
///
/// Ed25519 rather than the X25519 used for messages: those are different jobs.
/// X25519 agrees on a shared secret, Ed25519 signs. The same key cannot safely
/// do both.
class DidKeys {
  const DidKeys();

  static final _algorithm = Ed25519();

  /// Multicodec for an Ed25519 public key: varint 0xed. The two bytes in front
  /// of the key are what tell a reader which kind of key it is, and a did:key
  /// without them is unreadable rather than merely unlabelled.
  static const _ed25519Multicodec = [0xed, 0x01];

  Future<SimpleKeyPair> newKeyPair() => _algorithm.newKeyPair();

  /// Signs [message] as this identity.
  Future<String> sign(SimpleKeyPair pair, String message) async {
    final signature = await _algorithm.sign(
      utf8.encode(message),
      keyPair: pair,
    );
    return base64Url.encode(signature.bytes).replaceAll('=', '');
  }

  /// The `did:key` for a public key.
  static Future<String> didFor(SimpleKeyPair pair) async {
    final key = await pair.extractPublicKey();
    return didForBytes(key.bytes);
  }

  static String didForBytes(List<int> publicKey) {
    if (publicKey.length != 32) {
      throw ArgumentError.value(
        publicKey.length,
        'publicKey',
        'an Ed25519 public key is 32 bytes',
      );
    }
    return 'did:key:z${encodeBase58([..._ed25519Multicodec, ...publicKey])}';
  }

  /// Stores the secret half as text.
  static Future<String> encodeSecret(SimpleKeyPair pair) async =>
      base64Url.encode(await pair.extractPrivateKeyBytes());

  /// And back. Null for anything that is not a seed of the right length, which
  /// is what a truncated or tampered value looks like.
  static Future<SimpleKeyPair?> tryDecodeSecret(String value) async {
    try {
      final bytes = base64Url.decode(value);
      if (bytes.length != 32) return null;
      return _algorithm.newKeyPairFromSeed(Uint8List.fromList(bytes));
    } catch (_) {
      return null;
    }
  }
}

const _alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

/// base58btc, as `did:key` spells its keys.
///
/// Written out rather than pulled in: it is twenty lines, and the identifier
/// it produces is the thing the server checks a signature against -- an
/// encoding bug here is an account that cannot prove who it is.
String encodeBase58(List<int> input) {
  final digits = <int>[0];
  for (final byte in input) {
    var carry = byte;
    for (var i = 0; i < digits.length; i++) {
      carry += digits[i] << 8;
      digits[i] = carry % 58;
      carry = carry ~/ 58;
    }
    while (carry > 0) {
      digits.add(carry % 58);
      carry = carry ~/ 58;
    }
  }

  // The accumulator starts at a single zero digit, and for an all-zero input
  // nothing ever displaces it -- so it would be written out as a '1' on top of
  // the leading '1's below, and encode(0) came back as "11". Dropped here: the
  // leading zeros are the whole representation of zero.
  while (digits.length > 1 && digits.last == 0) {
    digits.removeLast();
  }
  final significant = digits.length == 1 && digits.first == 0
      ? const <int>[]
      : digits.reversed.toList();

  // A leading zero byte is a leading '1' and cannot be written any other way.
  // Dropping them changes the key rather than failing.
  final leading = StringBuffer();
  for (var i = 0; i < input.length && input[i] == 0; i++) {
    leading.write('1');
  }

  return leading.toString() +
      significant.map((digit) => _alphabet[digit]).join();
}
