import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { normaliseUrl, resolveIfPublic } from './link-safety';
import { oembedEndpoint, parseOembed } from './oembed';
import { LinkCard, parseCard } from './open-graph';

export interface LinkPreviewResult {
  url: string;
  host: string;
  title: string | null;
  description: string | null;
  imageUrl: string | null;
  siteName: string | null;
}

@Injectable()
export class LinksService {
  private readonly logger = new Logger(LinksService.name);

  /** How long a successful card is trusted before it is fetched again. */
  private static readonly freshFor = 7 * 24 * 60 * 60 * 1000;

  /** How long a failure is remembered, so a dead link is not retried per scroll. */
  private static readonly retryFailedAfter = 6 * 60 * 60 * 1000;

  /**
   * The same for a link with an oEmbed endpoint, which is cheap to ask and
   * rarely down: a failure there is more likely a blip than a dead link. It
   * also lets a link that failed before the endpoint was used -- every
   * YouTube link -- get its card within minutes rather than hours.
   */
  private static readonly retryFailedOembedAfter = 15 * 60 * 1000;

  /** An oEmbed answer is a few hundred bytes of JSON. */
  private static readonly maxOembedBytes = 64 * 1024;

  /** Long enough for a slow site, short enough not to hold a request open. */
  private static readonly timeoutMs = 5000;

  /** A card lives in the first few kilobytes; anything past this is body. */
  private static readonly maxBytes = 512 * 1024;

  private static readonly maxRedirects = 3;

  constructor(private readonly prisma: PrismaService) {}

  /**
   * The card for one URL, from cache when it is fresh.
   *
   * Returns null rather than throwing when a page simply has no card: a post
   * containing a link to something that does not describe itself is not an
   * error, and the client should render the post without a card.
   */
  async preview(rawUrl: string): Promise<LinkPreviewResult | null> {
    let url: URL;
    try {
      url = normaliseUrl(rawUrl);
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'That is not a web address.',
      );
    }

    const key = url.toString();
    const cached = await this.prisma.linkPreview.findUnique({
      where: { url: key },
    });

    const failed = cached?.failedAt != null;
    const retryAfter =
      failed && oembedEndpoint(url)
        ? LinksService.retryFailedOembedAfter
        : failed
          ? LinksService.retryFailedAfter
          : LinksService.freshFor;
    if (cached && Date.now() - cached.fetchedAt.getTime() < retryAfter) {
      return cached.failedAt ? null : this.toResult(cached);
    }

    let card: LinkCard | null;
    try {
      card = await this.fetchCard(url);
    } catch (error) {
      // A link that will not load is recorded as a failure and reported as
      // "no card", not as an error: one unreachable link in a post must not
      // stop the post rendering.
      this.logger.warn(
        `No preview for ${url.host}: ${error instanceof Error ? error.message : String(error)}`,
      );
      card = null;
    }

    const row = await this.prisma.linkPreview.upsert({
      where: { url: key },
      create: {
        url: key,
        host: url.host,
        title: card?.title ?? null,
        description: card?.description ?? null,
        imageUrl: card?.imageUrl ?? null,
        siteName: card?.siteName ?? null,
        failedAt: card ? null : new Date(),
      },
      update: {
        host: url.host,
        title: card?.title ?? null,
        description: card?.description ?? null,
        imageUrl: card?.imageUrl ?? null,
        siteName: card?.siteName ?? null,
        failedAt: card ? null : new Date(),
        fetchedAt: new Date(),
      },
    });

