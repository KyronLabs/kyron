import { ProfileService } from './profile.service';

describe('ProfileService.isUuid', () => {
  // A profile is addressed by handle or by account id on the same route.
  // Not every account has a handle -- one is only set during onboarding --
  // and requiring one made every account without one unreachable: search
  // results, followers and following all had nothing to open them by.
  it('recognises an account id', () => {
    expect(ProfileService.isUuid('8039e182-78d0-49c6-89bb-8d0009b8fee2')).toBe(
      true,
    );
  });

  it('is case insensitive, as ids are written both ways', () => {
    expect(ProfileService.isUuid('8039E182-78D0-49C6-89BB-8D0009B8FEE2')).toBe(
      true,
    );
  });

  it('does not mistake a handle for one', () => {
    for (const handle of [
      'epigone',
      'me',
      'interests',
      '8039e182',
      '8039e182-78d0-49c6-89bb',
      '8039e182-78d0-49c6-89bb-8d0009b8fee2-extra',
      'zzzzzzzz-78d0-49c6-89bb-8d0009b8fee2',
      '',
    ]) {
      expect(ProfileService.isUuid(handle)).toBe(false);
    }
  });
});
