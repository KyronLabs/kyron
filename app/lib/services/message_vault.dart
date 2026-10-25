// lib/services/message_vault.dart
import 'dart:async';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/key_share.dart';
import '../repositories/keys_repository.dart';
import 'app_log.dart';
import 'message_crypto.dart';

/// This install's identity for private messages, one per account, and the
/// keys it has fetched.
///
/// The secret half is generated on the device and written to the same secure
/// storage the session token lives in. It is never sent anywhere: what the
/// server holds is the public half, and what it stores in the Message table is
/// ciphertext it has no key for.
///
/// Each account signed in on this install has its own key and its own device
/// id, kept in storage under that account's id, and kept across sign-out. It
/// used to be one key for the install, deleted on every sign-out: switching
/// to another account and back, or just signing out and in again, made a new
/// key every time, and everything sealed to the old one could never be opened
/// again -- on the very phone it was sent to.
class MessageVault {
  final KeysRepository _keys;
  final FlutterSecureStorage _storage;
  final MessageCrypto _crypto;

  /// Who is signed in, for a read that comes before [unlock] has run.
  final String? Function() _signedIn;

  MessageVault(
    this._keys, {
    FlutterSecureStorage storage = const FlutterSecureStorage(),
    MessageCrypto? crypto,
    String? Function()? signedIn,
  })  : _storage = storage,
        _crypto = crypto ?? MessageCrypto(),
        _signedIn = signedIn ?? _nobody;

  static String? _nobody() => null;

  /// Where an account's secret half and device id are kept.
  @visibleForTesting
  static String secretKeyName(String account) => 'dm_secret_key_v2:$account';
  static String _deviceIdName(String account) => 'dm_device_id_v2:$account';

  /// Where the install's one key was kept before keys were per account. Moved
  /// to the first account that unlocks: it was deleted on every sign-out, so
  /// one that is still here belongs to whoever is signed in now.
  static const _legacySecretName = 'dm_secret_key_v1';
  static const _legacyDeviceIdName = 'dm_device_id_v1';

  /// The account [_mine] belongs to.
  String? _account;

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
  /// grows with every development build somebody has ever installed.
  ///
  /// Sized for a group: 32 people and a phone or two each. Each device adds
  /// about 120 characters, so a full envelope stays well inside the
  /// server's limit on a sealed body. Who is dropped when it bites is
  /// decided in [seal]: never anybody's freshest device.
  static const maxDevices = 64;

  /// Whether this install has an identity yet.
  bool get isReady => _mine != null;

  /// Loads [account]'s keypair, making one the first time.
  ///
  /// Called after sign-in. The public half is published every time rather than
  /// only when new: a server that lost it, or an account restored to a new
  /// install, otherwise leaves this device unwritable-to with nothing saying
  /// why.
  Future<void> unlock(String account) async {
    if (_account != account) _clear();
    _account = account;
    final loading = _load(account);
    _loading = loading;
    final pair = await loading;
    // Signed out, or into another account, while the key was being read.
    if (_account != account) return;

    try {
      await _keys.publish(
        MessageCrypto.encodePublicKey(await pair.extractPublicKey()),
        await _deviceId(account),
      );
    } catch (error) {
      // Not fatal: messages still send in the clear-to-the-server form the app
      // used before this existed, and the next launch tries again. Logged
      // because a run of these means nobody can write to this device.
      AppLog.instance.error('e2ee', 'Could not publish the key: $error');
    }
    // Whatever was asked of this device while it was away.
    unawaited(answerPending());
  }

  /// The keypair being read from storage, while it is. [unlock] is not
  /// awaited by sign-in, so the conversation list can ask to open a message
  /// before the key is in memory; it waits for this rather than answering
  /// that nothing can be opened.
  Future<SimpleKeyPair?>? _loading;

  Future<SimpleKeyPair> _load(String account) async {
    var pair = await _readStored(account);
    if (pair == null) {
      pair = await _crypto.newKeyPair();
      await _storage.write(
        key: secretKeyName(account),
        value: await MessageCrypto.encodeSecret(pair),
      );
    }
    if (_account == account) _mine = pair;
    return pair;
  }

