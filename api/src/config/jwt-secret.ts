/**
 * Single source of truth for the JWT signing/verification secret.
 *
 * Every sign and verify site must go through this function. Reading
 * `process.env.JWT_SECRET` ad hoc is what let a since-deleted passport
 * strategy fall back to a hardcoded literal while the signers had no fallback
 * at all: with JWT_SECRET unset, the API would have accepted any token minted
 * with a string published in this repository.
 */
export function getJwtSecret(): string {
  const secret = process.env.JWT_SECRET?.trim();

  if (!secret) {
    throw new Error(
      'JWT_SECRET is not set. Refusing to start: an unset signing secret ' +
        'previously caused the token verifier to accept a guessable fallback. ' +
        'Set JWT_SECRET to a high-entropy random value (see api/.env.example).',
    );
  }

  // Warn rather than throw: an short-but-real secret is still honoured so a
  // running deployment is never taken down by this check alone.
  if (secret.length < 32) {
    console.warn(
      `[security] JWT_SECRET is only ${secret.length} characters. Use at ` +
        'least 32 (openssl rand -base64 48) — short secrets are brute-forceable.',
    );
  }

  return secret;
}
