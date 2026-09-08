import { Injectable } from '@nestjs/common';

/** What ranking needs to know about one candidate post. */
export interface RankingCandidate {
  id: string;
  authorId: string;
  createdAt: Date;
  likes: number;
  comments: number;
  reposts: number;
  /** How many times the reader has already opened it. */
  seenCount: number;
  /** Whether the reader follows the author. */
  followed: boolean;
  /** Topics this post is filed under. */
  topicIds: string[];
}

/** What the reader brings to the ranking. */
export interface RankingViewer {
  /** Authors the reader has engaged with, and how strongly. */
  affinity: Map<string, number>;
  /**
   * Authors the reader has asked to see less of, and how many times.
   *
   * Separate from a negative affinity because it is a stated preference
   * rather than an inferred one, and the two should not cancel out: somebody
   * who reads an account closely and then asks for less of it has said
   * something the reading does not contradict.
   */
  damped: Map<string, number>;
  /** Topics the reader follows. */
  topicIds: Set<string>;
}

/** A ranked page: what to show, and where the next one starts. */
export interface RankedPage<T> {
  items: T[];
  nextOffset: number | null;
}

/**
 * How a feed decides what to put first.
 *
 * The feed was `ORDER BY createdAt DESC`, which is not a ranking at all: it
 * gives every reader the same posts in the same order, every session, until
 * somebody writes something new. This scores a bounded pool of candidates the
 * way the large networks do -- freshness, engagement, who you follow, what you
 * have already seen -- and then deliberately loosens the result so two
 * sessions do not read identically.
 *
 * Bounded and in memory on purpose. Expressing this as SQL means a query no
 * one can change safely; over a few hundred candidates the arithmetic is
 * free, and it is testable as a pure function, which the query never was.
 */
@Injectable()
export class RankingService {
  /** Freshness halves this often. A day is roughly how long a post stays
   * interesting on a network this size; shorter and the feed forgets
   * yesterday, longer and it never moves. */
  static readonly halfLifeHours = 24;

  /** Nothing older than this is a candidate, however popular. */
  static readonly windowHours = 24 * 14;

  /** Engagement weights. A comment is worth more than a like because it costs
   * more to leave, and a repost more still because it is an endorsement the
   * reposter's own followers see. */
  static readonly likeWeight = 1;
  static readonly commentWeight = 2.5;
  static readonly repostWeight = 4;

  /** What is left of a post's score per time the reader has opened it.
   * Compounding, so a second look costs more than the first and a fourth
   * effectively retires the post. Not zero at one view: re-reading a thread
   * you are in is normal, and dropping seen posts entirely makes a quiet feed
   * look broken. */
  static readonly seenMultiplier = 0.25;

  /** However often it has been seen, it keeps this much. A post that reaches
   * exactly zero can never come back, and a thread somebody is part of should
   * still surface when it moves. */
  static readonly seenFloor = 0.02;

  /** What is left of an author's score per time the reader has asked for less
   * of them. Compounding for the same reason, and harder: this one was asked
   * for out loud. */
  static readonly dampedMultiplier = 0.2;

  /** And the floor under that, so the answer is "much less of this" rather
   * than a silent block the reader never chose. */
  static readonly dampedFloor = 0.05;

  /** Multiplier for a post by somebody the reader follows. */
  static readonly followedBoost = 1.6;

  /** And for one filed under a topic they follow. */
  static readonly topicBoost = 1.25;

  /** How much the per-session jitter may move a score, either way.
   *
   * This is the part that answers "I keep seeing the same posts in the same
   * order". It is seeded by the session rather than random per request, so
   * paging stays coherent while two sessions differ. */
  static readonly jitter = 0.35;

  /** At most this many posts in a row by one author. */
  static readonly authorRun = 2;

  /**
   * Scores, orders, spaces out and pages a candidate pool.
   *
   * [seed] makes the whole thing deterministic: the same seed gives the same
   * order, so page two continues page one instead of reshuffling under the
   * reader.
   */
  rank<T extends RankingCandidate>(
    candidates: T[],
    viewer: RankingViewer,
    {
      seed,
      offset = 0,
      limit = 20,
      now = new Date(),
    }: {
      seed: number;
      offset?: number;
      limit?: number;
      now?: Date;
    },
  ): RankedPage<T> {
    const scored = candidates
      .map((post) => ({
        post,
        score: this.score(post, viewer, seed, now),
      }))
      .sort((a, b) => {
        if (b.score !== a.score) return b.score - a.score;
        // A stable tiebreak, or two posts scoring alike swap places between
        // pages and one of them is shown twice while the other never is.
        return a.post.id < b.post.id ? -1 : 1;
      })
      .map((entry) => entry.post);

    const spaced = this.spaceOutAuthors(scored);
    const page = spaced.slice(offset, offset + limit);
    const nextOffset = offset + limit < spaced.length ? offset + limit : null;
    return { items: page, nextOffset };
  }