  /// The key [account] already has here, or null -- never a new one.
  Future<SimpleKeyPair?> _readStored(String account) async {
    final stored = await _storage.read(key: secretKeyName(account)) ??
        await _adoptLegacy(account);
    final pair =
        stored == null ? null : await MessageCrypto.tryDecodeSecret(stored);
    if (pair != null && _account == account) _mine = pair;
    return pair;
  }

  /// Moves the install's key from before keys were per account to
  /// [account], with its device id, so the people who sealed messages to it
  /// are still read. Answers the stored secret, or null when there was none.
  Future<String?> _adoptLegacy(String account) async {
    final legacy = await _storage.read(key: _legacySecretName);
    if (legacy == null) return null;
    await _storage.write(key: secretKeyName(account), value: legacy);
    final device = await _storage.read(key: _legacyDeviceIdName);
    if (device != null &&
        await _storage.read(key: _deviceIdName(account)) == null) {
      await _storage.write(key: _deviceIdName(account), value: device);
    }
    await _storage.delete(key: _legacySecretName);
    await _storage.delete(key: _legacyDeviceIdName);
    AppLog.instance.info('e2ee', 'Moved the install key to the account');
    return legacy;
  }

  /// The signed-in account's key, waiting for [unlock] if it is still reading
  /// it. Null when there is none: signed out, or the keychain failed.
  ///
  /// When nothing has unlocked the vault at all, the key on the device is
  /// read rather than taken to be absent. A sign-in path that forgot to
  /// unlock used to leave every sealed message unreadable and every new one
  /// sent in the clear, with the key sitting in storage the whole time. Only
  /// read: making and publishing a key stays [unlock]'s job, so a vault does
  /// not mint one behind anybody's back.
  Future<SimpleKeyPair?> _key() async {
    final mine = _mine;
    if (mine != null) return mine;
    if (_loading == null) {
      final account = _account ??= _signedIn();
      if (account == null) return null;
      _loading = _readStored(account);
    }
    try {
      return await _loading;
    } catch (_) {
      return null;
    }
  }

  /// Puts the vault down, on sign-out.
  ///
  /// The key stays, in storage and on the server. It is this account's key on
  /// this phone, and the next person to sign in here is told nothing about it:
  /// another account reads only its own. Signing back in picks it up again
  /// and opens everything sealed to it -- including what arrived while
  /// signed out, which is why the public half is not withdrawn either.
  ///
  /// It used to be deleted here, and with it every message sealed to it.
  /// [erase] is still that, for an account that is gone.
  Future<void> lock() async => _clear();

  /// Deletes [account]'s key from this install, and withdraws it. For an
  /// account that has been deleted; anything sealed to the key can no longer
  /// be opened here.
  Future<void> erase(String account) async {
    final deviceId = await _storage.read(key: _deviceIdName(account));
    if (_account == account) _clear();
    await _storage.delete(key: secretKeyName(account));
    await _storage.delete(key: _deviceIdName(account));
    if (deviceId != null) {
      try {
        await _keys.withdraw(deviceId);
      } catch (_) {
        // The account is gone, and its keys went with it on the server.
      }
    }
  }

  void _clear() {
    _mine = null;
    _loading = null;
    _account = null;
    _asked.clear();
    _sharedByConversation.clear();
    _devicesByConversation.clear();
    _unwrapKeys.clear();
  }

