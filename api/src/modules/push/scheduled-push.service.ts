import {
  Injectable,
  Logger,
  type OnApplicationBootstrap,
  type OnModuleDestroy,
} from '@nestjs/common';
import { AccountStatus, CoinKind } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { WEEKLY_COINS, weekStart } from '../gifts/gift-catalogue';
import { NotificationsService } from '../notifications/notifications.service';
import { type PushText, say } from './push-text';
import { PushService } from './push.service';

const HOUR = 3_600_000;
const DAY = 24 * HOUR;

/**
 * The pushes nobody's action sends: "while you were away" for somebody who
 * has not opened the app in a while and has something new waiting, and
 * "your coins are back" when the week's gift coins refill.
 *
 * Every one has to be worth opening. A reminder with nothing behind it
 * teaches people to switch notifications off, so:
 *
 * - **Away** goes only after 36 hours without the app, only with something
 *   new since then and since the last one sent, at most once a day, in the
 *   person's evening, and never to somebody gone a month -- they have
 *   decided.
 * - **Coins** goes once a week, only to somebody who spent some last week:
 *   a wallet that was never touched has nothing new to say.
 * - Both are off with User.reminderPushes, from Settings, Notifications.
 *
 * Run every 15 minutes while the server is up, and from outside by
 * .github/workflows/scheduled-pushes.yml, which also wakes a sleeping
 * server. Each run decides from the database and records what it sent, so
 * two runs at once, or one run twice, send nothing twice.
 */
