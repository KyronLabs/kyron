import { AuthGuard } from './auth.guard';
import type { SupabaseClaims } from '@/modules/auth/supabase-token.service';

/**
 * The handle and the backfill, reached through the private method the guard
 * uses. Everything else about the guard needs a live token and is covered by
 * the token service's own spec.
 */
interface Guard {
  resolveSupabaseUser(claims: SupabaseClaims): Promise<{
    id: string;
    name: string | null;
    username: string | null;
  }>;
}

interface Row {
  id: string;
  name: string | null;
  username: string | null;
}

function guardWith(
  existing: Row | null,
  updateFails = false,
  /** Handles somebody else already holds, so `create` rejects on them. */
  taken: string[] = [],
  /** Rejects every create, whatever it asks for. */
  createAlwaysFails = false,
) {
  const updates: unknown[] = [];
  const creates: unknown[] = [];
  const prisma = {
    // No banned addresses unless a test says otherwise.
    bannedIdentity: { findUnique: jest.fn().mockResolvedValue(null) },
    moderationAction: {
      findUnique: jest.fn().mockResolvedValue(null),
      create: jest.fn().mockResolvedValue({}),
    },
    user: {
      findUnique: jest.fn().mockResolvedValue(existing),
      findFirst: jest.fn().mockResolvedValue(null),
      create: jest.fn((args: { data: Row }) => {
        creates.push(args.data);
        if (createAlwaysFails) {
          return Promise.reject(new Error('unique constraint: email'));
        }
        if (args.data.username && taken.includes(args.data.username)) {
          return Promise.reject(new Error('unique constraint: username'));
        }
        return Promise.resolve(args.data);
      }),
      update: jest.fn((args: { where: unknown; data: Partial<Row> }) => {
        updates.push(args.data);
        if (updateFails) return Promise.reject(new Error('unique violation'));
        return Promise.resolve({ ...existing, ...args.data });
      }),
    },
  };

  const guard = new AuthGuard(
    prisma as never,
    { get: jest.fn() } as never,
    {} as never,
  ) as unknown as Guard;

  return { guard, updates, creates };
}

const subject = (meta: SupabaseClaims['user_metadata']): SupabaseClaims => ({
  sub: 'u1',
  email: 'a@b.c',
  user_metadata: meta,
});

describe('AuthGuard account provisioning', () => {
  it('keeps the handle the sign-up form asked for', async () => {
    const { guard, creates } = guardWith(null);

    await guard.resolveSupabaseUser(subject({ username: 'spawn' }));

    expect(creates[0]).toMatchObject({ username: 'spawn' });
  });

  it('takes the handle an OAuth provider sends instead', async () => {
    const { guard, creates } = guardWith(null);

    await guard.resolveSupabaseUser(subject({ user_name: 'octocat' }));
    expect(creates[0]).toMatchObject({ username: 'octocat' });

    const other = guardWith(null);
    await other.guard.resolveSupabaseUser(
      subject({ preferred_username: '@ada' }),
    );
    // The leading @ is how it is typed, not how it is stored.
    expect(other.creates[0]).toMatchObject({ username: 'ada' });
  });

  it('refuses something that is not a handle rather than storing it', async () => {
    const { guard, creates } = guardWith(null);

    await guard.resolveSupabaseUser(subject({ username: 'not a handle!' }));

    expect(creates[0]).toMatchObject({ username: undefined });
  });

  it('stores a handle lowercase, so "Ada" cannot sit beside "ada"', async () => {
    const { guard, creates } = guardWith(null);

    await guard.resolveSupabaseUser(subject({ username: 'Ada_Birds' }));

    expect(creates[0]).toMatchObject({ username: 'ada_birds' });
  });

  it('will not take a reserved handle from a sign-in either', async () => {
    // The same rule as choosing one in the app: an account named "suggested"
    // would have a profile nobody could open, and "kyron" speaks for Kyron.
    const { guard, creates } = guardWith(null);

    await guard.resolveSupabaseUser(subject({ preferred_username: 'kyron' }));

    expect(creates[0]).toMatchObject({ username: undefined });
  });

  it('fills in an account provisioned before any of this existed', async () => {
    // Every account made by the earlier guard has both of these empty, and
    // nothing else would ever set them.
    const { guard, updates } = guardWith({
      id: 'u1',
      name: null,
      username: null,
    });

    await guard.resolveSupabaseUser(
      subject({ username: 'spawn', full_name: 'Spawn' }),
    );

    expect(updates).toEqual([{ name: 'Spawn', username: 'spawn' }]);
  });

  it('never overwrites what the user has since chosen', async () => {
    const { guard, updates } = guardWith({
      id: 'u1',
      name: 'Chosen Name',
      username: 'chosen',
    });

    await guard.resolveSupabaseUser(
      subject({ username: 'stale', full_name: 'Stale' }),
    );

    expect(updates).toEqual([]);
  });

  it('lets the request through when the handle is already taken', async () => {
    const { guard } = guardWith({ id: 'u1', name: null, username: null }, true);

    await expect(
      guard.resolveSupabaseUser(subject({ username: 'taken' })),
    ).resolves.toMatchObject({ id: 'u1' });
  });
});

