import { createCipheriv, createHash, randomBytes } from 'node:crypto';

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