@Injectable()
export class ScheduledPushService
  implements OnApplicationBootstrap, OnModuleDestroy
{
  private readonly log = new Logger(ScheduledPushService.name);
  private timer: NodeJS.Timeout | null = null;
  private running = false;

  /** How long without the app before "while you were away". */
  static readonly awayAfter = 36 * HOUR;
  /** Gone longer than this, and they are left alone. */
  static readonly forgetAfter = 30 * DAY;
  /** The least time between two of them. */
  static readonly awayEvery = 22 * HOUR;
  /** The local hours they may arrive in: evening, before it is late. */
  static readonly evening = { from: 18, to: 21 } as const;
  /** The local hours the coins one may arrive in: a weekday morning. */
  static readonly morning = { from: 9, to: 12 } as const;
  /** Until the app reports a phone's offset: West Africa, where the team
   * and most of the test are. */
  static readonly defaultOffsetMinutes = 60;
  /** How many people one run looks at, of each kind. */
  static readonly batch = 500;

  constructor(
    private readonly prisma: PrismaService,
    private readonly push: PushService,
    private readonly notifications: NotificationsService,
  ) {}

  onApplicationBootstrap(): void {
    if (
      process.env.NODE_ENV === 'test' ||
      process.env.SCHEDULED_PUSHES === 'off'
    ) {
      return;
    }
    this.timer = setInterval(() => void this.runDue(), 15 * 60_000);
    // Never what keeps the process alive.
    this.timer.unref();
  }

  onModuleDestroy(): void {
    if (this.timer) clearInterval(this.timer);
  }

  /** Sends whatever is due now, and says how many of each went. */
  async runDue(now = new Date()): Promise<{ away: number; coins: number }> {
    if (this.running) return { away: 0, coins: 0 };
    this.running = true;
    try {
      const away = await this.awayDue(now);
      const coins = await this.coinsDue(now);
      if (away || coins) {
        this.log.log(`Sent ${away} away and ${coins} coins reminder(s).`);
      }
      return { away, coins };
    } catch (error) {
      this.log.error(`A scheduled run failed: ${String(error)}`);
      return { away: 0, coins: 0 };
    } finally {
      this.running = false;
    }
  }

  /** [now] in somebody's own day: the hour, 0 to 23. */
  static localHour(now: Date, offsetMinutes: number | null): number {
    const minutes =
      now.getUTCHours() * 60 +
      now.getUTCMinutes() +
      (offsetMinutes ?? ScheduledPushService.defaultOffsetMinutes);
    return Math.floor((((minutes % 1440) + 1440) % 1440) / 60);
  }

  private static within(
    hour: number,
    window: { readonly from: number; readonly to: number },
  ): boolean {
    return hour >= window.from && hour < window.to;
  }

  /** The people a reminder may go to at all. */
  private readonly reachable = {
    reminderPushes: true,
    deletedAt: null,
    status: AccountStatus.ACTIVE,
    devices: { some: {} },
  } as const;

  private async awayDue(now: Date): Promise<number> {
    const candidates = await this.prisma.user.findMany({
      where: {
        ...this.reachable,
        lastActiveAt: {
          lt: new Date(now.getTime() - ScheduledPushService.awayAfter),
          gt: new Date(now.getTime() - ScheduledPushService.forgetAfter),
        },
        OR: [
          { awayPushAt: null },
          {
            awayPushAt: {
              lt: new Date(now.getTime() - ScheduledPushService.awayEvery),
            },
          },
        ],
      },
      select: {
        id: true,
        lastActiveAt: true,
        awayPushAt: true,
        utcOffsetMinutes: true,
      },
      take: ScheduledPushService.batch,
    });

    let sent = 0;
    for (const person of candidates) {
      const hour = ScheduledPushService.localHour(now, person.utcOffsetMinutes);
      if (!ScheduledPushService.within(hour, ScheduledPushService.evening)) {
        continue;
      }
      const since = new Date(
        Math.max(
          person.lastActiveAt?.getTime() ?? 0,
          person.awayPushAt?.getTime() ?? 0,
        ),
      );
      const body = await this.whatIsNew(person.id, since);
      if (!body) continue;

      // Claimed before sending, and only if nobody else claimed it first:
      // a second run at the same moment finds it taken and moves on.
      const claimed = await this.prisma.user.updateMany({
        where: {
          id: person.id,
          awayPushAt: person.awayPushAt ?? null,
        },
        data: { awayPushAt: now },
      });
      if (claimed.count === 0) continue;
      await this.push.sendTo(person.id, {
        title: say('away_title'),
        body,
        data: { type: 'away' },
      });
      sent++;
    }
    return sent;
  }

  /**
   * What is waiting for [userId] that is newer than [since]: posts from
   * people they follow, and things done to their own. Null when nothing
   * is -- and then nothing is sent.
   */
  private async whatIsNew(
    userId: string,
    since: Date,
  ): Promise<PushText | null> {
    const [posts, activity] = await Promise.all([
      this.prisma.post.findMany({
        where: {
          createdAt: { gt: since },
          deletedAt: null,
          author: {
            followers: { some: { followerId: userId } },
            status: AccountStatus.ACTIVE,
            deletedAt: null,
          },
        },
        orderBy: { createdAt: 'desc' },
        take: 50,
        select: {
          author: { select: { id: true, name: true, username: true } },
        },
      }),
      this.notifications.unreadCount(userId, {
        mentions: true,
        gifts: true,
        after: since,
      }),
    ]);

    const parts: PushText[] = [];
    const authors = new Map<string, string>();
    for (const { author } of posts) {
      if (!authors.has(author.id)) {
        authors.set(author.id, author.name ?? author.username ?? '');
      }
    }
    if (authors.size > 0) {
      const first = [...authors.values()].find((n) => n) ?? say('someone');
      const others = authors.size - 1;
      const who =
        others === 0
          ? first
          : others === 1
            ? say('and_one_other', { name: first })
            : say('and_others', { name: first, count: others });
      parts.push(say('away_posted', { who }));
    }
    if (activity.count === 1) parts.push(say('away_activity_one'));
    if (activity.count > 1) {
      parts.push(say('away_activity', { count: activity.count }));
    }
    return parts.length ? parts : null;
  }

  private async coinsDue(now: Date): Promise<number> {
    const week = weekStart(now);
    const lastWeek = new Date(week.getTime() - 7 * DAY);
    const spent = await this.prisma.coinEntry.findMany({
      where: {
        kind: CoinKind.SPEND,
        createdAt: { gte: lastWeek, lt: week },
        user: {
          ...this.reachable,
          OR: [{ refillPushAt: null }, { refillPushAt: { lt: week } }],
        },
      },
      distinct: ['userId'],
      select: {
        user: {
          select: { id: true, utcOffsetMinutes: true, refillPushAt: true },
        },
      },
      take: ScheduledPushService.batch,
    });

    let sent = 0;
    for (const { user } of spent) {
      const hour = ScheduledPushService.localHour(now, user.utcOffsetMinutes);
      if (!ScheduledPushService.within(hour, ScheduledPushService.morning)) {
        continue;
      }
      const claimed = await this.prisma.user.updateMany({
        where: { id: user.id, refillPushAt: user.refillPushAt ?? null },
        data: { refillPushAt: now },
      });
      if (claimed.count === 0) continue;
      await this.push.sendTo(user.id, {
        title: say('refill_title'),
        body: say('refill_body', { coins: WEEKLY_COINS }),
        data: { type: 'coins' },
      });
      sent++;
    }
    return sent;
  }
}
