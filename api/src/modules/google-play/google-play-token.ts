import {
  createCipheriv,
  createDecipheriv,
  createHash,
  randomBytes,
} from 'node:crypto';

const TOKEN_PREFIX = 'v1';

export function tokenHash(token: string): string {
  return createHash('sha256').update(token, 'utf8').digest('hex');
}

export function encryptionKey(): Buffer | null {
  const raw = process.env.GOOGLE_PLAY_TOKEN_ENCRYPTION_KEY;
  if (!raw || !/^[A-Za-z0-9+/]+={0,2}$/.test(raw)) return null;
  const decoded = Buffer.from(raw, 'base64');
  if (
    decoded.length !== 32 ||
    decoded.toString('base64').replace(/=+$/, '') !== raw.replace(/=+$/, '')
  ) {
    return null;
  }
  return decoded;
}

export function encryptPurchaseToken(token: string, key: Buffer): string {
  const nonce = randomBytes(12);
  const cipher = createCipheriv('aes-256-gcm', key, nonce);
  const ciphertext = Buffer.concat([
    cipher.update(token, 'utf8'),
    cipher.final(),
  ]);
  const tag = cipher.getAuthTag();
  return [
    TOKEN_PREFIX,
    nonce.toString('base64url'),
    tag.toString('base64url'),
    ciphertext.toString('base64url'),
  ].join('.');
}

/** Decode only the authenticated envelope written by encryptPurchaseToken. */
export function decryptPurchaseToken(encrypted: string, key: Buffer): string {
  try {
    const [version, nonce, tag, ciphertext, extra] = encrypted.split('.');
    if (
      version !== TOKEN_PREFIX ||
      extra !== undefined ||
      !nonce ||
      !tag ||
      !ciphertext ||
      encrypted.length > 8192
    ) {
      throw new Error('Invalid token envelope.');
    }
    const parts = [nonce, tag, ciphertext].map((part) => {
      const bytes = Buffer.from(part, 'base64url');
      if (bytes.toString('base64url') !== part) {
        throw new Error('Invalid token encoding.');
      }
      return bytes;
    });
    if (parts[0].length !== 12 || parts[1].length !== 16) {
      throw new Error('Invalid token envelope.');
    }
    const decipher = createDecipheriv('aes-256-gcm', key, parts[0]);
    decipher.setAuthTag(parts[1]);
    const token = new TextDecoder('utf-8', { fatal: true }).decode(
      Buffer.concat([decipher.update(parts[2]), decipher.final()]),
    );
    if (!token || token.length > 4096) {
      throw new Error('Invalid token length.');
    }
    return token;
  } catch {
    throw new Error('Google Play token could not be decrypted.');
  }
}
