import { timingSafeEqual } from 'node:crypto';

/**
 * Single source of truth for how many requests a minute one caller may make.
 *
 * Read through a function for the same reason the JWT secret is. This was
 * `config.get<number>('RATE_LIMIT_MAX') ?? 100` handed straight to the Fastify
 * plugin, and two separate things went wrong in it. `ConfigService.get` reads
 * the raw environment and returns a *string* whatever the type parameter
 * claims; the plugin quietly ignores a `max` that is not a number and applies
 * its own default of 1000. So a deployment that set the variable got 1000 a
 * minute whatever it asked for, and only one that left it unset got the 100
 * the code appears to say. Separately, the config factory's `Number(x) || 100`
 * turned any unparseable value into 100 with nothing said about it.
 *
 * A limit nobody can set is not a limit, and one that is silently a tenth or
 * ten times what was asked for is worse than none: it is relied upon.
 */
export function readRateLimit(raw = process.env.RATE_LIMIT_MAX): number {
  if (raw === undefined || raw.trim() === '') return DEFAULT_RATE_LIMIT;

  const parsed = Number(raw.trim());
  if (!Number.isInteger(parsed) || parsed < 1) {
    throw new Error(
      `RATE_LIMIT_MAX must be a whole number of requests per minute, and is ` +
        `"${raw}". Refusing to start rather than serve behind a limit nobody ` +
        `chose: this used to become 100 or 1000 depending on which of two ` +
        `layers swallowed it first.`,
    );
  }
  return parsed;
}

/** What a deployment gets for leaving it unset. Per caller, per minute. */
export const DEFAULT_RATE_LIMIT = 100;

/**
 * The bucket for kyron-links, the server that renders shared links for people
 * without the app.
 *
 * Every page it serves is fetched from here from one address, so in the
 * per-address bucket the whole internet's link previews would share 100
 * requests a minute between them. It identifies itself with a shared secret
 * (PUBLIC_PAGES_KEY, set on both services) and gets a bucket of its own,
 * larger but still finite: it caches, and a flood that gets past its cache
 * should still meet a ceiling here.
 *
 * Unset, nothing matches and kyron-links is limited like anybody else.
 */
export const PAGES_BUCKET = 'service:pages';
export const PAGES_RATE_LIMIT = 3000;

export function isPagesService(
  url: string | undefined,
  header: string | string[] | undefined,
  secret = process.env.PUBLIC_PAGES_KEY,
): boolean {
  // Only for what kyron-links reads. A leaked key buys a bigger bucket for the
  // public pages and nothing else.
  if (!url?.startsWith('/public/')) return false;
  if (!secret || secret.length < 32 || typeof header !== 'string') return false;
  const a = Buffer.from(header);
  const b = Buffer.from(secret);
  // Compared in constant time, so the answer's timing says nothing about how
  // much of a guess was right.
  return a.length === b.length && timingSafeEqual(a, b);
}

/** How many requests a minute the bucket [key] may make. */
export function limitFor(key: string, base = readRateLimit()): number {
  return key === PAGES_BUCKET ? PAGES_RATE_LIMIT : base;
}

/**
 * How many different accounts one address may claim to be in a window
 * before its claims stop being believed.
 *
 * The bucket is chosen from the token's subject without verifying the token
 * (verifying is the guard's job, after the limiter). On its own that let a
 * caller mint a fresh bucket per request by sending a made-up subject each
 * time, which is no limit at all. So the subjects an address presents are
 * counted: up to this many get a bucket each, which covers an office or a
 * carrier's NAT, and past it everything from that address shares one
 * overflow bucket, larger than a single caller's but finite.
 */
export const SUBJECTS_PER_ADDRESS = 200;
export const OVERFLOW_FACTOR = 200;
const OVERFLOW_PREFIX = 'crowd:';

export class BucketChooser {
  private claims = new Map<string, Set<string>>();
  private windowStart = 0;

  constructor(
    private readonly windowMs = 60_000,
    private readonly now: () => number = Date.now,
  ) {}

  /** The bucket for a request from [ip] presenting [subject], if any. */
  bucketFor(ip: string, subject: string | null): string {
    if (!subject) return `ip:${ip}`;

    const at = this.now();
    if (at - this.windowStart >= this.windowMs) {
      // Forgotten wholesale each window: bounded memory with no sweeper.
      this.claims = new Map();
      this.windowStart = at;
    }
    let seen = this.claims.get(ip);
    if (!seen) this.claims.set(ip, (seen = new Set()));
    if (seen.has(subject)) return `user:${subject}`;
    if (seen.size >= SUBJECTS_PER_ADDRESS) return `${OVERFLOW_PREFIX}${ip}`;
    seen.add(subject);
    return `user:${subject}`;
  }
}

/** [limitFor], knowing about the overflow bucket. */
export function limitForBucket(key: string, base = readRateLimit()): number {
  if (key.startsWith(OVERFLOW_PREFIX)) return base * OVERFLOW_FACTOR;
  return limitFor(key, base);
}

/**
 * How many proxies in front of this process to believe about the caller's
 * address (TRUST_PROXY_HOPS).
 *
 * Zero trusts nothing: every caller appears to come from the platform's own
 * proxy and all anonymous traffic shares one bucket. Too many and a caller
 * can write its own address in X-Forwarded-For. It must be exactly the
 * number of proxies the platform puts in front; on Render that is one.
 */
export function readTrustedHops(raw = process.env.TRUST_PROXY_HOPS): number {
  if (raw === undefined || raw.trim() === '') return 0;
  const parsed = Number(raw.trim());
  if (!Number.isInteger(parsed) || parsed < 0 || parsed > 5) {
    throw new Error(
      `TRUST_PROXY_HOPS must be a whole number from 0 to 5, and is "${raw}".`,
    );
  }
  return parsed;
}

/** What answers cross-origin when CORS_ORIGIN is unset in production:
 * nothing. The web app is withdrawn (#192), and the Android and Windows apps
 * do not send an Origin, so no browser page needs to call this API. Set
 * CORS_ORIGIN if a web client comes back. */
export const DEFAULT_PRODUCTION_ORIGINS: string[] = [];

/**
 * The origins allowed to call this API from a browser, or `true` to reflect
 * any (development only).
 *
 * Unset used to mean "reflect anything, with credentials" everywhere,
 * production included. Nothing rides on a cookie today, so it was not yet a
 * hole; it was one waiting for the first cookie.
 */
export function corsOrigins(
  raw = process.env.CORS_ORIGIN,
  nodeEnv = process.env.NODE_ENV,
): string[] | true {
  const listed = raw
    ?.split(',')
    .map((origin) => origin.trim())
    .filter(Boolean);
  if (listed?.length) return listed;
  return nodeEnv === 'production' ? DEFAULT_PRODUCTION_ORIGINS : true;
}
