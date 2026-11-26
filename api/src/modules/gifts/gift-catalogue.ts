/**
 * The gifts a reader can send, and what each costs.
 *
 * Kept in code rather than in a table: prices that change only with a
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

// In price order, which is the order the sheet shows them: two rows of four.
// Gift keys stay stable. Prices apply to new sends.
//
// The app draws each gift from app/assets/gifts/<type>.png, and a gold
// present icon for a type it has no picture for -- a gift added here before
// the app that draws it. It never shows the emoji: that is sent only for app
// builds before v0.1.22, which fell back to it, and can go once those are
// no longer supported.
export const GIFT_CATALOGUE: readonly GiftType[] = [
  { type: 'spark', name: 'Spark', emoji: '✨', coins: 5 },
  { type: 'rose', name: 'Rose', emoji: '🌹', coins: 10 },
  { type: 'fire', name: 'Fire', emoji: '🔥', coins: 15 },
  { type: 'star', name: 'Star', emoji: '⭐', coins: 20 },
  { type: 'gem', name: 'Gem', emoji: '💎', coins: 30 },
  { type: 'cake', name: 'Cake', emoji: '🎂', coins: 40 },
  { type: 'crown', name: 'Crown', emoji: '👑', coins: 50 },
  { type: 'rocket', name: 'Rocket', emoji: '🚀', coins: 100 },
];

export const GIFT_TYPES = GIFT_CATALOGUE.map((gift) => gift.type);

export function giftType(type: string): GiftType | undefined {
  return GIFT_CATALOGUE.find((gift) => gift.type === type);
}
