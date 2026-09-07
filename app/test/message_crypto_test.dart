import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/message_crypto.dart';

void main() {
  final crypto = MessageCrypto();

  /// Two people, and the key each derives for talking to the other.
  Future<(SecretKey, SecretKey)> pair() async {
    final ada = await crypto.newKeyPair();
    final bo = await crypto.newKeyPair();
    return (
      await crypto.sharedSecret(
        mine: ada,
        theirs: await bo.extractPublicKey(),
      ),
      await crypto.sharedSecret(
        mine: bo,
        theirs: await ada.extractPublicKey(),
      ),
    );
  }

  group('MessageCrypto', () {
    test('both sides derive the same key', () async {
      final (mine, theirs) = await pair();

      expect(
        await mine.extractBytes(),
        equals(await theirs.extractBytes()),
      );
    });

    test('what one seals the other opens', () async {
      final (mine, theirs) = await pair();

      final sealed = await crypto.seal('meet me at six', mine);

      expect(await crypto.open(sealed, theirs), 'meet me at six');
    });

    test('a stranger cannot open it', () async {
      final (mine, _) = await pair();
      final (eve, _) = await pair();

      final sealed = await crypto.seal('meet me at six', mine);

      await expectLater(crypto.open(sealed, eve), throwsA(anything));
    });

    test('an altered message will not open', () async {
      final (mine, theirs) = await pair();
      final sealed = await crypto.seal('send 10', mine);

      final tampered = SealedMessage(
        nonce: sealed.nonce,
        body: [...sealed.body]..[0] ^= 0xff,
        mac: sealed.mac,
      );

      // The point of an AEAD: a changed byte is a refusal, not a different
      // plaintext.
      await expectLater(crypto.open(tampered, theirs), throwsA(anything));
    });

    test('two sealings of the same words differ', () async {
      final (mine, _) = await pair();

      final once = await crypto.seal('hello', mine);
      final twice = await crypto.seal('hello', mine);

      // A nonce reused under one key breaks this cipher outright, so the
      // ciphertexts must never match.
      expect(once.nonce, isNot(equals(twice.nonce)));
      expect(once.body, isNot(equals(twice.body)));
    });

    test('survives the wire and back', () async {
      final (mine, theirs) = await pair();
      final sealed = await crypto.seal('a message with emoji 🎈', mine);

      final decoded = SealedMessage.tryDecode(sealed.encode());

      expect(decoded, isNotNull);
      expect(await crypto.open(decoded!, theirs), 'a message with emoji 🎈');
    });

    test('a plain message is not mistaken for a sealed one', () async {
      // Everything written before this existed looks like this, and has to
      // keep reading as what it is.
      expect(SealedMessage.tryDecode('just some words'), isNull);
      expect(SealedMessage.tryDecode('k1.only.three'), isNull);
      expect(SealedMessage.tryDecode('k9.a.b.c'), isNull);
      expect(SealedMessage.tryDecode('k1.!!.!!.!!'), isNull);
    });

    test('a public key survives the wire', () async {
      final ada = await crypto.newKeyPair();
      final public = await ada.extractPublicKey();

      final back = MessageCrypto.tryDecodePublicKey(
        MessageCrypto.encodePublicKey(public),
      );

      expect(back?.bytes, equals(public.bytes));
    });

    test('a key of the wrong length is refused', () {
      expect(MessageCrypto.tryDecodePublicKey('c2hvcnQ='), isNull);
      expect(MessageCrypto.tryDecodePublicKey('not base64 at all!'), isNull);
    });

    test('a stored secret comes back able to derive the same key', () async {
      final ada = await crypto.newKeyPair();
      final bo = await crypto.newKeyPair();

      final restored = await MessageCrypto.tryDecodeSecret(
          await MessageCrypto.encodeSecret(ada));

      expect(restored, isNotNull);
      expect(
        await (await crypto.sharedSecret(
          mine: restored!,
          theirs: await bo.extractPublicKey(),
        ))
            .extractBytes(),
        equals(await (await crypto.sharedSecret(
          mine: ada,
          theirs: await bo.extractPublicKey(),
        ))
            .extractBytes()),
      );
    });
  });
}
