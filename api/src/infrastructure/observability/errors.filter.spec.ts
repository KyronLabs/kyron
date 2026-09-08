import { ArgumentsHost, NotFoundException } from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { ErrorsFilter } from './errors.filter';
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
});
