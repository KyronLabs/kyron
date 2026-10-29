/**
 * What a creator should do next, worked out from their own numbers.
 *
 * Every tip here is a rule with a condition, and a tip is only given when its
 * condition holds for this account in this period: nobody is told to reply to
 * comments they have already answered, or to fill in a bio they have. The app
 * words each one in the reader's language from a code and its numbers; the
 * server decides which apply, so the rules are one place and tested.
 *
 * None of them promises an outcome or quotes a figure from outside Kyron. They
 * say what this account's data shows and the mechanism that makes the advice
 * work here -- topics put a post in topic feeds and in front of the people who
 * follow that topic; a profile is what a stranger reads before following.
 */

/** The numbers the tips and the summary are decided from. */
export interface GrowthFacts {
  days: number;
  reach: { current: number; previous: number };
  /** Of [reach.current], how many already follow the account. */
  followersReached: number;
  newFollowers: { current: number; previous: number };
  posts: { count: number; withTopic: number };
  profile: { hasAvatar: boolean; hasBio: boolean };
  comments: { received: number; answered: number };
  /** The period's best post and the median of the others, by reach. */
  topPost: { id: string; reach: number } | null;
  otherPostsMedianReach: number;
  otherPostsCount: number;
  /** The community most of the audience is in, if one stands out. */
  topCommunity: {
    slug: string;
    name: string;
    postedThere: boolean;
  } | null;
  /** The busiest hour of the week for the audience, UTC, 0 = Monday 00:00. */
  bestHourOfWeek: number | null;
  /** The topic most of the audience follows. */
  topInterest: { slug: string; name: string } | null;
}

/** One tip: a code the app words, and the numbers to word it with. */
export interface GrowthTip {
  code: string;
  params: Record<string, string | number>;
}

/** One line of the summary, the same way. */
export type SummaryLine = GrowthTip;

export class GrowthTips {
  /** At most this many tips at once. A list of ten is a list nobody does. */
  static readonly limit = 4;

  /** Reach under this is too few people for an audience-shaped tip to mean
   * anything: three viewers on a Tuesday is not a best time to post. */
  static readonly audienceFloor = 20;

  static tips(f: GrowthFacts): GrowthTip[] {
    const tips: GrowthTip[] = [];
    const add = (code: string, params: GrowthTip['params'] = {}) =>
      tips.push({ code, params });

    // In order of what matters most. Nothing reaches anyone without a post,
    // and a stranger who lands on an empty profile leaves.
    if (f.posts.count === 0) {
      add('post_something', { days: f.days });
    }
    if (!f.profile.hasAvatar) add('add_avatar');
    if (!f.profile.hasBio) add('add_bio');

    // Fewer than one post a week over the period.
    const weekly = Math.max(1, Math.ceil(f.days / 7));
    if (f.posts.count > 0 && f.posts.count < weekly) {
      add('post_more', { posts: f.posts.count, days: f.days });
    }

    // Comments are people who already cared enough to write. Leaving most
    // unanswered is the cheapest audience there is, left on the table.
    if (
      f.comments.received >= 5 &&
      f.comments.answered / f.comments.received < 0.3
    ) {
      add('answer_comments', {
        received: f.comments.received,
        answered: f.comments.answered,
      });
    }

    // Plenty of strangers saw the posts, almost none followed. With no bio
    // the bio tip above already says the same thing.
    const strangers = f.reach.current - f.followersReached;
    if (
      f.profile.hasBio &&
      strangers >= 100 &&
      f.newFollowers.current / strangers < 0.01
    ) {
      add('convert_strangers', {
        reached: strangers,
        gained: f.newFollowers.current,
      });
    }

    // Topics are how a post reaches the people who follow that topic, and
    // how it appears in the topic's own feed. Most posts went without one.
    if (f.posts.count >= 2 && f.posts.withTopic / f.posts.count < 0.5) {
      add('add_topics', {
        without: f.posts.count - f.posts.withTopic,
        total: f.posts.count,
      });
    }

    // One post did far better than the rest: that is the account's own
    // evidence of what works, better than any general advice.
    if (
      f.topPost &&
      f.otherPostsCount >= 3 &&
      f.otherPostsMedianReach > 0 &&
      f.topPost.reach >= 2 * f.otherPostsMedianReach
    ) {
      add('more_like_top', {
        postId: f.topPost.id,
        times: Math.round(f.topPost.reach / f.otherPostsMedianReach),
      });
    }

    if (f.reach.current >= GrowthTips.audienceFloor) {
      if (f.topCommunity && !f.topCommunity.postedThere) {
        add('post_in_community', {
          slug: f.topCommunity.slug,
          name: f.topCommunity.name,
        });
      }
      if (f.bestHourOfWeek !== null) {
        add('best_time', { hourOfWeek: f.bestHourOfWeek });
      }
    }

    return tips.slice(0, GrowthTips.limit);
  }

  /**
   * Two or three plain sentences about the period, in place of Threads'
   * AI-written summary. Rules, not a model: the same numbers always read the
   * same way, and none of it can be wrong in a way a model can.
   */
  static summary(f: GrowthFacts): SummaryLine[] {
    const lines: SummaryLine[] = [];
    const { current, previous } = f.reach;

    if (current === 0) {
      lines.push({ code: 'reach_none', params: { days: f.days } });
      return lines;
    }

    if (previous === 0) {
      lines.push({
        code: 'reach_first',
        params: { reach: current, days: f.days },
      });
    } else {
      const ratio = current / previous;
      if (ratio >= 2) {
        lines.push({
          code: 'reach_up_times',
          params: { times: Math.floor(ratio), reach: current },
        });
      } else if (ratio >= 1.05) {
        lines.push({
          code: 'reach_up_pct',
          params: { pct: Math.round((ratio - 1) * 100), reach: current },
        });
      } else if (ratio <= 0.95) {
        lines.push({
          code: 'reach_down_pct',
          params: { pct: Math.round((1 - ratio) * 100), reach: current },
        });
      } else {
        lines.push({ code: 'reach_flat', params: { reach: current } });
      }
    }

    const strangers = (current - f.followersReached) / current;
    if (current >= GrowthTips.audienceFloor) {
      if (strangers >= 0.8) {
        lines.push({
          code: 'mostly_strangers',
          params: { pct: Math.round(strangers * 100) },
        });
      } else if (strangers <= 0.5) {
        lines.push({
          code: 'mostly_followers',
          params: { pct: Math.round((1 - strangers) * 100) },
        });
      }
      if (f.topInterest) {
        lines.push({
          code: 'top_interest',
          params: { name: f.topInterest.name },
        });
      }
    }

    return lines;
  }
}
