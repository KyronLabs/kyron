import { Module } from '@nestjs/common';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';
import { SupabaseTokenModule } from '../auth/supabase-token.module';
import { PrismaModule } from '../../infrastructure/prisma/prisma.module';
import { MediaController } from './media.controller';
import { MediaQueue } from './media-queue.service';
import { MediaWorker } from './media-worker.service';
import { MediaService } from './media.service';
import { TranscodeService } from './transcode.service';

@Module({
  imports: [
    // MediaService uploads through SupabaseService. SupabaseModule is not
    // global, so without this import Nest cannot construct MediaService and
    // the whole application fails to start.
    SupabaseModule,
    // SupabaseTokenService is what AuthGuard uses to verify access tokens;
    // without it in scope Nest cannot construct the guard on this controller.
    SupabaseTokenModule,
    // The re-encode queue is a table, so the worker needs Prisma.
    PrismaModule,
  ],
  controllers: [MediaController],
  providers: [MediaService, TranscodeService, MediaQueue, MediaWorker],
  exports: [MediaService],
})
export class MediaModule {}
