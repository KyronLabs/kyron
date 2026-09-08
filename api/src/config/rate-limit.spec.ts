import { DEFAULT_RATE_LIMIT, readRateLimit } from './rate-limit';

describe('reading the rate limit', () => {
  it('takes the number it was given', () => {
    expect(readRateLimit('250')).toBe(250);
    expect(readRateLimit(' 40 ')).toBe(40);
  });

  it('falls back only when nothing was set', () => {
    expect(readRateLimit(undefined)).toBe(DEFAULT_RATE_LIMIT);
    expect(readRateLimit('')).toBe(DEFAULT_RATE_LIMIT);
    expect(readRateLimit('   ')).toBe(DEFAULT_RATE_LIMIT);
  });

  it('refuses a value it cannot honour rather than choosing one', () => {
    // Both layers this replaces made something up: ConfigService handed the
    // plugin a string and the plugin used its own default of 1000, while the
    // config factory's `Number(x) || 100` turned anything unparseable into
    // 100. A limit silently a tenth or ten times what was asked for is worse
    // than none, because it is relied upon.
    for (const bad of ['lots', '10.5', '0', '-5', 'NaN', '1e3x']) {
      expect(() => readRateLimit(bad)).toThrow(/RATE_LIMIT_MAX/);
    }
  });

  it('says what was actually set, so the fix is obvious', () => {
    expect(() => readRateLimit('lots')).toThrow(/"lots"/);
  });

  it('accepts a number written in a form Number understands', () => {
    // 1e3 is a whole number however it is spelled, and refusing it would be
    // pedantry rather than safety.
    expect(readRateLimit('1e3')).toBe(1000);
  });
});
