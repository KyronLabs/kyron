// lib/services/message_vault.dart
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/keys_repository.dart';
import 'app_log.dart';
import 'message_crypto.dart';

/// This install's identity for private messages, and the keys it has fetched.
///
/// The secret half is generated on the device and written to the same secure
/// storage the session token lives in. It is never sent anywhere: what the
/// server holds is the public half, and what it stores in the Message table is
/// ciphertext it has no key for.
class MessageVault {
  final KeysRepository _keys;
  final FlutterSecureStorage _storage;
  final MessageCrypto _crypto;

  MessageVault(
    this._keys, {
    FlutterSecureStorage storage = const FlutterSecureStorage(),
    MessageCrypto? crypto,
  })  : _storage = storage,
        _crypto = crypto ?? MessageCrypto();

  static const _secretKeyName = 'dm_secret_key_v1';
  static const _deviceIdName = 'dm_device_id_v1';

  SimpleKeyPair? _mine;

  /// Shared secrets already worked out, by conversation. Derivation is not
  /// free and a chat asks for the same one on every message it draws.
  final _sharedByConversation = <String, List<SecretKey>>{};

  /// Whether this install has an identity yet.
  bool get isReady => _mine != null;

  /// Loads the keypair, making one the first time.
  ///
  /// Called after sign-in. The public half is published every time rather than
  /// only when new: a server that lost it, or an account restored to a new
  /// install, otherwise leaves this device unwritable-to with nothing saying
  /// why.
  Future<void> unlock() async {
    final stored = await _storage.read(key: _secretKeyName);
    var pair =
        stored == null ? null : await MessageCrypto.tryDecodeSecret(stored);

    if (pair == null) {
      pair = await _crypto.newKeyPair();
      await _storage.write(
        key: _secretKeyName,
        value: await MessageCrypto.encodeSecret(pair),
      );
    }
    _mine = pair;

    try {
      await _keys.publish(
        MessageCrypto.encodePublicKey(await pair.extractPublicKey()),
        await _deviceId(),
      );
    } catch (error) {
      // Not fatal: messages still send in the clear-to-the-server form the app
      // used before this existed, and the next launch tries again. Logged
      // because a run of these means nobody can write to this device.
      AppLog.instance.error('e2ee', 'Could not publish the key: $error');
    }
  }

  /// Forgets everything, on sign-out.
  ///
  /// The secret goes with the session. Anything sealed to it becomes
  /// unreadable, which is the trade this design makes and is written down in
  /// docs/E2EE.md.
  Future<void> lock() async {
    final deviceId = await _storage.read(key: _deviceIdName);
    _mine = null;
    _sharedByConversation.clear();
    await _storage.delete(key: _secretKeyName);
    if (deviceId != null) {
      try {
        await _keys.withdraw(deviceId);
      } catch (_) {
        // The row is stale rather than dangerous: it is a public key with no
        // secret anywhere, so nothing sealed to it can be opened by anyone.
      }
    }
  }

  /// The keys of everybody else in a conversation, cached.
  ///
  /// A list because one person can have several installs, and a message has to
  /// be sealed for each or it arrives on one device and not the other.
  Future<List<SecretKey>> secretsFor(String conversationId) async {
    final cached = _sharedByConversation[conversationId];
    if (cached != null) return cached;

    final mine = _mine;
    if (mine == null) return const [];

    try {
      final published = await _keys.forConversation(conversationId);
      final secrets = <SecretKey>[];
      for (final key in published) {
        final theirs = MessageCrypto.tryDecodePublicKey(key.publicKey);
        if (theirs == null) continue;
        secrets.add(await _crypto.sharedSecret(mine: mine, theirs: theirs));
      }
      _sharedByConversation[conversationId] = secrets;
      return secrets;
    } catch (error) {
      AppLog.instance.error('e2ee', 'Could not fetch keys: $error');
      return const [];
    }
  }

  /// Forgets what was derived for one conversation, so a new device in it is
  /// picked up rather than being written past.
  void forget(String conversationId) =>
      _sharedByConversation.remove(conversationId);

  /// Seals a message for a conversation, or answers null when it cannot.
  ///
  /// Null rather than throwing, and never a fallback that silently sends in
  /// the clear: the caller decides, and the reader is told which they got.
  Future<String?> seal(String plain, String conversationId) async {
    final secrets = await secretsFor(conversationId);
    if (secrets.isEmpty) return null;

    // Sealed under the first key. Sealing separately for every device is the
    // next step and needs the wire to carry more than one ciphertext -- see
    // docs/E2EE.md.
    final sealed = await _crypto.seal(plain, secrets.first);
    return sealed.encode();
  }

  /// Opens one, or answers null if this was never sealed or cannot be opened.
  Future<String?> open(String body, String conversationId) async {
    final sealed = SealedMessage.tryDecode(body);
    if (sealed == null) return null;

    for (final secret in await secretsFor(conversationId)) {
      try {
        return await _crypto.open(sealed, secret);
      } catch (_) {
        // Wrong key for this one; try the next. A message sealed for another
        // device looks exactly like this.
      }
    }
    return null;
  }

  /// A stable id for this install, made once.
  Future<String> _deviceId() async {
    final existing = await _storage.read(key: _deviceIdName);
    if (existing != null && existing.length >= 8) return existing;

    final random = Random.secure();
    final id = List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    await _storage.write(key: _deviceIdName, value: id);
    return id;
  }
}
