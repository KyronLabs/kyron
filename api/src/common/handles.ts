/**
 * What a handle may be, in one place.
 *
 * Lowercase letters, digits and underscores, two to thirty of them: the rule
 * the app's sign-up form has always enforced, and the shape of every handle
 * in the database when this was written. Stored lowercase, so the unique
 * index on `username` also keeps "Ada" and "ada" from being two accounts --
 * which is how one account passes itself off as another.
 */
export const HANDLE_RULE = /^[a-z0-9_]{2,30}$/;

/**
 * Handles nobody may take.
 *
 * Two kinds. Fixed paths under /profile: `GET /profile/:username` matches
 * any one segment, so an account called "suggested" would have a profile
 * nobody could open. And names that read as Kyron itself speaking, which is
 * the impersonation a handle is most often taken for.
 */
export const RESERVED_HANDLES: ReadonlySet<string> = new Set([
  // Routes under /profile.
  'me',
  'search',
  'users',
  'legacy',
  'avatar',
  'cover',
  'interests',
  'suggested',
  'follow',
  'unfollow',
  'handle',
  // Kyron, and the people who run it.
  'kyron',
  'kyronlabs',
  'kyron_app',
  'kyronapp',
  'admin',
  'administrator',
  'moderator',
  'moderators',
  'mod',
  'mods',
  'staff',
  'team',
  'support',
  'help',
  'helpdesk',
  'official',
  'security',
  'safety',
  'trust',
  'verified',
  'verify',
  'verification',
  'system',
  'root',
  'api',
  'www',
  'settings',
  'about',
  'terms',
  'privacy',
  'legal',
  'everyone',
  'here',
  'null',
  'undefined',
  'anonymous',
  'deleted',
]);

/** Why a handle cannot be used, or null if it can (taken aside). */
export type HandleProblem = 'format' | 'reserved';

/** What someone typed, as it would be stored: no @, no spaces, lowercase. */
export function normaliseHandle(raw: string): string {
  return raw.trim().replace(/^@+/, '').toLowerCase();
}

/** Checks a handle that has already been through [normaliseHandle]. */
export function handleProblem(handle: string): HandleProblem | null {
  if (!HANDLE_RULE.test(handle)) return 'format';
  if (RESERVED_HANDLES.has(handle)) return 'reserved';
  return null;
}

/** What to tell somebody whose handle has a [HandleProblem]. */
export const HANDLE_PROBLEMS: Record<HandleProblem, string> = {
  format:
    'A handle is 2 to 30 lowercase letters, numbers or underscores, with no spaces.',
  reserved: 'That handle is reserved. Try another.',
};
