import { GrowthFacts, GrowthTips } from './growth-tips';
import { InsightsService } from './insights.service';

/** An account doing everything right, which earns no tips. */
const healthy = (over: Partial<GrowthFacts> = {}): GrowthFacts => ({
  days: 30,
  reach: { current: 50, previous: 50 },
  followersReached: 30,
  newFollowers: { current: 5, previous: 5 },
  posts: { count: 8, withTopic: 8 },
  profile: { hasAvatar: true, hasBio: true },
  comments: { received: 10, answered: 8 },
  topPost: { id: 'p1', reach: 20 },
  otherPostsMedianReach: 15,
  otherPostsCount: 7,
  topCommunity: { slug: 'club', name: 'Club', postedThere: true },
  bestHourOfWeek: null,
  topInterest: null,
  ...over,
});

const codes = (f: GrowthFacts) => GrowthTips.tips(f).map((t) => t.code);

describe('GrowthTips', () => {
  it('says nothing to an account with nothing to fix', () => {
    expect(codes(healthy())).toEqual([]);
  });

  it('asks for a post before anything else', () => {
    const tips = GrowthTips.tips(
      healthy({ posts: { count: 0, withTopic: 0 }, topPost: null }),
    );
    expect(tips[0]).toEqual({ code: 'post_something', params: { days: 30 } });
  });

  it('asks for a picture and a bio only when they are missing', () => {
    expect(
      codes(healthy({ profile: { hasAvatar: false, hasBio: false } })),
    ).toEqual(['add_avatar', 'add_bio']);
    expect(
      codes(healthy({ profile: { hasAvatar: true, hasBio: false } })),
    ).toEqual(['add_bio']);
  });

  it('asks for more posts under one a week', () => {
    expect(codes(healthy({ posts: { count: 3, withTopic: 3 } }))).toContain(
      'post_more',
    );
    expect(codes(healthy({ posts: { count: 5, withTopic: 5 } }))).not.toContain(
      'post_more',
    );
    // A week is one post.
    expect(
      codes(healthy({ days: 7, posts: { count: 1, withTopic: 1 } })),
    ).not.toContain('post_more');
  });

  it('points at comments left unanswered, with the numbers', () => {
    const [tip] = GrowthTips.tips(
      healthy({ comments: { received: 12, answered: 2 } }),
    );
    expect(tip).toEqual({
      code: 'answer_comments',
      params: { received: 12, answered: 2 },
    });
    // Four comments is not a pattern.
    expect(codes(healthy({ comments: { received: 4, answered: 0 } }))).toEqual(
      [],
    );
  });

  it('notices strangers seeing the posts and not following', () => {
    const tip = GrowthTips.tips(
      healthy({
        reach: { current: 300, previous: 100 },
        followersReached: 50,
        newFollowers: { current: 1, previous: 0 },
      }),
    ).find((t) => t.code === 'convert_strangers');
    expect(tip?.params).toEqual({ reached: 250, gained: 1 });
  });

  it('leaves converting strangers to the bio tip when there is no bio', () => {
    expect(
      codes(
        healthy({
          profile: { hasAvatar: true, hasBio: false },
          reach: { current: 300, previous: 100 },
          followersReached: 50,
          newFollowers: { current: 0, previous: 0 },
        }),
      ),
    ).toEqual(['add_bio']);
  });

  it('asks for topics when most posts went without', () => {
    const tip = GrowthTips.tips(
      healthy({ posts: { count: 8, withTopic: 2 } }),
    ).find((t) => t.code === 'add_topics');
    expect(tip?.params).toEqual({ without: 6, total: 8 });
  });

  it('points at a post that did far better than the rest', () => {
    const tip = GrowthTips.tips(
      healthy({ topPost: { id: 'hit', reach: 90 }, otherPostsMedianReach: 10 }),
    ).find((t) => t.code === 'more_like_top');
    expect(tip?.params).toEqual({ postId: 'hit', times: 9 });
    // Not from two posts: one of two is not a pattern either.
    expect(
      codes(
        healthy({
          topPost: { id: 'hit', reach: 90 },
          otherPostsMedianReach: 10,
          otherPostsCount: 1,
        }),
      ),
    ).not.toContain('more_like_top');
  });

  it("suggests the audience's community, and a time, only with an audience", () => {
    const facts = healthy({
      topCommunity: { slug: 'club', name: 'Club', postedThere: false },
      bestHourOfWeek: 36,
    });
    expect(codes(facts)).toEqual(['post_in_community', 'best_time']);
    expect(codes({ ...facts, reach: { current: 10, previous: 10 } })).toEqual(
      [],
    );
  });

  it('gives no more than four at once', () => {
    const tips = GrowthTips.tips(
      healthy({
        profile: { hasAvatar: false, hasBio: false },
        posts: { count: 2, withTopic: 0 },
        comments: { received: 10, answered: 0 },
        bestHourOfWeek: 3,
      }),
    );
    expect(tips).toHaveLength(GrowthTips.limit);
  });
});