  /// The keys of everybody else in a conversation, cached.
  ///
  /// A list because one person can have several installs, and a message has to
  /// be sealed for each or it arrives on one device and not the other.
  Future<List<SecretKey>> secretsFor(String conversationId) async {
    final cached = _sharedByConversation[conversationId];
    if (cached != null) return cached;

    final mine = await _key();
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

  /// Forgets every conversation's device list, when somebody in one of them
  /// has a new device. Which conversations they are in is not worth working
  /// out: the next message in each fetches its list again, once.
  void forgetDevices() {
    _sharedByConversation.clear();
    _devicesByConversation.clear();
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
    final mine = await _key();
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

    // This device first; then everybody else's freshest, one each; then
    // their second freshest, and so on; then this person's other installs.
    // So the ceiling, when it bites, drops the stalest installs -- and in a
    // group never takes somebody out altogether because somebody else has
    // a drawer of old phones.
    final byPerson = <String, List<String>>{};
    for (final k in others) {
      // Freshest first, as the server lists them.
      (byPerson[k.userId] ??= []).add(k.publicKey);
    }
    final ordered = [
      ownKey,
      for (var round = 0;
          byPerson.values.any((keys) => keys.length > round);
          round++)
        for (final keys in byPerson.values)
          if (keys.length > round) keys[round],
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
  /// A `k2` envelope opens with this device's key alone, no network -- or,
  /// when it was not sealed for this device, with one of [shares]: its key
  /// sealed again for this device by one that could open it. [card] when
  /// this is the message's link card, whose key rides second in a share. A
  /// `k1` message, the old single-key form, needs the conversation's keys.
  Future<String?> open(
    String body,
    String conversationId, {
    List<KeyShare> shares = const [],
    bool card = false,
  }) async {
    final envelope = SealedEnvelope.tryDecode(body);
    if (envelope != null) {
      final mine = await _key();
      if (mine == null) return null;
      return await _crypto.openEnvelope(envelope, mine: mine) ??
          await _openShared(envelope, mine, shares, card: card);
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
  /// for this device, or one of [shares] was; a `k1` message only if its keys
  /// were already fetched.
  Future<String?> openOffline(
    String body,
    String conversationId, {
    List<KeyShare> shares = const [],
  }) async {
    final envelope = SealedEnvelope.tryDecode(body);
    if (envelope != null) {
      final mine = await _key();
      if (mine == null) return null;
      return await _crypto.openEnvelope(envelope, mine: mine) ??
          await _openShared(envelope, mine, shares, card: false);
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

  Future<String?> _openShared(
    SealedEnvelope envelope,
    SimpleKeyPair mine,
    List<KeyShare> shares, {
    required bool card,
  }) async {
    if (shares.isEmpty) return null;
    final ownKey = MessageCrypto.encodePublicKey(await mine.extractPublicKey());
    final start = card ? _keyLength : 0;
    for (final share in shares) {
      if (share.publicKey != ownKey) continue;
      final keys = await _crypto.openShare(share.sealed, mine: mine);
      if (keys == null || keys.length < start + _keyLength) continue;
      final plain = await _crypto.openWithContentKey(
        envelope,
        keys.sublist(start, start + _keyLength),
      );
      if (plain != null) return plain;
    }
    return null;
  }

  /// A message key's length: XChaCha20's 256 bits.
  static const _keyLength = 32;

  /// How far back a device may ask for keys. Matches the server's
  /// `KeySharesService.windowDays`, which refuses older ones anyway: past
  /// it, asking would only say "waiting" about a message nobody will answer.
  static const shareWindow = Duration(days: 30);

  /// Whether a message this device cannot open is one worth asking for.
  static bool canAskFor(String body, DateTime sentAt) =>
      body.startsWith('k2.') && DateTime.now().difference(sentAt) < shareWindow;

  /// Whether anybody could answer this device if it asked: it has a key, and
  /// a device id to have published it under. A thread says "Waiting for
  /// this message" only then -- otherwise nothing is coming.
  Future<bool> canBeAnswered() async {
    final account = _account ?? _signedIn();
    if (account == null || await _key() == null) return false;
    return await _storage.read(key: _deviceIdName(account)) != null;
  }

  /// Messages already asked for since the vault was unlocked, so a thread
  /// drawn twice does not ask twice.
  final _asked = <String>{};

  /// Asks the conversation's other devices for the keys of [messageIds],
  /// which this device was not sealed for.
  ///
  /// Whoever can open them -- the sender's phone, another of this person's
  /// own -- seals each key again for this device when it is next online
  /// ([answerPending]), and the thread opens them then. Once per message per
  /// session; a failure is forgotten so the next look asks again.
  Future<void> requestKeys(
    String conversationId,
    Iterable<String> messageIds,
  ) async {
    final fresh = [
      for (final id in messageIds)
        if (_asked.add(id)) id,
    ];
    if (fresh.isEmpty) return;
    final account = _account ?? _signedIn();
    final device = account == null
        ? null
        : await _storage.read(key: _deviceIdName(account));
    if (device == null || await _key() == null) {
      _asked.removeAll(fresh);
      return;
    }
    try {
      for (var i = 0; i < fresh.length; i += 100) {
        await _keys.requestShares(
          conversationId,
          device,
          fresh.sublist(i, min(i + 100, fresh.length)),
        );
      }
    } catch (error) {
      _asked.removeAll(fresh);
      AppLog.instance.error('e2ee', 'Could not ask for keys: $error');
    }
  }

  Future<int>? _answering;
  bool _answerAgain = false;

  /// Answers every request this device can: for each message somebody's
  /// device is waiting on that this one can open, its key sealed for theirs.
  ///
  /// Run after unlocking, when the socket connects, and whenever the server
  /// says a request arrived. One run at a time; a call during a run makes it
  /// go round once more, so a request that arrived meanwhile is not left.
  /// Answers how many it answered.
  Future<int> answerPending() {
    if (_answering != null) {
      _answerAgain = true;
      return _answering!;
    }
    final run = () async {
      var answered = 0;
      do {
        _answerAgain = false;
        answered += await _answerOnce();
      } while (_answerAgain);
      return answered;
    }();
    _answering = run;
    return run.whenComplete(() => _answering = null);
  }

  Future<int> _answerOnce() async {
    final mine = await _key();
    if (mine == null) return 0;
    final ownKey = MessageCrypto.encodePublicKey(await mine.extractPublicKey());

    // Named, so the server hands over only what this device can answer.
    // Without it, requests nobody can answer crowded out the ones this
    // device could, a hundred at a time (KeySharesService.pending).
    final account = _account ?? _signedIn();
    final device = account == null
        ? null
        : await _storage.read(key: _deviceIdName(account));

    final List<KeyRequest> pending;
    try {
      pending = await _keys.pendingRequests(deviceId: device);
    } catch (error) {
      AppLog.instance.error('e2ee', 'Could not fetch key requests: $error');
      return 0;
    }

    final answers = <({String id, String sealed})>[];
    for (final request in pending) {
      if (request.publicKey == ownKey) continue;
      final device = MessageCrypto.tryDecodePublicKey(request.publicKey);
      final envelope = SealedEnvelope.tryDecode(request.body);
      if (device == null || envelope == null) continue;
      // Only a message this device was sealed for. One it was handed a share
      // of is left to the devices that were.
      final bodyKey = await _crypto.contentKeyOf(envelope, mine: mine);
      if (bodyKey == null) continue;
      final card = request.linkCard == null
          ? null
          : SealedEnvelope.tryDecode(request.linkCard!);
      final cardKey =
          card == null ? null : await _crypto.contentKeyOf(card, mine: mine);
      answers.add((
        id: request.id,
        sealed: await _crypto.sealShare(
          [...bodyKey, ...?cardKey],
          mine: mine,
          device: device,
        ),
      ));
    }
    if (answers.isEmpty) return 0;

    try {
      for (var i = 0; i < answers.length; i += 100) {
        await _keys.shareKeys(
          answers.sublist(i, min(i + 100, answers.length)),
        );
      }
    } catch (error) {
      AppLog.instance.error('e2ee', 'Could not answer key requests: $error');
      return 0;
    }
    AppLog.instance.info('e2ee', 'Answered ${answers.length} key requests');
    return answers.length;
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

  /// A stable id for [account] on this install, made once.
  ///
  /// Per account rather than per install, so the server is not told which
  /// accounts share a phone.
  Future<String> _deviceId(String account) async {
    final name = _deviceIdName(account);
    final existing = await _storage.read(key: name);
    if (existing != null && existing.length >= 8) return existing;

    final random = Random.secure();
    final id = List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    await _storage.write(key: name, value: id);
    return id;
  }
}
