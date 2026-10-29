import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { GrowthFacts, GrowthTip, GrowthTips, SummaryLine } from './growth-tips';

/** A number for this period and the one before it, the same length. */
export interface Compared {
  current: number;
  previous: number;
}

/** One named group in the audience, and how many of it. */
export interface AudienceGroup {
  slug: string;
  name: string;
  count: number;
}

export interface InsightsReport {
  days: number;
  since: string;
  until: string;

  /** People shown or opening one of your posts for the first time. */
  reach: Compared;
  /** Of [reach.current], those who already follow you. */
  followersReached: number;
  /** First opens of your posts: a person opening a post counts once. */
  opens: Compared;
  likes: Compared;
  comments: Compared;
  reposts: Compared;
  saves: Compared;
  /** Follows that started in the period and still stand. Unfollows are not
   * recorded, so this is not net. */
  newFollowers: Compared;
  followers: number;

  /** People reached each day, in the reader's time zone. */
  timeline: { date: string; reach: number }[];

  audience: {
    /** Under [GrowthTips.audienceFloor] people reached, there is nothing here
     * that would not risk pointing at somebody. */
    enough: boolean;
    /** Age bands with at least [InsightsService.minGroup] people in them. */
    ages: { band: string; count: number }[];
    /** How many of the people reached gave a birthday at all. */
    agesKnown: number;
    interests: AudienceGroup[];
    communities: AudienceGroup[];
    /** Countries with at least [InsightsService.minGroup] people in them,
     * the five largest, as ISO codes: the app names them in its language. */
    countries: { code: string; count: number }[];
    /** How many of the people reached have a country on their profile. */
    countriesKnown: number;
    /** Sittings on your posts by hour of the week, UTC, Monday 00:00 first. */
    activeHours: number[];
  };

  topPosts: {
    id: string;
    excerpt: string;
    createdAt: string;
    reach: number;
    likes: number;
    comments: number;
    reposts: number;
  }[];

  summary: SummaryLine[];
  tips: GrowthTip[];
}

const DAY = 86_400_000;

/**
 * How an account is doing, for its owner: reach, interactions, followers,
 * who the audience is, and what to do next.
 *
 * Measured, never estimated, and said plainly where the data stops. Reach is
 * counted from when each post was first in front of each person
 * (PostImpression.createdAt and PostView.createdAt), which is what lets a
 * period be compared with the one before it -- a "last seen" time is
 * overwritten and cannot say who was reached last month. There are no
 * countries, cities or genders: Kyron does not collect them, and a guess at
 * them presented as a measurement would be worse than the gap.
 *
 * The audience is about other people, so it is held to two rules: nothing at
 * all under [GrowthTips.audienceFloor] people reached, and no group smaller
 * than [minGroup]. Without them "1 viewer, 25-34, in the Lagos Runners
 * community" names somebody.
 */
@Injectable()
export class InsightsService {
  constructor(private readonly prisma: PrismaService) {}

  /** The periods offered. Anything else is read as the nearest default. */
  static readonly periods = [7, 30, 90] as const;

  /** The smallest group the audience breakdowns will show. */
  static readonly minGroup = 5;

  /** Age bands, by lower bound. */
  static readonly ageBands: [number, string][] = [
    [13, '13-17'],
    [18, '18-24'],
    [25, '25-34'],
    [35, '35-44'],
    [45, '45-54'],
    [55, '55-64'],
    [65, '65+'],
  ];

  static period(days: number | undefined): number {
    return (InsightsService.periods as readonly number[]).includes(days ?? 0)
      ? (days as number)
      : 30;
  }

  /** A time-zone offset in minutes, as a phone reports it, within reason. */
  static offset(minutes: number | undefined): number {
    if (minutes === undefined || !Number.isFinite(minutes)) return 0;
    return Math.max(-14 * 60, Math.min(14 * 60, Math.round(minutes)));
  }

