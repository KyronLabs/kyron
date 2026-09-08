import { MetricsService } from './metrics.service';
import { installRequestLogging, requestIdOf } from './request-log';

type Hook = (...args: unknown[]) => void;

/** Just enough Fastify to hold the two hooks and fire them. */
class FakeFastify {
  readonly hooks = new Map<string, Hook>();

  addHook(event: string, handler: unknown): void {
    this.hooks.set(event, handler as Hook);
  }

  respond(request: unknown, reply: unknown): void {
    this.hooks.get('onResponse')!(request, reply, () => {});
  }

  send(request: unknown, reply: unknown): void {
    this.hooks.get('onSend')!(request, reply, null, () => {});
  }
}

describe('logging a request', () => {
  const install = () => {
    const fastify = new FakeFastify();
    const metrics = new MetricsService();
    installRequestLogging(
      fastify as unknown as Parameters<typeof installRequestLogging>[0],
      metrics,
    );
    return { fastify, metrics };
  };

  it('counts a request a guard rejected before any handler ran', () => {
    // The reason this is a Fastify hook and not a Nest interceptor:
    // interceptors never run for a 401, and a dashboard missing every auth
    // failure is missing most of what anyone opens it to find.
    const { fastify, metrics } = install();

    fastify.respond(
      { method: 'GET', id: 'r1', routeOptions: { url: '/feed' } },
      { statusCode: 401, elapsedTime: 2 },
    );

    expect(metrics.render()).toContain(
      'http_requests_total{method="GET",route="/feed",status="401"} 1',
    );
  });

  it('takes the duration Fastify measured, not one started in the hook', () => {
    const { fastify, metrics } = install();

    fastify.respond(
      { method: 'GET', id: 'r1', routeOptions: { url: '/feed' } },
      { statusCode: 200, elapsedTime: 250 },
    );

    // 250ms as reported, in seconds, in the bucket that covers it.
    expect(metrics.render()).toContain('le="0.25"} 1');
  });

  it('echoes the request id, so a bug report can carry one', () => {
    const { fastify } = install();
    const headers: Record<string, string> = {};

    fastify.send(
      { id: 'abc-123' },
      { header: (n: string, v: string) => (headers[n] = v) },
    );

    expect(headers['x-request-id']).toBe('abc-123');
  });

  it('sends no header when there is no id to send', () => {
    const { fastify } = install();
    const headers: Record<string, string> = {};

    fastify.send({}, { header: (n: string, v: string) => (headers[n] = v) });

    expect(headers).toEqual({});
  });

  it('still answers when the response object is not what was expected', () => {
    // This runs after the response has gone out. It must never be able to
    // fail one.
    const { fastify, metrics } = install();

    expect(() => fastify.respond(null, null)).not.toThrow();
    expect(metrics.render()).toContain('http_requests_total');
  });

  it('reads an id only when there is a real one', () => {
    expect(requestIdOf({ id: 'r1' })).toBe('r1');
    expect(requestIdOf({ id: '' })).toBeUndefined();
    expect(requestIdOf({ id: 7 })).toBeUndefined();
    expect(requestIdOf(undefined)).toBeUndefined();
  });
});
