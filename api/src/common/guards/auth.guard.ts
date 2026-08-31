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
    const existing = await this.prisma.user.findUnique({
      where: { id: claims.sub },
    });
    if (existing) return existing;

    const email = claims.email ?? `${claims.sub}@users.noreply.kyron.so`;
    const meta = claims.user_metadata ?? {};
    const name = meta.full_name ?? meta.name ?? null;

    try {
      const created = await this.prisma.user.create({
        data: {
          id: claims.sub,
          email,
          name,
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
      if (recovered) return recovered;
      this.logger.error(
        `Could not provision a local user for Supabase subject ${claims.sub}`,
        error instanceof Error ? error.stack : String(error),
      );
      throw new UnauthorizedException('Could not resolve account');
    }
  }
}
