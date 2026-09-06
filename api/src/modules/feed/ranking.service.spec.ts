import { RankingService, RankingCandidate } from './ranking.service';

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
    seen: over.seen ?? false,
    followed: over.followed ?? false,
    topicIds: over.topicIds ?? [],
  };
}

const nobody = {
  affinity: new Map<string, number>(),
  topicIds: new Set<string>(),
};

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
      const viewer = {
        affinity: new Map([['author-a', 20]]),
        topicIds: new Set<string>(),
      };

      expect(score(post('a'), viewer)).toBeGreaterThan(score(post('a')));
    });

    it('lifts a topic the reader follows', () => {
      const viewer = {
        affinity: new Map<string, number>(),
        topicIds: new Set(['t1']),
      };

      expect(score(post('a', { topicIds: ['t1'] }), viewer)).toBeGreaterThan(
        score(post('a', { topicIds: ['t1'] })),
      );
    });

    it('pushes down what has already been read, without burying it', () => {
      const seen = score(post('a', { seen: true }));

      expect(seen).toBeLessThan(score(post('a')));
      // Not zero: re-reading a thread you are in is normal, and dropping seen
      // posts entirely makes a quiet feed look broken.
      expect(seen).toBeGreaterThan(0);
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
