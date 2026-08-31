import { Controller, Get } from '@nestjs/common';
import { SupabaseTokenService } from '../auth/supabase-token.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

@Controller('health')
export class HealthController {
  constructor(
    private readonly supabaseToken: SupabaseTokenService,
    private readonly prisma: PrismaService,
  ) {}

  @Get()
  async health() {
    const databaseReachable = await this.prisma.isReachable();

    return {
      // Deliberately still "ok" with the database down, and still HTTP 200.
      // The process is serving; reporting unhealthy would take the machine out
      // of rotation and hide the very information this endpoint exists to
      // give. "degraded" says which it is without doing that.
      status: databaseReachable ? 'ok' : 'degraded',
      timestamp: Date.now(),
      database: databaseReachable ? 'reachable' : 'unreachable',
      // Which identity provider this deployment will accept tokens from, and
      // which signatures it can check. Every authenticated route fails when
      // either is wrong, and the only symptom used to be a 401 that looked
      // exactly like a bad password.
      //
      // Nothing here is secret: the issuer is the `iss` claim of every token
      // the client already holds, and the project URL ships inside the app.
      auth: {
        supabase: this.supabaseToken.enabled ? 'configured' : 'not configured',
        issuer: this.supabaseToken.configuredIssuer,
        accepts: this.supabaseToken.accepts,
      },
    };
  }
}