  async report(
    userId: string,
    requestedDays?: number,
    tzOffsetMinutes?: number,
    now = new Date(),
  ): Promise<InsightsReport> {
    const days = InsightsService.period(requestedDays);
    const offset = InsightsService.offset(tzOffsetMinutes);
    const until = now;
    const since = new Date(until.getTime() - days * DAY);
    const before = new Date(since.getTime() - days * DAY);

    const [reach, perDay, byPost, counts, posts, profile, comments] =
      await Promise.all([
        this.reach(userId, before, since, until),
        this.daily(userId, since, until, offset),
        this.reachByPost(userId, since, until),
        this.counts(userId, before, since, until),
        this.prisma.post.findMany({
          where: {
            authorId: userId,
            deletedAt: null,
            createdAt: { gte: since, lt: until },
          },
          select: {
            id: true,
            topics: { select: { interestId: true }, take: 1 },
          },
        }),
        this.prisma.userProfile.findUnique({
          where: { userId },
          select: { avatarUrl: true, bio: true },
        }),
        this.commentsAnswered(userId, since, until),
      ]);

    const timeline = InsightsService.timeline(perDay, since, days, offset);
    const ranked = [...byPost].sort(
      (a, b) => b.reach - a.reach || a.id.localeCompare(b.id),
    );

    const enough = reach.current >= GrowthTips.audienceFloor;
    const [audience, topPosts] = await Promise.all([
      enough
        ? this.audience(userId, since, until)
        : Promise.resolve(InsightsService.noAudience()),
      this.topPosts(ranked.slice(0, 5)),
    ]);

    const others = ranked.slice(1).map((p) => p.reach);
    const topCommunity = audience.communities[0];
    const facts: GrowthFacts = {
      days,
      reach: { current: reach.current, previous: reach.previous },
      followersReached: reach.followers,
      newFollowers: counts.newFollowers,
      posts: {
        count: posts.length,
        withTopic: posts.filter((p) => p.topics.length > 0).length,
      },
      profile: {
        hasAvatar: !!profile?.avatarUrl,
        hasBio: !!profile?.bio?.trim(),
      },
      comments,
      topPost: ranked[0] ?? null,
      otherPostsMedianReach: InsightsService.median(others),
      otherPostsCount: others.length,
      topCommunity: topCommunity
        ? {
            slug: topCommunity.slug,
            name: topCommunity.name,
            postedThere: await this.postedIn(userId, topCommunity.slug, since),
          }
        : null,
      bestHourOfWeek: enough
        ? InsightsService.busiest(audience.activeHours)
        : null,
      topInterest: audience.interests[0] ?? null,
    };

    return {
      days,
      since: since.toISOString(),
      until: until.toISOString(),
      reach: facts.reach,
      followersReached: reach.followers,
      opens: counts.opens,
      likes: counts.likes,
      comments: counts.comments,
      reposts: counts.reposts,
      saves: counts.saves,
      newFollowers: counts.newFollowers,
      followers: counts.followers,
      timeline,
      audience: { enough, ...audience },
      topPosts,
      summary: GrowthTips.summary(facts),
      tips: GrowthTips.tips(facts),
    };
  }

  /**
   * Every first contact between another person and one of [userId]'s posts
   * from [from] to [until]: first time on their screen, or first time
   * opened, whichever the row records. The author's own looks are not reach.
   *
   * A CTE, aggregated where it is used: a popular account's contacts over
   * two ninety-day periods are far too many rows to bring back.
   */
  private static contacts(userId: string, from: Date, until: Date) {
    return Prisma.sql`contacts AS (
      SELECT i."viewerId" AS "viewerId", i."postId" AS "postId", i."createdAt" AS "at"
      FROM "PostImpression" i
      JOIN "Post" p ON p.id = i."postId"
      WHERE p."authorId" = ${userId}::uuid
        AND i."viewerId" <> ${userId}::uuid
        AND i."createdAt" >= ${from} AND i."createdAt" < ${until}
      UNION ALL
      SELECT v."viewerId", v."postId", v."createdAt"
      FROM "PostView" v
      JOIN "Post" p ON p.id = v."postId"
      WHERE p."authorId" = ${userId}::uuid
        AND v."viewerId" <> ${userId}::uuid
        AND v."createdAt" >= ${from} AND v."createdAt" < ${until}
    )`;
  }

