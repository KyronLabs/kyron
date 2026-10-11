// lib/services/message_vault.dart
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
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

  /// Shared secrets already worked out, by conversation, for opening `k1`
  /// messages. Derivation is not free and a chat asks for the same one on
  /// every message it draws.
  final _sharedByConversation = <String, List<SecretKey>>{};

  /// Every device in each conversation, and when the list was fetched.
  final _devicesByConversation =
      <String, ({DateTime at, List<PublishedKey> keys})>{};

  /// Per-device keys for sealing `k2` envelopes, by device id. They depend
  /// only on this install's key and that device's, so they hold across
  /// conversations.
  final _unwrapKeys = <String, SecretKey>{};

  /// How long a conversation's device list is trusted before it is asked for
  /// again -- so a device somebody has just added is written to within
  /// minutes, not only after this app restarts.
  static const devicesFresh = Duration(minutes: 10);

  /// The most devices one message is sealed for. Every reinstall publishes a
  /// new key and the old one stays listed, so without a ceiling an envelope
  /// grows with every development build somebody has ever installed. The
  /// freshest are kept.
  static const maxDevices = 16;

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
    _devicesByConversation.clear();
    _unwrapKeys.clear();
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
  void forget(String conversationId) {
    _sharedByConversation.remove(conversationId);
    _devicesByConversation.remove(conversationId);
  }

  /// Uses [pair] as this install's key, without secure storage. For tests,
  /// which have no keychain.
  @visibleForTesting
  void adopt(SimpleKeyPair pair) => _mine = pair;

  /// Seals a message for a conversation, or answers null when it cannot.
  ///
  /// Sealed for every device in the conversation: each of the other
  /// person's, and each of this person's own, this one included -- or they
  /// could not read their own message after a restart. This used to seal
  /// under whichever single key the server happened to list first, and too
  /// often that was the sender's own: the person it was written to could
  /// never open it.
  ///
  /// Null rather than throwing, and never a fallback that silently sends in
  /// the clear: the caller decides, and the reader is told which they got.
  Future<String?> seal(String plain, String conversationId) async {
    final mine = _mine;
    if (mine == null) return null;
    final ownKey = MessageCrypto.encodePublicKey(await mine.extractPublicKey());

    final published = await _devicesFor(conversationId);
    // Which account is the reader's is read off the list itself: whoever
    // published this install's key.
    final me = published
        .where((k) => k.publicKey == ownKey)
        .map((k) => k.userId)
        .firstOrNull;
    final others = [
      for (final k in published)
        if (me == null ? k.publicKey != ownKey : k.userId != me) k,
    ];
    // Nobody else can open anything yet: their app has published no key. Sent
    // as written, and the bubble says so. Never sealed for the sender alone,
    // which would arrive as a message nobody else could ever read.
    if (others.isEmpty) return null;

    // This device first, then the other person's (freshest first, as the
    // server lists them), then this person's other installs -- so the
    // ceiling, when it bites, drops the stalest of one's own.
    final ordered = [
      ownKey,
      for (final k in others) k.publicKey,
      for (final k in published)
        if (k.publicKey != ownKey && !others.contains(k)) k.publicKey,
    ];
    final devices = <SimplePublicKey>[];
    final seen = <String>{};
    for (final key in ordered) {
      if (!seen.add(key)) continue;
      final decoded = MessageCrypto.tryDecodePublicKey(key);
      if (decoded != null) devices.add(decoded);
      if (devices.length >= maxDevices) break;
    }

    final envelope = await _crypto.sealForDevices(
      plain,
      mine: mine,
      devices: devices,
      unwrapKeys: _unwrapKeys,
    );
    return envelope.encode();
  }

  /// Opens one, or answers null if this was never sealed or cannot be opened.
  ///
  /// A `k2` envelope opens with this device's key alone, no network. A `k1`
  /// message, the old single-key form, needs the conversation's keys.
  Future<String?> open(String body, String conversationId) async {
    final envelope = SealedEnvelope.tryDecode(body);
    if (envelope != null) {
      final mine = _mine;
      if (mine == null) return null;
      return _crypto.openEnvelope(envelope, mine: mine);
    }

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

  /// Opens [body] using only what this device holds -- for a list of
  /// conversations, where fetching every conversation's keys to show one line
  /// each is not worth it. A `k2` envelope always opens here if it was sealed
  /// for this device; a `k1` message only if its keys were already fetched.
  Future<String?> openOffline(String body, String conversationId) async {
    final envelope = SealedEnvelope.tryDecode(body);
    final mine = _mine;
    if (envelope != null) {
      return mine == null ? null : _crypto.openEnvelope(envelope, mine: mine);
    }
    final sealed = SealedMessage.tryDecode(body);
    final cached = _sharedByConversation[conversationId];
    if (sealed == null || cached == null) return null;
    for (final secret in cached) {
      try {
        return await _crypto.open(sealed, secret);
      } catch (_) {}
    }
    return null;
  }

  /// Every device in a conversation, freshest first, cached for
  /// [devicesFresh].
  Future<List<PublishedKey>> _devicesFor(String conversationId) async {
    final cached = _devicesByConversation[conversationId];
    if (cached != null && DateTime.now().difference(cached.at) < devicesFresh) {
      return cached.keys;
    }
    try {
      final keys = await _keys.forConversation(conversationId);
      _devicesByConversation[conversationId] = (at: DateTime.now(), keys: keys);
      return keys;
    } catch (error) {
      AppLog.instance.error('e2ee', 'Could not fetch keys: $error');
      return cached?.keys ?? const [];
    }
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
