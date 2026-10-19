import { ProfileService } from './profile.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

const supabase = {} as unknown as SupabaseService;

function person(id: string, followers: number) {
  return {
    id,
    name: id,
    username: id,
    did: null,
    profile: { avatarUrl: null, bio: null },
    _count: { followers },
  };
}

type Person = ReturnType<typeof person>;

describe('ProfileService.searchProfiles', () => {
  function serviceWith(options: { exact?: Person | null; ranked?: Person[] }) {
    const findFirst = jest
      .fn<Promise<Person | null>, [unknown]>()
      .mockResolvedValue(options.exact ?? null);
    const findMany = jest
      .fn<Promise<Person[]>, [unknown]>()
      .mockResolvedValue(options.ranked ?? []);
    const prisma = {
      user: { findFirst, findMany },
    } as unknown as PrismaService;
    return {
      service: new ProfileService(supabase, prisma, new RecordingDelivery()),
      findFirst,
      findMany,
    };
  }

  it('ranks by how many people follow each match', async () => {
    const { service, findMany } = serviceWith({});
    await service.searchProfiles('ada', 'me');

    const { orderBy } = findMany.mock.calls[0][0] as { orderBy: unknown };
    expect(orderBy).toEqual([
      { followers: { _count: 'desc' } },
      { username: 'asc' },
    ]);
  });

  it('can no longer be bought with points', async () => {
    // The order used to be kyronPoints, which anyone could award themselves.
    const { service, findMany, findFirst } = serviceWith({});
    await service.searchProfiles('ada', 'me');

    expect(JSON.stringify(findMany.mock.calls)).not.toContain('kyronPoints');
    expect(JSON.stringify(findFirst.mock.calls)).not.toContain('kyronPoints');
  });

  it('puts an exact handle first, even one the page had no room for', async () => {
    // A full page of better-followed near-misses: the account somebody typed
    // out in full is not on it at all.
    const { service } = serviceWith({
      exact: person('ada', 1),
      ranked: [person('ada_fans', 900), person('adam', 400)],
    });

    const { items } = await service.searchProfiles('ada', 'me', 2);
    expect(items.map((p) => p.id)).toEqual(['ada', 'ada_fans']);
  });

  it('does not list the exact handle twice', async () => {
    const ada = person('ada', 50);
    const { service } = serviceWith({
      exact: ada,
      ranked: [person('adam', 400), ada, person('adaline', 2)],
    });

    const { items } = await service.searchProfiles('ada', 'me');
    expect(items.map((p) => p.id)).toEqual(['ada', 'adam', 'adaline']);
  });

  it('matches the handle whatever its case, and never yours or a deleted one', async () => {
    const { service, findFirst, findMany } = serviceWith({});
    await service.searchProfiles('  Ada ', 'me');

    for (const call of [findFirst, findMany]) {
      const { where } = call.mock.calls[0][0] as {
        where: { id: unknown; deletedAt: unknown };
      };
      expect(where.id).toEqual({ not: 'me' });
      expect(where.deletedAt).toBeNull();
    }
    const { where } = findFirst.mock.calls[0][0] as {
      where: { username: unknown };
    };
    expect(where.username).toEqual({ equals: 'Ada', mode: 'insensitive' });
  });

  it('keeps the order the database gave when nothing matches exactly', async () => {
    const { service } = serviceWith({
      ranked: [person('b', 9), person('a', 3)],
    });
    const { items } = await service.searchProfiles('xy', 'me');
    expect(items.map((p) => p.id)).toEqual(['b', 'a']);
    expect(items[0]).toEqual({
      id: 'b',
      name: 'b',
      username: 'b',
      did: null,
      avatarUrl: null,
      verified: false,
      bio: null,
      followers: 9,
    });
  });

  it('asks nothing of the database for a query too short to mean anything', async () => {
    const { service, findFirst, findMany } = serviceWith({});
    expect(await service.searchProfiles(' a ', 'me')).toEqual({ items: [] });
    expect(findFirst).not.toHaveBeenCalled();
    expect(findMany).not.toHaveBeenCalled();
  });
});
