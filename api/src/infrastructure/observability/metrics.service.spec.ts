import { HttpException, NotFoundException } from '@nestjs/common';
import { MetricsService, escapeLabel } from './metrics.service';
import { normalisePath, routeLabel } from './route-label';
import { kindOf } from './errors.filter';
import { timingSafeEqual } from './metrics.controller';

describe('MetricsService', () => {
  const served = (
    over: Partial<Parameters<MetricsService['request']>[0]> = {},
  ) => ({
    method: over.method ?? 'GET',
    route: over.route ?? '/feed',
    status: over.status ?? 200,
    seconds: over.seconds ?? 0.01,
  });

  it('counts requests by method, route and status', () => {
    const metrics = new MetricsService();
    metrics.request(served());
    metrics.request(served());
    metrics.request(served({ status: 500 }));

    const out = metrics.render();
    expect(out).toContain(
      'http_requests_total{method="GET",route="/feed",status="200"} 2',
    );
    expect(out).toContain(
      'http_requests_total{method="GET",route="/feed",status="500"} 1',
    );
  });

  it('puts a duration in every bucket it is under, and none below it', () => {
    // Prometheus histograms are cumulative: a request is counted in its own
    // bucket and every wider one, or a quantile computed from them is wrong.
    const metrics = new MetricsService();
    metrics.request(served({ seconds: 0.04 }));

    const out = metrics.render();
    expect(out).toContain('le="0.025"} 0');
    expect(out).toContain('le="0.05"} 1');
    expect(out).toContain('le="+Inf"} 1');
  });

  it('reports the total time and count alongside the buckets', () => {
    const metrics = new MetricsService();
    metrics.request(served({ seconds: 0.1 }));
    metrics.request(served({ seconds: 0.3 }));

    const out = metrics.render();
    // Labelled with the status too: the latency of the requests that worked
    // and the ones that failed are different numbers, and an average over
    // both describes neither.
    expect(out).toContain(
      'http_request_duration_seconds_sum{method="GET",route="/feed",status="200"} 0.400000',
    );
    expect(out).toContain(
      'http_request_duration_seconds_count{method="GET",route="/feed",status="200"} 2',
    );
  });

  it('treats the method case-insensitively, so it is one series', () => {
    const metrics = new MetricsService();
    metrics.request(served({ method: 'get' }));
    metrics.request(served({ method: 'GET' }));

    expect(metrics.render()).toContain(
      'http_requests_total{method="GET",route="/feed",status="200"} 2',
    );
  });

  it('folds series past the ceiling rather than growing without bound', () => {
    // One series per request is how a metrics endpoint takes down the thing
    // scraping it, and one leaky route pattern is all it takes.
    const metrics = new MetricsService();
    for (let i = 0; i < MetricsService.maxSeries + 50; i++) {
      metrics.request(served({ route: `/leaky/${i}` }));
    }

    const out = metrics.render();
    expect(out).toContain('route="other"');
    expect(out).toContain('kyron_metrics_series_folded_total 50');
  });

  it('keeps counting after it has folded, rather than going quiet', () => {
    const metrics = new MetricsService();
    for (let i = 0; i < MetricsService.maxSeries + 3; i++) {
      metrics.request(served({ route: `/leaky/${i}` }));
    }

    expect(metrics.render()).toContain(
      'http_requests_total{method="GET",route="other",status="200"} 3',
    );
  });

  it('counts errors by cause, not only by status', () => {
    // A NotFoundException from a missing post and one from a missing
    // conversation are the same 404 and different problems.
    const metrics = new MetricsService();
    metrics.error('/feed/posts/:id', 'NotFoundException');
    metrics.error('/feed/posts/:id', 'NotFoundException');

    expect(metrics.render()).toContain(
      'http_errors_total{route="/feed/posts/:id",kind="NotFoundException"} 2',
    );
  });

  it('reads a gauge at scrape time', () => {
    const metrics = new MetricsService();
    let readers = 2;
    metrics.gauge('kyron_readers', 'Connected readers.', () => readers);

    expect(metrics.render()).toContain('kyron_readers 2');
    readers = 9;
    expect(metrics.render()).toContain('kyron_readers 9');
  });

  it('renders the rest when one gauge throws', () => {
    // This endpoint exists to work while something else is broken.
    const metrics = new MetricsService();
    metrics.gauge('kyron_broken', 'Throws.', () => {
      throw new Error('no');
    });
    metrics.gauge('kyron_fine', 'Does not.', () => 1);

    const out = metrics.render();
    expect(out).not.toContain('kyron_broken ');
    expect(out).toContain('kyron_fine 1');
  });

  it('skips a gauge that is not a number', () => {
    const metrics = new MetricsService();
    metrics.gauge('kyron_nan', 'Not a number.', () => NaN);

    expect(metrics.render()).not.toContain('kyron_nan ');
  });

  it('declares a type for every metric it emits', () => {
    // A scraper drops a metric it was never told the type of.
    const metrics = new MetricsService();
    metrics.request(served());
    metrics.error('/feed', 'Error');

    const out = metrics.render();
    for (const name of [
      'http_requests_total',
      'http_request_duration_seconds',
      'http_errors_total',
      'kyron_uptime_seconds',
    ]) {
      expect(out).toContain(`# TYPE ${name} `);
      expect(out).toContain(`# HELP ${name} `);
    }
  });
});