  /** People reached in each period, and how many of this period's follow. */
  private async reach(userId: string, before: Date, since: Date, until: Date) {
    const [row] = await this.prisma.$queryRaw<
      { current: bigint; previous: bigint; followers: bigint }[]
    >(Prisma.sql`
      WITH ${InsightsService.contacts(userId, before, until)}
      SELECT
        COUNT(DISTINCT c."viewerId") FILTER (WHERE c.at >= ${since}) AS current,
        COUNT(DISTINCT c."viewerId") FILTER (WHERE c.at < ${since}) AS previous,
        COUNT(DISTINCT c."viewerId") FILTER (
          WHERE c.at >= ${since} AND EXISTS (
            SELECT 1 FROM "Follow" f
            WHERE f."followerId" = c."viewerId" AND f."followingId" = ${userId}::uuid
          )
        ) AS followers
      FROM contacts c
    `);
    return {
      current: Number(row?.current ?? 0),
      previous: Number(row?.previous ?? 0),
      followers: Number(row?.followers ?? 0),
    };
  }

  /** People reached per day of the reader's calendar. */
  private async daily(
    userId: string,
    since: Date,
    until: Date,
    offsetMinutes: number,
  ) {
    const rows = await this.prisma.$queryRaw<
      { date: string; reach: bigint }[]
    >(Prisma.sql`
      WITH ${InsightsService.contacts(userId, since, until)}
      SELECT to_char((c.at AT TIME ZONE 'UTC') + make_interval(mins => ${offsetMinutes}::int),
                     'YYYY-MM-DD') AS date,
             COUNT(DISTINCT c."viewerId") AS reach
      FROM contacts c
      GROUP BY 1
    `);
    return rows.map((r) => ({ date: r.date, reach: Number(r.reach) }));
  }

  /** People reached by each post, this period. */
  private async reachByPost(userId: string, since: Date, until: Date) {
    const rows = await this.prisma.$queryRaw<
      { postId: string; reach: bigint }[]
    >(Prisma.sql`
      WITH ${InsightsService.contacts(userId, since, until)}
      SELECT c."postId" AS "postId", COUNT(DISTINCT c."viewerId") AS reach
      FROM contacts c
      GROUP BY 1
    `);
    return rows.map((r) => ({ id: r.postId, reach: Number(r.reach) }));
  }

  /** Interactions and followers, for this period and the one before. */
  private async counts(userId: string, before: Date, since: Date, until: Date) {
    const mine = { authorId: userId };
    const pair = async (
      count: (range: { gte: Date; lt: Date }) => Promise<number>,
    ): Promise<Compared> => {
      const [current, previous] = await Promise.all([
        count({ gte: since, lt: until }),
        count({ gte: before, lt: since }),
      ]);
      return { current, previous };
    };
    const notMe = { not: userId };

    const [opens, likes, comments, reposts, saves, newFollowers, followers] =
      await Promise.all([
        pair((createdAt) =>
          this.prisma.postView.count({
            where: { post: mine, viewerId: notMe, createdAt },
          }),
        ),
        pair((createdAt) =>
          this.prisma.postLike.count({
            where: { post: mine, userId: notMe, createdAt },
          }),
        ),
        pair((createdAt) =>
          this.prisma.comment.count({
            where: {
              post: mine,
              authorId: notMe,
              deletedAt: null,
              createdAt,
            },
          }),
        ),
        pair((createdAt) =>
          this.prisma.repost.count({
            where: { post: mine, userId: notMe, createdAt },
          }),
        ),
        pair((createdAt) =>
          this.prisma.postSave.count({
            where: { post: mine, userId: notMe, createdAt },
          }),
        ),
        pair((createdAt) =>
          this.prisma.follow.count({
            where: { followingId: userId, createdAt },
          }),
        ),
        this.prisma.follow.count({ where: { followingId: userId } }),
      ]);

    return { opens, likes, comments, reposts, saves, newFollowers, followers };
  }

