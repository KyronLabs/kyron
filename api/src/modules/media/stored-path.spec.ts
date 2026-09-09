import { storedPathFromUrl } from './stored-path';

const BUCKET = 'kyron-media';
const base = 'https://zgzvclssemsyctstwgod.supabase.co/storage/v1/object';

describe('storedPathFromUrl', () => {
  it('takes the path after the bucket', () => {
    expect(
      storedPathFromUrl(`${base}/public/${BUCKET}/videos/abc.mp4`, BUCKET),
    ).toEqual({ path: 'videos/abc.mp4' });
  });

  it('reads a signed URL, which names the same object', () => {
    expect(
      storedPathFromUrl(
        `${base}/sign/${BUCKET}/videos/abc.mp4?token=eyJhbGciOi`,
        BUCKET,
      ),
    ).toEqual({ path: 'videos/abc.mp4' });
  });

  it('decodes an escaped name, because storage wants the real one', () => {
    expect(
      storedPathFromUrl(
        `${base}/public/${BUCKET}/videos/my%20clip.mp4`,
        BUCKET,
      ),
    ).toEqual({ path: 'videos/my clip.mp4' });
  });

  it('keeps nested folders whole', () => {
    expect(
      storedPathFromUrl(`${base}/public/${BUCKET}/u/1/v/2/c.mp4`, BUCKET),
    ).toEqual({ path: 'u/1/v/2/c.mp4' });
  });

  // Everything below gets a reason rather than a guess. A guessed path is a
  // job that cannot download -- and a path is also where the smaller file is
  // written back, so a wrong one aims a write at the wrong object.
  it.each([
    ['not a URL at all', 'videos/abc.mp4'],
    [
      'http rather than https',
      `http://x.supabase.co/storage/v1/object/public/${BUCKET}/a.mp4`,
    ],
    ['some other host entirely', 'https://cdn.example.com/videos/abc.mp4'],
    [
      'a Supabase URL that is not storage',
      'https://x.supabase.co/rest/v1/media',
    ],
    ['another bucket', `${base}/public/avatars/a.png`],
    ['nothing after the bucket', `${base}/public/${BUCKET}/`],
    ['a traversal', `${base}/public/${BUCKET}/../avatars/a.png`],
  ])('refuses %s', (_why, url) => {
    const answer = storedPathFromUrl(url, BUCKET);
    expect(answer).toHaveProperty('refused');
    expect((answer as { refused: string }).refused).not.toHaveLength(0);
  });
});
