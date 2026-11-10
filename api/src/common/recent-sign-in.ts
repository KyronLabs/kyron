import { ForbiddenException } from '@nestjs/common';
import type { SupabaseClaims } from '../modules/auth/supabase-token.service';

/** How long a sign-in counts as recent enough to delete an account with. */
export const RECENT_SIGN_IN_SECONDS = 15 * 60;

/**
 * When the person behind a token last proved who they are, in seconds.
 *
 * Not `iat`: that is when this access token was minted, and the app mints a
 * new one every hour from the refresh token without anybody typing anything.
 * Supabase records the sign-in itself in `amr`, one entry per method, and
 * carries it unchanged through every refresh.
 */
export function signedInAt(claims: SupabaseClaims): number | null {
  const amr = (claims as { amr?: unknown }).amr;
  if (!Array.isArray(amr)) return null;
  let latest: number | null = null;
  for (const entry of amr) {
    const at = (entry as { timestamp?: unknown } | null)?.timestamp;
    if (typeof at === 'number' && Number.isFinite(at)) {
      latest = latest === null ? at : Math.max(latest, at);
    }
  }
  return latest;
}

/**
 * Refuses unless the sign-in behind this request is recent.
 *
 * For what cannot be undone. A phone left unlocked, or a stolen refresh
 * token, holds a session that works for weeks; neither should be enough to
 * delete the account. The app answers the code by asking the person to sign
 * in again and trying once more.
 */
export function requireRecentSignIn(
  signedIn: number | null | undefined,
  now = Date.now(),
): void {
  const fresh =
    typeof signedIn === 'number' &&
    now / 1000 - signedIn <= RECENT_SIGN_IN_SECONDS &&
    signedIn <= now / 1000 + 60;
  if (!fresh) {
    throw new ForbiddenException({
      statusCode: 403,
      code: 'RECENT_SIGN_IN_REQUIRED',
      message: 'Sign in again to confirm it is you, then try once more.',
    });
  }
}
