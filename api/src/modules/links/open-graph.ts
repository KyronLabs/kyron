/**
 * The fields a link card needs, however the page chose to declare them.
 */
export interface LinkCard {
  title: string | null;
  description: string | null;
  imageUrl: string | null;
  siteName: string | null;
}

/**
 * Pulls a card out of a page's HTML.
 *
 * Deliberately a scan of the head rather than a full DOM parse: the input is
 * an arbitrary page from the open web, and the only thing wanted from it is
 * four short strings. A parser would spend the memory of an entire document
 * tree, on untrusted markup, to reach a handful of meta tags.
 *
 * Preference order is Open Graph, then Twitter's tags, then the plain HTML
 * ones -- a page that sets og:title and <title> differently means the first
 * for a card and the second for a tab.
 */
export function parseCard(html: string, pageUrl: URL): LinkCard {
  const head = headOf(html);
  const meta = metaTags(head);

  const title =
    meta.get('og:title') ?? meta.get('twitter:title') ?? titleTag(head) ?? null;

  const description =
    meta.get('og:description') ??
    meta.get('twitter:description') ??
    meta.get('description') ??
    null;

  const image =
    meta.get('og:image:secure_url') ??
    meta.get('og:image:url') ??
    meta.get('og:image') ??
    meta.get('twitter:image') ??
    meta.get('twitter:image:src') ??
    null;

  return {
    title: clean(title, 300),
    description: clean(description, 600),
    // Resolved against the page, because og:image is routinely a path.
    imageUrl: image ? absolute(image, pageUrl) : null,
    siteName: clean(meta.get('og:site_name') ?? null, 120),
  };
}

/**
 * The document head, or the first 128 KB if the page never closes one.
 *
 * Bounded because everything below is a regular expression, and running those
 * over the body of a multi-megabyte page buys nothing: every tag worth reading
 * is above it.
 */
function headOf(html: string): string {
  const end = html.search(/<\/head>/i);
  const bounded = end === -1 ? html.slice(0, 128 * 1024) : html.slice(0, end);
  return bounded;
}

/** Every meta tag in the head, keyed by its property or name, first wins. */
function metaTags(head: string): Map<string, string> {
  const found = new Map<string, string>();

  for (const match of head.matchAll(/<meta\s+([^>]*)>/gi)) {
    const attributes = match[1];
    const key =
      attribute(attributes, 'property') ?? attribute(attributes, 'name');
    const value = attribute(attributes, 'content');
    if (!key || value === null) continue;

    const normalised = key.trim().toLowerCase();
    if (!found.has(normalised)) found.set(normalised, value);
  }

  return found;
}

function attribute(attributes: string, name: string): string | null {
  const quoted = new RegExp(`\\b${name}\\s*=\\s*("([^"]*)"|'([^']*)')`, 'i');
  const bare = new RegExp(`\\b${name}\\s*=\\s*([^\\s"'>]+)`, 'i');

  const withQuotes = quoted.exec(attributes);
  if (withQuotes) return withQuotes[2] ?? withQuotes[3] ?? '';

  const without = bare.exec(attributes);
  return without ? without[1] : null;
}

function titleTag(head: string): string | null {
  const match = /<title[^>]*>([\s\S]*?)<\/title>/i.exec(head);
  return match ? match[1] : null;
}

/**
 * Decodes the handful of entities that actually appear in titles, collapses
 * whitespace, and truncates.
 *
 * Numeric entities are capped at the Unicode maximum so a page cannot make
 * String.fromCodePoint throw.
 */
function clean(value: string | null, limit: number): string | null {
  if (value === null) return null;

  const decoded = value
    .replace(/&(#\d+|#x[0-9a-f]+|[a-z]+);/gi, (whole, entity: string) => {
      const named: Record<string, string> = {
        amp: '&',
        lt: '<',
        gt: '>',
        quot: '"',
        apos: "'",
        nbsp: ' ',
      };
      const lower = entity.toLowerCase();
      if (named[lower] !== undefined) return named[lower];

      if (lower.startsWith('#')) {
        const code = lower.startsWith('#x')
          ? Number.parseInt(lower.slice(2), 16)
          : Number.parseInt(lower.slice(1), 10);
        if (Number.isFinite(code) && code > 0 && code <= 0x10ffff) {
          return String.fromCodePoint(code);
        }
      }
      return whole;
    })
    .replace(/\s+/g, ' ')
    .trim();

  if (!decoded) return null;
  return decoded.length > limit ? `${decoded.slice(0, limit - 1)}…` : decoded;
}

/** Resolves a possibly-relative URL, dropping anything that is not http(s). */
function absolute(value: string, base: URL): string | null {
  try {
    const resolved = new URL(value, base);
    if (resolved.protocol !== 'http:' && resolved.protocol !== 'https:') {
      return null;
    }
    return resolved.toString();
  } catch {
    return null;
  }
}
