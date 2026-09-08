import { createPublicKey, verify as verifySignature } from 'node:crypto';

/**
 * `did:key` for Ed25519, and the arithmetic to check one.
 *
 * A DID that anybody can put on their profile is decoration. This is the part
 * that makes it mean something: the identifier *is* a public key, so proving
 * you hold the matching secret proves the identifier is yours, and anyone can
 * check that without asking Kyron anything. No registry, no network, nothing
 * to trust.
 *
 * The method is `did:key` rather than `did:plc` or `did:web` because those
 * need something else to exist first -- a PLC directory, a domain you control
 * and serve JSON from. This one is self-contained, which is what makes it
 * buildable today rather than a column nobody writes to.
 *
 * Kept as pure functions with no Nest in them, because the failure mode of
 * getting this wrong is accepting somebody else's identifier as your own.
 */

/** Multicodec for an Ed25519 public key: varint 0xed. */
const ED25519_MULTICODEC = Uint8Array.from([0xed, 0x01]);

/** Raw Ed25519 public keys are this long, always. */
const PUBLIC_KEY_BYTES = 32;

/** And signatures this long. */
export const SIGNATURE_BYTES = 64;

/**
 * The DER that wraps a raw Ed25519 public key as SubjectPublicKeyInfo.
 *
 * Node will not take 32 loose bytes; it wants the structure around them. The
 * bytes are fixed for this one algorithm: SEQUENCE(42) { SEQUENCE(5) {
 * OID 1.3.101.112 } BIT STRING(33, 0 unused) }.
 */
const SPKI_PREFIX = Buffer.from('302a300506032b6570032100', 'hex');

const BASE58_ALPHABET =
  '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

/**
 * Decodes base58btc.
 *
 * Written out rather than pulled in: it is thirty lines, it is on the path
 * that decides whether an identity claim is accepted, and a dependency here
 * would be one nobody in this repository has read.
 */
export function decodeBase58(input: string): Uint8Array | null {
  if (input.length === 0) return null;

  const bytes: number[] = [0];
  for (const character of input) {
    const value = BASE58_ALPHABET.indexOf(character);
    if (value === -1) return null;

    let carry = value;
    for (let i = 0; i < bytes.length; i++) {
      carry += bytes[i] * 58;
      bytes[i] = carry & 0xff;
      carry >>= 8;
    }
    while (carry > 0) {
      bytes.push(carry & 0xff);
      carry >>= 8;
    }
  }

  // The accumulator starts at a single zero byte, which for an all-zero value
  // is never displaced -- and would then be counted again by the leading
  // zeros below, so decode('1') answered two bytes rather than one. A
  // canonical base58 number has no zero as its most significant byte, so
  // anything left here is that same padding.
  while (bytes.length > 0 && bytes[bytes.length - 1] === 0) bytes.pop();

  // A leading '1' is a leading zero byte, and base58 cannot represent it any
  // other way. Dropping them silently changes the key.
  for (let i = 0; i < input.length && input[i] === '1'; i++) bytes.push(0);

  return Uint8Array.from(bytes.reverse());
}

/** Encodes base58btc. The inverse of [decodeBase58]; used by the tests. */
export function encodeBase58(input: Uint8Array): string {
  const digits: number[] = [0];
  for (const byte of input) {
    let carry = byte;
    for (let i = 0; i < digits.length; i++) {
      carry += digits[i] << 8;
      digits[i] = carry % 58;
      carry = (carry / 58) | 0;
    }
    while (carry > 0) {
      digits.push(carry % 58);
      carry = (carry / 58) | 0;
    }
  }

  // The accumulator starts at a single zero digit, and for an all-zero input
  // nothing displaces it -- so it would be written out as a '1' on top of the
  // leading '1's below, and encode(0) came back as "11".
  while (digits.length > 1 && digits[digits.length - 1] === 0) digits.pop();
  const significant =
    digits.length === 1 && digits[0] === 0 ? [] : digits.reverse();

  let leading = '';
  for (let i = 0; i < input.length && input[i] === 0; i++) leading += '1';

  return leading + significant.map((digit) => BASE58_ALPHABET[digit]).join('');
}

/**
 * The public key inside a `did:key`, or null when it is not one we can read.
 *
 * Null rather than a throw for every rejection, and deliberately without
 * saying which check failed: this runs on a value a stranger supplies, and
 * the difference between "wrong prefix" and "wrong length" is not information
 * they need.
 */
export function publicKeyFromDid(did: string): Uint8Array | null {
  if (typeof did !== 'string') return null;

  const prefix = 'did:key:z';
  if (!did.startsWith(prefix)) return null;

  const decoded = decodeBase58(did.slice(prefix.length));
  if (!decoded) return null;
  if (decoded.length !== ED25519_MULTICODEC.length + PUBLIC_KEY_BYTES) {
    return null;
  }

  // The multicodec is what says this is Ed25519 rather than one of the other
  // key types did:key covers. Accepting a did:key of another type and then
  // verifying it as Ed25519 is how a check becomes a formality.
  for (let i = 0; i < ED25519_MULTICODEC.length; i++) {
    if (decoded[i] !== ED25519_MULTICODEC[i]) return null;
  }

  return decoded.slice(ED25519_MULTICODEC.length);
}

/** Builds the `did:key` for a raw Ed25519 public key. */
export function didFromPublicKey(publicKey: Uint8Array): string {
  if (publicKey.length !== PUBLIC_KEY_BYTES) {
    throw new Error(
      `An Ed25519 public key is ${PUBLIC_KEY_BYTES} bytes, not ${publicKey.length}.`,
    );
  }
  const multicodec = new Uint8Array(
    ED25519_MULTICODEC.length + publicKey.length,
  );
  multicodec.set(ED25519_MULTICODEC, 0);
  multicodec.set(publicKey, ED25519_MULTICODEC.length);
  return `did:key:z${encodeBase58(multicodec)}`;
}

/**
 * Whether [signature] over [message] was made by the key [did] names.
 *
 * False for anything malformed as well as anything wrong. Every failure here
 * is the same answer to the caller -- an identity claim is either proved or
 * it is not, and a claimant learning *why* their forgery was rejected is a
 * claimant being helped.
 */
export function verifyDidSignature(
  did: string,
  message: Uint8Array,
  signature: Uint8Array,
): boolean {
  const publicKey = publicKeyFromDid(did);
  if (!publicKey) return false;
  if (signature.length !== SIGNATURE_BYTES) return false;

  try {
    const key = createPublicKey({
      key: Buffer.concat([SPKI_PREFIX, Buffer.from(publicKey)]),
      format: 'der',
      type: 'spki',
    });
    // Ed25519 takes no separate digest: the algorithm hashes internally, and
    // passing one anyway is an error rather than a stronger check.
    return verifySignature(null, message, key, signature);
  } catch {
    return false;
  }
}
