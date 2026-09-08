import { Logger } from '@nestjs/common';
import { MetricsService } from './metrics.service';
import { routeLabel } from './route-label';

/** What one served request looks like in the log. */
export interface RequestRecord {
  requestId: string;
  method: string;
  route: string;
  status: number;
  ms: number;
  userId?: string;
}

/**
 * One structured line per served request, and the numbers behind it.
 *
 * Installed as a Fastify hook rather than a Nest interceptor on purpose:
 * interceptors do not run for a request a guard rejected or a route that
 * matched nothing, so an interceptor counts the traffic that worked and
 * misses every 401 and 404 -- which is most of what anybody looks at a
 * dashboard to find.
 *
 * Written to stdout, not to a file. The container this runs in is replaced on
 * every deploy and its disk goes with it; the file logger this replaces wrote
 * fourteen days of rotation into a directory nobody could reach, and nothing
 * imported it anyway.
 */
export function installRequestLogging(
  fastify: FastifyLike,
  metrics: MetricsService,
  options: { slowMs: number } = { slowMs: 1000 },
): void {
  const logger = new Logger('Request');

  fastify.addHook('onResponse', (request, reply, done) => {
    try {
      const record = describe(request, reply);
      metrics.request({
        method: record.method,
        route: record.route,
        status: record.status,
        seconds: record.ms / 1000,
      });

      // Levelled by what the line is for. A 500 is this server's problem and
      // should be findable; a 4xx is a client's and is worth seeing without
      // being an alarm; a slow success is the one that would otherwise never
      // be noticed until somebody complained the app felt heavy.
      const line = JSON.stringify(record);
      if (record.status >= 500) logger.error(line);
      else if (record.status >= 400) logger.warn(line);
      else if (record.ms >= options.slowMs) logger.warn(line);
      else logger.log(line);
    } catch (error) {
      // A logging hook must never be able to fail a response that has already
      // been sent.
      logger.error(
        `Could not record a request: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
    }
    done();
  });

  // The id the client can quote back. Echoed on every response, including the
  // failures -- a bug report that carries one turns "it broke this morning"
  // into a single line of log.
  fastify.addHook('onSend', (request, reply, _payload, done) => {
    const id = requestIdOf(request);
    if (id) reply.header('x-request-id', id);
    done();
  });
}

function describe(request: unknown, reply: unknown): RequestRecord {
  const req = request as {
    method?: string;
    user?: { id?: string };
  };
  const res = reply as { statusCode?: number; elapsedTime?: number };

  return {
    requestId: requestIdOf(request) ?? 'none',
    method: (req?.method ?? 'GET').toUpperCase(),
    route: routeLabel(request),
    status: res?.statusCode ?? 0,
    // Fastify measures this itself, from the moment the request arrived. A
    // timer started in a hook would miss whatever happened before the hook.
    ms: Math.round((res?.elapsedTime ?? 0) * 1000) / 1000,
    // Present only once a guard has run, which is the point: an authenticated
    // request that went wrong can be traced to the account it went wrong for.
    ...(req?.user?.id ? { userId: req.user.id } : {}),
  };
}

export function requestIdOf(request: unknown): string | undefined {
  const id = (request as { id?: unknown })?.id;
  return typeof id === 'string' && id.length > 0 ? id : undefined;
}

/** The slice of Fastify this needs, so a test does not need Fastify. */
export interface FastifyLike {
  addHook(
    event: 'onResponse',
    handler: (request: unknown, reply: unknown, done: () => void) => void,
  ): void;
  addHook(
    event: 'onSend',
    handler: (
      request: unknown,
      reply: { header(name: string, value: string): unknown },
      payload: unknown,
      done: () => void,
    ) => void,
  ): void;
}
