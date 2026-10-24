import { CATALOGS } from './copy';
import { type Copy, en, type PushKey } from './copy/en';

/**
 * Words a push will say, decided per phone.
 *
 * A plain string is said as it is -- somebody's name, a chat's name, the start
 * of a post: words people wrote, in whatever language they wrote them. A
 * [Phrase] is Kyron's own words, looked up in the language of each device the
 * push goes to. An array is sentences, said one after another.
 */
export type PushText = string | Phrase | readonly PushText[];

export interface Phrase {
  readonly key: PushKey;
  readonly params?: Readonly<Record<string, PushText | number | Date>>;
}

/** Kyron's words, by key. */
export function say(key: PushKey, params?: Phrase['params']): Phrase {
  return params ? { key, params } : { key };
}

/**
 * The catalog for a device's language, from whatever the app reported:
 * `fr`, `pt-BR`, `zh_Hant`. The language alone decides -- there is one
 * Portuguese, one Chinese -- and anything unknown is English.
 */
export function catalogFor(locale: string | null | undefined): {
  copy: Copy;
  tag: string;
} {
  const language = (locale ?? '').trim().toLowerCase().split(/[-_]/)[0];
  const known = ALIASES[language] ?? language;
  const copy = known ? CATALOGS[known] : undefined;
  return copy ? { copy, tag: known } : { copy: en, tag: 'en' };
}

/** Older and alternative codes for the same language. */
const ALIASES: Readonly<Record<string, string>> = {
  iw: 'he',
  in: 'id',
  no: 'nb',
  nn: 'nb',
  fil: 'tl',
};

/** Languages whose sentences follow one another with no space between. */
const NO_SPACE = new Set(['zh', 'ja']);

/** [text] in one language. */
export function render(
  text: PushText,
  locale: string | null | undefined,
): string {
  const { copy, tag } = catalogFor(locale);
  return renderIn(text, copy, tag);
}

function renderIn(text: PushText, copy: Copy, tag: string): string {
  if (typeof text === 'string') return text;
  if (isPhrases(text)) {
    return text
      .map((part) => renderIn(part, copy, tag).trim())
      .filter((part) => part.length > 0)
      .join(NO_SPACE.has(tag) ? '' : ' ');
  }
  const template = copy[text.key] ?? en[text.key];
  const params = text.params ?? {};
  return template.replace(/\{(\w+)\}/g, (whole, name: string) => {
    const value = params[name];
    if (value === undefined) return whole;
    if (value instanceof Date) return formatDate(value, tag);
    if (typeof value === 'number') return formatNumber(value, tag);
    return renderIn(value, copy, tag);
  });
}

function isPhrases(text: PushText): text is readonly PushText[] {
  return Array.isArray(text);
}

function formatDate(date: Date, tag: string): string {
  try {
    return new Intl.DateTimeFormat(tag, {
      dateStyle: 'medium',
      // A suspension ends at an instant; the day is the one in UTC, the zone
      // it was set in, rather than one the server happens to run in.
      timeZone: 'UTC',
    }).format(date);
  } catch {
    return date.toISOString().slice(0, 10);
  }
}

function formatNumber(value: number, tag: string): string {
  try {
    return new Intl.NumberFormat(tag).format(value);
  } catch {
    return String(value);
  }
}