describe('escaping a label', () => {
  it('escapes a quote, so one bad value cannot void the whole page', () => {
    // An unparseable line loses every metric on the page, not just its own.
    expect(escapeLabel('a"b')).toBe('a\\"b');
    expect(escapeLabel('a\\b')).toBe('a\\\\b');
    expect(escapeLabel('a\nb')).toBe('a\\nb');
  });
});

describe('the route label', () => {
  it('prefers the pattern Fastify matched', () => {
    expect(routeLabel({ routeOptions: { url: '/feed/posts/:id/view' } })).toBe(
      '/feed/posts/:id/view',
    );
  });

  it('falls back to the older Fastify field', () => {
    expect(routeLabel({ routerPath: '/feed' })).toBe('/feed');
  });

  it('normalises a path that matched no route at all', () => {
    // A 404 is exactly the traffic worth counting, and it has no pattern.
    expect(
      routeLabel({
        url: '/feed/posts/2f1c9d5a-0b3e-4a7c-9f11-8d2e6b4a1c07/view',
      }),
    ).toBe('/feed/posts/:id/view');
  });

  it('drops the query string, which is per-request by definition', () => {
    expect(normalisePath('/search?q=whatever&cursor=abc')).toBe('/search');
  });

  it('folds numbers and opaque segments', () => {
    expect(normalisePath('/posts/12345')).toBe('/posts/:n');
    expect(normalisePath('/x/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')).toBe(
      '/x/:opaque',
    );
  });

  it('leaves a real path alone', () => {
    expect(normalisePath('/feed/trending/tags')).toBe('/feed/trending/tags');
  });

  it('bounds a path nobody should be able to make a label out of', () => {
    const long = '/' + Array.from({ length: 200 }, (_, i) => `s${i}`).join('/');

    const label = normalisePath(long);

    expect(label.length).toBeLessThanOrEqual(121);
    expect(label.split('/').length).toBeLessThanOrEqual(9);
  });
});

describe('naming what went wrong', () => {
  it('names the exception, not just the status', () => {
    expect(kindOf(new NotFoundException('gone'), 404)).toBe(
      'NotFoundException',
    );
    expect(kindOf(new HttpException('teapot', 418), 418)).toBe('HttpException');
  });

  it('names a plain failure without pretending to know more', () => {
    expect(kindOf(new Error('boom'), 500)).toBe('Error');
    expect(kindOf('a string somebody threw', 500)).toBe('Unknown500');
  });
});

describe('the metrics token', () => {
  it('accepts the right one and refuses the rest', () => {
    expect(timingSafeEqual('secret', 'secret')).toBe(true);
    expect(timingSafeEqual('secreu', 'secret')).toBe(false);
    expect(timingSafeEqual('secre', 'secret')).toBe(false);
    expect(timingSafeEqual(undefined, 'secret')).toBe(false);
  });

  it('compares every byte of a same-length token', () => {
    // Returning at the first difference leaks the token one byte at a time
    // over enough requests.
    expect(timingSafeEqual('aaaaaa', 'aaaaab')).toBe(false);
    expect(timingSafeEqual('baaaaa', 'aaaaaa')).toBe(false);
  });
});
