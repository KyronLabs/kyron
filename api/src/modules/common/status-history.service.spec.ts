import { StatusHistoryService } from './status-history.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * The record behind the status screen's uptime bars.
 *
 * A fake Prisma that keeps rows in memory and can be made to fail, which is
 * the case that matters most: a database outage cannot be written down while
 * it lasts, and has to be written once it is over.
 */
type Day = { day: Date; component: string; checks: number; failures: number };
type Incident = {
  id: string;
  component: string;
  startedAt: Date;
  endedAt: Date | null;
  detail: string | null;
};

function fakePrisma() {
  const days: Day[] = [];
  const incidents: Incident[] = [];
  let down = false;
  let reachable = true;
  const guard = () => {
    if (down) return Promise.reject(new Error('database down'));
    return Promise.resolve();
  };

  const prisma = {
    isReachable: () => Promise.resolve(reachable),
    serviceDay: {
      upsert: async (args: {
        where: { day_component: { day: Date; component: string } };
        create: Day;
        update: { failures?: unknown };
      }) => {
        await guard();
        const { day, component } = args.where.day_component;
        const row = days.find(
          (d) => d.day.getTime() === day.getTime() && d.component === component,
        );
        if (row) {
          row.checks += 1;
          if (args.update.failures) row.failures += 1;
        } else {
          days.push({ ...args.create });
        }
      },
      findMany: async (args: { where: { day: { gte: Date } } }) => {
        await guard();
        return days
          .filter((d) => d.day >= args.where.day.gte)
          .sort((a, b) => a.day.getTime() - b.day.getTime());
      },
    },
    serviceIncident: {
      findFirst: async (args: {
        where: { component: string; endedAt: null };
      }) => {
        await guard();
        return (
          incidents.find(
            (i) => i.component === args.where.component && i.endedAt === null,
          ) ?? null
        );
      },
      create: async (args: {
        data: { component: string; startedAt: Date; detail: string | null };
      }) => {
        await guard();
        incidents.push({
          id: `i${incidents.length + 1}`,
          endedAt: null,
          ...args.data,
        });
      },
      update: async (args: {
        where: { id: string };
        data: { endedAt: Date };
      }) => {
        await guard();
        const row = incidents.find((i) => i.id === args.where.id)!;
        row.endedAt = args.data.endedAt;
      },
      findMany: async () => {
        await guard();
        return [...incidents].sort(
          (a, b) => b.startedAt.getTime() - a.startedAt.getTime(),
        );
      },
    },
  };

  return {
    prisma: prisma as unknown as PrismaService,
    days,
    incidents,
    setDown: (value: boolean) => {
      down = value;
      reachable = !value;
    },
  };
}

const at = (iso: string) => new Date(iso);

