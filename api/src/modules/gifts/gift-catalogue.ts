/**
 * The gifts a reader can send, and what each costs.
 *
 * Kept in code rather than in a table: four rows that change only with a
 * release do not need an admin screen, and a gift's price is part of what a
 * reviewer should see in a diff. Gift.type stores the key, and Gift.coins the
 * price it was sent at, so changing a price here never rewrites history.
 */
export interface GiftType {
  type: string;
  name: string;
  emoji: string;
  coins: number;
}

export const GIFT_CATALOGUE: readonly GiftType[] = [
  { type: 'spark', name: 'Spark', emoji: '✨', coins: 1 },
  { type: 'fire', name: 'Fire', emoji: '🔥', coins: 5 },
  { type: 'gem', name: 'Gem', emoji: '💎', coins: 20 },
  { type: 'crown', name: 'Crown', emoji: '👑', coins: 50 },
];

export const GIFT_TYPES = GIFT_CATALOGUE.map((gift) => gift.type);

export function giftType(type: string): GiftType | undefined {
  return GIFT_CATALOGUE.find((gift) => gift.type === type);
}

/**
 * What the weekly refill tops a wallet up to.
 *
 * A top-up rather than an addition, so an account that never sends anything
 * holds 100 coins rather than piling up a hoard to spend all at once. Test
 * coins only: there is no way to buy more.
 */
export const WEEKLY_COINS = 100;

/**
 * The start of the week [at] falls in: Monday, 00:00 UTC.
 *
 * One instant for everybody, wherever they are. A refill at local midnight
 * would need the account's time zone, which Kyron does not keep.
 */
export function weekStart(at: Date): Date {
  const day = new Date(
    Date.UTC(at.getUTCFullYear(), at.getUTCMonth(), at.getUTCDate()),
  );
  // getUTCDay: Sunday is 0. Days since Monday, then.
  const sinceMonday = (day.getUTCDay() + 6) % 7;
  day.setUTCDate(day.getUTCDate() - sinceMonday);
  return day;
}

/** When the wallet next refills: the Monday after [at]. */
export function nextRefill(at: Date): Date {
  const next = weekStart(at);
  next.setUTCDate(next.getUTCDate() + 7);
  return next;
}
