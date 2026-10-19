import { AccountStatus } from '@prisma/client';

import { emailHash, refuses, restrictedError, restrictionOf } from './standing';

const now = new Date('2026-10-19T12:00:00Z');
const later = new Date('2026-10-26T12:00:00Z');
const earlier = new Date('2026-10-12T12:00:00Z');

describe('what restricts an account', () => {
  it('nothing, for an ordinary one', () => {
    expect(restrictionOf({ status: AccountStatus.ACTIVE }, now)).toBeNull();
  });

  it('a ban, with no end', () => {
    expect(restrictionOf({ status: AccountStatus.BANNED }, now)).toEqual({
      status: 'BANNED',
      until: null,
    });
  });

  it('a suspension, until it ends', () => {
    expect(
      restrictionOf(
        { status: AccountStatus.SUSPENDED, suspendedUntil: later },
        now,
      ),
    ).toEqual({ status: 'SUSPENDED', until: later });
  });

  it('nothing once a suspension has run out, whatever the column says', () => {
    // The guard puts the row right on the way through; until then the
    // account must not be held to a suspension that is over.
    expect(
      restrictionOf(
        { status: AccountStatus.SUSPENDED, suspendedUntil: earlier },
        now,
      ),
    ).toBeNull();
  });
});

describe('what a restricted account may still do', () => {
  const suspended = { status: 'SUSPENDED' as const, until: later };
  const banned = { status: 'BANNED' as const, until: null };

  it('a suspension is read-only', () => {
    expect(refuses(suspended, 'GET', undefined)).toBe(false);
    expect(refuses(suspended, 'POST', undefined)).toBe(true);
    expect(refuses(suspended, 'PUT', undefined)).toBe(true);
    expect(refuses(suspended, 'DELETE', undefined)).toBe(true);
  });

  it('but can still report, block and mute', () => {
    expect(refuses(suspended, 'POST', 'suspended')).toBe(false);
  });

  it('a ban reaches only what is opened to it', () => {
    expect(refuses(banned, 'GET', undefined)).toBe(true);
    expect(refuses(banned, 'POST', 'suspended')).toBe(true);
    expect(refuses(banned, 'GET', 'banned')).toBe(false);
    expect(refuses(banned, 'POST', 'banned')).toBe(false);
  });
});

describe('the refusal', () => {
  it('carries a code the app can recognise, and the end', () => {
    const body = restrictedError({
      status: 'SUSPENDED',
      until: later,
    }).getResponse();
    expect(body).toMatchObject({
      statusCode: 403,
      code: 'ACCOUNT_RESTRICTED',
      status: 'SUSPENDED',
      until: later.toISOString(),
    });
  });
});

describe('a banned address', () => {
  it('matches however it is typed', () => {
    expect(emailHash(' Ada@Example.TEST ')).toBe(emailHash('ada@example.test'));
  });

  it('is not kept as itself', () => {
    expect(emailHash('ada@example.test')).not.toContain('ada');
    expect(emailHash('ada@example.test')).toMatch(/^[0-9a-f]{64}$/);
  });
});
