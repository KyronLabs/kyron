// lib/services/identity_vault.dart
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/identity_repository.dart';
import 'app_log.dart';
import 'did_keys.dart';

/// This account's portable identifier, and the key that proves it.
///
/// The `did` column existed from the beginning with nothing ever writing to
/// it, and Settings showed "No DID yet" to everyone forever. Before that it
/// showed `did:plc:abc…` and copied a hardcoded string -- the same invented
/// identifier for every account, to anyone who tapped Copy.
///
/// What it holds now is real: an Ed25519 keypair made on the device, whose
/// public half *is* the identifier. Claiming it means signing a challenge the
/// server issued, so the server records the identifier only once this account
/// has demonstrated it holds the matching secret -- and anybody else can check
/// that demonstration later without involving Kyron.
///
/// Same shape as [MessageVault], and the same limitation: the secret is per
/// install and there is no backup. Reinstalling produces a different
/// identifier. See docs/IDENTITY.md.
class IdentityVault {
  final IdentityRepository _identity;
  final FlutterSecureStorage _storage;
  final DidKeys _keys;

  IdentityVault(
    this._identity, {
    FlutterSecureStorage storage = const FlutterSecureStorage(),
    DidKeys keys = const DidKeys(),
  })  : _storage = storage,
        _keys = keys;

  static const _secretName = 'did_secret_key_v1';

  /// Loads or makes the keypair and claims the identifier if it is not
  /// already this account's.
  ///
  /// Returns the identifier, or null when it could not be established -- a
  /// device with no readable secure storage, or a server that refused. Null is
  /// reported to the reader as "no identifier yet", which is true, rather than
  /// as a fabricated one.
  Future<String?> ensure() async {
    try {
      final pair = await _load();
      final did = await DidKeys.didFor(pair);

      // Only when the server does not already have it. Claiming spends a
      // challenge and writes a row; doing it on every launch is noise.
      final known = await _identity.mine();
      if (known == did) return did;

      final message = await _identity.challenge();
      if (!message.startsWith(messagePrefix)) {
        // Signing whatever a server sends is how a challenge-response becomes
        // a signing oracle. An identifier is only worth anything because its
        // holder signs only what they meant to.
        throw StateError('That is not a Kyron identity challenge.');
      }

      final signature = await _keys.sign(pair, message);
      await _identity.claim(did: did, signature: signature);
      AppLog.instance.info('identity', 'Claimed $did');
      return did;
    } catch (error) {
      // Not fatal. Everything else in the app works without an identifier,
      // and the next launch tries again -- but a run of these means nobody is
      // getting one, which is worth being able to see.
      AppLog.instance.error('identity', 'Could not establish a DID: $error');
      return null;
    }
  }

  /// What every message this app will sign has to start with.
  ///
  /// Matches `IdentityService.messagePrefix`. The rest of the message is the
  /// server's to compose -- it puts its own idea of who is asking into it,
  /// which is what stops a proof made for one account counting for another --
  /// but the app checks this much before putting its key to anything.
  static const messagePrefix = 'kyron-did-claim:v1:';

  Future<SimpleKeyPair> _load() async {
    final stored = await _storage.read(key: _secretName);
    final existing =
        stored == null ? null : await DidKeys.tryDecodeSecret(stored);
    if (existing != null) return existing;

    final made = await _keys.newKeyPair();
    await _storage.write(
      key: _secretName,
      value: await DidKeys.encodeSecret(made),
    );
    return made;
  }

  /// Forgets the key, on sign-out.
  ///
  /// The identifier goes with the account that made it, exactly like the
  /// message key. Signing in again on this device produces a new one.
  Future<void> forget() => _storage.delete(key: _secretName);
}
