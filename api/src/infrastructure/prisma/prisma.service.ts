import {
  Injectable,
  OnModuleInit,
  OnModuleDestroy,
  Logger,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

/** Attempts and backoff for the connection made at boot. */
const CONNECT_ATTEMPTS = 5;
const RETRY_DELAY_MS = 2000;

/**
 * The host and port from a Postgres URL, with the credentials dropped.
 *
 * Worth naming in a log: an unreachable database is far more often a wrong
 * host than a database that is actually down, and the host is the one part of
 * DATABASE_URL that is safe to print. Returns null rather than risk echoing a
 * URL it could not parse -- that string holds the password.
 */
export function describeDatabaseHost(url: string | undefined): string | null {
  if (!url) return null;
  try {
    const { hostname, port } = new URL(url);
    if (!hostname) return null;
    return port ? `${hostname}:${port}` : hostname;
  } catch {
    return null;
  }
}

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  private readonly logger = new Logger(PrismaService.name);
  userFollowers: any;

  /**
   * Connects, but never refuses to boot.
   *
   * This used to throw after five attempts, which killed the process -- and a
   * machine that exits at boot is not restarted, so a database that was
   * unreachable for ten seconds took the API down until someone deployed
   * again by hand. It cost a full outage over a hostname with a missing
   * segment, which resolved to nothing and so could never recover on its own.
   *
   * Prisma connects lazily on first query anyway, so an API that starts
   * without a database recovers by itself the moment one is reachable. Until
   * then GET /health reports it, which is the difference between a diagnosis
   * and a machine that is simply gone.
   */
  async onModuleInit(): Promise<void> {
    for (let attempt = 1; attempt <= CONNECT_ATTEMPTS; attempt++) {
      try {
        this.logger.log('Connecting to Postgres via Prisma...');
        await this.$connect();
        this.logger.log('Prisma connected.');
        return;
      } catch (err) {
        this.logger.warn(
          `DB connect attempt ${attempt}/${CONNECT_ATTEMPTS} failed` +
            (attempt < CONNECT_ATTEMPTS ? `, retrying in 2 s…` : ''),
          err instanceof Error ? err.message : String(err),
        );
        if (attempt < CONNECT_ATTEMPTS) {
          await new Promise((res) => setTimeout(res, RETRY_DELAY_MS));
        }
      }
    }

    const host = describeDatabaseHost(process.env.DATABASE_URL);
    this.logger.error(
      `Could not reach Postgres${host ? ` at ${host}` : ''} after ` +
        `${CONNECT_ATTEMPTS} attempts. Starting anyway: Prisma connects on ` +
        'first query, so this recovers on its own once the database is ' +
        'reachable. Until then every data route will fail and GET /health ' +
        'reports the database as unreachable. If the host above is not one ' +
        'you recognise, check DATABASE_URL -- a name that does not resolve ' +
        'looks exactly like a database that is down.',
    );
  }

  /** Whether a trivial query round-trips right now. Used by GET /health. */
  async isReachable(): Promise<boolean> {
    try {
      await this.$queryRaw`select 1`;
      return true;
    } catch {
      return false;
    }
  }

  async onModuleDestroy(): Promise<void> {
    this.logger.log('Disconnecting Prisma...');
    await this.$disconnect();
    this.logger.log('Prisma disconnected.');
  }
}