  /** One post's score for one reader. */
  score(
    post: RankingCandidate,
    viewer: RankingViewer,
    seed: number,
    now: Date,
  ): number {
    const ageHours = Math.max(
      0,
      (now.getTime() - post.createdAt.getTime()) / 3_600_000,
    );
    const freshness = Math.pow(0.5, ageHours / RankingService.halfLifeHours);

    // Damped, so a post with a thousand likes outranks one with a hundred but
    // does not outrank everything for a fortnight.
    const engagement = Math.log1p(
      post.likes * RankingService.likeWeight +
        post.comments * RankingService.commentWeight +
        post.reposts * RankingService.repostWeight,
    );

    // Following someone is a standing instruction to show me their posts, so
    // it multiplies rather than adds -- an added constant is swamped by any
    // popular stranger.
    let affinity = post.followed ? RankingService.followedBoost : 1;
    const engaged = viewer.affinity.get(post.authorId) ?? 0;
    if (engaged > 0) affinity *= 1 + Math.min(0.6, Math.log1p(engaged) / 5);

    const onTopic = post.topicIds.some((id) => viewer.topicIds.has(id));
    if (onTopic) affinity *= RankingService.topicBoost;

    // "Show me less of this" is the one thing in here the reader said in
    // words, so it is applied last and it overrides the rest: following
    // somebody and then asking for less of them is not a contradiction to
    // split the difference on, it is a correction.
    const damped = viewer.damped.get(post.authorId) ?? 0;
    if (damped > 0) {
      affinity *= Math.max(
        RankingService.dampedFloor,
        Math.pow(RankingService.dampedMultiplier, damped),
      );
    }

    const base = (0.6 + engagement) * freshness * affinity;
    const seenAdjusted = base * this.seenDecay(post.seenCount);

    return seenAdjusted * this.wobble(post.id, seed);
  }

  /**
   * What is left of a score after the reader has opened the post this often.
   *
   * A flat penalty for "seen" put the post somebody had read four times
   * exactly where the one they glanced at once went. This compounds instead,
   * so a feed stops offering back what its reader has plainly finished with,
   * and floors rather than reaching zero, so nothing is retired for good.
   */
  seenDecay(seenCount: number): number {
    if (seenCount <= 0) return 1;
    return Math.max(
      RankingService.seenFloor,
      Math.pow(RankingService.seenMultiplier, seenCount),
    );
  }

  /**
   * A per-post, per-session multiplier near 1.
   *
   * Deterministic from the post id and the session seed, so the order holds
   * while paging but differs from the reader's last session -- which is the
   * whole point. Random per call would shuffle the feed under the reader's
   * thumb and show them the same post twice.
   */
  wobble(postId: string, seed: number): number {
    let hash = seed >>> 0;
    for (let i = 0; i < postId.length; i++) {
      hash = Math.imul(hash ^ postId.charCodeAt(i), 0x01000193) >>> 0;
    }
    const unit = hash / 0xffffffff;
    return 1 + (unit * 2 - 1) * RankingService.jitter;
  }

  /**
   * Pushes back a post that would be the third in a row by one author.
   *
   * Without this a prolific account takes the top of the feed whenever it has
   * a good day, and the feed stops being a feed. The displaced post is not
   * dropped -- it goes to the back of the queue and is placed as soon as
   * somebody else has broken the run.
   */
  spaceOutAuthors<T extends RankingCandidate>(ordered: T[]): T[] {
    const out: T[] = [];
    const held: T[] = [];
    let lastAuthor: string | null = null;
    let run = 0;

    const place = (post: T) => {
      run = post.authorId === lastAuthor ? run + 1 : 1;
      lastAuthor = post.authorId;
      out.push(post);
    };

    for (const post of ordered) {
      // Anything held back that no longer clashes goes first, so a deferred
      // post is placed at the next opportunity rather than at the very end.
      const readyIndex = held.findIndex((h) => h.authorId !== lastAuthor);
      if (
        readyIndex >= 0 &&
        post.authorId === lastAuthor &&
        run >= RankingService.authorRun
      ) {
        place(held.splice(readyIndex, 1)[0]);
      }

      if (post.authorId === lastAuthor && run >= RankingService.authorRun) {
        held.push(post);
        continue;
      }
      place(post);
    }

    // Whatever is still held goes on the end, in score order.
    out.push(...held);
    return out;
  }
}
