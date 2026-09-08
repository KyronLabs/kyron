/**
 * Which route a request was served by, as a label safe to count on.
 *
 * The URL cannot be used directly: `/feed/posts/9f3.../view` is a different
 * string every time, and one series per request is how a metrics endpoint
 * takes down the thing scraping it. Fastify knows the pattern it matched, so
 * that is preferred; the normaliser below is for the requests that matched no
 * route at all, which still deserve to be counted.
 */
export function routeLabel(request: unknown): string {
  const req = request as {
    routeOptions?: { url?: string };
    routerPath?: string;
    url?: string;
    originalUrl?: string;
  };

  const matched = req?.routeOptions?.url ?? req?.routerPath;
  if (typeof matched === 'string' && matched.length > 0) return matched;

  return normalisePath(req?.originalUrl ?? req?.url ?? '/');
}

/** Everything that looks like an id, replaced by the shape of one. */
export function normalisePath(url: string): string {
  const path = url.split('?')[0] || '/';

  const segments = path.split('/').map((segment) => {
    if (segment.length === 0) return segment;
    if (UUID.test(segment)) return ':id';
    if (/^\d+$/.test(segment)) return ':n';
    // A base64url cursor, a Supabase id, a token in a path somebody added
    // without thinking. Folded on length alone, with no exception for
    // something that happens to look like a word: a base64 payload is all
    // letters and digits often enough that any such exception lets one
    // through, and the longest route segment this API actually declares is
    // "default-cover" at thirteen characters.
    if (segment.length > MAX_SEGMENT) return ':opaque';
    return segment.toLowerCase();
  });

  // Bounded, so a path with a thousand segments cannot become a label with a
  // thousand segments.
  const trimmed = segments.slice(0, 8).join('/') || '/';
  return trimmed.length > 120 ? `${trimmed.slice(0, 120)}…` : trimmed;
}

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/** Past this, a segment is an id rather than a name. */
const MAX_SEGMENT = 24;
