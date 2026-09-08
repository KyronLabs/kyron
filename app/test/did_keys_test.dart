import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/did_keys.dart';

void main() {
  group('base58btc', () {
    test('matches the encoding did:key is written in', () {
      // Bitcoin's own published vectors, so this is checked against somebody
      // else's arithmetic rather than only against itself.
      expect(encodeBase58(utf8.encode('Hello World!')), '2NEpo7TZRRrLZSi2U');
      expect(encodeBase58([0x00, 0x00, 0x28, 0x7f, 0xb4, 0xcd]), '11233QC4');
    });

    test('writes a leading zero byte as a 1', () {
      // The only way base58 can represent one. Dropping it changes the key.
      expect(encodeBase58([0]), '1');
      expect(encodeBase58([0, 0, 1]), '112');
    });
  });

  group('did:key', () {
    test('is derived from the public key, and is stable for it', () async {
      final pair = await const DidKeys().newKeyPair();

      final did = await DidKeys.didFor(pair);

      expect(did.startsWith('did:key:z6Mk'), isTrue);
      expect(await DidKeys.didFor(pair), did);
    });

    test('differs between identities', () async {
      const keys = DidKeys();

      final a = await DidKeys.didFor(await keys.newKeyPair());
      final b = await DidKeys.didFor(await keys.newKeyPair());

      expect(a, isNot(b));
    });

    test('reads the published test vector', () async {
      // From the did:key specification. The bytes are the key; the string is
      // what the server decodes to check a signature, so the two have to agree
      // exactly or an account cannot prove who it is.
      const expected =
          'did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK';
      // The same key as raw bytes, taken by decoding that DID with the
      // *server's* implementation. So this asserts the two languages agree:
      // if Dart encoded a key differently from the way TypeScript decodes
      // one, an account would produce an identifier the server could not
      // check a signature against.
      final key = base64Url.decode(
        base64Url.normalize('Lm_M42cB3HkUiODQsXRcweM6TByfzEHGO9ND274JcOY'),
      );

      expect(DidKeys.didForBytes(key), expected);
    });

    test('refuses a key of the wrong length rather than encoding it', () {
      expect(() => DidKeys.didForBytes([1, 2, 3]), throwsArgumentError);
    });
  });

  group('the secret half', () {
    test('survives being written down and read back', () async {
      const keys = DidKeys();
      final pair = await keys.newKeyPair();

      final restored =
          await DidKeys.tryDecodeSecret(await DidKeys.encodeSecret(pair));

      // The same identity, which is what matters: the same DID, and a
      // signature the same key made.
      expect(await DidKeys.didFor(restored!), await DidKeys.didFor(pair));
    });

    test('reads nothing out of something that is not a key', () async {
      for (final bad in [
        '',
        'not base64!!',
        base64Url.encode([1, 2, 3])
      ]) {
        expect(await DidKeys.tryDecodeSecret(bad), isNull);
      }
    });
  });

  group('signing', () {
    test('produces a signature the key verifies', () async {
      const keys = DidKeys();
      final pair = await keys.newKeyPair();
      const message = 'kyron-did-claim:v1:user-1:some-challenge';

      final signature = await keys.sign(pair, message);

      final verified = await Ed25519().verify(
        utf8.encode(message),
        signature: Signature(
          base64Url.decode(base64Url.normalize(signature)),
          publicKey: await pair.extractPublicKey(),
        ),
      );
      expect(verified, isTrue);
    });

    test('is base64url without padding, which is what the API takes', () async {
      const keys = DidKeys();
      final signature =
          await keys.sign(await keys.newKeyPair(), 'anything at all');

      expect(signature.contains('='), isFalse);
      expect(RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(signature), isTrue);
      // 64 bytes, base64url, unpadded.
      expect(signature.length, 86);
    });

    test('a different key signs differently', () async {
      const keys = DidKeys();
      const message = 'kyron-did-claim:v1:user-1:c';

      final mine = await keys.sign(await keys.newKeyPair(), message);
      final theirs = await keys.sign(await keys.newKeyPair(), message);

      expect(mine, isNot(theirs));
    });
  });
}
