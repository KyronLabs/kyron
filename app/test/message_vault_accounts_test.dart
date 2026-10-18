import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/key_share.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';

/// More than one account on one phone.
///
/// The key used to be the install's, and sign-out deleted it. Signing out of
/// one account and into another -- or out and back into the same one -- made
/// a new key each time, and every message sealed to the old one was never
/// readable on that phone again. The key is now the account's, kept under
/// its id, and kept across sign-out.
class _Keys extends KeysRepository {
  _Keys() : super(ApiClient()..dio.interceptors.clear());

  /// Who the server would say is signed in, since it takes the account from
  /// the session rather than the request.
  String signedIn = '';

  final published = <PublishedKey>[];
  final withdrawn = <String>[];

  @override
  Future<List<KeyRequest>> pendingRequests() async => const [];

  @override
  Future<void> publish(String publicKey, String deviceId) async {
    published.removeWhere(
      (k) => k.userId == signedIn && k.deviceId == deviceId,
    );
    published.insert(
      0,
      PublishedKey(userId: signedIn, deviceId: deviceId, publicKey: publicKey),
    );
  }

  @override
  Future<void> withdraw(String deviceId) async {
    withdrawn.add(deviceId);
    published.removeWhere(
      (k) => k.userId == signedIn && k.deviceId == deviceId,
    );
  }

  @override
  Future<List<PublishedKey>> forConversation(String conversationId) async =>
      List.of(published);

  PublishedKey of(String user) => published.firstWhere((k) => k.userId == user);
}

/// Somebody on another phone, writing in.
Future<String> _writeTo(_Keys keys, String text) async {
  final cy = await MessageCrypto().newKeyPair();
  keys.published.add(
    PublishedKey(
      userId: 'cy',
      deviceId: 'cy-phone',
      publicKey: MessageCrypto.encodePublicKey(await cy.extractPublicKey()),
    ),
  );
  final sealed = await (MessageVault(keys)..adopt(cy)).seal(text, 'c1');
  return sealed!;
}

Future<void> _signIn(_Keys keys, MessageVault phone, String account) async {
  keys.signedIn = account;
  await phone.unlock(account);
}

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('signing out and into another account and back keeps the messages',
      () async {
    final keys = _Keys();
    final phone = MessageVault(keys);

    await _signIn(keys, phone, 'ada');
    final adaKey = keys.of('ada').publicKey;
    final forAda = await _writeTo(keys, 'for ada');

    await phone.lock();
    await _signIn(keys, phone, 'bo');
    // Bo's own key, not Ada's, and not able to read Ada's messages.
    expect(keys.of('bo').publicKey, isNot(adaKey));
    expect(await phone.open(forAda, 'c1'), isNull);

    await phone.lock();
    await _signIn(keys, phone, 'ada');

    expect(keys.of('ada').publicKey, adaKey);
    expect(await phone.open(forAda, 'c1'), 'for ada');
  });

  test('sign-out keeps the key published, so what arrives meanwhile reads',
      () async {
    final keys = _Keys();
    final phone = MessageVault(keys);
    await _signIn(keys, phone, 'ada');

    await phone.lock();
    expect(keys.withdrawn, isEmpty);
    final whileAway = await _writeTo(keys, 'while you were out');

    await _signIn(keys, phone, 'ada');
    expect(await phone.open(whileAway, 'c1'), 'while you were out');
  });

  test('accounts on one phone do not share a device id', () async {
    // The server would otherwise be told which accounts are the same phone.
    final keys = _Keys();
    final phone = MessageVault(keys);
    await _signIn(keys, phone, 'ada');
    await phone.lock();
    await _signIn(keys, phone, 'bo');

    expect(keys.of('ada').deviceId, isNot(keys.of('bo').deviceId));
  });

  test('a signed-out vault opens nothing, and never another account\'s',
      () async {
    final keys = _Keys();
    final phone = MessageVault(keys);
    await _signIn(keys, phone, 'ada');
    final forAda = await _writeTo(keys, 'for ada');
    await phone.lock();

    expect(await phone.open(forAda, 'c1'), isNull);
    // Before Bo's unlock has run, the vault reads Bo's key -- and only Bo's.
    final asBo = MessageVault(keys, signedIn: () => 'bo');
    expect(await asBo.open(forAda, 'c1'), isNull);
  });

  test('the install key from before is moved to whoever is signed in',
      () async {
    // Every phone updating to this has its one key under the old name, and
    // messages already sealed to it.
    final old = await MessageCrypto().newKeyPair();
    FlutterSecureStorage.setMockInitialValues({
      'dm_secret_key_v1': await MessageCrypto.encodeSecret(old),
      'dm_device_id_v1': 'install-0001',
    });
    final keys = _Keys();
    final sealedBefore = await () async {
      keys.published.add(
        PublishedKey(
          userId: 'ada',
          deviceId: 'install-0001',
          publicKey:
              MessageCrypto.encodePublicKey(await old.extractPublicKey()),
        ),
      );
      return _writeTo(keys, 'from before the update');
    }();

    final phone = MessageVault(keys);
    await _signIn(keys, phone, 'ada');

    expect(await phone.open(sealedBefore, 'c1'), 'from before the update');
    // Same key, same device: the server's row is replaced, not joined.
    expect(keys.published.where((k) => k.userId == 'ada'), hasLength(1));
    expect(keys.of('ada').deviceId, 'install-0001');
    const storage = FlutterSecureStorage();
    expect(await storage.read(key: 'dm_secret_key_v1'), isNull);

    // And the next account to sign in here gets one of its own.
    await phone.lock();
    await _signIn(keys, phone, 'bo');
    expect(keys.of('bo').deviceId, isNot('install-0001'));
    expect(await phone.open(sealedBefore, 'c1'), isNull);
  });

  test('a deleted account takes its key with it', () async {
    final keys = _Keys();
    final phone = MessageVault(keys);
    await _signIn(keys, phone, 'ada');
    final device = keys.of('ada').deviceId;

    await phone.erase('ada');

    expect(keys.withdrawn, [device]);
    expect(
      await const FlutterSecureStorage().read(
        key: MessageVault.secretKeyName('ada'),
      ),
      isNull,
    );
    expect(phone.isReady, isFalse);
  });

  test('a key for one account is never used to seal as another', () async {
    // Bo signs in while Ada's key is still loading from a slow keychain.
    final keys = _Keys();
    final ada = await MessageCrypto().newKeyPair();
    FlutterSecureStorage.setMockInitialValues({
      MessageVault.secretKeyName('ada'): await MessageCrypto.encodeSecret(ada),
    });
    final phone = MessageVault(keys);
    keys.signedIn = 'ada';
    final adaUnlocking = phone.unlock('ada');
    keys.signedIn = 'bo';
    await phone.unlock('bo');
    await adaUnlocking;

    final mine = keys.of('bo').publicKey;
    await _writeTo(keys, 'hello');
    final sealed = SealedEnvelope.tryDecode((await phone.seal('hi', 'c1'))!)!;
    expect(sealed.sender, mine);
    expect(
      sealed.sender,
      isNot(MessageCrypto.encodePublicKey(await ada.extractPublicKey())),
    );
  });
}