describe('AuthGuard when the handle is taken', () => {
  it('provisions the account without it rather than refusing the sign-in', async () => {
    const { guard, creates } = guardWith(null, false, ['taken']);

    const user = await guard.resolveSupabaseUser(
      subject({ username: 'taken' }),
    );

    // Two attempts: the handle it asked for, then none.
    expect(creates).toHaveLength(2);
    expect((creates[0] as Row).username).toBe('taken');
    expect((creates[1] as Row).username).toBeUndefined();
    expect(user.id).toBe('u1');
  });

  it('does not retry when there was no handle to drop', async () => {
    const { guard, creates } = guardWith(null, false, [], true);

    await expect(guard.resolveSupabaseUser(subject({}))).rejects.toMatchObject({
      status: 500,
    });
    expect(creates).toHaveLength(1);
  });

  it('blames the server, not the sign-in, when the row cannot be written', async () => {
    // The account holds a valid Supabase token; nothing about it is expired or
    // forged. A 401 here sent people to a login screen that could not help.
    const { guard } = guardWith(null, false, [], true);

    await expect(
      guard.resolveSupabaseUser(subject({ username: 'anything' })),
    ).rejects.toMatchObject({ status: 500 });
  });
});

describe('AuthGuard and deleted accounts', () => {
  it('refuses a token for a deleted account rather than making a new one', async () => {
    // What a deletion leaves under the id: an empty row marked DELETED. An
    // access token outlives the sign-in by up to an hour, and without the
    // row this would provision a fresh account on the next request.
    const deleted = {
      id: 'u1',
      name: null,
      username: null,
      status: 'DELETED',
    } as Row & { status: string };
    const { guard, creates } = guardWith(deleted);

    await expect(guard.resolveSupabaseUser(subject({}))).rejects.toThrow(
      'This account has been deleted.',
    );
    expect(creates).toHaveLength(0);
  });
});

describe('AuthGuard and a row that shares only an email address', () => {
  /** A sign-in whose own row cannot be created: the address is taken. */
  function collidingWith(row: Row & { role: string }) {
    const made = guardWith(null, false, [], true);
    const prisma = (made.guard as unknown as { prisma: { user: never } }).prisma
      .user as unknown as { findFirst: jest.Mock };
    prisma.findFirst.mockResolvedValue(row);
    return made;
  }

  it('still attaches an account from before Supabase to its owner', async () => {
    const legacy = { id: 'old', name: 'Ada', username: 'ada', role: 'USER' };
    const { guard } = collidingWith(legacy);

    await expect(guard.resolveSupabaseUser(subject({}))).resolves.toMatchObject(
      { id: 'old' },
    );
  });

  it('never hands over a staff role that way', async () => {
    // POST /users created rows with any role and any address. Signing up
    // with that address would have arrived here, as ADMIN.
    const planted = { id: 'old', name: null, username: null, role: 'ADMIN' };
    const { guard } = collidingWith(planted);

    await expect(guard.resolveSupabaseUser(subject({}))).rejects.toMatchObject({
      status: 403,
    });
  });
});

