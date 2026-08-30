import { Module } from '@nestjs/common';
import { SupabaseTokenService } from './supabase-token.service';

/**
 * Its own module so the guard and the health endpoint share one instance, and
 * therefore one JWKS cache, instead of each constructing its own and fetching
 * the key set separately.
 */
@Module({
  providers: [SupabaseTokenService],
  exports: [SupabaseTokenService],
})
export class SupabaseTokenModule {}
