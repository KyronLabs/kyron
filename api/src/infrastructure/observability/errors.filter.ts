import { ArgumentsHost, Catch, HttpException, Logger } from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { MetricsService } from './metrics.service';
import { requestIdOf } from './request-log';
import { routeLabel } from './route-label';

/**
 * Somewhere for a failure to be counted and findable.
 *
 * There was no error aggregation at all: a 500 left a stack in whatever the
 * platform happened to capture, with nothing tying it to the request that
 * caused it or to how often it had happened. This adds both, and changes no
 * response body -- the client's error handling reads the shape Nest already
 * produced, so the base filter still writes it.
 */
@Catch()
export class ErrorsFilter extends BaseExceptionFilter {
  private readonly logger = new Logger('Errors');

  constructor(private readonly metrics: MetricsService) {
    super();
  }

  catch(exception: unknown, host: ArgumentsHost): void {
    // Only HTTP. A failure on the websocket path has no reply to write and
    // handing it to the base filter would throw inside the handler for a
    // throw.
    if (host.getType() !== 'http') {
      super.catch(exception, host);
      return;
    }

    const request: unknown = host.switchToHttp().getRequest();
    const route = routeLabel(request);
    const status = statusOf(exception);

    this.metrics.error(route, kindOf(exception, status));

    // Only what this server did wrong. A 400 or a 404 is already one line in
    // the request log, and a stack for every one of them buries the 500s.
    if (status >= 500) {
      this.logger.error(
        JSON.stringify({
          requestId: requestIdOf(request) ?? 'none',
          route,
          status,
          message:
            exception instanceof Error ? exception.message : String(exception),
        }),
        exception instanceof Error ? exception.stack : undefined,
      );
    }

    super.catch(exception, host);
  }
}

/**
 * The status a failure is really answering with.
 *
 * Not every failure is a Nest `HttpException`. A Fastify plugin throws a plain
 * `Error` carrying `statusCode`, which is how every 429 from the rate limiter
 * was being recorded as a 500 and logged with a full stack -- turning ordinary
 * throttling into what looked like the server falling over, in the log a
 * person reads to find out whether it had.
 */
export function statusOf(exception: unknown): number {
  if (exception instanceof HttpException) return exception.getStatus();

  const carried = (exception as { statusCode?: unknown })?.statusCode;
  // A sane HTTP status and nothing else: this decides whether a stack is
  // written, so a thrown object claiming `statusCode: 200` must not be able to
  // hide a genuine failure.
  if (typeof carried === 'number' && carried >= 400 && carried <= 599) {
    return carried;
  }
  return 500;
}

/**
 * What went wrong, as something countable.
 *
 * The exception's own class name, because "which error is spiking" is the
 * question this is asked, and a status code alone cannot answer it: a
 * NotFoundException thrown by a missing post and one thrown by a missing
 * conversation are the same 404 and different problems.
 */
export function kindOf(exception: unknown, status: number): string {
  if (exception instanceof HttpException) return exception.constructor.name;
  if (exception instanceof Error) {
    return exception.constructor.name === 'Error'
      ? 'Error'
      : exception.constructor.name;
  }
  return `Unknown${status}`;
}
