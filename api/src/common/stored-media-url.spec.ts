import { isStoredMediaUrl } from './stored-media-url';

describe('isStoredMediaUrl', () => {
  const ours =
    'https://abc.supabase.co/storage/v1/object/public/kyron-media/post-media/u_1.jpg';

  beforeEach(() => {
    process.env.SUPABASE_URL = 'https://abc.supabase.co';
    delete process.env.SUPABASE_BUCKET_NAME;
  });
  afterEach(() => delete process.env.SUPABASE_URL);

  it('takes a file in this project public bucket', () => {
    expect(isStoredMediaUrl(ours)).toBe(true);
  });

  it('refuses another server, however the path is dressed', () => {
    expect(isStoredMediaUrl('https://evil.example/pixel.gif')).toBe(false);
    expect(
      isStoredMediaUrl(
        'https://evil.example/storage/v1/object/public/kyron-media/a.jpg',
      ),
    ).toBe(false);
    expect(isStoredMediaUrl(ours.replace('abc.', 'abd.'))).toBe(false);
  });

  it('refuses another bucket, a signed URL, http and a traversal', () => {
    expect(isStoredMediaUrl(ours.replace('kyron-media', 'kyron-private'))).toBe(
      false,
    );
    expect(isStoredMediaUrl(ours.replace('/public/', '/sign/'))).toBe(false);
    expect(isStoredMediaUrl(ours.replace('https:', 'http:'))).toBe(false);
    expect(isStoredMediaUrl(ours.replace('post-media', '..'))).toBe(false);
  });

  it('refuses what is not a string', () => {
    expect(isStoredMediaUrl(undefined)).toBe(false);
    expect(isStoredMediaUrl({ url: ours })).toBe(false);
  });
});
