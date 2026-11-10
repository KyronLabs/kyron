import {
  BucketChooser,
  corsOrigins,
  DEFAULT_PRODUCTION_ORIGINS,
  limitForBucket,
  readTrustedHops,
  SUBJECTS_PER_ADDRESS,
} from './rate-limit';

describe('BucketChooser', () => {
  it('counts a signed-in caller by account and an anonymous one by address', () => {
    const chooser = new BucketChooser();
    expect(chooser.bucketFor('1.1.1.1', 'ada')).toBe('user:ada');
    expect(chooser.bucketFor('1.1.1.1', null)).toBe('ip:1.1.1.1');
  });

  it('stops believing an address that claims to be everybody', () => {
    const chooser = new BucketChooser();
    for (let i = 0; i < SUBJECTS_PER_ADDRESS; i++) {
      expect(chooser.bucketFor('6.6.6.6', `forged${i}`)).toBe(
        `user:forged${i}`,
      );
    }
    // The next invention lands in one shared bucket, however many follow.
    expect(chooser.bucketFor('6.6.6.6', 'another')).toBe('crowd:6.6.6.6');
    expect(chooser.bucketFor('6.6.6.6', 'and-another')).toBe('crowd:6.6.6.6');
    // An account already seen there keeps its own, and another address is
    // not affected.
    expect(chooser.bucketFor('6.6.6.6', 'forged3')).toBe('user:forged3');
    expect(chooser.bucketFor('7.7.7.7', 'another')).toBe('user:another');
    expect(limitForBucket('crowd:6.6.6.6', 100)).toBe(20000);
    expect(limitForBucket('user:ada', 100)).toBe(100);
  });

  it('forgets with the window', () => {
    let now = 1_000_000;
    const chooser = new BucketChooser(60_000, () => now);
    for (let i = 0; i <= SUBJECTS_PER_ADDRESS; i++) {
      chooser.bucketFor('6.6.6.6', `s${i}`);
    }
    now += 60_000;
    expect(chooser.bucketFor('6.6.6.6', 'fresh')).toBe('user:fresh');
  });
});

describe('readTrustedHops', () => {
  it('trusts nothing unless told to', () => {
    expect(readTrustedHops(undefined)).toBe(0);
    expect(readTrustedHops('1')).toBe(1);
    expect(() => readTrustedHops('true')).toThrow(/whole number/);
    expect(() => readTrustedHops('40')).toThrow(/whole number/);
  });
});

describe('corsOrigins', () => {
  it('uses the list when there is one', () => {
    expect(
      corsOrigins('https://a.example, https://b.example', 'production'),
    ).toEqual(['https://a.example', 'https://b.example']);
  });

  it('never reflects in production', () => {
    expect(corsOrigins(undefined, 'production')).toEqual(
      DEFAULT_PRODUCTION_ORIGINS,
    );
    expect(corsOrigins('  ', 'production')).toEqual(DEFAULT_PRODUCTION_ORIGINS);
  });

  it('reflects in development', () => {
    expect(corsOrigins(undefined, 'development')).toBe(true);
  });
});
