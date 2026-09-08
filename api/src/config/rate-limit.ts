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
