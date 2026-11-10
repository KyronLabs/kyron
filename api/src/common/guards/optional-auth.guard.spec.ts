import { ExecutionContext } from '@nestjs/common';
import { OptionalAuthGuard } from './optional-auth.guard';
import type { SupabaseTokenService } from '@/modules/auth/supabase-token.service';
import type { PrismaService } from '@/infrastructure/prisma/prisma.service';

describe('OptionalAuthGuard', () => {
  const run = async (
    authorization: string | undefined,
    verify: (token: string) => Promise<unknown>,
    status: string | null = 'ACTIVE',
  ) => {
    const request: { headers: Record<string, string>; user?: { id: string } } =
      { headers: authorization ? { authorization } : {} };
    const ctx = {
      switchToHttp: () => ({ getRequest: () => request }),
    } as unknown as ExecutionContext;
    const guard = new OptionalAuthGuard(
      { verify } as unknown as SupabaseTokenService,
      {
        user: {
          findUnique: () => Promise.resolve(status ? { status } : null),
        },
      } as unknown as PrismaService,
    );
    const allowed = await guard.canActivate(ctx);
    return { allowed, user: request.user };
  };

  it('names a reader whose token verifies', async () => {
    // This is what tells a profile its reader follows it.
    const out = await run('Bearer good', (t) =>
      Promise.resolve(t === 'good' ? { sub: 'u1' } : null),
    );
    expect(out).toEqual({ allowed: true, user: { id: 'u1' } });
  });

  it('lets nobody in as nobody', async () => {
    expect(await run(undefined, () => Promise.resolve({ sub: 'u1' }))).toEqual({
      allowed: true,
      user: undefined,
    });
  });

  it('reads a bad token as nobody rather than refusing', async () => {
    expect(await run('Bearer bad', () => Promise.resolve(null))).toEqual({
      allowed: true,
      user: undefined,
    });
    expect(
      await run('Bearer boom', () => Promise.reject(new Error('jwks down'))),
    ).toEqual({ allowed: true, user: undefined });
  });

  it('reads a banned, deleted or unknown account as nobody', async () => {
    for (const status of ['BANNED', 'DELETED', null]) {
      expect(
        await run('Bearer good', () => Promise.resolve({ sub: 'u1' }), status),
      ).toEqual({ allowed: true, user: undefined });
    }
  });
});
