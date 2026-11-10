import { UserRole } from '@prisma/client';
import { secondFactorRequired, staffFrom } from './staff-session';

const req = (role: UserRole, aal?: 'aal1' | 'aal2') =>
  ({ user: { id: 'u', role }, aal }) as never;

describe('staffFrom', () => {
  it('refuses staff without a second factor once required', () => {
    expect(() => staffFrom(req(UserRole.ADMIN, 'aal1'), true)).toThrow(
      expect.objectContaining({ status: 403 }),
    );
    expect(() => staffFrom(req(UserRole.MODERATOR), true)).toThrow();
  });

  it('lets staff through with one', () => {
    expect(staffFrom(req(UserRole.ADMIN, 'aal2'), true)).toEqual({
      id: 'u',
      role: UserRole.ADMIN,
    });
  });

  it('changes nothing for everybody else', () => {
    // The service refuses them, as "not found", as it always did.
    expect(staffFrom(req(UserRole.USER, 'aal1'), true)).toEqual({
      id: 'u',
      role: UserRole.USER,
    });
  });

  it('asks nothing until the switch is on', () => {
    expect(() => staffFrom(req(UserRole.ADMIN, 'aal1'), false)).not.toThrow();
    expect(secondFactorRequired(undefined)).toBe(false);
    expect(secondFactorRequired('true')).toBe(true);
  });
});
