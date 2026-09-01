import { Global, Module } from '@nestjs/common';
import { ModerationController } from './moderation.controller';
import { ModerationService } from './moderation.service';

// Global, because FeedService needs filtersFor on every listing and importing
// the module into each consumer is the same thing said three times.
@Global()
@Module({
  controllers: [ModerationController],
  providers: [ModerationService],
  exports: [ModerationService],
})
export class ModerationModule {}
