import {
  Injectable,
  OnModuleInit,
  OnModuleDestroy,
  Logger,
} from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
import { promises as dns } from 'dns';
import { diagnoseUnreachableHost, type DnsResolver } from './host-diagnosis';

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

/** Just the hostname, for a DNS lookup. Same redaction rules as above. */
export function databaseHostname(url: string | undefined): string | null {
  if (!url) return null;
  try {
    return new URL(url).hostname || null;
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
   * The API must not become ready without its database. The container entry
   * point applies migrations first; this connection check verifies that the
   * application can reach Postgres before Nest starts serving requests.
   * A failed boot is visible to the platform and can be retried by its
   * restart policy instead of presenting a live but unusable API.
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
        `${CONNECT_ATTEMPTS} attempts. Refusing to start the API.`,
    );

    const diagnosis = await this.diagnoseHost();
    if (diagnosis) this.logger.error(diagnosis);

    throw new Error(
      'Database connection is unavailable; refusing to start the API.',
    );
  }

  /**
   * What DNS can say about why the database host is unreachable, or null when
   * it resolves to IPv4 and the fault lies past name resolution.
   *
   * Resolved on demand rather than cached: the answer changes the moment
   * DATABASE_URL is corrected, and a stale explanation is worse than none.
   */
  async diagnoseHost(resolver: DnsResolver = dns): Promise<string | null> {
    const hostname = databaseHostname(process.env.DATABASE_URL);
    if (!hostname) return null;
    try {
      return await diagnoseUnreachableHost(hostname, resolver);
    } catch {
      // A diagnostic must never be the thing that breaks a boot.
      return null;
    }
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
