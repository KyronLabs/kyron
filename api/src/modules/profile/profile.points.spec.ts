import { PATH_METADATA } from '@nestjs/common/constants';
import { ProfileController } from './profile.controller';
import { ProfileService } from './profile.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

/**
 * Kyron Points are gone, and these keep them gone.
 *
 * `POST /profile/kp/award` took a user id and an amount from the body and
 * checked only that the caller was signed in, so anybody could give anybody
 * any number of points, themselves included. That would have been a curiosity
 * if the number did nothing; it decided the order of people search. And the
 * programme it belonged to had already been withdrawn in public -- the README
 * says no points, token or equity agreement exists.
 *
 * The column and the event table are still in the schema. Dropping them is a
 * migration, and `scripts/start.sh` applies every migration on boot, so that is
 * a decision about production data rather than a code change. Until it is
 * made, nothing may read them into a response or write to them.
 */

const supabase = {} as unknown as SupabaseService;

/** Every path the profile controller serves, as Nest will route them. */
function routes(): string[] {
  const proto = ProfileController.prototype as unknown as Record<
    string,
    object
  >;
  return Object.getOwnPropertyNames(ProfileController.prototype)
    .filter((name) => name !== 'constructor')
    .flatMap((name) => {
      const path = Reflect.getMetadata(PATH_METADATA, proto[name]) as
        | string
        | string[]
        | undefined;
      return path === undefined ? [] : [path].flat();
    });
}

describe('Kyron Points', () => {
  it('reads the route table it means to', () => {
    // Without this an empty list would pass the next test for the wrong
    // reason: the reflection failing rather than the routes being gone.
    expect(routes()).toEqual(expect.arrayContaining(['me', 'search']));
  });

  it('have no route left to award, list or rank them', () => {
    expect(routes().filter((path) => /^\/?kp(\/|$)/.test(path))).toEqual([]);
  });

  it('are not part of a public profile', async () => {
    const findUnique = jest.fn().mockResolvedValue({
      id: 'u1',
      name: 'Ada',
      username: 'ada',
      did: null,
      profile: null,
    });
    const prisma = {
      user: { findUnique },
      follow: {
        count: jest.fn().mockResolvedValue(0),
        findFirst: jest.fn().mockResolvedValue(null),
      },
      post: { count: jest.fn().mockResolvedValue(0) },
    } as unknown as PrismaService;

    const result = await new ProfileService(
      supabase,
      prisma,
      new RecordingDelivery(),
    ).getPublicProfile('ada', 'viewer');

    expect(JSON.stringify(findUnique.mock.calls)).not.toContain('kyronPoints');
    expect(result.user).not.toHaveProperty('kyronPoints');
  });

  it('are not part of your own profile', async () => {
    const findUnique = jest.fn().mockResolvedValue({
      id: 'me',
      name: 'Me',
      username: 'me',
      did: null,
    });
    const prisma = {
      user: { findUnique },
      userProfile: {
        findUnique: jest.fn().mockResolvedValue({
          avatarUrl: null,
          coverUrl: null,
          bio: null,
          location: null,
          website: null,
        }),
      },
      follow: { count: jest.fn().mockResolvedValue(0) },
      post: { count: jest.fn().mockResolvedValue(0) },
    } as unknown as PrismaService;

    const result = await new ProfileService(
      supabase,
      prisma,
      new RecordingDelivery(),
    ).getMe('me');

    expect(JSON.stringify(findUnique.mock.calls)).not.toContain('kyronPoints');
    expect(result.user).not.toHaveProperty('kyronPoints');
  });

  it('are not part of a followers list', async () => {
    const findMany = jest.fn().mockResolvedValue([
      {
        id: 'f1',
        follower: {
          id: 'a',
          name: 'A',
          username: 'a',
          did: null,
          profile: null,
          _count: { followers: 3 },
        },
        following: null,
      },
    ]);
    const prisma = {
      user: { findFirst: jest.fn().mockResolvedValue({ id: 'u1' }) },
      follow: { findMany },
    } as unknown as PrismaService;

    const { items } = await new ProfileService(
      supabase,
      prisma,
      new RecordingDelivery(),
    ).listFollows('u1', 'followers', 'viewer');

    expect(JSON.stringify(findMany.mock.calls)).not.toContain('kyronPoints');
    expect(items[0]).not.toHaveProperty('kyronPoints');
  });
});
