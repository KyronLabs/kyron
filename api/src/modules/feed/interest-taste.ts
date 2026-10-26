import { InterestKind } from '@prisma/client';

/**
 * What a reader's "Show more posts like this" and "Not interested in this"
 * add up to, as of one moment.
 *
 * Both used to act on the post's author and nothing else: "not interested"
 * in a friend's post about football took 80% off that friend for good, even
 * when the reader followed them, and changed nothing about football. The
 * labels promise posts *like this*, so a signal now lands mostly on what the
 * post was about -- its topics and hashtags -- and only gently on who wrote
 * it. Muting the author is the strong, per-person button, and it is in the
 * same menu.
 *
 * And it fades. A tap is worth half as much after [halfLifeDays], and after
 * [windowDays] it is not read at all. Tastes move, and an instruction given
 * once in March should not still be shaping the feed in December. Tapping
 * again on another post renews it, and every signal can be taken back from
 * Settings.
 */
export interface Taste {
  /** Per author: positive for more, negative for less, faded. */
  authors: Map<string, number>;
  /** Per topic id, the same. */
  topics: Map<string, number>;
  /** Per hashtag id, the same. */
  hashtags: Map<string, number>;
}

/** One signal as the ranking reads it. */
export interface TasteSignal {
  kind: InterestKind;
  /** When it was last given: tapping again on the same post renews it. */
  createdAt: Date;
  post: {
    authorId: string;
    topics: { interestId: string }[];
    hashtags: { hashtagId: string }[];
  } | null;
}

/** What a post brings to be weighed against a [Taste]. */
export interface TasteTarget {
  authorId: string;
  topicIds: readonly string[];
  hashtagIds: readonly string[];
}

export const emptyTaste = (): Taste => ({
  authors: new Map(),
  topics: new Map(),
  hashtags: new Map(),
});

export class InterestTaste {
  /** Days for a signal to fade to half its weight. */
  static readonly halfLifeDays = 30;

  /** Days after which a signal is not read at all: six half-lives, under 2%. */
  static readonly windowDays = 180;

  /** The most signals one reader's ranking reads, newest first. */
  static readonly sample = 500;

  /**
   * What is left of an author's score per unit of "less", and the floor
   * under it. Gentle on purpose: one tap on a post someone you follow wrote
   * takes them from 1.6 to about 1, not out of the feed.
   */
  static readonly authorLess = 0.6;
  static readonly authorFloor = 0.3;

  /** What an author gains per unit of "more", and the ceiling. One fresh
   * tap is about as much as following them is worth halfway. */
  static readonly authorMore = 0.25;
  static readonly authorCeiling = 1.5;

  /** What is left of a post's score per unit of "less" on what it is about,
   * and the floor: much less football, never no football. */
  static readonly contentLess = 0.5;
  static readonly contentFloor = 0.15;

  /** And per unit of "more", with its ceiling. */
  static readonly contentMore = 0.3;
  static readonly contentCeiling = 1.6;

  /** How much one signal is still worth at [asOf]: 1 when new, halving every
   * [halfLifeDays], and 0 past [windowDays] or from the future. */
  static weight(createdAt: Date, asOf: Date): number {
    const days = (asOf.getTime() - createdAt.getTime()) / 86_400_000;
    if (days < 0 || days > InterestTaste.windowDays) return 0;
    return Math.pow(0.5, days / InterestTaste.halfLifeDays);
  }

  /** The oldest signal still worth reading at [asOf]. */
  static since(asOf: Date): Date {
    return new Date(asOf.getTime() - InterestTaste.windowDays * 86_400_000);
  }

  static from(signals: readonly TasteSignal[], asOf: Date): Taste {
    const taste = emptyTaste();
    const add = (map: Map<string, number>, key: string, by: number) =>
      map.set(key, (map.get(key) ?? 0) + by);

    for (const signal of signals) {
      const post = signal.post;
      if (!post) continue;
      const weight = InterestTaste.weight(signal.createdAt, asOf);
      if (weight === 0) continue;
      const signed = signal.kind === InterestKind.LESS ? -weight : weight;

      add(taste.authors, post.authorId, signed);
      // Each of what the post was about takes the whole signal: a post filed
      // under two topics was about both of them.
      for (const t of new Set(post.topics.map((t) => t.interestId))) {
        add(taste.topics, t, signed);
      }
      for (const h of new Set(post.hashtags.map((h) => h.hashtagId))) {
        add(taste.hashtags, h, signed);
      }
    }
    return taste;
  }

  /**
   * The multiplier a post's score takes from the reader's taste: 1 when the
   * reader has said nothing that touches it.
   *
   * Two parts. The author's, gentle. And the content's, summed over every
   * topic and hashtag the post shares with what the reader has asked about,
   * stronger -- that is what "like this" means. A post about a topic the
   * reader wants more of and one they want less of sits between the two.
   */
  static factor(post: TasteTarget, taste: Taste): number {
    const author = taste.authors.get(post.authorId) ?? 0;

    let content = 0;
    for (const t of new Set(post.topicIds)) content += taste.topics.get(t) ?? 0;
    for (const h of new Set(post.hashtagIds)) {
      content += taste.hashtags.get(h) ?? 0;
    }

    return (
      InterestTaste.curve(author, {
        less: InterestTaste.authorLess,
        floor: InterestTaste.authorFloor,
        more: InterestTaste.authorMore,
        ceiling: InterestTaste.authorCeiling,
      }) *
      InterestTaste.curve(content, {
        less: InterestTaste.contentLess,
        floor: InterestTaste.contentFloor,
        more: InterestTaste.contentMore,
        ceiling: InterestTaste.contentCeiling,
      })
    );
  }

  /** Compounding down to a floor for "less", linear up to a ceiling for
   * "more": asking for less twice should be felt twice, and asking for more
   * should never let one thing take the whole feed. */
  private static curve(
    net: number,
    k: { less: number; floor: number; more: number; ceiling: number },
  ): number {
    if (net < 0) return Math.max(k.floor, Math.pow(k.less, -net));
    if (net > 0) return Math.min(k.ceiling, 1 + k.more * net);
    return 1;
  }
}
