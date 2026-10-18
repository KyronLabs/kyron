// lib/services/identity_vault.dart
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/identity_repository.dart';
import 'app_log.dart';
import 'did_keys.dart';

/// This account's verifiable identifier, and the key that proves it.
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
///
/// Kept per account, and across sign-out, for the reason the message key is:
/// it used to be deleted on every sign-out, so every sign-in made and claimed
/// a new identifier, and an identifier that changes whenever somebody signs
/// in identifies nothing.
class IdentityVault {
  final IdentityRepository _identity;
  final FlutterSecureStorage _storage;
  final DidKeys _keys;

  /// Who is signed in, for a caller that does not say.
  final String? Function() _signedIn;

  IdentityVault(
    this._identity, {
    FlutterSecureStorage storage = const FlutterSecureStorage(),
    DidKeys keys = const DidKeys(),
    String? Function()? signedIn,
  })  : _storage = storage,
        _keys = keys,
        _signedIn = signedIn ?? _nobody;

  static String? _nobody() => null;

  static String _secretName(String account) => 'did_secret_key_v2:$account';

  /// The install's one key from before keys were per account: deleted on
  /// every sign-out, so one still here is the signed-in account's.
  static const _legacySecretName = 'did_secret_key_v1';

  /// Loads or makes [account]'s keypair -- the signed-in account's when none
  /// is named -- and claims the identifier if it is not already the
  /// account's.
  ///
  /// Returns the identifier, or null when it could not be established -- a
  /// device with no readable secure storage, or a server that refused. Null is
  /// reported to the reader as "no identifier yet", which is true, rather than
  /// as a fabricated one.
  Future<String?> ensure([String? account]) async {
    final who = account ?? _signedIn();
    if (who == null) return null;
    try {
      final pair = await _load(who);
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

  Future<SimpleKeyPair> _load(String account) async {
    final stored = await _storage.read(key: _secretName(account)) ??
        await _adoptLegacy(account);
    final existing =
        stored == null ? null : await DidKeys.tryDecodeSecret(stored);
    if (existing != null) return existing;

    final made = await _keys.newKeyPair();
    await _storage.write(
      key: _secretName(account),
      value: await DidKeys.encodeSecret(made),
    );
    return made;
  }

  Future<String?> _adoptLegacy(String account) async {
    final legacy = await _storage.read(key: _legacySecretName);
    if (legacy == null) return null;
    await _storage.write(key: _secretName(account), value: legacy);
    await _storage.delete(key: _legacySecretName);
    return legacy;
  }

  /// Deletes [account]'s key from this install, for an account that has been
  /// deleted. Not on sign-out: signing back in keeps the same identifier.
  Future<void> erase(String account) =>
      _storage.delete(key: _secretName(account));
}
