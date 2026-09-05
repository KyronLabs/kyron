import { Module } from '@nestjs/common';
import { MessagesController } from './messages.controller';
import { MessagesService } from './messages.service';
import { SupabaseTokenModule } from '../auth/supabase-token.module';

@Module({
  // AuthGuard needs SupabaseTokenService in scope to be constructible.
  imports: [SupabaseTokenModule],
  controllers: [MessagesController],
  providers: [MessagesService],
  exports: [MessagesService],
})
export class MessagesModule {}
