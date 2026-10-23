import { LinksService } from './links.service';

jest.mock('./link-safety', () => ({
  ...jest.requireActual<typeof import('./link-safety')>('./link-safety'),
  // No DNS from a unit test; the address check has its own spec.
  resolveIfPublic: jest.fn().mockResolvedValue(['93.184.216.34']),
}));

const youtube = 'https://www.youtube.com/watch?v=FDGacISecDQ';

const oembed = {
  title: 'You Probably Don’t Realize How Big A Trillion Is',
  author_name: 'StarTalk',
  provider_name: 'YouTube',
  thumbnail_url: 'https://i.ytimg.com/vi/FDGacISecDQ/hqdefault.jpg',
};

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json' },
  });
}

function page(html: string): Response {
  return new Response(html, {
    status: 200,
    headers: { 'content-type': 'text/html' },
  });
}

/** What Google answers a server asking for a YouTube page. */
function captcha(): Response {
  return new Response('', {
    status: 302,
    headers: { location: 'https://www.google.com/sorry/index' },
  });
}

function tooMany(): Response {
  return new Response('', { status: 429 });
}

/** Where a fetch was sent: the service always passes a URL. */
function sentTo(call: unknown[]): string {
  const target = call[0];
  return target instanceof URL ? target.toString() : String(target as string);
}

/** Answers the oEmbed endpoint one way and anything else another. */
function route(endpoint: () => Response, other: () => Response) {
  return (input: unknown) =>
    Promise.resolve(sentTo([input]).includes('/oembed') ? endpoint() : other());
}

function setup(cached: Record<string, unknown> | null = null) {
  const rows: Record<string, unknown>[] = [];
  const prisma = {
    linkPreview: {
      findUnique: jest.fn().mockResolvedValue(cached),
      upsert: jest.fn((args: { create: Record<string, unknown> }) => {
        rows.push(args.create);
        return Promise.resolve({ ...args.create, fetchedAt: new Date() });
      }),
    },
  };
  const service = new LinksService(prisma as never);
  const fetch = jest.spyOn(global, 'fetch');
  return { service, fetch, rows };
}

function failedRow(url: string, host: string, minutesAgo: number) {
  const at = new Date(Date.now() - minutesAgo * 60 * 1000);
  return {
    url,
    host,
    title: null,
    description: null,
    imageUrl: null,
    siteName: null,
    fetchedAt: at,
    failedAt: at,
  };
}

afterEach(() => jest.restoreAllMocks());

describe('LinksService.preview', () => {
  it("gets a YouTube link's card from oEmbed, not from the page", async () => {
    const { service, fetch } = setup();
    fetch.mockImplementation(route(() => json(oembed), captcha));

    const card = await service.preview(youtube);

    expect(card).toEqual({
      url: youtube,
      host: 'www.youtube.com',
      title: oembed.title,
      description: 'StarTalk',
      imageUrl: oembed.thumbnail_url,
      siteName: 'YouTube',
    });
    expect(fetch).toHaveBeenCalledTimes(1);
    const asked = new URL(sentTo(fetch.mock.calls[0]));
    expect(asked.pathname).toBe('/oembed');
    expect(asked.searchParams.get('url')).toBe(youtube);
  });

  it('reads a youtu.be link the same way', async () => {
    const { service, fetch } = setup();
    fetch.mockImplementation(() => Promise.resolve(json(oembed)));

    const card = await service.preview('https://youtu.be/FDGacISecDQ');

    expect(card?.title).toBe(oembed.title);
  });

  it('falls back to the page when oEmbed has nothing to say', async () => {
    const { service, fetch } = setup();
    fetch.mockImplementation(
      route(
        () => json({ error: 'Unauthorized' }, 401),
        () =>
          page(
            '<head><meta property="og:title" content="From the page"></head>',
          ),
      ),
    );

    const card = await service.preview(youtube);

    expect(card?.title).toBe('From the page');
    expect(fetch).toHaveBeenCalledTimes(2);
  });

  it('records a failure when neither answers', async () => {
    const { service, fetch, rows } = setup();
    fetch
      .mockResolvedValueOnce(json({}, 404)) // the endpoint
      .mockResolvedValueOnce(captcha()) // the page
      .mockResolvedValueOnce(tooMany()); // where the page sent it

    expect(await service.preview(youtube)).toBeNull();
    expect(rows[0]?.failedAt).toBeInstanceOf(Date);
  });

  it('does not follow a redirect from an oEmbed endpoint', async () => {
    const { service, fetch } = setup();
    fetch.mockResolvedValueOnce(captcha());
    fetch.mockImplementation(() => Promise.resolve(tooMany()));

    expect(await service.preview(youtube)).toBeNull();
    // The endpoint, then the page: never where the endpoint pointed.
    expect(sentTo(fetch.mock.calls[0])).toContain('/oembed');
    expect(sentTo(fetch.mock.calls[1])).toBe(youtube);
  });

  it('tries a YouTube link that failed again after minutes, not hours', async () => {
    const { service, fetch } = setup(failedRow(youtube, 'www.youtube.com', 20));
    fetch.mockImplementation(() => Promise.resolve(json(oembed)));

    expect((await service.preview(youtube))?.title).toBe(oembed.title);
  });

  it('still remembers a failed ordinary link for hours', async () => {
    const { service, fetch } = setup(
      failedRow('https://example.com/', 'example.com', 20),
    );

    expect(await service.preview('https://example.com/')).toBeNull();
    expect(fetch).not.toHaveBeenCalled();
  });

  it('leaves other links to the page, as before', async () => {
    const { service, fetch } = setup();
    fetch.mockImplementation(() =>
      Promise.resolve(
        page('<head><meta property="og:title" content="A track"></head>'),
      ),
    );

    const card = await service.preview(
      'https://open.spotify.com/track/4cOdK2wGLETKBW3PvgPWqT',
    );

    expect(card?.title).toBe('A track');
    expect(sentTo(fetch.mock.calls[0])).not.toContain('oembed');
  });
});