describe('StatusHistoryService', () => {
  const env = { ...process.env };
  let fetchSpy: jest.SpyInstance;

  beforeEach(() => {
    process.env.SUPABASE_URL = 'https://project.supabase.co';
    process.env.SUPABASE_ANON_KEY = 'anon';
    fetchSpy = jest
      .spyOn(global, 'fetch')
      .mockResolvedValue(new Response('{}', { status: 200 }));
  });

  afterEach(() => {
    process.env = { ...env };
    fetchSpy.mockRestore();
  });

  it('counts each check against its component and its day', async () => {
    const db = fakePrisma();
    const service = new StatusHistoryService(db.prisma);

    await service.tick(at('2026-10-11T10:00:00Z'));
    await service.tick(at('2026-10-11T10:05:00Z'));
    await service.tick(at('2026-10-12T00:01:00Z'));

    const database = db.days.filter((d) => d.component === 'database');
    expect(database.map((d) => [d.day.toISOString(), d.checks])).toEqual([
      ['2026-10-11T00:00:00.000Z', 2],
      ['2026-10-12T00:00:00.000Z', 1],
    ]);
    expect(db.days.every((d) => d.failures === 0)).toBe(true);
    // And asked Supabase Auth itself, not just whether it is configured.
    expect(fetchSpy).toHaveBeenCalledWith(
      'https://project.supabase.co/auth/v1/health',
      expect.objectContaining({ headers: { apikey: 'anon' } }),
    );
  });

  it('opens an incident on the first failure and closes it on recovery', async () => {
    const db = fakePrisma();
    const service = new StatusHistoryService(db.prisma);

    await service.tick(at('2026-10-11T10:00:00Z'));
    fetchSpy.mockResolvedValue(new Response('', { status: 503 }));
    await service.tick(at('2026-10-11T10:05:00Z'));
    await service.tick(at('2026-10-11T10:10:00Z'));
    fetchSpy.mockResolvedValue(new Response('{}', { status: 200 }));
    await service.tick(at('2026-10-11T10:15:00Z'));

    expect(db.incidents).toHaveLength(1);
    expect(db.incidents[0]).toMatchObject({
      component: 'auth',
      startedAt: at('2026-10-11T10:05:00Z'),
      endedAt: at('2026-10-11T10:15:00Z'),
      detail: 'Supabase Auth answered 503.',
    });
    const auth = db.days.find((d) => d.component === 'auth')!;
    expect([auth.checks, auth.failures]).toEqual([4, 2]);
  });

  it('writes a database outage down once the database is back', async () => {
    // The one failure that cannot be recorded while it lasts.
    const db = fakePrisma();
    const service = new StatusHistoryService(db.prisma);

    db.setDown(true);
    await service.tick(at('2026-10-11T10:00:00Z'));
    await service.tick(at('2026-10-11T10:05:00Z'));
    expect(service.waiting).toBe(2);
    expect(db.days).toHaveLength(0);

    db.setDown(false);
    await service.tick(at('2026-10-11T10:10:00Z'));

    expect(service.waiting).toBe(0);
    const database = db.days.find((d) => d.component === 'database')!;
    expect([database.checks, database.failures]).toEqual([3, 2]);
    expect(db.incidents).toEqual([
      expect.objectContaining({
        component: 'database',
        startedAt: at('2026-10-11T10:00:00Z'),
        endedAt: at('2026-10-11T10:10:00Z'),
      }),
    ]);
  });

  it('keeps no more than a week of results waiting', async () => {
    const db = fakePrisma();
    const service = new StatusHistoryService(db.prisma);
    db.setDown(true);

    const start = at('2026-10-01T00:00:00Z').getTime();
    for (let i = 0; i < StatusHistoryService.maxPending + 3; i++) {
      await service.tick(new Date(start + i * 5 * 60 * 1000));
    }

    expect(service.waiting).toBe(StatusHistoryService.maxPending);
  });

  it('reports uptime over the window, and a day with no checks as absent', async () => {
    const db = fakePrisma();
    const service = new StatusHistoryService(db.prisma);
    db.days.push(
      {
        day: at('2026-10-09T00:00:00Z'),
        component: 'database',
        checks: 100,
        failures: 0,
      },
      {
        day: at('2026-10-11T00:00:00Z'),
        component: 'database',
        checks: 100,
        failures: 4,
      },
      // Outside a three-day window.
      {
        day: at('2026-10-01T00:00:00Z'),
        component: 'database',
        checks: 100,
        failures: 100,
      },
    );

    const history = await service.history(3, at('2026-10-11T12:00:00Z'));

    const database = history.components.find((c) => c.id === 'database')!;
    expect(database.uptime).toBe(98);
    // The 10th had no checks and is simply not there.
    expect(database.days.map((d) => d.day)).toEqual([
      '2026-10-09',
      '2026-10-11',
    ]);
    // A component with no checks at all has no uptime to report.
    expect(history.components.find((c) => c.id === 'api')!.uptime).toBeNull();
    expect(history.intervalMinutes).toBe(StatusHistoryService.intervalMinutes);
  });
});