describe('GrowthTips.summary', () => {
  const lines = (f: GrowthFacts) => GrowthTips.summary(f);

  it('says how many times reach grew', () => {
    expect(
      lines(healthy({ reach: { current: 230, previous: 25 } }))[0],
    ).toEqual({ code: 'reach_up_times', params: { times: 9, reach: 230 } });
  });

  it('says by how much it rose, fell, or held', () => {
    expect(
      lines(healthy({ reach: { current: 60, previous: 50 } }))[0].code,
    ).toBe('reach_up_pct');
    expect(lines(healthy({ reach: { current: 40, previous: 50 } }))[0]).toEqual(
      { code: 'reach_down_pct', params: { pct: 20, reach: 40 } },
    );
    expect(
      lines(healthy({ reach: { current: 51, previous: 50 } }))[0].code,
    ).toBe('reach_flat');
  });

  it('notes a first period, and an empty one', () => {
    expect(lines(healthy({ reach: { current: 5, previous: 0 } }))[0].code).toBe(
      'reach_first',
    );
    expect(lines(healthy({ reach: { current: 0, previous: 9 } }))).toEqual([
      { code: 'reach_none', params: { days: 30 } },
    ]);
  });

  it('says who the reach came from, and what they follow', () => {
    const codesOf = (f: GrowthFacts) => lines(f).map((l) => l.code);
    expect(
      codesOf(
        healthy({
          reach: { current: 100, previous: 100 },
          followersReached: 5,
          topInterest: { slug: 'jazz', name: 'Jazz' },
        }),
      ),
    ).toEqual(['reach_flat', 'mostly_strangers', 'top_interest']);
    expect(
      codesOf(
        healthy({
          reach: { current: 100, previous: 100 },
          followersReached: 70,
        }),
      ),
    ).toEqual(['reach_flat', 'mostly_followers']);
  });
});

describe('InsightsService helpers', () => {
  it('offers 7, 30 and 90 days, and 30 otherwise', () => {
    expect(InsightsService.period(7)).toBe(7);
    expect(InsightsService.period(90)).toBe(90);
    expect(InsightsService.period(3)).toBe(30);
    expect(InsightsService.period(undefined)).toBe(30);
  });

  it('bands ages, and keeps out the under-thirteens', () => {
    expect(InsightsService.bandFor(12)).toBeNull();
    expect(InsightsService.bandFor(13)).toBe('13-17');
    expect(InsightsService.bandFor(24)).toBe('18-24');
    expect(InsightsService.bandFor(25)).toBe('25-34');
    expect(InsightsService.bandFor(80)).toBe('65+');
  });

  it('finds the busiest hour, or none', () => {
    const hours = new Array<number>(168).fill(0);
    expect(InsightsService.busiest(hours)).toBeNull();
    hours[36] = 4;
    hours[100] = 9;
    expect(InsightsService.busiest(hours)).toBe(100);
  });

  it('takes a median', () => {
    expect(InsightsService.median([])).toBe(0);
    expect(InsightsService.median([5, 1, 3])).toBe(3);
    expect(InsightsService.median([1, 2, 3, 10])).toBe(2.5);
  });

  it('fills every day of the period', () => {
    const since = new Date('2026-10-01T00:00:00Z');
    const days = InsightsService.timeline(
      [{ date: '2026-10-03', reach: 4 }],
      since,
      7,
      0,
    );
    expect(days).toHaveLength(7);
    expect(days.find((d) => d.date === '2026-10-03')?.reach).toBe(4);
    expect(days.filter((d) => d.reach === 0)).toHaveLength(6);
  });
});
