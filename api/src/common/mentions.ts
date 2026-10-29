/**
 * The handles a piece of text mentions, lower-cased, each once, in the order
 * they first appear.
 *
 * The same rule the app uses to draw a mention as a link (PostText.pattern):
 * an @ that does not follow a letter, digit, underscore or another @, then a
 * handle's characters. So "ada@example.com" mentions nobody, and anything the
 * app shows as a mention is one the server records. Shorter than two
 * characters is not a handle (HANDLE_RULE), so "@a" is skipped here rather
 * than looked up.
 */
export function mentionedHandles(text: string, limit = MAX_MENTIONS): string[] {
  const found = new Set<string>();
  for (const match of text.matchAll(/(?<![\w@])@([A-Za-z0-9_]{1,30})/g)) {
    const handle = match[1].toLowerCase();
    if (handle.length < 2) continue;
    found.add(handle);
    if (found.size >= limit) break;
  }
  return [...found];
}

/**
 * The most people one post or reply can notify by naming them. A post that
 * tags fifty accounts is spam whatever it says; the first twenty are told
 * and the rest are not.
 */
export const MAX_MENTIONS = 20;