describe('AuthGuard and restricted accounts', () => {
  /** A guard whose token always verifies, as [row]. */
  function signedInAs(
    row: { status: string; suspendedUntil?: Date | null },
    access?: string,
  ) {
    const user = {
      id: 'u1',
      name: 'Ada',
      username: 'ada',
      role: 'USER',
      ...row,
    };
    const updateMany = jest.fn().mockResolvedValue({ count: 1 });
    const prisma = {
      user: {
        findUnique: jest.fn().mockResolvedValue(user),
        update: jest.fn(),
        updateMany,
      },
    };
    const reflector = {
      get: jest.fn().mockReturnValue([]),
      getAllAndOverride: jest.fn().mockReturnValue(access),
    };
    const tokens = {
      verify: jest.fn().mockResolvedValue({ sub: 'u1', email: 'a@b.c' }),
      missingConfigFor: jest.fn().mockReturnValue(null),
    };
    const guard = new AuthGuard(
      prisma as never,
      reflector as never,
      tokens as never,
    );
    return { guard, updateMany };
  }

  function request(method: string) {
    const req = { method, headers: { authorization: 'Bearer t' } };
    return {
      switchToHttp: () => ({ getRequest: () => req }),
      getHandler: () => undefined,
      getClass: () => undefined,
    } as never;
  }

  const week = new Date(Date.now() + 7 * 86_400_000);

  it('lets a suspended account read', async () => {
    const { guard } = signedInAs({ status: 'SUSPENDED', suspendedUntil: week });
    await expect(guard.canActivate(request('GET'))).resolves.toBe(true);
  });

  it('refuses a suspended account anything that writes', async () => {
    const { guard } = signedInAs({ status: 'SUSPENDED', suspendedUntil: week });
    await expect(guard.canActivate(request('POST'))).rejects.toMatchObject({
      status: 403,
      response: { code: 'ACCOUNT_RESTRICTED', status: 'SUSPENDED' },
    });
  });

  it('refuses a banned account even reading', async () => {
    const { guard } = signedInAs({ status: 'BANNED' });
    await expect(guard.canActivate(request('GET'))).rejects.toMatchObject({
      status: 403,
      response: { code: 'ACCOUNT_RESTRICTED', status: 'BANNED' },
    });
  });

  it('but lets it reach what is opened to it', async () => {
    const { guard } = signedInAs({ status: 'BANNED' }, 'banned');
    await expect(guard.canActivate(request('POST'))).resolves.toBe(true);
  });

  it('ends a suspension whose time is up', async () => {
    const { guard, updateMany } = signedInAs({
      status: 'SUSPENDED',
      suspendedUntil: new Date(Date.now() - 1000),
    });
    await expect(guard.canActivate(request('POST'))).resolves.toBe(true);
    expect(updateMany).toHaveBeenCalledWith({
      where: { id: 'u1', status: 'SUSPENDED' },
      data: { status: 'ACTIVE', suspendedUntil: null },
    });
  });
});

describe('AuthGuard and a banned address', () => {
  it('provisions a new account at that address banned, saying why', async () => {
    const { guard, creates } = guardWith(null);
    const prisma = (
      guard as unknown as {
        prisma: {
          bannedIdentity: { findUnique: jest.Mock };
          moderationAction: { findUnique: jest.Mock; create: jest.Mock };
          user: { update: jest.Mock };
        };
      }
    ).prisma;
    prisma.bannedIdentity.findUnique.mockResolvedValue({ actionId: 'a1' });
    prisma.moderationAction.findUnique.mockResolvedValue({
      rule: 'SPAM',
      number: 12,
    });
    prisma.user.update = jest.fn((args: { data: unknown }) =>
      Promise.resolve({ id: 'u1', ...(args.data as object) }),
    );

    const user = await guard.resolveSupabaseUser(subject({}));

    expect(creates).toHaveLength(1);
    expect(user).toMatchObject({ status: 'BANNED' });
    const [[made]] = prisma.moderationAction.create.mock.calls as [
      [{ data: { kind: string; rule: string; message: string } }],
    ];
    expect(made.data).toMatchObject({ kind: 'BAN', rule: 'SPAM' });
    expect(made.data.message).toContain('case 12');
    expect(made.data.message).toContain('appeal');
  });
});
