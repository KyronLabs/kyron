import { ForbiddenException } from '@nestjs/common';
import type { AuthRequest } from '../../common/types/auth-request';
import { EnforcementService, type Staff } from './enforcement.service';

/**
 * Whether staff powers need a session that passed a second factor.
 *
 * A switch rather than always on, so staff can enrol an authenticator in the
 * app before the requirement arrives; turning it on first would lock every
 * staff account out of moderation with no way back in from the app.
 */
export function secondFactorRequired(
  raw = process.env.STAFF_REQUIRE_SECOND_FACTOR,
): boolean {
  return raw?.trim().toLowerCase() === 'true';
}

/**
 * The staff member a request acts as, refused unless the session passed a
 * second factor (when [secondFactorRequired]).
 *
 * Bans, verification and the report queue are the powers worth stealing a
 * staff password for. With this, a stolen password or Google account alone
 * no longer carries them. Applied to staff only: anybody else is refused by
 * the service exactly as before, as "not found", so the rule itself does not
 * reveal that a staff route exists.
 */
export function staffFrom(
  req: AuthRequest,
  required = secondFactorRequired(),
): Staff {
  const staff: Staff = { id: req.user.id, role: req.user.role };
  if (
    required &&
    EnforcementService.isStaff(staff.role) &&
    req.aal !== 'aal2'
  ) {
    throw new ForbiddenException({
      statusCode: 403,
      code: 'STAFF_SECOND_FACTOR_REQUIRED',
      message: 'Enter the code from your authenticator app to use staff tools.',
    });
  }
  return staff;
}
