import type { LinkCard } from './open-graph';

/**
 * Where to ask for a card for a link to a site that will not give one to a
 * fetch of the page itself.
 *
 * YouTube answers a request from a server -- any data centre, Render's
 * included -- with a redirect to google.com/sorry, a captcha, and in the EU
 * with a cookie consent page: so every YouTube link said "youtube.com has no
 * preview". TikTok's pages are an empty shell a script fills in. Both
 * publish oEmbed, an endpoint that exists to describe a link to another site,
 * and that answers servers.
 *
 * Only sites whose pages fail. Spotify, SoundCloud and Vimeo give a fetch of
 * the page its Open Graph tags, which say more than their oEmbed does.
 */
export function oembedEndpoint(url: URL): URL | null {
  const host = url.hostname.toLowerCase().replace(/^www\./, '');

  if (YOUTUBE_HOSTS.has(host)) {
    const video = youtubeVideoId(url);
    // A channel or a playlist has a page oEmbed does not describe either; the
    // page fetch is no worse a try.
    if (!video) return null;
    return withUrl(
      'https://www.youtube.com/oembed?format=json',
      `https://www.youtube.com/watch?v=${video}`,
    );
  }

  if (host === 'tiktok.com' || host === 'm.tiktok.com') {
    if (!/\/video\/\d+/.test(url.pathname)) return null;
    return withUrl('https://www.tiktok.com/oembed', url.toString());
  }

  return null;
}

const YOUTUBE_HOSTS = new Set([
  'youtube.com',
  'm.youtube.com',
  'music.youtube.com',
  'youtu.be',
  'youtube-nocookie.com',
]);

/**
 * The eleven characters that name a YouTube video, however the link was
 * written: watch?v=, youtu.be/, /shorts/, /live/, /embed/.
 */
export function youtubeVideoId(url: URL): string | null {
  const host = url.hostname.toLowerCase().replace(/^www\./, '');
  const path = url.pathname.split('/').filter(Boolean);

  const candidate =
    host === 'youtu.be'
      ? path[0]
      : path[0] === 'watch'
        ? url.searchParams.get('v')
        : ['shorts', 'live', 'embed', 'v'].includes(path[0] ?? '')
          ? path[1]
          : null;

  return candidate && /^[A-Za-z0-9_-]{11}$/.test(candidate) ? candidate : null;
}

function withUrl(endpoint: string, url: string): URL {
  const result = new URL(endpoint);
  result.searchParams.set('url', url);
  return result;
}

/**
 * A card from an oEmbed answer: the title, who made it in place of a
 * description, the thumbnail, and the site.
 *
 * Null when it names nothing, so the caller can try the page instead. The
 * answer is another site's JSON, so every field is checked rather than
 * trusted: a string, a sensible length, and a picture only over https.
 */
export function parseOembed(body: unknown): LinkCard | null {
  if (typeof body !== 'object' || body === null) return null;
  const json = body as Record<string, unknown>;

  const text = (key: string, max: number): string | null => {
    const value = json[key];
    if (typeof value !== 'string') return null;
    const trimmed = value.replace(/\s+/g, ' ').trim();
    if (!trimmed) return null;
    return trimmed.length > max ? `${trimmed.slice(0, max - 1)}…` : trimmed;
  };

  const thumbnail = text('thumbnail_url', 2048);
  let imageUrl: string | null = null;
  if (thumbnail) {
    try {
      const parsed = new URL(thumbnail);
      if (parsed.protocol === 'https:') imageUrl = parsed.toString();
    } catch {
      imageUrl = null;
    }
  }

  const title = text('title', 300);
  if (!title && !imageUrl) return null;

  return {
    title,
    description: text('author_name', 600),
    imageUrl,
    siteName: text('provider_name', 120),
  };
}
