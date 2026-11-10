import { requireRecentSignIn, signedInAt } from './recent-sign-in';

const now = Date.UTC(2026, 10, 10, 12);
const secs = now / 1000;

describe('signedInAt', () => {
  it('reads the latest sign-in from amr, not iat', () => {
    expect(
      signedInAt({
        sub: 'u',
        iat: secs,
        amr: [
          { method: 'password', timestamp: secs - 4000 },
          { method: 'otp', timestamp: secs - 100 },
        ],
      } as never),
    ).toBe(secs - 100);
  });

  it('knows nothing from a token without amr', () => {
    expect(signedInAt({ sub: 'u', iat: secs } as never)).toBeNull();
  });
});

describe('requireRecentSignIn', () => {
  it('lets a sign-in from a few minutes ago through', () => {
    expect(() => requireRecentSignIn(secs - 300, now)).not.toThrow();
  });

  it('refuses one from yesterday, with a code the app can act on', () => {
    let thrown: unknown;
    try {
      requireRecentSignIn(secs - 86_400, now);
    } catch (error) {
      thrown = error;
    }
    expect(
      (thrown as { getResponse(): { code: string } }).getResponse().code,
    ).toBe('RECENT_SIGN_IN_REQUIRED');
  });

  it('refuses when there is no sign-in time at all', () => {
    expect(() => requireRecentSignIn(null, now)).toThrow();
  });
});
