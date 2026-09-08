#!/usr/bin/env node
/**
 * Drives the API under concurrency and reports what it actually did.
 *
 * Written here rather than pulled in, for the reason the ranking engine and
 * the metrics registry were: it is a page of arithmetic over a clock, the
 * numbers it produces get quoted, and a number nobody can read the derivation
 * of is not evidence. It measures the whole round trip from a client's point
 * of view -- connect, request, read the body -- because that is the number a
 * person waiting on a screen experiences.
 *
 * Usage:
 *   node scripts/loadtest.mjs --base http://127.0.0.1:3999 --token "$JWT" \
 *     [--concurrency 16] [--seconds 10] [--warmup 2]
 */

const args = Object.fromEntries(
  process.argv
    .slice(2)
    .join(' ')
    .split('--')
    .filter(Boolean)
    .map((pair) => {
      const [key, ...rest] = pair.trim().split(/\s+/);
      return [key, rest.join(' ') || 'true'];
    }),
);

const BASE = args.base ?? 'http://127.0.0.1:3999';
const TOKEN = args.token ?? '';
const CONCURRENCY = Number(args.concurrency ?? 16);
const SECONDS = Number(args.seconds ?? 10);
const WARMUP = Number(args.warmup ?? 2);

/** The endpoints a phone actually hits when somebody opens the app. */
const ROUTES = [
  { name: 'GET /health', path: '/health', auth: false },
  { name: 'GET /feed/recent', path: '/feed/recent?limit=20', auth: true },
  { name: 'GET /feed/following', path: '/feed/following?limit=20', auth: true },
  { name: 'GET /feed/trending/tags', path: '/feed/trending/tags?limit=20', auth: true },
  { name: 'GET /feed/search', path: '/feed/search?q=load&limit=20', auth: true },
  { name: 'GET /profile/me', path: '/profile/me', auth: true },
  { name: 'GET /profile/interests', path: '/profile/interests', auth: true },
  { name: 'GET /notifications', path: '/notifications?limit=20', auth: true },
  { name: 'GET /messages', path: '/messages?limit=30', auth: true },
];

/**
 * Percentiles by nearest rank on a sorted sample.
 *
 * No interpolation: with a few thousand samples the difference is under the
 * measurement noise, and a rank is a real observation rather than a number
 * between two of them.
 */
function percentile(sorted, p) {
  if (sorted.length === 0) return NaN;
  const rank = Math.ceil((p / 100) * sorted.length);
  return sorted[Math.min(sorted.length - 1, Math.max(0, rank - 1))];
}

async function hit(route) {
  const started = performance.now();
  try {
    const response = await fetch(BASE + route.path, {
      headers: route.auth && TOKEN ? { authorization: `Bearer ${TOKEN}` } : {},
    });
    // Read the body. A latency that stops at the headers is not the latency
    // anybody experiences, and it hides a slow serialiser entirely.
    await response.arrayBuffer();
    return { ms: performance.now() - started, status: response.status };
  } catch (error) {
    return { ms: performance.now() - started, status: 0, error: String(error) };
  }
}

async function drive(route, seconds, concurrency) {
  const samples = [];
  const statuses = new Map();
  const until = Date.now() + seconds * 1000;

  const worker = async () => {
    while (Date.now() < until) {
      const { ms, status } = await hit(route);
      samples.push(ms);
      statuses.set(status, (statuses.get(status) ?? 0) + 1);
    }
  };

  await Promise.all(Array.from({ length: concurrency }, worker));
  samples.sort((a, b) => a - b);
  return { samples, statuses, seconds };
}

const ms = (n) => (Number.isNaN(n) ? '   -' : n.toFixed(1).padStart(7));

async function main() {
  if (!TOKEN) {
    console.error('No --token given: every authenticated route will be a 401.');
  }

  console.log(
    `\n${CONCURRENCY} concurrent clients, ${SECONDS}s per route, against ${BASE}\n`,
  );
  console.log(
    'route                          rps      p50      p95      p99      max  statuses',
  );
  console.log('-'.repeat(94));

  const report = [];
  for (const route of ROUTES) {
    // Warm up out of the sample. The first request through a route pays for
    // Prisma's query plan and Node's JIT, and folding that into a p99 makes
    // one number describe two different things.
    if (WARMUP > 0) await drive(route, WARMUP, 2);

    const { samples, statuses } = await drive(route, SECONDS, CONCURRENCY);
    const rps = samples.length / SECONDS;
    const line = {
      name: route.name,
      rps,
      p50: percentile(samples, 50),
      p95: percentile(samples, 95),
      p99: percentile(samples, 99),
      max: samples[samples.length - 1] ?? NaN,
      statuses: [...statuses.entries()]
        .sort((a, b) => b[1] - a[1])
        .map(([code, n]) => `${code}×${n}`)
        .join(' '),
    };
    report.push(line);
    console.log(
      `${line.name.padEnd(30)}${line.rps.toFixed(0).padStart(4)}  ${ms(line.p50)}  ${ms(line.p95)}  ${ms(line.p99)}  ${ms(line.max)}  ${line.statuses}`,
    );
  }

  console.log('\nAll times are milliseconds, whole round trip including body.');
  return report;
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
