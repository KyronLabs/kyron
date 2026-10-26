import {
  RankingService,
  RankingCandidate,
  RankingViewer,
} from './ranking.service';
import { emptyTaste } from './interest-taste';

const NOW = new Date('2026-09-06T12:00:00Z');

function post(
  id: string,
  over: Partial<RankingCandidate> = {},
): RankingCandidate {
  return {
    id,
    authorId: over.authorId ?? `author-${id}`,
    createdAt: over.createdAt ?? new Date(NOW.getTime() - 3_600_000),
    likes: over.likes ?? 0,
    comments: over.comments ?? 0,
    reposts: over.reposts ?? 0,
    seenCount: over.seenCount ?? 0,
    shownCount: over.shownCount ?? 0,
    lastShownAt: over.lastShownAt ?? null,
    followed: over.followed ?? false,
    topicIds: over.topicIds ?? [],
    hashtagIds: over.hashtagIds ?? [],
  };
}

/** A reader the ranking knows nothing about. */
const nobody: RankingViewer = {
  affinity: new Map<string, number>(),
  taste: emptyTaste(),
  topicIds: new Set<string>(),
};

/** A reader who differs from [nobody] in exactly one respect. */
function reader(over: Partial<RankingViewer> = {}): RankingViewer {
  return {
    affinity: over.affinity ?? new Map<string, number>(),
    taste: over.taste ?? emptyTaste(),
    topicIds: over.topicIds ?? new Set<string>(),
  };
}

