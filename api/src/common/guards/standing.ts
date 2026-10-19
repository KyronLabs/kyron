import { createHash } from 'node:crypto';

import { ForbiddenException, SetMetadata } from '@nestjs/common';
import { AccountStatus } from '@prisma/client';

/**
 * What a suspended or banned account may still do.
 *
 * A suspension is read-only: every GET still answers, and nothing that
 * writes does, except what is marked here. A ban answers nothing but what is
 * marked 'banned' -- enough to see why, appeal, get the answer, contact
 * support, and leave.
 */
export const RESTRICTED_ACCESS = 'restrictedAccess';

export type RestrictedAccess = 'suspended' | 'banned';

/**
 * Lets a restricted account through to this route.
 *
 * 'suspended' is for what protects somebody rather than adds to the
 * service: reporting, blocking, muting. A suspended account being harassed
 * still needs those. 'banned' is for the few routes a banned account needs
 * to understand and answer its ban, and implies 'suspended'.
 */
export const AllowRestricted = (level: RestrictedAccess = 'banned') =>
  SetMetadata(RESTRICTED_ACCESS, level);

export interface Restriction {
  status: 'SUSPENDED' | 'BANNED';
  /** When a suspension ends. Null for a ban. */
  until: Date | null;
}

/** What is restricting this account right now, or null. */
export function restrictionOf(
  user: { status: AccountStatus; suspendedUntil?: Date | null },
  now: Date = new Date(),
): Restriction | null {
  if (user.status === AccountStatus.BANNED) {
    return { status: 'BANNED', until: null };
  }
  if (user.status === AccountStatus.SUSPENDED) {
    const until = user.suspendedUntil ?? null;
    // A suspension whose end has passed is over, whatever the column still
    // says: the guard puts it right on the way through.
    if (until !== null && until <= now) return null;
    return { status: 'SUSPENDED', until };
  }
  return null;
}

/** Whether [restriction] keeps [method] on a route marked [access] out. */
export function refuses(
  restriction: Restriction,
  method: string,
  access: RestrictedAccess | undefined,
): boolean {
  if (access === 'banned') return false;
  if (restriction.status === 'BANNED') return true;
  if (access === 'suspended') return false;
  return !['GET', 'HEAD', 'OPTIONS'].includes(method.toUpperCase());
}

/**
 * The refusal the app recognises by its code, and turns into the screen
 * that explains it rather than an error toast.
 */
export function restrictedError(restriction: Restriction): ForbiddenException {
  return new ForbiddenException({
    statusCode: 403,
    error: 'Forbidden',
    code: 'ACCOUNT_RESTRICTED',
    status: restriction.status,
    until: restriction.until?.toISOString() ?? null,
    message:
      restriction.status === 'BANNED'
        ? 'This account has been banned from Kyron. Settings > Account ' +
          'status says why, and how to appeal.'
        : 'This account is suspended, so it can read but not post, reply, ' +
          'follow or message until the suspension ends. Settings > Account ' +
          'status says why, and how to appeal.',
  });
}

/**
 * How a banned account's address is kept: hashed, lower-cased and trimmed,
 * so it can be matched against a new sign-up without being kept as itself.
 */
export function emailHash(email: string): string {
  return createHash('sha256').update(email.trim().toLowerCase()).digest('hex');
}