  /** Comments from other people in the period, and how many the author
   * answered in their thread. */
  private async commentsAnswered(userId: string, since: Date, until: Date) {
    const received = {
      post: { authorId: userId },
      authorId: { not: userId },
      deletedAt: null,
      createdAt: { gte: since, lt: until },
    };
    const [count, answered] = await Promise.all([
      this.prisma.comment.count({ where: received }),
      this.prisma.comment.count({
        where: {
          ...received,
          replies: { some: { authorId: userId, deletedAt: null } },
        },
      }),
    ]);
    return { received: count, answered };
  }

  /** Who the people reached are, held to the group floor. */
  private async audience(userId: string, since: Date, until: Date) {
    const floor = InsightsService.minGroup;
    const reached = Prisma.sql`
      WITH ${InsightsService.contacts(userId, since, until)},
      reached AS (SELECT DISTINCT c."viewerId" AS id FROM contacts c)`;

    const [ages, interests, communities, countries, hours] = await Promise.all([
      this.prisma.$queryRaw<{ age: number; count: bigint }[]>(Prisma.sql`
        ${reached}
        SELECT date_part('year', age(${until}::timestamptz, pr."dateOfBirth"))::int AS age,
               COUNT(*) AS count
        FROM reached r JOIN "UserProfile" pr ON pr."userId" = r.id
        WHERE pr."dateOfBirth" IS NOT NULL
        GROUP BY 1
      `),
      this.prisma.$queryRaw<{ slug: string; name: string; count: bigint }[]>(
        Prisma.sql`
        ${reached}
        SELECT i.slug, i.name, COUNT(*) AS count
        FROM reached r
        JOIN "UserInterest" ui ON ui."userId" = r.id
        JOIN "Interest" i ON i.id = ui."interestId"
        GROUP BY i.id, i.slug, i.name
        HAVING COUNT(*) >= ${floor}
        ORDER BY 3 DESC, 1
        LIMIT 5
      `,
      ),
      this.prisma.$queryRaw<{ slug: string; name: string; count: bigint }[]>(
        Prisma.sql`
        ${reached}
        SELECT cm.slug, cm.name, COUNT(*) AS count
        FROM reached r
        JOIN "CommunityMember" m ON m."userId" = r.id
        JOIN "Community" cm ON cm.id = m."communityId"
        WHERE cm."deletedAt" IS NULL
        GROUP BY cm.id, cm.slug, cm.name
        HAVING COUNT(*) >= ${floor}
        ORDER BY 3 DESC, 1
        LIMIT 5
      `,
      ),
      // Every country, small ones included, so the known total can be
      // counted from the same rows; the floor is applied below.
      this.prisma.$queryRaw<{ code: string; count: bigint }[]>(Prisma.sql`
        ${reached}
        SELECT pr.country AS code, COUNT(*) AS count
        FROM reached r JOIN "UserProfile" pr ON pr."userId" = r.id
        WHERE pr.country IS NOT NULL
        GROUP BY 1
        ORDER BY 2 DESC, 1
      `),
      // When the people reached were last on these posts. Last rather than
      // first: it is when they are around, which is what a best time to
      // post is about.
      this.prisma.$queryRaw<{ hour: number; count: bigint }[]>(Prisma.sql`
        SELECT ((EXTRACT(ISODOW FROM t.at AT TIME ZONE 'UTC')::int - 1) * 24
                + EXTRACT(HOUR FROM t.at AT TIME ZONE 'UTC')::int) AS hour,
               COUNT(*) AS count
        FROM (
          SELECT i."lastAt" AS at
          FROM "PostImpression" i JOIN "Post" p ON p.id = i."postId"
          WHERE p."authorId" = ${userId}::uuid
            AND i."viewerId" <> ${userId}::uuid
            AND i."lastAt" >= ${since} AND i."lastAt" < ${until}
          UNION ALL
          SELECT v."lastViewedAt"
          FROM "PostView" v JOIN "Post" p ON p.id = v."postId"
          WHERE p."authorId" = ${userId}::uuid
            AND v."viewerId" <> ${userId}::uuid
            AND v."lastViewedAt" >= ${since} AND v."lastViewedAt" < ${until}
        ) t
        GROUP BY 1
      `),
    ]);

    const bands = new Map<string, number>();
    let agesKnown = 0;
    for (const row of ages) {
      const count = Number(row.count);
      agesKnown += count;
      const band = InsightsService.bandFor(row.age);
      if (band) bands.set(band, (bands.get(band) ?? 0) + count);
    }

    const activeHours = new Array<number>(168).fill(0);
    for (const row of hours) {
      const hour = Number(row.hour);
      if (hour >= 0 && hour < 168) activeHours[hour] = Number(row.count);
    }

    const group = (r: { slug: string; name: string; count: bigint }) => ({
      slug: r.slug,
      name: r.name,
      count: Number(r.count),
    });

    return {
      ages: InsightsService.ageBands
        .map(([, band]) => ({ band, count: bands.get(band) ?? 0 }))
        .filter((b) => b.count >= floor),
      agesKnown,
      interests: interests.map(group),
      communities: communities.map(group),
      countries: countries
        .map((r) => ({ code: r.code, count: Number(r.count) }))
        .filter((c) => c.count >= floor)
        .slice(0, 5),
      countriesKnown: countries.reduce((n, r) => n + Number(r.count), 0),
      activeHours,
    };
  }

