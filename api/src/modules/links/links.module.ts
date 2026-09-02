import { Module } from '@nestjs/common';
import { LinksController } from './links.controller';
import { LinksService } from './links.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

/**
 * SupabaseTokenModule is imported because the controller is behind AuthGuard,
 * which injects the token service. A guarded controller in a module that does
 * not import it type-checks, builds, passes every unit test, and then fails at
 * boot -- which is what app.module.spec.ts exists to catch.
 */
@Module({
  imports: [SupabaseTokenModule],
  controllers: [LinksController],
  providers: [LinksService],
  exports: [LinksService],
})
export class LinksModule {}
