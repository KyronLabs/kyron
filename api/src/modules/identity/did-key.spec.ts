import { generateKeyPairSync, sign as signMessage } from 'node:crypto';
import {
  decodeBase58,
  didFromPublicKey,
  encodeBase58,
  publicKeyFromDid,
  verifyDidSignature,
} from './did-key';

/** A real Ed25519 pair, and the DID for it. */
function identity() {
  const { publicKey, privateKey } = generateKeyPairSync('ed25519');
  // The raw 32 bytes are the last of the SPKI DER.
  const raw = publicKey.export({ format: 'der', type: 'spki' }).subarray(-32);
  return {
    did: didFromPublicKey(raw),
    sign: (message: Buffer) => signMessage(null, message, privateKey),
  };
}

describe('base58btc', () => {
  it('round-trips', () => {
    for (const bytes of [
      Uint8Array.from([1, 2, 3]),
      Uint8Array.from([255, 255, 255, 255]),
      Uint8Array.from(Array.from({ length: 34 }, (_, i) => i * 7)),
    ]) {
      expect(decodeBase58(encodeBase58(bytes))).toEqual(bytes);
    }
  });

  it('keeps leading zero bytes, which base58 hides', () => {
    // A leading zero is a leading '1' and nothing else; dropping them changes
    // the key silently rather than failing.
    const bytes = Uint8Array.from([0, 0, 9, 9]);

    const text = encodeBase58(bytes);

    expect(text.startsWith('11')).toBe(true);
    expect(decodeBase58(text)).toEqual(bytes);
  });

  it('writes zero as a single 1, not two', () => {
    // The accumulator starts at one zero digit, and for an all-zero input
    // nothing displaces it -- so it was written out on top of the leading
    // '1's and encode(0) came back as "11". No real Ed25519 key is all
    // zeroes, which is exactly why this would have sat there.
    expect(encodeBase58(Uint8Array.from([0]))).toBe('1');
    expect(encodeBase58(Uint8Array.from([0, 0]))).toBe('11');
    expect(decodeBase58('1')).toEqual(Uint8Array.from([0]));
  });

  it('matches the vectors base58 is specified by', () => {
    expect(encodeBase58(Uint8Array.from(Buffer.from('Hello World!')))).toBe(
      '2NEpo7TZRRrLZSi2U',
    );
    expect(
      encodeBase58(Uint8Array.from([0x00, 0x00, 0x28, 0x7f, 0xb4, 0xcd])),
    ).toBe('11233QC4');
  });

  it('refuses characters that are not in the alphabet', () => {
    // 0, O, I and l are left out of base58 precisely because they are read
    // wrongly; accepting them would decode to something the writer did not
    // mean.
    for (const bad of ['0', 'O', 'I', 'l', 'hello world', '+/=']) {
      expect(decodeBase58(bad)).toBeNull();
    }
    expect(decodeBase58('')).toBeNull();
  });
});

describe('did:key', () => {
  it('round-trips a real key', () => {
    const me = identity();

    expect(me.did.startsWith('did:key:z6Mk')).toBe(true);
    expect(publicKeyFromDid(me.did)).toHaveLength(32);
  });

  it('reads the published test vector', () => {
    // From the did:key specification, so this is checked against somebody
    // else's arithmetic rather than only against its own.
    const did = 'did:key:z6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK';

    const key = publicKeyFromDid(did);

    expect(key).not.toBeNull();
    expect(didFromPublicKey(key!)).toBe(did);
  });

  it('refuses a did:key that is not Ed25519', () => {
    // did:key covers several key types. Reading one of the others and then
    // verifying it as Ed25519 is how a check becomes a formality -- the
    // multicodec prefix is the only thing that says which it is.
    const secp256k1 =
      'did:key:zQ3shokFTS3brHcDQrn82RUDfCZESWL1ZdCEJwekUDPQiYBme';

    expect(publicKeyFromDid(secp256k1)).toBeNull();
  });

  it('refuses anything that is not a did:key at all', () => {
    for (const bad of [
      '',
      'did:plc:abcdef',
      'did:web:example.com',
      'did:key:6MkhaXgBZDvotDkL5257faiztiGiC2QtKLGpbnnEGta2doK', // no multibase 'z'
      'did:key:z!!!',
      'did:key:z6Mkh', // too short once decoded
    ]) {
      expect(publicKeyFromDid(bad)).toBeNull();
    }
  });

  it('will not build one from the wrong number of bytes', () => {
    expect(() => didFromPublicKey(Uint8Array.from([1, 2, 3]))).toThrow();
  });
});

describe('proving a DID', () => {
  const challenge = Buffer.from('kyron-identity-challenge-0123456789');

  it('accepts a signature by the key the DID names', () => {
    const me = identity();

    expect(verifyDidSignature(me.did, challenge, me.sign(challenge))).toBe(
      true,
    );
  });

  it('refuses another key signing the same challenge', () => {
    // The whole point: anyone can claim any identifier, so the claim is worth
    // nothing without this.
    const me = identity();
    const impostor = identity();

    expect(
      verifyDidSignature(me.did, challenge, impostor.sign(challenge)),
    ).toBe(false);
  });

  it('refuses a good signature over a different message', () => {
    // Otherwise a signature captured anywhere else could be replayed here.
    const me = identity();
    const elsewhere = Buffer.from('some other message entirely');

    expect(verifyDidSignature(me.did, challenge, me.sign(elsewhere))).toBe(
      false,
    );
  });

  it('refuses a tampered signature', () => {
    const me = identity();
    const signature = me.sign(challenge);
    signature[0] ^= 0xff;

    expect(verifyDidSignature(me.did, challenge, signature)).toBe(false);
  });

  it('refuses a signature of the wrong length rather than trying it', () => {
    const me = identity();

    expect(verifyDidSignature(me.did, challenge, Buffer.alloc(0))).toBe(false);
    expect(verifyDidSignature(me.did, challenge, Buffer.alloc(63))).toBe(false);
    expect(verifyDidSignature(me.did, challenge, Buffer.alloc(65))).toBe(false);
  });

  it('refuses everything when the DID is malformed', () => {
    const me = identity();

    expect(
      verifyDidSignature('did:web:kyron.so', challenge, me.sign(challenge)),
    ).toBe(false);
  });
});
