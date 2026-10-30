import { BadRequestException, NotFoundException } from '@nestjs/common';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import {
  GIFT_CATALOGUE,
  WEEKLY_COINS,
  giftType,
  nextRefill,
  weekStart,
} from './gift-catalogue';
import { GiftsService } from './gifts.service';

/**
 * The rules a gift is held to before any coin moves. What happens to the
 * coins themselves is in gifts.db.spec.ts, against a real database, because
 * a row lock in a mock proves nothing.
 */
function service({
  post = { authorId: 'author' } as { authorId: string } | null,
  blocked = false,
} = {}) {
  const transaction = jest.fn();
  const prisma = {
    post: { findFirst: jest.fn().mockResolvedValue(post) },
    block: {
      findFirst: jest.fn().mockResolvedValue(blocked ? { id: 'b' } : null),
    },
    $transaction: transaction,
  };
  const delivery = new RecordingDelivery();
  const gifts = new GiftsService(prisma as unknown as PrismaService, delivery);
  return { gifts, transaction, delivery };
}

const send = {
  type: 'fire',
  requestId: '6f1c5a0e-2b7d-4c1e-9a3b-0d8e7f6a5b4c',
};

describe('sending a gift', () => {
  it('refuses a gift that is not in the catalogue', async () => {
    const { gifts, transaction } = service();
    await expect(
      gifts.send('me', 'p1', { ...send, type: 'yacht' }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(transaction).not.toHaveBeenCalled();
  });

  it('refuses a post that is gone, or whose author is banned', async () => {
    const { gifts, transaction } = service({ post: null });
    await expect(gifts.send('me', 'p1', send)).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(transaction).not.toHaveBeenCalled();
  });

  it('refuses a gift to your own post', async () => {
    const { gifts, transaction } = service({ post: { authorId: 'me' } });
    await expect(gifts.send('me', 'p1', send)).rejects.toThrow(
      "You can't send a gift to your own post.",
    );
    expect(transaction).not.toHaveBeenCalled();
  });

  it('answers as if the post were not there when either has blocked the other', async () => {
    const { gifts, transaction, delivery } = service({ blocked: true });
    await expect(gifts.send('me', 'p1', send)).rejects.toBeInstanceOf(
      NotFoundException,
    );
    expect(transaction).not.toHaveBeenCalled();
    expect(delivery.told).toHaveLength(0);
  });
});

describe('the weekly refill', () => {
  it('starts the week on Monday, 00:00 UTC', () => {
    // Wednesday 29 October 2026, late in the day.
    const wednesday = new Date('2026-10-29T23:30:00Z');
    expect(weekStart(wednesday).toISOString()).toBe('2026-10-26T00:00:00.000Z');
    expect(nextRefill(wednesday).toISOString()).toBe(
      '2026-11-02T00:00:00.000Z',
    );
  });

  it('counts a Sunday as the end of its week, not the start of the next', () => {
    const sunday = new Date('2026-11-01T12:00:00Z');
    expect(weekStart(sunday).toISOString()).toBe('2026-10-26T00:00:00.000Z');
  });

  it('counts the first instant of Monday as the new week', () => {
    const monday = new Date('2026-11-02T00:00:00Z');
    expect(weekStart(monday).toISOString()).toBe('2026-11-02T00:00:00.000Z');
  });
});

describe('the catalogue', () => {
  it('is in price order, which is the order the sheet shows', () => {
    const prices = GIFT_CATALOGUE.map((gift) => gift.coins);
    expect(prices).toEqual([...prices].sort((a, b) => a - b));
  });

  it('keeps the gifts that have already been sent, at their prices', () => {
    // Gift.type and Gift.coins on rows already written name these.
    const shipped = { spark: 1, fire: 5, gem: 20, crown: 50 };
    for (const [type, coins] of Object.entries(shipped)) {
      expect(giftType(type)?.coins).toBe(coins);
    }
  });

  it('has nothing a week of coins cannot buy', () => {
    for (const gift of GIFT_CATALOGUE) {
      expect(gift.coins).toBeLessThanOrEqual(WEEKLY_COINS);
    }
  });

  it('names every gift once', () => {
    const types = GIFT_CATALOGUE.map((gift) => gift.type);
    expect(new Set(types).size).toBe(types.length);
  });
});
