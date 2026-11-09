import { randomUUID } from 'node:crypto';

import { CoinKind, PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { weekStart } from '../gifts/gift-catalogue';
import { NotificationsService } from '../notifications/notifications.service';
import { render } from './push-text';
import type { PushMessage, PushService } from './push.service';
import { ScheduledPushService } from './scheduled-push.service';

/**
 * The scheduled pushes against a real Postgres: who is told they missed
 * something, and only when they did; who is told their coins are back.
 * Skipped unless MODERATION_TEST_DATABASE_URL names a migrated database.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

const HOUR = 3_600_000;

/**
 * 19:30 in Lagos (UTC+1), two days ago: evening, and in the past. Never a
 * fixed date -- the other database specs share these tables, and posts
 * dated in the future sat above all of theirs in every feed they read.
 */
const EVENING = (() => {
  const at = new Date();
  at.setUTCDate(at.getUTCDate() - 2);
  at.setUTCHours(18, 30, 0, 0);
  return at;
})();

/** 10:00 in Lagos on the most recent Monday at least a day past. */
const MONDAY_MORNING = (() => {
  const at = weekStart(new Date(Date.now() - 24 * HOUR));
  at.setUTCHours(9, 0, 0, 0);
  return at;
})();

run('scheduled pushes, against a real database', () => {
  let prisma: PrismaClient;
  let scheduled: ScheduledPushService;
  const sent: { userId: string; message: PushMessage }[] = [];
  const stamp = Date.now();
  // Ada has been away and has something new; Ben has been away with
  // nothing new; Cy was here an hour ago; Di is away but switched
  // reminders off; Ed writes the posts.
  const [ada, ben, cy, di, ed] = [0, 1, 2, 3, 4].map(() => randomUUID());
  const everyone = [ada, ben, cy, di, ed];

  const sentTo = (id: string) => sent.filter((s) => s.userId === id);

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    const push = {
      sendTo: (userId: string, message: PushMessage) => {
        sent.push({ userId, message });
        return Promise.resolve();
      },
    } as unknown as PushService;
    scheduled = new ScheduledPushService(
      prisma as PrismaService,
      push,
      new NotificationsService(prisma as PrismaService),
    );

    const away = new Date(EVENING.getTime() - 48 * HOUR);
    for (const [id, lastActiveAt, reminderPushes] of [
      [ada, away, true],
      [ben, away, true],
      [cy, new Date(EVENING.getTime() - HOUR), true],
      [di, away, false],
      [ed, away, true],
    ] as const) {
      await prisma.user.create({
        data: {
          id,
          username: `sp${id.slice(0, 6)}${stamp}`,
          email: `sp${id}@example.test`,
          name: id === ed ? 'Ed' : null,
          lastActiveAt,
          utcOffsetMinutes: 60,
          reminderPushes,
          devices: {
            create: { token: `token-${id}-${stamp}`, platform: 'android' },
          },
        },
      });
    }
    // Ada, Cy and Di follow Ed, who posts after they left. Ben follows
    // nobody, and nothing happens to his posts.
    for (const follower of [ada, cy, di]) {
      await prisma.follow.create({
        data: { followerId: follower, followingId: ed },
      });
    }
    await prisma.post.create({
      data: {
        authorId: ed,
        content: 'something new',
        createdAt: new Date(EVENING.getTime() - 10 * HOUR),
      },
    });
  });

  afterAll(async () => {
    await prisma?.user.deleteMany({ where: { id: { in: everyone } } });
    await prisma?.$disconnect();
  });

  beforeEach(() => sent.splice(0));

  it('tells somebody away what is new, in their evening, once', async () => {
    await scheduled.runDue(EVENING);

    expect(sentTo(ada)).toHaveLength(1);
    const [{ message }] = sentTo(ada);
    expect(render(message.title, 'en')).toBe('While you were away');
    expect(render(message.body, 'en')).toBe('Ed posted.');
    expect(render(message.body, 'fr')).toBe('Ed a publié.');

    // A second run, a minute later, sends nothing again.
    await scheduled.runDue(new Date(EVENING.getTime() + 60_000));
    expect(sentTo(ada)).toHaveLength(1);
  });

  it('says nothing to somebody away with nothing new', async () => {
    await scheduled.runDue(EVENING);
    expect(sentTo(ben)).toHaveLength(0);
  });

  it('says nothing to somebody who was just here', async () => {
    await scheduled.runDue(EVENING);
    expect(sentTo(cy)).toHaveLength(0);
  });

  it('says nothing to somebody who turned reminders off', async () => {
    await scheduled.runDue(EVENING);
    expect(sentTo(di)).toHaveLength(0);
  });

  it('waits for the evening', async () => {
    await prisma.user.update({
      where: { id: ada },
      data: { awayPushAt: null },
    });
    // 03:30 in Lagos, the night after.
    const night = new Date(EVENING);
    night.setUTCDate(night.getUTCDate() + 1);
    night.setUTCHours(2, 30, 0, 0);
    await scheduled.runDue(night);
    expect(sentTo(ada)).toHaveLength(0);
  });

  it('a day later, only if something else is new', async () => {
    const day = new Date(EVENING.getTime() + 24 * HOUR);
    await prisma.user.update({
      where: { id: ada },
      data: { awayPushAt: EVENING },
    });
    await scheduled.runDue(day);
    expect(sentTo(ada)).toHaveLength(0);

    await prisma.post.create({
      data: {
        authorId: ed,
        content: 'and more',
        createdAt: new Date(day.getTime() - HOUR),
      },
    });
    await scheduled.runDue(day);
    expect(sentTo(ada)).toHaveLength(1);
  });

  it('tells somebody who spent coins last week that they are back', async () => {
    const lastWeek = new Date(
      weekStart(MONDAY_MORNING).getTime() - 2 * 24 * HOUR,
    );
    await prisma.coinEntry.create({
      data: {
        userId: ben,
        kind: CoinKind.SPEND,
        amount: -5,
        key: `spend:${ben}:${stamp}`,
        createdAt: lastWeek,
      },
    });

    await scheduled.runDue(MONDAY_MORNING);
    const coins = sentTo(ben).filter((s) => s.message.data?.type === 'coins');
    expect(coins).toHaveLength(1);
    expect(render(coins[0].message.body, 'en')).toBe(
      '100 coins to send as gifts this week.',
    );
    // Nobody who spent nothing.
    expect(
      sentTo(cy).filter((s) => s.message.data?.type === 'coins'),
    ).toHaveLength(0);

    // Once a week.
    await scheduled.runDue(new Date(MONDAY_MORNING.getTime() + HOUR));
    expect(
      sentTo(ben).filter((s) => s.message.data?.type === 'coins'),
    ).toHaveLength(1);
  });
});

describe("where in somebody's day it is", () => {
  it('adds their offset, round the clock', () => {
    const at = new Date('2026-11-11T23:30:00Z');
    expect(ScheduledPushService.localHour(at, 60)).toBe(0);
    expect(ScheduledPushService.localHour(at, -300)).toBe(18);
    expect(ScheduledPushService.localHour(at, 330)).toBe(5);
    // Unknown: the team's own zone.
    expect(ScheduledPushService.localHour(at, null)).toBe(0);
  });
});