  private static noAudience() {
    return {
      ages: [],
      agesKnown: 0,
      interests: [],
      communities: [],
      countries: [],
      countriesKnown: 0,
      activeHours: new Array<number>(168).fill(0),
    };
  }

  private async topPosts(ranked: { id: string; reach: number }[]) {
    if (ranked.length === 0) return [];
    const rows = await this.prisma.post.findMany({
      where: { id: { in: ranked.map((r) => r.id) }, deletedAt: null },
      select: {
        id: true,
        content: true,
        createdAt: true,
        likeCount: true,
        commentCount: true,
        repostCount: true,
      },
    });
    const byId = new Map(rows.map((r) => [r.id, r]));
    return ranked.flatMap(({ id, reach }) => {
      const row = byId.get(id);
      if (!row) return [];
      return [
        {
          id,
          excerpt: InsightsService.excerpt(row.content),
          createdAt: row.createdAt.toISOString(),
          reach,
          likes: row.likeCount,
          comments: row.commentCount,
          reposts: row.repostCount,
        },
      ];
    });
  }

  private async postedIn(userId: string, slug: string, since: Date) {
    const count = await this.prisma.post.count({
      where: {
        authorId: userId,
        deletedAt: null,
        createdAt: { gte: since },
        community: { slug },
      },
    });
    return count > 0;
  }

  /**
   * Every day of the period in the reader's calendar, with its reach: a
   * quiet day is a zero on the chart rather than the line skipping it.
   */
  static timeline(
    rows: { date: string; reach: number }[],
    since: Date,
    days: number,
    offsetMinutes: number,
  ): { date: string; reach: number }[] {
    const shift = offsetMinutes * 60_000;
    const key = (at: Date) =>
      new Date(at.getTime() + shift).toISOString().slice(0, 10);

    const byDay = new Map<string, number>();
    for (let i = 1; i <= days; i++) {
      byDay.set(key(new Date(since.getTime() + i * DAY)), 0);
    }
    for (const row of rows) byDay.set(row.date, row.reach);
    return [...byDay.entries()]
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([date, reach]) => ({ date, reach }));
  }

  /** The band an age falls in, or null under the youngest. */
  static bandFor(age: number): string | null {
    let band: string | null = null;
    for (const [from, name] of InsightsService.ageBands) {
      if (age >= from) band = name;
    }
    return band;
  }

  /** The hour of the week with the most sittings, or null with none. */
  static busiest(hours: number[]): number | null {
    let best = -1;
    let at: number | null = null;
    hours.forEach((count, hour) => {
      if (count > best && count > 0) {
        best = count;
        at = hour;
      }
    });
    return at;
  }

  static median(values: number[]): number {
    if (values.length === 0) return 0;
    const sorted = [...values].sort((a, b) => a - b);
    const mid = Math.floor(sorted.length / 2);
    return sorted.length % 2
      ? sorted[mid]
      : (sorted[mid - 1] + sorted[mid]) / 2;
  }

  static excerpt(content: string): string {
    const flat = content.replace(/\s+/g, ' ').trim();
    return flat.length <= 120 ? flat : `${flat.slice(0, 119).trimEnd()}…`;
  }
}
