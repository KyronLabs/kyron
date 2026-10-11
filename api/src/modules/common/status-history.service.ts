import {
  Injectable,
  Logger,
  OnApplicationBootstrap,
  OnModuleDestroy,
} from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/** What the status screen shows a history for. */
export type ComponentId = 'api' | 'database' | 'auth';

export interface CheckResult {
  component: ComponentId;
  ok: boolean;
  /** What a failing check said, kept on the incident it opens. */
  detail?: string;
}

export interface DayRecord {
  /** The UTC calendar day, `YYYY-MM-DD`. */
  day: string;
  checks: number;
  failures: number;
}

export interface ComponentHistory {
  id: ComponentId;
  /** Percent of checks passed over the window; null with no checks at all. */
  uptime: number | null;
  /** Only the days that had checks. A day missing here had none. */
  days: DayRecord[];
}

export interface IncidentRecord {
  component: ComponentId;
  startedAt: string;
  /** Null while it is still going on. */
  endedAt: string | null;
  detail: string | null;
}

export interface StatusHistory {
  days: number;
  /** How often the service checks itself, so a reader can judge a count. */
  intervalMinutes: number;
  components: ComponentHistory[];
  incidents: IncidentRecord[];
}

/**
 * The service's record of its own health, for the status screen's uptime
 * bars and incident list.
 *
 * Every few minutes, while the process is running, it checks itself: that it
 * is up (it is, or nothing would be checking), that the database answers,
 * and that Supabase Auth -- which every sign-in goes through -- answers. Each
 * result is counted against its component's day, and a run of failures is an
 * incident.
 *
 * What this cannot see is time the process was not running. A host that
 * sleeps an idle service, or a crash, leaves a gap: no checks, so no row,
 * and the screen shows that day as "no data" rather than claiming it was up.
 *
 * A database outage is the one failure that cannot be written down while it
 * lasts, so results wait in memory and are written, in order, once the
 * database is back. A restart in between loses them.
 */
