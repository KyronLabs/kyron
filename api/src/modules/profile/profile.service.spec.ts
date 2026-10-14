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

describe('ProfileService.follow', () => {
  function serviceWith(target: { id: string } | null) {
    const prisma = {
      user: { findFirst: jest.fn().mockResolvedValue(target) },
      follow: { upsert: jest.fn().mockResolvedValue({}) },
    };
    const service = new ProfileService(
      {} as never,
      prisma as never,
      {} as never,
    );
    return { service, prisma };
  }

  it('refuses an account that does not exist or was deleted', async () => {
    // A deleted account keeps an empty row under its id, so the id alone is
    // not enough to follow by.
    const { service, prisma } = serviceWith(null);

    await expect(service.follow('me', 'gone')).rejects.toThrow(
      'That account does not exist.',
    );
    expect(prisma.user.findFirst).toHaveBeenCalledWith({
      where: { id: 'gone', deletedAt: null },
      select: { id: true },
    });
    expect(prisma.follow.upsert).not.toHaveBeenCalled();
  });
});