    return card ? this.toResult(row) : null;
  }

  private toResult(row: {
    url: string;
    host: string;
    title: string | null;
    description: string | null;
    imageUrl: string | null;
    siteName: string | null;
  }): LinkPreviewResult {
    return {
      url: row.url,
      host: row.host,
      title: row.title,
      description: row.description,
      imageUrl: row.imageUrl,
      siteName: row.siteName,
    };
  }

  /**
   * The card for a link: from the site's oEmbed endpoint when it has one and
   * it answers, otherwise from the page.
   */
  private async fetchCard(start: URL): Promise<LinkCard | null> {
    const endpoint = oembedEndpoint(start);
    if (endpoint) {
      try {
        const card = await this.fetchOembed(endpoint);
        if (card) return card;
      } catch (error) {
        this.logger.warn(
          `No oEmbed for ${start.host}: ${error instanceof Error ? error.message : String(error)}`,
        );
      }
    }
    return this.fetchPage(start);
  }

  /**
   * Asks an oEmbed endpoint. Its host goes through the same address check as
   * a page's, and a redirect is a failure rather than something to follow:
   * the endpoints are fixed, and none of them redirects.
   */
  private async fetchOembed(endpoint: URL): Promise<LinkCard | null> {
    await resolveIfPublic(endpoint.hostname);
    const response = await this.get(endpoint, 'application/json');

    if (!response.ok) {
      response.body?.cancel().catch(() => undefined);
      throw new Error(`Answered ${response.status}.`);
    }
    const type = response.headers.get('content-type') ?? '';
    if (!type.includes('json')) {
      response.body?.cancel().catch(() => undefined);
      throw new Error(`Not JSON (${type || 'no content type'}).`);
    }

    const text = await readCapped(response, LinksService.maxOembedBytes, {
      stopAtHead: false,
    });
    return parseOembed(JSON.parse(text));
  }

  /**
   * Fetches the page and reads its card, following redirects by hand.
   *
   * By hand because every hop has to be checked: fetch's own redirect
   * following would happily walk from a public URL to http://127.0.0.1/, and
   * the address check is worthless if it only guards the first request.
   */
  private async fetchPage(start: URL): Promise<LinkCard | null> {
    let url = start;

    for (let hop = 0; hop <= LinksService.maxRedirects; hop++) {
      await resolveIfPublic(url.hostname);

      const response = await this.get(url);

      const location = response.headers.get('location');
      if (isRedirect(response.status) && location) {
        response.body?.cancel().catch(() => undefined);
        url = new URL(location, url);
        if (url.protocol !== 'http:' && url.protocol !== 'https:') {
          throw new Error('Redirected somewhere that is not the web.');
        }
        continue;
      }

      if (!response.ok) {
        throw new Error(`Answered ${response.status}.`);
      }

      const type = response.headers.get('content-type') ?? '';
      if (!type.includes('html')) {
        response.body?.cancel().catch(() => undefined);
        throw new Error(`Not a page (${type || 'no content type'}).`);
      }

      const html = await readCapped(response, LinksService.maxBytes);
      const card = parseCard(html, url);

      // A card with nothing in it is not a card. Storing one would put an
      // empty grey rectangle under every link to a page that has no metadata.
      return card.title || card.description || card.imageUrl ? card : null;
    }

    throw new Error('Too many redirects.');
  }

  private async get(
    url: URL,
    accept = 'text/html,application/xhtml+xml',
  ): Promise<Response> {
    const abort = new AbortController();
    const timer = setTimeout(() => abort.abort(), LinksService.timeoutMs);

    try {
      return await fetch(url, {
        method: 'GET',
        redirect: 'manual',
        signal: abort.signal,
        headers: {
          // Identifies the fetch so a site owner seeing it in their logs knows
          // what it is, and can refuse it.
          'user-agent': 'KyronBot/1.0 (+https://kyron.so/bot)',
          accept,
          'accept-language': 'en',
        },
      });
    } finally {
      clearTimeout(timer);
    }
  }
}

function isRedirect(status: number): boolean {
  return (
    status === 301 ||
    status === 302 ||
    status === 303 ||
    status === 307 ||
    status === 308
  );
}

/**
 * Reads at most `limit` bytes and stops.
 *
 * Content-Length cannot be trusted to bound this: a server can omit it, or lie
 * about it, and stream forever. Counting what actually arrives is the only
 * limit that holds.
 */
async function readCapped(
  response: Response,
  limit: number,
  { stopAtHead = true }: { stopAtHead?: boolean } = {},
): Promise<string> {
  const reader = response.body?.getReader() as
    | ReadableStreamDefaultReader<Uint8Array>
    | undefined;
  if (!reader) return '';

  const decoder = new TextDecoder('utf-8');
  let text = '';
  let read = 0;

  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) break;
      if (!value) continue;

      read += value.byteLength;
      text += decoder.decode(value, { stream: true });

      if (read >= limit || (stopAtHead && /<\/head>/i.test(text))) break;
    }
  } finally {
    await reader.cancel().catch(() => undefined);
  }

  return text;
}
