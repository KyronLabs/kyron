import { ProfileService } from './profile.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import {
  RESERVED_HANDLES,
  handleProblem,
  normaliseHandle,
} from '../../common/handles';

/**
 * Choosing a handle. Accounts made through Google never had one, because
 * Google sends no username, and neither did an email sign-up that left the
 * box empty or asked for a handle already taken -- and there was no way to
 * set one afterwards.
 */

const supabase = {} as unknown as SupabaseService;

function serviceWith({
  mine = null,
  holder = null,
  updated = 1,
  updateError,
}: {
  mine?: string | null;
  holder?: { id: string } | null;
  updated?: number;
  updateError?: Error;
} = {}) {
  const findFirst = jest
    .fn<Promise<{ id: string } | null>, [unknown]>()
    .mockResolvedValue(holder);
  const updateMany = jest.fn<Promise<{ count: number }>, [unknown]>(() =>
    updateError
      ? Promise.reject(updateError)
      : Promise.resolve({ count: updated }),
  );
  const prisma = {
    user: {
      findFirst,
      findUnique: jest.fn(() => Promise.resolve({ username: mine })),
      updateMany,
    },
  } as unknown as PrismaService;
  return {
    service: new ProfileService(supabase, prisma, new RecordingDelivery()),
    findFirst,
    updateMany,
  };
}

describe('what a handle may be', () => {
  it('is stored as typed, less the @ and any capitals', () => {
    expect(normaliseHandle('  @Ada_Birds ')).toBe('ada_birds');
  });

  it.each(['a', 'has space', 'dash-ed', 'dot.ted', 'émile', 'x'.repeat(31)])(
    'is not %p',
    (handle) => {
      expect(handleProblem(normaliseHandle(handle))).toBe('format');
    },
  );

  it('is never a path under /profile, or Kyron speaking', () => {
    // GET /profile/:username matches one segment, so an account called
    // "suggested" would have a profile nobody could open.
    for (const handle of ['suggested', 'interests', 'me', 'kyron', 'admin']) {
      expect(RESERVED_HANDLES.has(handle)).toBe(true);
      expect(handleProblem(handle)).toBe('reserved');
    }
  });
});

describe('ProfileService.handleAvailability', () => {
  it('says a free handle is free', async () => {
    const { service } = serviceWith();
    await expect(
      service.handleAvailability('me', '@Birdwatcher'),
    ).resolves.toEqual({ handle: 'birdwatcher', available: true });
  });

  it('says a taken one is taken, whatever its case', async () => {
    const { service, findFirst } = serviceWith({ holder: { id: 'other' } });
    await expect(
      service.handleAvailability('me', 'Birdwatcher'),
    ).resolves.toMatchObject({ available: false, reason: 'taken' });

    const [args] = findFirst.mock.calls[0] as [
      { where: { username: { mode: string }; NOT: { id: string } } },
    ];
    expect(args.where.username.mode).toBe('insensitive');
    // Its own handle is not "taken" from the account that holds it.
    expect(args.where.NOT).toEqual({ id: 'me' });
  });

  it('gives the reason without asking the database', async () => {
    const { service, findFirst } = serviceWith();
    await expect(
      service.handleAvailability('me', 'support'),
    ).resolves.toMatchObject({ available: false, reason: 'reserved' });
    expect(findFirst).not.toHaveBeenCalled();
  });
});

describe('ProfileService.chooseHandle', () => {
  it('gives an account with none the one it chose', async () => {
    const { service, updateMany } = serviceWith();
    await expect(service.chooseHandle('me', '@Yunnie')).resolves.toEqual({
      username: 'yunnie',
    });
    expect(updateMany).toHaveBeenCalledWith({
      where: { id: 'me', username: null },
      data: { username: 'yunnie' },
    });
  });

  it('refuses a taken one', async () => {
    const { service, updateMany } = serviceWith({ holder: { id: 'other' } });
    await expect(service.chooseHandle('me', 'gremlin')).rejects.toMatchObject({
      status: 409,
    });
    expect(updateMany).not.toHaveBeenCalled();
  });

  it('refuses one that breaks the rule, saying what the rule is', async () => {
    const { service } = serviceWith();
    await expect(service.chooseHandle('me', 'no spaces')).rejects.toMatchObject(
      { status: 400, message: expect.stringContaining('lowercase') as string },
    );
  });

  it('is once only', async () => {
    const { service, updateMany } = serviceWith({ mine: 'ada' });
    await expect(service.chooseHandle('me', 'ada2')).rejects.toMatchObject({
      status: 409,
    });
    expect(updateMany).not.toHaveBeenCalled();
  });

  it('answers a repeat of the same choice as done, not as an error', async () => {
    // A retry after a dropped response must not tell somebody they failed.
    const { service } = serviceWith({ mine: 'ada' });
    await expect(service.chooseHandle('me', 'Ada')).resolves.toEqual({
      username: 'ada',
    });
  });

  it('loses to a handle filled in at the same moment, and says so', async () => {
    const { service } = serviceWith({ updated: 0 });
    await expect(service.chooseHandle('me', 'ada')).rejects.toMatchObject({
      status: 409,
    });
  });

  it('turns two people asking at once into "taken", not a 500', async () => {
    const { service } = serviceWith({
      // What Prisma throws for the unique index.
      updateError: Object.assign(new Error('Unique constraint failed'), {
        code: 'P2002',
      }),
    });
    await expect(service.chooseHandle('me', 'ada')).rejects.toMatchObject({
      status: 409,
    });
  });
});