describe('RankingService', () => {
  const svc = new RankingService();
  const score = (p: RankingCandidate, viewer = nobody, seed = 1) =>
    svc.score(p, viewer, seed, NOW);

  describe('scoring', () => {
    it('prefers the fresher of two equal posts', () => {
      const fresh = post('a', {
        createdAt: new Date(NOW.getTime() - 3_600_000),
      });
      const stale = post('a', {
        createdAt: new Date(NOW.getTime() - 72 * 3_600_000),
      });

      // Same id, so the per-session wobble is identical and only age differs.
      expect(score(fresh)).toBeGreaterThan(score(stale));
    });

    it('prefers the more engaged of two equally fresh posts', () => {
      expect(score(post('a', { likes: 100 }))).toBeGreaterThan(
        score(post('a', { likes: 1 })),
      );
    });

    it('damps engagement, so one hit does not own the feed', () => {
      // Ten times the likes must not be ten times the score, or a single
      // viral post outranks everything for a fortnight.
      const ratio =
        score(post('a', { likes: 1000 })) / score(post('a', { likes: 100 }));

      expect(ratio).toBeLessThan(2);
    });

    it('weighs a comment above a like and a repost above both', () => {
      expect(score(post('a', { comments: 10 }))).toBeGreaterThan(
        score(post('a', { likes: 10 })),
      );
      expect(score(post('a', { reposts: 10 }))).toBeGreaterThan(
        score(post('a', { comments: 10 })),
      );
    });

    it('lifts a post by somebody the reader follows', () => {
      expect(score(post('a', { followed: true }))).toBeGreaterThan(
        score(post('a')),
      );
    });

    it('lifts an author the reader actually engages with', () => {
      const viewer = reader({ affinity: new Map([['author-a', 20]]) });

      expect(score(post('a'), viewer)).toBeGreaterThan(score(post('a')));
    });

    it('lifts a topic the reader follows', () => {
      const viewer = reader({ topicIds: new Set(['t1']) });

      expect(score(post('a', { topicIds: ['t1'] }), viewer)).toBeGreaterThan(
        score(post('a', { topicIds: ['t1'] })),
      );
    });

    it('pushes down what has already been read, without burying it', () => {
      const seen = score(post('a', { seenCount: 1 }));

      expect(seen).toBeLessThan(score(post('a')));
      // Not zero: re-reading a thread you are in is normal, and dropping seen
      // posts entirely makes a quiet feed look broken.
      expect(seen).toBeGreaterThan(0);
    });

    it('pushes it down further every time it is opened again', () => {
      // The flat penalty this replaces put the post somebody had read four
      // times exactly where the one they glanced at once went.
      const once = score(post('a', { seenCount: 1 }));
      const twice = score(post('a', { seenCount: 2 }));
      const thrice = score(post('a', { seenCount: 3 }));

      expect(twice).toBeLessThan(once);
      expect(thrice).toBeLessThan(twice);
    });

    it('never retires a post entirely, however often it is opened', () => {
      // A thread somebody is part of is opened over and over, and should
      // still surface when it moves.
      const worn = svc.seenDecay(50);

      expect(worn).toBe(RankingService.seenFloor);
      expect(score(post('a', { seenCount: 50 }))).toBeGreaterThan(0);
    });

    // What the reader said with the two buttons, as InterestTaste reads it:
    // negative for "not interested", positive for "show more", faded.
    const said = (
      over: Partial<{
        authors: [string, number][];
        topics: [string, number][];
        hashtags: [string, number][];
      }>,
    ) =>
      reader({
        taste: {
          authors: new Map(over.authors ?? []),
          topics: new Map(over.topics ?? []),
          hashtags: new Map(over.hashtags ?? []),
        },
      });

    it('shows fewer posts about what the reader was not interested in', () => {
      // From anybody: that is what "like this" means.
      const p = post('a', { authorId: 'stranger', topicIds: ['football'] });
      const offTopic = post('a', { authorId: 'stranger' });
      const quieted = said({ topics: [['football', -1]] });

      expect(score(p, quieted)).toBeLessThan(score(p, nobody) * 0.6);
      expect(score(offTopic, quieted)).toBe(score(offTopic, nobody));
    });

    it('reads a hashtag the way it reads a topic', () => {
      const p = post('a', { hashtagIds: ['spoilers'] });
      const quieted = said({ hashtags: [['spoilers', -1]] });

      expect(score(p, quieted)).toBeLessThan(score(p, nobody));
    });

    it('does not bury somebody the reader follows over one post', () => {
      // It used to take 80% off them and override following: one tap on a
      // friend's post about football all but took the friend away.
      const friend = post('a', { authorId: 'friend', followed: true });
      const once = said({ authors: [['friend', -1]] });

      expect(score(friend, once)).toBeGreaterThan(
        score(post('a'), nobody) * 0.9,
      );
    });

    it('shows less again each time they ask, down to a floor', () => {
      const p = post('a', { topicIds: ['football'] });
      const once = said({ topics: [['football', -1]] });
      const twice = said({ topics: [['football', -2]] });
      const shouted = said({ topics: [['football', -40]] });

      expect(score(p, twice)).toBeLessThan(score(p, once));
      // Much less football, never none. Muting is a different button.
      expect(score(p, shouted)).toBeGreaterThan(0);
    });

    it('shows more of what the reader asked for, enough to see', () => {
      // About x1.22 before, below following and lost under a few likes.
      const p = post('a', { authorId: 'good', topicIds: ['jazz'] });
      const more = said({ authors: [['good', 1]], topics: [['jazz', 1]] });

      expect(score(p, more)).toBeGreaterThan(score(p, nobody) * 1.5);
    });

    it('never lets "more" take the whole feed', () => {
      const p = post('a', { authorId: 'good', topicIds: ['jazz'] });
      const lots = said({ authors: [['good', 50]], topics: [['jazz', 50]] });

      expect(score(p, lots)).toBeLessThanOrEqual(score(p, nobody) * 2.4 + 1e-9);
    });
  });

  describe('the per-session wobble', () => {
    it('is stable for one seed and post', () => {
      expect(svc.wobble('p1', 7)).toBe(svc.wobble('p1', 7));
    });

    it('differs between seeds', () => {
      expect(svc.wobble('p1', 7)).not.toBe(svc.wobble('p1', 8));
    });

    it('stays within the declared bound', () => {
      for (let seed = 0; seed < 200; seed++) {
        const w = svc.wobble(`p${seed}`, seed);
        expect(w).toBeGreaterThanOrEqual(1 - RankingService.jitter);
        expect(w).toBeLessThanOrEqual(1 + RankingService.jitter);
      }
    });
  });

  describe('author spacing', () => {
    it('breaks a run of one author', () => {
      const ordered = [
        post('1', { authorId: 'loud' }),
        post('2', { authorId: 'loud' }),
        post('3', { authorId: 'loud' }),
        post('4', { authorId: 'other' }),
      ];

      const spaced = svc.spaceOutAuthors(ordered).map((p) => p.authorId);

      expect(spaced.slice(0, 3)).toEqual(['loud', 'loud', 'other']);
    });

    it('places a held-back post rather than dropping it', () => {
      const ordered = [
        post('1', { authorId: 'loud' }),
        post('2', { authorId: 'loud' }),
        post('3', { authorId: 'loud' }),
        post('4', { authorId: 'other' }),
      ];

      expect(svc.spaceOutAuthors(ordered)).toHaveLength(4);
    });

    it('leaves an already varied order alone', () => {
      const ordered = ['a', 'b', 'c'].map((id) => post(id, { authorId: id }));

      expect(svc.spaceOutAuthors(ordered).map((p) => p.id)).toEqual([
        'a',
        'b',
        'c',
      ]);
    });
  });

  describe('having been on screen', () => {
    const hoursAgo = (h: number) => new Date(NOW.getTime() - h * 3_600_000);

    it('moves down a post the reader has already scrolled past', () => {
      // Before this only opening a post counted, so one scrolled past every
      // day looked unseen and headed the feed every session.
      const passed = score(
        post('a', { shownCount: 1, lastShownAt: hoursAgo(1) }),
      );

      expect(passed).toBeLessThan(score(post('a')));
      expect(passed).toBeGreaterThan(0);
    });

    it('moves it further each sitting it was shown in', () => {
      const shown = (n: number) =>
        score(post('a', { shownCount: n, lastShownAt: hoursAgo(1) }));

      expect(shown(2)).toBeLessThan(shown(1));
      expect(shown(3)).toBeLessThan(shown(2));
    });

    it('weighs scrolling past below opening', () => {
      // Opening something is a stronger sign of being done with it.
      expect(
        score(post('a', { shownCount: 1, lastShownAt: hoursAgo(0) })),
      ).toBeGreaterThan(score(post('a', { seenCount: 1 })));
    });

    it('forgets, so what was passed over last week can come round again', () => {
      const yesterday = svc.shownDecay(2, hoursAgo(24), NOW);
      const lastWeek = svc.shownDecay(2, hoursAgo(24 * 7), NOW);

      expect(lastWeek).toBeGreaterThan(yesterday);
      expect(lastWeek).toBeLessThan(1);
    });

    it('never retires a post entirely', () => {
      expect(svc.shownDecay(500, hoursAgo(0), NOW)).toBe(
        RankingService.shownFloor,
      );
    });

    it('leaves a post nobody has shown them alone', () => {
      expect(svc.shownDecay(0, null, NOW)).toBe(1);
    });
  });

  describe('how fast freshness fades', () => {
    const spread = (count: number, everyHours: number) =>
      Array.from({ length: count }, (_, i) =>
        post(`p${i}`, {
          createdAt: new Date(NOW.getTime() - i * everyHours * 3_600_000),
        }),
      );

    it('keeps a day on a busy network', () => {
      // Four hundred posts in two hours: a day is plenty.
      expect(svc.halfLifeFor(spread(400, 0.005), NOW)).toBe(
        RankingService.halfLifeHours,
      );
    });

    it('is the time the network took to write a page of posts', () => {
      // A post every six hours: twenty of them took nineteen gaps.
      expect(svc.halfLifeFor(spread(60, 6), NOW)).toBeCloseTo(19 * 6);
    });

    it('stops at a week on a very quiet one', () => {
      // Otherwise a month-old post would count as new.
      expect(svc.halfLifeFor(spread(60, 48), NOW)).toBe(
        RankingService.maxHalfLifeHours,
      );
    });

    it('uses the oldest post when there are fewer than a page', () => {
      expect(svc.halfLifeFor(spread(5, 12), NOW)).toBeCloseTo(48);
    });
  });

  describe('on a network the size of Kyron today', () => {
    // What production looked like when For You stuck at nineteen posts: a
    // hundred and four posts over seven weeks, twenty of them in the last
    // fortnight, fourteen authors.
    const DAY = 24;
    const pool = Array.from({ length: 104 }, (_, i) =>
      post(`p${i}`, {
        authorId: `a${i % 14}`,
        likes: i % 5,
        createdAt: new Date(
          NOW.getTime() -
            (i < 20 ? i * 0.7 * DAY : 14 * DAY + (i - 20) * 0.4 * DAY) *
              3_600_000,
        ),
      }),
    );
    const rankAll = (posts: RankingCandidate[]) =>
      svc.rank(posts, nobody, { seed: 11, limit: 200, now: NOW }).items;

    it('can reach every post, not just the last fortnight', () => {
      expect(rankAll(pool)).toHaveLength(104);
    });

    it('opens on the newest for a reader who has seen nothing', () => {
      const newest = new Set(pool.slice(0, 20).map((p) => p.id));
      const top = rankAll(pool).slice(0, 10);

      // Most of it, not all: a well-liked post from last week may edge in,
      // which on a network this quiet is the point.
      expect(top.filter((p) => newest.has(p.id)).length).toBeGreaterThanOrEqual(
        8,
      );
    });

    it('moves on to what they have not seen once they have scrolled past it', () => {
      // The newest nineteen, shown three times today -- the feed as it was.
      const shown = new Set(pool.slice(0, 19).map((p) => p.id));
      const seenToday = pool.map((p) =>
        shown.has(p.id)
          ? {
              ...p,
              shownCount: 3,
              lastShownAt: new Date(NOW.getTime() - 2 * 3_600_000),
            }
          : p,
      );

      const firstPage = rankAll(seenToday).slice(0, 20);
      const unseen = firstPage.filter((p) => !shown.has(p.id));

      // Most of the first page is new to them, and what they have seen is
      // still there, further down, rather than gone.
      expect(unseen.length).toBeGreaterThanOrEqual(12);
      expect(rankAll(seenToday).filter((p) => shown.has(p.id))).toHaveLength(
        19,
      );
    });
  });

  describe('paging', () => {
    const pool = Array.from({ length: 25 }, (_, i) =>
      post(`p${i}`, { authorId: `a${i}` }),
    );

    it('pages without repeating or skipping', () => {
      const first = svc.rank(pool, nobody, { seed: 5, limit: 10, now: NOW });
      const second = svc.rank(pool, nobody, {
        seed: 5,
        offset: first.nextOffset!,
        limit: 10,
        now: NOW,
      });

      const ids = [...first.items, ...second.items].map((p) => p.id);
      expect(new Set(ids).size).toBe(20);
    });

    it('ends the list rather than offering an empty page', () => {
      const last = svc.rank(pool, nobody, {
        seed: 5,
        offset: 20,
        limit: 10,
        now: NOW,
      });

      expect(last.items).toHaveLength(5);
      expect(last.nextOffset).toBeNull();
    });

    it('gives the same order for one seed and a different one for another', () => {
      const order = (seed: number) =>
        svc
          .rank(pool, nobody, { seed, limit: 25, now: NOW })
          .items.map((p) => p.id)
          .join(',');

      expect(order(1)).toBe(order(1));
      expect(order(1)).not.toBe(order(2));
    });

    it('breaks a score tie the same way every time', () => {
      // Two posts scoring alike must not swap between pages, or one is shown
      // twice and the other never.
      const twins = [
        post('x', { authorId: 'a' }),
        post('y', { authorId: 'b' }),
      ];
      const once = svc.rank(twins, nobody, { seed: 3, now: NOW });
      const again = svc.rank(twins, nobody, { seed: 3, now: NOW });

      expect(once.items.map((p) => p.id)).toEqual(again.items.map((p) => p.id));
    });
  });
});
