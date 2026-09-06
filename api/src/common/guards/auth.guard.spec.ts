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

function guardWith(existing: Row | null, updateFails = false) {
  const updates: unknown[] = [];
  const creates: unknown[] = [];
  const prisma = {
    user: {
      findUnique: jest.fn().mockResolvedValue(existing),
      findFirst: jest.fn().mockResolvedValue(null),
      create: jest.fn((args: { data: Row }) => {
        creates.push(args.data);
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