@Injectable()
export class StatusHistoryService
  implements OnApplicationBootstrap, OnModuleDestroy
{
  static readonly intervalMinutes = 5;

  /** Results kept while they cannot be written: a week of checks. */
  static readonly maxPending =
    (7 * 24 * 60) / StatusHistoryService.intervalMinutes;

  static readonly components: readonly ComponentId[] = [
    'api',
    'database',
    'auth',
  ];

  private readonly logger = new Logger(StatusHistoryService.name);
  private timer?: NodeJS.Timeout;
  private first?: NodeJS.Timeout;
  private pending: { at: Date; results: CheckResult[] }[] = [];

  constructor(private readonly prisma: PrismaService) {}

  onApplicationBootstrap(): void {
    // Never under test, where a timer would outlive the test, and switchable
    // off for a deployment that would rather not write these at all.
    if (process.env.NODE_ENV === 'test') return;
    if (process.env.STATUS_HISTORY === 'off') return;

    const every = StatusHistoryService.intervalMinutes * 60 * 1000;
    this.timer = setInterval(() => void this.tick(), every);
    // One soon after boot, so a service woken by a request counts as up for
    // the day it woke on.
    this.first = setTimeout(() => void this.tick(), 30 * 1000);
    // Neither keeps the process alive on its own.
    this.timer.unref();
    this.first.unref();
  }

  onModuleDestroy(): void {
    if (this.timer) clearInterval(this.timer);
    if (this.first) clearTimeout(this.first);
  }

  /** Checks, then writes everything that is waiting. Never throws. */
  async tick(now = new Date()): Promise<void> {
    try {
      this.pending.push({ at: now, results: await this.check() });
      const over = this.pending.length - StatusHistoryService.maxPending;
      if (over > 0) this.pending.splice(0, over);
      await this.flush();
    } catch (error) {
      this.logger.warn(`Status check failed: ${String(error)}`);
    }
  }

  /** How many results are waiting to be written. For tests. */
  get waiting(): number {
    return this.pending.length;
  }

  /** One round of checks, every component at once. */
  async check(): Promise<CheckResult[]> {
    const database = await this.prisma.isReachable().catch(() => false);
    const auth = await this.checkAuth();
    return [
      { component: 'api', ok: true },
      {
        component: 'database',
        ok: database,
        detail: database ? undefined : 'The database did not answer.',
      },
      auth,
    ];
  }

  /**
   * Supabase Auth's own health endpoint. The one check that says whether
   * signing in works right now, rather than whether it is configured.
   */
  private async checkAuth(): Promise<CheckResult> {
    const base = process.env.SUPABASE_URL?.trim().replace(/\/+$/, '');
    const key =
      process.env.SUPABASE_ANON_KEY?.trim() ||
      process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
    if (!base || !key) {
      return {
        component: 'auth',
        ok: false,
        detail: 'SUPABASE_URL or a project key is not set.',
      };
    }
    try {
      const res = await fetch(`${base}/auth/v1/health`, {
        headers: { apikey: key },
        signal: AbortSignal.timeout(5000),
      });
      return res.ok
        ? { component: 'auth', ok: true }
        : {
            component: 'auth',
            ok: false,
            detail: `Supabase Auth answered ${res.status}.`,
          };
    } catch (error) {
      return {
        component: 'auth',
        ok: false,
        detail: `Supabase Auth did not answer: ${String(error)}`,
      };
    }
  }

  /** Writes what is waiting, oldest first, stopping at the first failure. */
  private async flush(): Promise<void> {
    while (this.pending.length > 0) {
      const next = this.pending[0];
      try {
        await this.record(next.at, next.results);
      } catch {
        // The database is the thing that is down. Kept, and tried again on
        // the next check.
        return;
      }
      this.pending.shift();
    }
  }

  /** Counts one round against its day, and opens or closes incidents. */
  async record(at: Date, results: CheckResult[]): Promise<void> {
    const day = new Date(
      Date.UTC(at.getUTCFullYear(), at.getUTCMonth(), at.getUTCDate()),
    );
    for (const result of results) {
      await this.prisma.serviceDay.upsert({
        where: { day_component: { day, component: result.component } },
        create: {
          day,
          component: result.component,
          checks: 1,
          failures: result.ok ? 0 : 1,
        },
        update: {
          checks: { increment: 1 },
          ...(result.ok ? {} : { failures: { increment: 1 } }),
        },
      });

      const open = await this.prisma.serviceIncident.findFirst({
        where: { component: result.component, endedAt: null },
        select: { id: true },
      });
      if (!result.ok && !open) {
        await this.prisma.serviceIncident.create({
          data: {
            component: result.component,
            startedAt: at,
            detail: result.detail ?? null,
          },
        });
      } else if (result.ok && open) {
        await this.prisma.serviceIncident.update({
          where: { id: open.id },
          data: { endedAt: at },
        });
      }
    }
  }

  /** The last [days] days, for the status screen. */
  async history(days = 60, now = new Date()): Promise<StatusHistory> {
    const since = new Date(
      Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()) -
        (days - 1) * 24 * 60 * 60 * 1000,
    );
    const [rows, incidents] = await Promise.all([
      this.prisma.serviceDay.findMany({
        where: { day: { gte: since } },
        orderBy: { day: 'asc' },
      }),
      this.prisma.serviceIncident.findMany({
        // Anything that started in the window, and anything still going on
        // however long ago it started.
        where: { OR: [{ startedAt: { gte: since } }, { endedAt: null }] },
        orderBy: { startedAt: 'desc' },
        take: 20,
      }),
    ]);

    return {
      days,
      intervalMinutes: StatusHistoryService.intervalMinutes,
      components: StatusHistoryService.components.map((id) => {
        const own = rows.filter((row) => row.component === id);
        const checks = own.reduce((sum, row) => sum + row.checks, 0);
        const failures = own.reduce((sum, row) => sum + row.failures, 0);
        return {
          id,
          uptime:
            checks === 0
              ? null
              : Math.round(((checks - failures) / checks) * 10000) / 100,
          days: own.map((row) => ({
            day: row.day.toISOString().slice(0, 10),
            checks: row.checks,
            failures: row.failures,
          })),
        };
      }),
      incidents: incidents.map((incident) => ({
        component: incident.component as ComponentId,
        startedAt: incident.startedAt.toISOString(),
        endedAt: incident.endedAt?.toISOString() ?? null,
        detail: incident.detail,
      })),
    };
  }
}
