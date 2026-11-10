import { DeletedMediaService } from './deleted-media.service';

const url = (path: string) =>
  `https://p.supabase.co/storage/v1/object/public/kyron-media/${path}`;

function setup(
  rows: { id: string; url: string; thumbnailUrl: string | null }[],
  shared: { url: string; thumbnailUrl: string | null }[] = [],
  removeFails = false,
) {
  const media = {
    findMany: jest
      .fn()
      .mockResolvedValueOnce(rows)
      .mockResolvedValueOnce(shared),
    deleteMany: jest.fn().mockResolvedValue({ count: rows.length }),
  };
  const supabase = {
    getBucketName: () => 'kyron-media',
    removeFiles: jest.fn(() =>
      removeFails ? Promise.reject(new Error('down')) : Promise.resolve(),
    ),
  };
  const service = new DeletedMediaService(
    { media } as never,
    supabase as never,
  );
  return { service, media, supabase };
}

describe('DeletedMediaService', () => {
  const now = new Date('2026-11-10T12:00:00Z');

  it('only looks at posts deleted more than the grace period ago', async () => {
    const { service, media } = setup([]);
    await service.sweep(now);
    const [[query]] = media.findMany.mock.calls as unknown as [
      [{ where: { post: { deletedAt: { lt: Date } } } }],
    ];
    const cutoff = query.where.post.deletedAt.lt;
    expect(now.getTime() - cutoff.getTime()).toBe(30 * 86_400_000);
  });

  it('removes the files, thumbnails included, then the rows', async () => {
    const { service, media, supabase } = setup([
      { id: 'm1', url: url('a.jpg'), thumbnailUrl: null },
      { id: 'm2', url: url('b.mp4'), thumbnailUrl: url('b.jpg') },
    ]);

    await expect(service.sweep(now)).resolves.toBe(2);

    expect(supabase.removeFiles).toHaveBeenCalledWith([
      'a.jpg',
      'b.mp4',
      'b.jpg',
    ]);
    expect(media.deleteMany).toHaveBeenCalledWith({
      where: { id: { in: ['m1', 'm2'] } },
    });
  });

  it('keeps a file another row still shows', async () => {
    const { service, supabase } = setup(
      [{ id: 'm1', url: url('a.jpg'), thumbnailUrl: null }],
      [{ url: url('a.jpg'), thumbnailUrl: null }],
    );
    await service.sweep(now);
    expect(supabase.removeFiles).toHaveBeenCalledWith([]);
  });

  it('leaves the rows for next time when storage fails', async () => {
    const { service, media } = setup(
      [{ id: 'm1', url: url('a.jpg'), thumbnailUrl: null }],
      [],
      true,
    );
    await expect(service.sweep(now)).resolves.toBe(0);
    expect(media.deleteMany).not.toHaveBeenCalled();
  });
});
