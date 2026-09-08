import { Global, Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { ErrorsFilter } from './errors.filter';
import { MetricsController } from './metrics.controller';
import { MetricsService } from './metrics.service';

/**
 * Global, because a failure anywhere should be counted the same way and
 * importing this into every module to get that is how one of them ends up
 * missed.
 */
@Global()
@Module({
  controllers: [MetricsController],
  providers: [MetricsService, { provide: APP_FILTER, useClass: ErrorsFilter }],
  exports: [MetricsService],
})
export class ObservabilityModule {}
