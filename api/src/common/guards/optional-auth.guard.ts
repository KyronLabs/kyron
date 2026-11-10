import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { AccountStatus } from '@prisma/client';

import { SupabaseTokenService } from '@/modules/auth/supabase-token.service';
import { PrismaService } from '@/infrastructure/prisma/prisma.service';

/**
 * For a route anybody may read, where a signed-in reader is told a little
 * more: who they are, when they say.
 *
 * Without it such a route never learns the reader at all -- nothing else sets
 * `request.user` -- and that is how a profile told everybody they did not
 * follow it: the follow was saved, and every reload of the profile said
 * "Follow" again.
 *
 * Never refuses. No token, or one that does not verify, is read as nobody;
 * the route must already be fine for nobody. Only the id is set: this does
 * not provision accounts, which [AuthGuard] does for routes that act.
 *
 * A token whose account is banned, deleted or not mirrored at all is read
 * as nobody too: a token is proof of a sign-in, not of an account in good
 * standing.
 */
@Injectable()
export class OptionalAuthGuard implements CanActivate {
  constructor(
    private readonly supabaseToken: SupabaseTokenService,
    private readonly prisma: PrismaService,
  ) {}

  async canActivate(ctx: ExecutionContext): Promise<boolean> {
    const request = ctx
      .switchToHttp()
      .getRequest<Request & { user?: { id: string } }>();
    const header = request.headers.authorization;
    if (!header?.startsWith('Bearer ')) return true;

    const claims = await this.supabaseToken
      .verify(header.slice('Bearer '.length))
      .catch(() => null);
    if (!claims?.sub) return true;

    const account = await this.prisma.user
      .findUnique({ where: { id: claims.sub }, select: { status: true } })
      .catch(() => null);
    if (
      account &&
      account.status !== AccountStatus.BANNED &&
      account.status !== AccountStatus.DELETED
    ) {
      request.user = { id: claims.sub };
    }
    return true;
  }
}
