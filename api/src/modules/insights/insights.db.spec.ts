import { randomUUID } from 'node:crypto';

import { PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { InsightsService } from './insights.service';

/**
 * Insights against a real Postgres: the reach CTE, the per-day and per-post
 * counts, the audience floors. Skipped unless MODERATION_TEST_DATABASE_URL
 * names a migrated database (see docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('Insights, against a real database', () => {
  let prisma: PrismaClient;
  let insights: InsightsService;

  const DAY = 86_400_000;
  const NOW = new Date('2026-10-28T12:00:00Z');
  const ago = (days: number) => new Date(NOW.getTime() - days * DAY);
  const stamp = Date.now();

  const author = randomUUID();
  // Thirty people reached this period, eight the period before.
  const viewers = Array.from({ length: 38 }, () => randomUUID());
  const users = [author, ...viewers];
  const posts: string[] = [];
  let jazz = '';
  let club = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    insights = new InsightsService(prisma as PrismaService);

    for (const id of users) {
      await prisma.user.create({
        data: { id, email: `${id}.${stamp}@example.test` },
      });
    }
    await prisma.userProfile.create({
      data: { userId: author, bio: 'I write about jazz' },
    });

    const interest = await prisma.interest.create({
      data: { slug: `jazz-${stamp}`, name: `Jazz ${stamp}` },
    });
    jazz = interest.id;
    const community = await prisma.community.create({
      data: {
        slug: `club-${stamp}`,
        name: `Club ${stamp}`,
        createdById: author,
      },
    });
    club = community.id;

    for (let i = 0; i < 4; i++) {
      const post = await prisma.post.create({
        data: {
          authorId: author,
          content: `post ${i}`,
          createdAt: ago(20 - i),
        },
      });
      posts.push(post.id);
    }

    // This period: viewers 0-29 shown post 0 two days ago; 0-9 also opened
    // post 1 ten days ago. Previous period: viewers 30-37 shown post 0.
    for (let i = 0; i < 30; i++) {
      await prisma.postImpression.create({
        data: {
          viewerId: viewers[i],
          postId: posts[0],
          createdAt: ago(2),
          lastAt: ago(2),
        },
      });
    }
    for (let i = 0; i < 10; i++) {
      await prisma.postView.create({
        data: {
          viewerId: viewers[i],
          postId: posts[1],
          createdAt: ago(10),
          lastViewedAt: ago(10),
        },
      });
    }
    for (let i = 30; i < 38; i++) {
      await prisma.postImpression.create({
        data: {
          viewerId: viewers[i],
          postId: posts[0],
          createdAt: ago(40),
          lastAt: ago(40),
        },
      });
    }
    // The author looking at their own post is not reach.
    await prisma.postImpression.create({
      data: { viewerId: author, postId: posts[0], createdAt: ago(1) },
    });

    // Six of the people reached follow the author.
    for (let i = 0; i < 6; i++) {
      await prisma.follow.create({
        data: {
          followerId: viewers[i],
          followingId: author,
          createdAt: ago(3),
        },
      });
    }
    // Seven follow Jazz, which clears the floor of five; four are in the
    // club, which does not.
    for (let i = 0; i < 7; i++) {
      await prisma.userInterest.create({
        data: { userId: viewers[i], interestId: jazz },
      });
    }
    for (let i = 0; i < 4; i++) {
      await prisma.communityMember.create({
        data: { userId: viewers[i], communityId: club },
      });
    }
    // Ages: six aged 20, two aged 40. Only 18-24 clears the floor.
    // Countries: five in Nigeria, two in Ghana. Only Nigeria clears it.
    for (let i = 0; i < 8; i++) {
      await prisma.userProfile.create({
        data: {
          userId: viewers[i],
          dateOfBirth: new Date(i < 6 ? '2006-01-01' : '1986-01-01'),
          country: i < 5 ? 'NG' : i < 7 ? 'GH' : null,
        },
      });
    }
    await prisma.postLike.create({
      data: { userId: viewers[0], postId: posts[0], createdAt: ago(2) },
    });
  });

  afterAll(async () => {
    await prisma?.communityMember.deleteMany({ where: { communityId: club } });
    await prisma?.community.deleteMany({ where: { id: club } });
    await prisma?.userInterest.deleteMany({ where: { interestId: jazz } });
    await prisma?.interest.deleteMany({ where: { id: jazz } });
    await prisma?.post.deleteMany({ where: { id: { in: posts } } });
    await prisma?.user.deleteMany({ where: { id: { in: users } } });
    await prisma?.$disconnect();
  });

  it('counts people reached, against the period before', async () => {
    const report = await insights.report(author, 30, 0, NOW);

    expect(report.reach).toEqual({ current: 30, previous: 8 });
    expect(report.followersReached).toBe(6);
    expect(report.opens.current).toBe(10);
    expect(report.likes.current).toBe(1);
    expect(report.newFollowers.current).toBe(6);
    expect(report.followers).toBe(6);
  });

  it('draws every day of the period, quiet ones as zero', async () => {
    const report = await insights.report(author, 30, 0, NOW);

    expect(report.timeline).toHaveLength(30);
    const byDate = new Map(report.timeline.map((d) => [d.date, d.reach]));
    expect(byDate.get('2026-10-26')).toBe(30);
    expect(byDate.get('2026-10-18')).toBe(10);
    expect(report.timeline.reduce((n, d) => n + d.reach, 0)).toBe(40);
  });

  it('ranks posts by the people they reached', async () => {
    const report = await insights.report(author, 30, 0, NOW);

    expect(report.topPosts.map((p) => [p.id, p.reach])).toEqual([
      [posts[0], 30],
      [posts[1], 10],
    ]);
  });

  it('holds the audience to its floors', async () => {
    const report = await insights.report(author, 30, 0, NOW);
    const { audience } = report;

    expect(audience.enough).toBe(true);
    expect(audience.interests.map((g) => [g.name, g.count])).toEqual([
      [`Jazz ${stamp}`, 7],
    ]);
    // Four in the club: a group that small is nearly a name list.
    expect(audience.communities).toEqual([]);
    expect(audience.ages).toEqual([{ band: '18-24', count: 6 }]);
    expect(audience.agesKnown).toBe(8);
    // Two in Ghana are counted as known but not named.
    expect(audience.countries).toEqual([{ code: 'NG', count: 5 }]);
    expect(audience.countriesKnown).toBe(7);
    // Thirty sittings, all on one hour two days ago (a Monday, 12:00 UTC).
    expect(audience.activeHours.reduce((a, b) => a + b, 0)).toBe(40);
    expect(audience.activeHours[12]).toBe(30);
  });

  it("shows nobody's audience when too few were reached", async () => {
    // The week ending five days ago holds only the ten opens from ten days
    // ago: under the floor of twenty, so nothing about who they are.
    const earlier = await insights.report(
      author,
      7,
      0,
      new Date(NOW.getTime() - 5 * DAY),
    );
    expect(earlier.reach.current).toBe(10);
    expect(earlier.audience.enough).toBe(false);
    expect(earlier.audience.interests).toEqual([]);
    expect(earlier.audience.ages).toEqual([]);
    expect(earlier.audience.activeHours.every((n) => n === 0)).toBe(true);
    // And the summary says nothing about them either.
    expect(earlier.summary.map((s) => s.code)).toEqual(['reach_first']);
  });

  it("days on the chart are the reader's days", async () => {
    // Two days ago at 12:00 UTC is 01:00 the next day at UTC+13.
    const report = await insights.report(author, 30, 13 * 60, NOW);
    const byDate = new Map(report.timeline.map((d) => [d.date, d.reach]));
    expect(byDate.get('2026-10-27')).toBe(30);
  });
});
