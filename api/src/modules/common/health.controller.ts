import { Controller, Get } from '@nestjs/common';
import { SupabaseTokenService } from '../auth/supabase-token.service';

@Controller('health')
export class HealthController {
  constructor(private readonly supabaseToken: SupabaseTokenService) {}

  @Get()
  health() {
    return {
      status: 'ok',
      timestamp: Date.now(),
      // Which identity provider this deployment will actually accept tokens
      // from. Every authenticated route fails when this is wrong, and until
      // now the only symptom was a 401 indistinguishable from a bad password,
      // so the misconfiguration could only be found by reading boot logs.
      //
      // Nothing here is secret: the issuer is the `iss` claim of every token
      // the client already holds, and the project URL ships inside the app.
      auth: {
        supabase: this.supabaseToken.enabled ? 'configured' : 'not configured',
        issuer: this.supabaseToken.configuredIssuer,
      },
    };
  }
}
