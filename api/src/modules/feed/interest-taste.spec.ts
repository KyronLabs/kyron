import { InterestKind } from '@prisma/client';

import { InterestTaste, TasteSignal } from './interest-taste';

const NOW = new Date('2026-10-26T12:00:00Z');
const daysAgo = (n: number) => new Date(NOW.getTime() - n * 86_400_000);

const signal = (
  kind: InterestKind,
  age: number,
  over: Partial<NonNullable<TasteSignal['post']>> = {},
): TasteSignal => ({
  kind,
  createdAt: daysAgo(age),
  post: {
    authorId: over.authorId ?? 'friend',
    topics: over.topics ?? [{ interestId: 'football' }],
    hashtags: over.hashtags ?? [],
  },
});

describe('InterestTaste', () => {
  describe('fading', () => {
    it('is whole when new and half after the half-life', () => {
      expect(InterestTaste.weight(NOW, NOW)).toBe(1);
      expect(
        InterestTaste.weight(daysAgo(InterestTaste.halfLifeDays), NOW),
      ).toBeCloseTo(0.5);
    });

    it('stops being read past the window', () => {
      // Tastes move. A tap from last spring is not still steering the feed.
      expect(
        InterestTaste.weight(daysAgo(InterestTaste.windowDays + 1), NOW),
      ).toBe(0);
    });

    it('ignores a date from the future', () => {
      expect(InterestTaste.weight(daysAgo(-1), NOW)).toBe(0);
    });

    it('weighs an old "not interested" less than a new one', () => {
      const post = { authorId: 'x', topicIds: ['football'], hashtagIds: [] };
      const fresh = InterestTaste.from([signal(InterestKind.LESS, 0)], NOW);
      const old = InterestTaste.from([signal(InterestKind.LESS, 90)], NOW);

      expect(InterestTaste.factor(post, fresh)).toBeLessThan(
        InterestTaste.factor(post, old),
      );
      expect(InterestTaste.factor(post, old)).toBeLessThan(1);
    });
  });

  describe('what a signal lands on', () => {
    it('lands on the topics and hashtags, and the author', () => {
      const taste = InterestTaste.from(
        [
          signal(InterestKind.LESS, 0, {
            topics: [{ interestId: 'football' }],
            hashtags: [{ hashtagId: 'derby' }],
          }),
        ],
        NOW,
      );

      expect(taste.topics.get('football')).toBe(-1);
      expect(taste.hashtags.get('derby')).toBe(-1);
      expect(taste.authors.get('friend')).toBe(-1);
    });

    it('lets "more" and "less" on the same topic pull against each other', () => {
      const taste = InterestTaste.from(
        [
          signal(InterestKind.MORE, 0, { authorId: 'a' }),
          signal(InterestKind.LESS, 0, { authorId: 'b' }),
        ],
        NOW,
      );
      expect(taste.topics.get('football')).toBe(0);
    });

    it('skips a signal whose post is gone', () => {
      const taste = InterestTaste.from(
        [{ kind: InterestKind.LESS, createdAt: NOW, post: null }],
        NOW,
      );
      expect(taste.authors.size).toBe(0);
    });
  });

  describe('the multiplier', () => {
    const taste = InterestTaste.from([signal(InterestKind.LESS, 0)], NOW);

    it('is 1 for a post the reader said nothing about', () => {
      expect(
        InterestTaste.factor(
          { authorId: 'stranger', topicIds: ['jazz'], hashtagIds: [] },
          taste,
        ),
      ).toBe(1);
    });

    it('is gentle on the author alone', () => {
      // One tap on one post is not a verdict on the person.
      expect(
        InterestTaste.factor(
          { authorId: 'friend', topicIds: [], hashtagIds: [] },
          taste,
        ),
      ).toBe(InterestTaste.authorLess);
    });

    it('is stronger on what the post was about, from anybody', () => {
      const stranger = InterestTaste.factor(
        { authorId: 'stranger', topicIds: ['football'], hashtagIds: [] },
        taste,
      );
      expect(stranger).toBe(InterestTaste.contentLess);
      expect(stranger).toBeLessThan(InterestTaste.authorLess);
    });

    it('has floors and ceilings', () => {
      const lots = InterestTaste.from(
        Array.from({ length: 30 }, () => signal(InterestKind.LESS, 0)),
        NOW,
      );
      expect(
        InterestTaste.factor(
          { authorId: 'friend', topicIds: ['football'], hashtagIds: [] },
          lots,
        ),
      ).toBeCloseTo(InterestTaste.authorFloor * InterestTaste.contentFloor);

      const more = InterestTaste.from(
        Array.from({ length: 30 }, () => signal(InterestKind.MORE, 0)),
        NOW,
      );
      expect(
        InterestTaste.factor(
          { authorId: 'friend', topicIds: ['football'], hashtagIds: [] },
          more,
        ),
      ).toBeCloseTo(InterestTaste.authorCeiling * InterestTaste.contentCeiling);
    });
  });
});
