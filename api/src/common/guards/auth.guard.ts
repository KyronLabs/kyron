/* eslint-disable @typescript-eslint/no-unsafe-member-access */

import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
  ForbiddenException,
  ServiceUnavailableException,
  Logger,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { PrismaService } from '@/infrastructure/prisma/prisma.service';
import { Request } from 'express';
import { User, UserRole, EmailStatus } from '@prisma/client';
import {
  SupabaseTokenService,
  type SupabaseClaims,
} from '@/modules/auth/supabase-token.service';

@Injectable()
export class AuthGuard implements CanActivate {
  private readonly logger = new Logger(AuthGuard.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly reflector: Reflector,
    private readonly supabaseToken: SupabaseTokenService,
  ) {}

  async canActivate(ctx: ExecutionContext): Promise<boolean> {
    const request = ctx.switchToHttp().getRequest<Request>();
    const authHeader = request.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer '))
      throw new UnauthorizedException('Missing or invalid token');

    const token = authHeader.split(' ')[1];

    // Supabase is the only identity provider. This used to fall back to
    // verifying Kyron-issued HS256 tokens, which was a second way in kept
    // alive for clients that had not moved over; every current client
    // authenticates through Supabase, so that path is gone.
    const claims = await this.supabaseToken.verify(token);

    // A token this server is not configured to check is not a bad token --
    // it is a server that cannot check it. Falling through to the legacy
    // HS256 path here would reject it as "invalid or expired", which the
    // client shows as an expired session and the user answers by signing in
    // again, landing straight back on the same error. Say what is actually
    // true instead, and make the cause greppable in the deployment log.
    const missing = claims ? null : this.supabaseToken.missingConfigFor(token);
    if (missing) {
      this.logger.error(
        `Refused an access token because ${missing} is not set, so there is ` +
          'nothing to verify it against. Every authenticated request fails ' +
          'until it is configured.',
      );
      throw new ServiceUnavailableException(
        'Sign-in cannot be verified right now: this server is missing its ' +
          'identity provider configuration.',
      );
    }

    if (!claims) throw new UnauthorizedException('Invalid or expired token');

    const user = await this.resolveSupabaseUser(claims);

    (request as any).user = user;

    const requiredRoles =
      this.reflector.get<UserRole[]>('roles', ctx.getHandler()) || [];

    if (requiredRoles.length > 0 && !requiredRoles.includes(user.role)) {
      throw new ForbiddenException('Insufficient permissions');
    }

    return true;
  }

  /**
   * Supabase owns the account; this row mirrors it so the rest of the schema
   * (profile, follows, points) still has a User to relate to. Provisioned on
   * first sight rather than by a migration, because a user can appear in
   * Supabase at any time -- including through Google or GitHub, which never
   * touch this API.
   */
  private async resolveSupabaseUser(claims: SupabaseClaims): Promise<User> {
    const meta = claims.user_metadata ?? {};
    const name = meta.full_name ?? meta.name ?? null;
    const username = this.handleFrom(meta);

    const existing = await this.prisma.user.findUnique({
      where: { id: claims.sub },
    });
    if (existing) return this.backfill(existing, { name, username });

    const email = claims.email ?? `${claims.sub}@users.noreply.kyron.so`;

    try {
      const created = await this.prisma.user.create({
        data: {
          id: claims.sub,
          email,
          name,
          // Sign-up asks for a handle and Supabase keeps it in the token's
          // metadata, but nothing here ever read it back out. Every account
          // provisioned this way had a null username, which is why a
          // finished profile still introduced itself as "Your account".
          username: username ?? undefined,
          password: null,
          role: UserRole.USER,
          // Supabase would not have issued this token if the account were not
          // usable, so the mirrored row starts verified.
          emailStatus: EmailStatus.VERIFIED,
          emailVerifiedAt: new Date(),
        },
      });
      this.logger.log(`Provisioned local user ${created.id} from Supabase`);
      return created;
    } catch (error) {
      // Two concurrent first requests race here, and an address already present
      // from the pre-Supabase era collides on the unique email. Recover by
      // reading back whichever row won.
      const recovered = await this.prisma.user.findFirst({
        where: { OR: [{ id: claims.sub }, { email }] },
      });
      if (recovered) return this.backfill(recovered, { name, username });
      this.logger.error(
        `Could not provision a local user for Supabase subject ${claims.sub}`,
        error instanceof Error ? error.stack : String(error),
      );
      throw new UnauthorizedException('Could not resolve account');
    }
  }

  /**
   * The handle the identity provider knows this account by.
   *
   * Kyron's own sign-up writes `username`; GitHub and Twitter write
   * `user_name`; most OIDC providers write `preferred_username`. Normalised
   * to what the rest of the schema stores, and dropped rather than mangled if
   * what comes back is not a handle at all.
   */
  private handleFrom(meta: {
    username?: string;
    user_name?: string;
    preferred_username?: string;
  }): string | null {
    const raw = (meta.username ?? meta.user_name ?? meta.preferred_username)
      ?.trim()
      .replace(/^@/, '');
    if (!raw) return null;
    return /^[A-Za-z0-9_.]{2,30}$/.test(raw) ? raw : null;
  }

  /**
   * Fills in what a row provisioned by an earlier version never got.
   *
   * Accounts created before the guard read the token's metadata have no name
   * and no handle, and nothing else would ever set them: this runs once per
   * account, on the first request after the gap is noticed, and leaves any
   * value the user has since chosen alone.
   */
  private async backfill(
    user: User,
    from: { name: string | null; username: string | null },
  ): Promise<User> {
    const data: { name?: string; username?: string } = {};
    if (!user.name?.trim() && from.name) data.name = from.name;
    if (!user.username?.trim() && from.username) data.username = from.username;
    if (Object.keys(data).length === 0) return user;

    try {
      return await this.prisma.user.update({ where: { id: user.id }, data });
    } catch {
      // The handle is unique, and somebody else may already hold it. Not
      // being able to fill it in is not a reason to fail the request -- the
      // user can set one from Edit profile.
      return user;
    }
  }
}
