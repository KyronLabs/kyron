import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/repositories/keys_repository.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/message_crypto.dart';
import 'package:kyron_app/services/message_vault.dart';

/// Sealing a message so that the person it is for can read it.
///
/// The bug this file exists for: a message was sealed under whichever single
/// key the server listed first, and the list included the sender's own key.
/// When that came first, the message was sealed with a secret only the sender
/// could derive -- they could read their own messages and the other person
/// could read none of them. The fix seals once and wraps the key for every
/// device in the conversation.
class _Keys extends KeysRepository {
  _Keys(this.published) : super(ApiClient()..dio.interceptors.clear());

  List<PublishedKey> published;
  int fetches = 0;

  @override
  Future<List<PublishedKey>> forConversation(String conversationId) async {
    fetches++;
    return published;
  }

  @override
  Future<void> publish(String publicKey, String deviceId) async {}
}

final _crypto = MessageCrypto();

class _Device {
  _Device(this.user, this.pair);
  final String user;
  final SimpleKeyPair pair;

  Future<PublishedKey> published() async => PublishedKey(
        userId: user,
        deviceId: '$user-${pair.hashCode}',
        publicKey: MessageCrypto.encodePublicKey(await pair.extractPublicKey()),
      );

  MessageVault vault(_Keys keys) => MessageVault(keys)..adopt(pair);
}

Future<_Device> _device(String user) async =>
    _Device(user, await _crypto.newKeyPair());

void main() {
  test('the person it is for can read it, whatever order the keys come in',
      () async {
    final ada = await _device('ada');
    final bo = await _device('bo');
    // Ada's own key first: the order that made the old version seal for Ada
    // alone.
    final keys = _Keys([await ada.published(), await bo.published()]);

    final sealed = await ada.vault(keys).seal('meet me at six', 'c1');

    expect(sealed, startsWith('k2.'));
    expect(await bo.vault(keys).open(sealed!, 'c1'), 'meet me at six');
    expect(await ada.vault(keys).open(sealed, 'c1'), 'meet me at six');
  });

  test('every device either of them has can read it', () async {
    final adaPhone = await _device('ada');
    final adaTablet = await _device('ada');
    final boPhone = await _device('bo');
    final boOldInstall = await _device('bo');
    final keys = _Keys([
      await boOldInstall.published(),
      await adaPhone.published(),
      await boPhone.published(),
      await adaTablet.published(),
    ]);

    final sealed = (await adaPhone.vault(keys).seal('hello', 'c1'))!;

    for (final device in [adaPhone, adaTablet, boPhone, boOldInstall]) {
      expect(await device.vault(keys).open(sealed, 'c1'), 'hello');
    }
  });

  test('nobody outside the conversation can', () async {
    final ada = await _device('ada');
    final bo = await _device('bo');
    final eve = await _device('eve');
    final keys = _Keys([await ada.published(), await bo.published()]);

    final sealed = (await ada.vault(keys).seal('meet me at six', 'c1'))!;

    expect(await eve.vault(keys).open(sealed, 'c1'), isNull);
  });

  test('an altered envelope does not open', () async {
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);

    final sealed = (await ada.vault(keys).seal('meet me at six', 'c1'))!;
    final parts = sealed.split('.');
    final body = parts[3];
    parts[3] = '${body.substring(0, 4)}${body[4] == 'A' ? 'B' : 'A'}'
        '${body.substring(5)}';

    expect(await bo.vault(keys).open(parts.join('.'), 'c1'), isNull);
  });

  test('is sent as written when the other person has no key yet', () async {
    // Ada has two devices; Bo's app has never published a key. Sealing for
    // Ada's devices alone would send Bo something he could never read.
    final adaPhone = await _device('ada');
    final adaTablet = await _device('ada');
    final keys = _Keys([
      await adaPhone.published(),
      await adaTablet.published(),
    ]);

    expect(await adaPhone.vault(keys).seal('hello', 'c1'), isNull);
  });

  test('opens without asking the server for anybody’s keys', () async {
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);
    final sealed = (await ada.vault(keys).seal('hello', 'c1'))!;

    final reader = bo.vault(keys);
    keys.fetches = 0;
    expect(await reader.openOffline(sealed, 'c1'), 'hello');
    expect(keys.fetches, 0);
  });

  test('waits for a key still being read rather than giving up', () async {
    // Sign-in does not wait for the key to load, so the conversation list
    // can ask to open its previews first. It used to be told nothing could be
    // opened, and drew every one as unreadable.
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);
    final sealed = (await ada.vault(keys).seal('hello', 'c1'))!;
    FlutterSecureStorage.setMockInitialValues({
      MessageVault.secretKeyName('bo'): await MessageCrypto.encodeSecret(
        bo.pair,
      ),
    });

    final reader = MessageVault(keys);
    final unlocking = reader.unlock('bo');
    expect(await reader.openOffline(sealed, 'c1'), 'hello');
    await unlocking;
  });

  test('opens with the stored key even when nothing unlocked the vault',
      () async {
    // A launch whose session had expired was refreshed without unlocking the
    // vault. Every sealed message then read "cannot be read", with the key
    // in storage the whole time.
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);
    final sealed = (await ada.vault(keys).seal('still here', 'c1'))!;
    FlutterSecureStorage.setMockInitialValues({
      MessageVault.secretKeyName('bo'): await MessageCrypto.encodeSecret(
        bo.pair,
      ),
    });

    final reader = MessageVault(keys, signedIn: () => 'bo');

    expect(await reader.open(sealed, 'c1'), 'still here');
    // And can seal again, rather than sending the next message in the clear.
    expect(await reader.seal('and back', 'c1'), startsWith('k2.'));
  });

  test('never makes a key of its own without being unlocked', () async {
    // Reading is all it does unprompted. A vault locked on sign-out must not
    // mint and use a new identity behind anybody's back.
    FlutterSecureStorage.setMockInitialValues({});
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);

    final vault = MessageVault(keys, signedIn: () => 'bo');

    expect(await vault.seal('hello', 'c1'), isNull);
    expect(vault.isReady, isFalse);
    expect(
      await const FlutterSecureStorage().read(
        key: MessageVault.secretKeyName('bo'),
      ),
      isNull,
    );
  });

  test('still opens a message in the old single-key form', () async {
    final ada = await _device('ada');
    final bo = await _device('bo');
    final keys = _Keys([await ada.published(), await bo.published()]);

    final secret = await _crypto.sharedSecret(
      mine: ada.pair,
      theirs: await bo.pair.extractPublicKey(),
    );
    final old = (await _crypto.seal('from before', secret)).encode();

    expect(old, startsWith('k1.'));
    expect(await bo.vault(keys).open(old, 'c1'), 'from before');
  });

  test('a plain message is not mistaken for a sealed one', () {
    expect(SealedEnvelope.looksSealed('k2 is a nice name for a cat'), isFalse);
    expect(SealedEnvelope.looksSealed('hello'), isFalse);
  });

  test('seals for no more than the ceiling of devices', () async {
    final ada = await _device('ada');
    final installs = [
      for (var i = 0; i < MessageVault.maxDevices + 5; i++) await _device('bo'),
    ];
    final keys = _Keys([
      await ada.published(),
      for (final d in installs) await d.published(),
    ]);

    final sealed = (await ada.vault(keys).seal('hi', 'c1'))!;
    final envelope = SealedEnvelope.tryDecode(sealed)!;

    expect(envelope.keys.length, MessageVault.maxDevices);
    // The sender's own device is always among them.
    expect(await ada.vault(keys).open(sealed, 'c1'), 'hi');
  });
}
