import {
  ArgumentsHost,
  HttpException,
  NotFoundException,
} from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { ErrorsFilter, statusOf } from './errors.filter';
import { MetricsService } from './metrics.service';

/** An ArgumentsHost carrying one request, and nothing else. */
function hostFor(
  request: unknown,
  type: 'http' | 'ws' = 'http',
): ArgumentsHost {
  return {
    getType: () => type,
    switchToHttp: () => ({ getRequest: () => request }),
  } as unknown as ArgumentsHost;
}

describe('ErrorsFilter', () => {
  let handled: unknown[];
  let metrics: MetricsService;
  let filter: ErrorsFilter;

  beforeEach(() => {
    handled = [];
    metrics = new MetricsService();
    filter = new ErrorsFilter(metrics);
    // The response body is Nest's to write, and the client reads that shape.
    // What is under test is what happens on the way past it.
    jest
      .spyOn(BaseExceptionFilter.prototype, 'catch')
      .mockImplementation((exception: unknown) => {
        handled.push(exception);
      });
  });

  afterEach(() => jest.restoreAllMocks());

  it('counts the failure against the route it happened on', () => {
    const failure = new NotFoundException('Post not found.');

    filter.catch(
      failure,
      hostFor({ routeOptions: { url: '/feed/posts/:id' } }),
    );

    expect(metrics.render()).toContain(
      'http_errors_total{route="/feed/posts/:id",kind="NotFoundException"} 1',
    );
  });

  it('still lets Nest write the response', () => {
    // Changing the body would break the client's error handling, which reads
    // the shape Nest already produced.
    const failure = new NotFoundException('gone');

    filter.catch(failure, hostFor({ routeOptions: { url: '/feed' } }));

    expect(handled).toEqual([failure]);
  });

  it('counts something thrown that was never an Error', () => {
    filter.catch('a string somebody threw', hostFor({ url: '/feed' }));

    expect(metrics.render()).toContain('kind="Unknown500"');
  });

  it('hands a websocket failure straight on', () => {
    // There is no reply to write on that path, and reaching for one inside
    // the handler for a throw is a second throw.
    const failure = new Error('socket went away');

    filter.catch(failure, hostFor(undefined, 'ws'));

    expect(handled).toEqual([failure]);
    expect(metrics.render()).not.toContain('http_errors_total{');
  });

  it('separates two failures with the same status but different causes', () => {
    filter.catch(
      new NotFoundException('no post'),
      hostFor({ routeOptions: { url: '/feed/posts/:id' } }),
    );
    filter.catch(
      new Error('database went away'),
      hostFor({ routeOptions: { url: '/feed/posts/:id' } }),
    );

    const out = metrics.render();
    expect(out).toContain('kind="NotFoundException"');
    expect(out).toContain('kind="Error"');
  });

  it('reads the status a Fastify plugin carries on a plain Error', () => {
    // The rate limiter throws exactly this. Read as a 500 it turned every
    // 429 into a stack trace in the log a person reads to find out whether
    // the server is falling over.
    const throttled = Object.assign(new Error('Rate limit exceeded'), {
      statusCode: 429,
    });

    expect(statusOf(throttled)).toBe(429);
  });

  it('prefers the exception over anything hung off it', () => {
    expect(statusOf(new NotFoundException('gone'))).toBe(404);
    expect(statusOf(new HttpException('teapot', 418))).toBe(418);
  });

  it('will not let a thrown object talk its way out of being a failure', () => {
    // This decides whether a stack is written, so a `statusCode` outside the
    // error range is not a status at all.
    expect(statusOf(Object.assign(new Error('x'), { statusCode: 200 }))).toBe(
      500,
    );
    expect(statusOf(Object.assign(new Error('x'), { statusCode: 'no' }))).toBe(
      500,
    );
    expect(statusOf(new Error('plain'))).toBe(500);
  });
});
