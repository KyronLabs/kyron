import { Injectable } from '@nestjs/common';

/** One request's outcome, as ranking would call a candidate: what is measured. */
export interface RequestOutcome {
  method: string;
  /** The route *pattern*, never the URL. See [MetricsService.maxSeries]. */
  route: string;
  status: number;
  seconds: number;
}

interface Series {
  count: number;
  sum: number;
  /** One running total per bucket in [MetricsService.buckets], cumulative. */
  buckets: number[];
}

/**
 * What the API can say about itself, in the format a scraper expects.
 *
 * Written here rather than pulled in as a dependency for the same reason the
 * ranking engine is: it is a few pages of arithmetic, it is exercised by real
 * tests, and the alternative is a library whose failure modes nobody here
 * would recognise. Everything is in memory and per process, which is what a
 * scrape is -- a counter that survives a restart is a different tool.
 */
@Injectable()
export class MetricsService {
  /** Upper bounds in seconds, ascending. `+Inf` is implied and added on render. */
  static readonly buckets = [
    0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10,
  ];

  /**
   * How many distinct label combinations are kept before the rest are folded
   * into `route="other"`.
   *
   * Unbounded label cardinality is the way a metrics endpoint takes down the
   * thing scraping it: one route pattern that leaks an id makes a new series
   * per request, and the process grows until it dies. This caps the damage at
   * a number rather than trusting every future route to behave.
   */
  static readonly maxSeries = 500;

  private readonly requests = new Map<string, Series>();
  private readonly errors = new Map<string, number>();
  private readonly gauges = new Map<
    string,
    { help: string; read: () => number }
  >();

  /** Series dropped for being past [maxSeries]. Reported, not hidden. */
  private folded = 0;

  private readonly startedAt = Date.now();

  /** Records one served request. */
  request({ method, route, status, seconds }: RequestOutcome): void {
    const key = this.keyFor([
      ['method', method.toUpperCase()],
      ['route', route],
      ['status', String(status)],
    ]);
    const series = this.seriesFor(key, method, route, status);

    series.count += 1;
    series.sum += seconds;
    for (let i = 0; i < MetricsService.buckets.length; i++) {
      if (seconds <= MetricsService.buckets[i]) series.buckets[i] += 1;
    }
  }

  /**
   * Records one request that failed, by what went wrong.
   *
   * Separate from the status counter because a 500 and a 400 are different
   * events: one is a bug here and the other is a client sending nonsense, and
   * a dashboard that adds them together tells nobody anything.
   */
  error(route: string, kind: string): void {
    const key = this.keyFor([
      ['route', route],
      ['kind', kind],
    ]);
    this.errors.set(key, (this.errors.get(key) ?? 0) + 1);
  }

  /**
   * Registers a number to read at scrape time rather than one to keep updated.
   *
   * A gauge that is pushed has to be pushed from everywhere it could change,
   * and the one place it is forgotten is the one that matters.
   */
  gauge(name: string, help: string, read: () => number): void {
    this.gauges.set(name, { help, read });
  }

  /** The whole registry, in Prometheus text exposition format. */
  render(): string {
    const lines: string[] = [];

    lines.push('# HELP http_requests_total Requests served.');
    lines.push('# TYPE http_requests_total counter');
    for (const [labels, series] of this.requests) {
      lines.push(`http_requests_total{${labels}} ${series.count}`);
    }

    lines.push(
      '# HELP http_request_duration_seconds How long requests took to serve.',
    );
    lines.push('# TYPE http_request_duration_seconds histogram');
    for (const [labels, series] of this.requests) {
      for (let i = 0; i < MetricsService.buckets.length; i++) {
        const le = MetricsService.buckets[i];
        lines.push(
          `http_request_duration_seconds_bucket{${labels},le="${le}"} ${series.buckets[i]}`,
        );
      }
      lines.push(
        `http_request_duration_seconds_bucket{${labels},le="+Inf"} ${series.count}`,
      );
      lines.push(
        `http_request_duration_seconds_sum{${labels}} ${series.sum.toFixed(6)}`,
      );
      lines.push(
        `http_request_duration_seconds_count{${labels}} ${series.count}`,
      );
    }

    lines.push('# HELP http_errors_total Requests that failed, by cause.');
    lines.push('# TYPE http_errors_total counter');
    for (const [labels, count] of this.errors) {
      lines.push(`http_errors_total{${labels}} ${count}`);
    }

    lines.push(
      '# HELP kyron_metrics_series_folded_total Series dropped for exceeding the cardinality ceiling.',
    );
    lines.push('# TYPE kyron_metrics_series_folded_total counter');
    lines.push(`kyron_metrics_series_folded_total ${this.folded}`);

    lines.push('# HELP kyron_uptime_seconds How long this process has served.');
    lines.push('# TYPE kyron_uptime_seconds gauge');
    lines.push(
      `kyron_uptime_seconds ${((Date.now() - this.startedAt) / 1000).toFixed(3)}`,
    );

    for (const [name, { help, read }] of this.gauges) {
      // Read before the header is written, not after. A gauge that throws
      // must not take the whole scrape with it -- the point of this endpoint
      // is to work when something else is broken -- and it must not leave a
      // HELP and TYPE behind with no sample under them either, which is a
      // metric that looks present and reads as zero.
      let value: number;
      try {
        value = read();
      } catch {
        continue;
      }
      if (!Number.isFinite(value)) continue;

      lines.push(`# HELP ${name} ${help}`);
      lines.push(`# TYPE ${name} gauge`);
      lines.push(`${name} ${value}`);
    }

    return lines.join('\n') + '\n';
  }

  private seriesFor(
    key: string,
    method: string,
    route: string,
    status: number,
  ): Series {
    const existing = this.requests.get(key);
    if (existing) return existing;

    if (this.requests.size >= MetricsService.maxSeries) {
      this.folded += 1;
      const overflow = this.keyFor([
        ['method', method.toUpperCase()],
        ['route', 'other'],
        ['status', String(status)],
      ]);
      const held = this.requests.get(overflow);
      if (held) return held;
      // The overflow series itself is always allowed in, or a full registry
      // would stop counting altogether and look like a quiet server.
      return this.blank(overflow);
    }

    return this.blank(key);
  }

  private blank(key: string): Series {
    const series: Series = {
      count: 0,
      sum: 0,
      buckets: new Array<number>(MetricsService.buckets.length).fill(0),
    };
    this.requests.set(key, series);
    return series;
  }

  private keyFor(labels: [string, string][]): string {
    return labels
      .map(([name, value]) => `${name}="${escapeLabel(value)}"`)
      .join(',');
  }
}

/**
 * Escapes a label value.
 *
 * A route or an error name reaches this from a request, and an unescaped
 * quote in one produces a line no scraper can parse -- which loses every
 * metric on the page, not just that one.
 */
export function escapeLabel(value: string): string {
  return value
    .replace(/\\/g, '\\\\')
    .replace(/"/g, '\\"')
    .replace(/\n/g, '\\n');
}
