import {
  Controller,
  Get,
  Header,
  Logger,
  NotFoundException,
  Req,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { MetricsService } from './metrics.service';

/**
 * What a scraper reads.
 *
 * Shut unless `METRICS_TOKEN` is set, and answering 404 rather than 401 when
 * it is not: a deployment with no token configured should look like one with
 * no metrics endpoint, rather than advertise a door and refuse to open it.
 * The numbers are not secrets exactly, but route names and traffic shape are
 * more than a stranger needs.
 */
@Controller('metrics')
export class MetricsController {
  private readonly logger = new Logger(MetricsController.name);
  private warned = false;

  constructor(
    private readonly metrics: MetricsService,
    private readonly config: ConfigService,
  ) {}

  @Get()
  @Header('content-type', 'text/plain; version=0.0.4; charset=utf-8')
  scrape(@Req() request: { headers?: Record<string, unknown> }): string {
    const expected = this.config.get<string>('METRICS_TOKEN');
    if (!expected) {
      // Once. A scraper pointed at a deployment that has not been given a
      // token would otherwise write this line every fifteen seconds forever.
      if (!this.warned) {
        this.warned = true;
        this.logger.warn(
          'Metrics are off because METRICS_TOKEN is not set. Set it to turn ' +
            'them on, and give the scraper the same value as a Bearer token.',
        );
      }
      throw new NotFoundException();
    }

    if (!presented(request) || !timingSafeEqual(presented(request), expected)) {
      throw new NotFoundException();
    }

    return this.metrics.render();
  }
}

function presented(request: {
  headers?: Record<string, unknown>;
}): string | undefined {
  const header = request?.headers?.authorization;
  if (typeof header !== 'string') return undefined;
  return header.startsWith('Bearer ') ? header.slice(7) : undefined;
}

/**
 * Compares without leaking the answer in how long it took.
 *
 * A plain `===` on a secret returns as soon as two bytes differ, which is
 * enough to recover the token one byte at a time over enough requests. Length
 * is compared first and separately, which does leak the length -- that is the
 * accepted part, and it is the part that cannot be avoided here.
 */
export function timingSafeEqual(a: string | undefined, b: string): boolean {
  if (a === undefined || a.length !== b.length) return false;
  let differences = 0;
  for (let i = 0; i < a.length; i++) {
    differences |= a.charCodeAt(i) ^ b.charCodeAt(i);
  }
  return differences === 0;
}
