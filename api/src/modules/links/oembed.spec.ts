import { oembedEndpoint, parseOembed, youtubeVideoId } from './oembed';

describe('youtubeVideoId', () => {
  it.each([
    'https://www.youtube.com/watch?v=FDGacISecDQ',
    'https://youtube.com/watch?v=FDGacISecDQ&t=42s',
    'https://m.youtube.com/watch?v=FDGacISecDQ',
    'https://music.youtube.com/watch?v=FDGacISecDQ&list=RD',
    'https://youtu.be/FDGacISecDQ',
    'https://youtu.be/FDGacISecDQ?si=abc',
    'https://www.youtube.com/shorts/FDGacISecDQ',
    'https://www.youtube.com/live/FDGacISecDQ',
    'https://www.youtube.com/embed/FDGacISecDQ',
  ])('reads %s', (link) => {
    expect(youtubeVideoId(new URL(link))).toBe('FDGacISecDQ');
  });

  it.each([
    'https://www.youtube.com/',
    'https://www.youtube.com/@StarTalk',
    'https://www.youtube.com/playlist?list=PL123',
    'https://www.youtube.com/watch?v=short',
    'https://www.youtube.com/watch?v=<script>abc',
  ])('finds no video in %s', (link) => {
    expect(youtubeVideoId(new URL(link))).toBeNull();
  });
});

describe('oembedEndpoint', () => {
  it("asks YouTube's endpoint about the plain watch link, whatever was posted", () => {
    const endpoint = oembedEndpoint(
      new URL('https://youtu.be/FDGacISecDQ?si=tracking'),
    );

    expect(endpoint?.origin).toBe('https://www.youtube.com');
    expect(endpoint?.pathname).toBe('/oembed');
    expect(endpoint?.searchParams.get('format')).toBe('json');
    expect(endpoint?.searchParams.get('url')).toBe(
      'https://www.youtube.com/watch?v=FDGacISecDQ',
    );
  });

  it("asks TikTok's about a video", () => {
    const link = 'https://www.tiktok.com/@scout2015/video/6718335390845095173';
    const endpoint = oembedEndpoint(new URL(link));

    expect(endpoint?.origin).toBe('https://www.tiktok.com');
    expect(endpoint?.searchParams.get('url')).toBe(link);
  });

  it.each([
    'https://www.youtube.com/@StarTalk',
    'https://www.tiktok.com/@scout2015',
    'https://open.spotify.com/track/4cOdK2wGLETKBW3PvgPWqT',
    'https://vimeo.com/76979871',
    'https://example.com/watch?v=FDGacISecDQ',
    'https://notyoutube.com/watch?v=FDGacISecDQ',
  ])('leaves %s to the page fetch', (link) => {
    expect(oembedEndpoint(new URL(link))).toBeNull();
  });
});

describe('parseOembed', () => {
  it('makes a card of what YouTube answers', () => {
    expect(
      parseOembed({
        title: 'You Probably Don’t Realize How Big A Trillion Is',
        author_name: 'StarTalk',
        provider_name: 'YouTube',
        thumbnail_url: 'https://i.ytimg.com/vi/FDGacISecDQ/hqdefault.jpg',
        html: '<iframe></iframe>',
      }),
    ).toEqual({
      title: 'You Probably Don’t Realize How Big A Trillion Is',
      description: 'StarTalk',
      imageUrl: 'https://i.ytimg.com/vi/FDGacISecDQ/hqdefault.jpg',
      siteName: 'YouTube',
    });
  });

  it('is nothing when it names nothing', () => {
    // TikTok's answer for a video that has gone.
    expect(parseOembed({ provider_name: 'TikTok', version: '1.0' })).toBeNull();
    expect(parseOembed(null)).toBeNull();
    expect(parseOembed('a string')).toBeNull();
  });

  it('checks every field rather than trusting it', () => {
    const card = parseOembed({
      title: { not: 'a string' },
      author_name: 42,
      thumbnail_url: 'http://insecure.example.com/a.jpg',
      provider_name: '  Site  ',
    });
    expect(card).toBeNull();

    expect(
      parseOembed({ title: 'x'.repeat(400), thumbnail_url: 'javascript:1' }),
    ).toEqual({
      title: `${'x'.repeat(299)}…`,
      description: null,
      imageUrl: null,
      siteName: null,
    });
  });
});
