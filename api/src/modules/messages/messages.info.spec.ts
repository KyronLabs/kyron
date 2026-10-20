import { NotFoundException } from '@nestjs/common';
import { MediaKind } from '@prisma/client';
import { MessagesService } from './messages.service';
import { WallpapersService } from './wallpapers.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

const ME = 'me';

const message = (id: string, urls: string[]) => ({
  id,
  senderId: 'them',
  createdAt: new Date('2026-10-01T09:00:00Z'),
  media: urls.map((url, i) => ({
    id: `${id}-${i}`,
    kind: MediaKind.IMAGE,
    url,
    width: null,
    height: null,
    alt: null,
    durationMs: null,
    waveform: [],
    thumbnailUrl: null,
  })),
});

function serviceWith({
  member = true,
  rows = [] as ReturnType<typeof message>[],
  anchor = { id: 'm1' } as { id: string } | null,
} = {}) {
  const prisma = {
    conversation: {
      findFirst: jest.fn(() =>
        Promise.resolve(
          member ? { id: 'c1', members: [{ userId: ME }] } : null,
        ),
      ),
    },
    message: {
      findMany: jest.fn(() => Promise.resolve(rows)),
      findFirst: jest.fn(() => Promise.resolve(anchor)),
    },
  };
  return {
    svc: new MessagesService(
      prisma as unknown as PrismaService,
      new RecordingDelivery(),
    ),
    prisma,
  };
}

describe('a conversation’s shared media', () => {
  it('lists every attachment with the message it came in, newest first', async () => {
    const { svc, prisma } = serviceWith({
      rows: [message('m2', ['b1', 'b2']), message('m1', ['a1'])],
    });

    const page = await svc.sharedMedia(ME, 'c1');

    expect(page.items.map((m) => [m.url, m.messageId])).toEqual([
      ['b1', 'm2'],
      ['b2', 'm2'],
      ['a1', 'm1'],
    ]);
    expect(page.nextCursor).toBeNull();
    // Only messages that carry something, never deleted ones, and never a
    // view-once one: it has no address, and a grid of everything shared is
    // what it promised not to become.
    expect(prisma.message.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          conversationId: 'c1',
          deletedAt: null,
          viewOnce: false,
          media: { some: {} },
        },
        orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
      }),
    );
  });

  it('pages by message, so an album is never split', async () => {
    const { svc } = serviceWith({
      rows: [message('m3', ['c']), message('m2', ['b1', 'b2'])],
    });

    const page = await svc.sharedMedia(ME, 'c1', { limit: 1 });

    expect(page.items.map((m) => m.url)).toEqual(['c']);
    expect(page.nextCursor).toBe('m3');
  });

  it('refuses a cursor from another conversation', async () => {
    const { svc } = serviceWith({ anchor: null });

    await expect(
      svc.sharedMedia(ME, 'c1', { cursor: 'elsewhere' }),
    ).rejects.toThrow(NotFoundException);
  });

  it('shows nothing of a conversation the reader is not in', async () => {
    const { svc } = serviceWith({ member: false });

    await expect(svc.sharedMedia(ME, 'c1')).rejects.toThrow(NotFoundException);
  });
});

describe('wallpapers', () => {
  function wallpapersWith(list: jest.Mock) {
    const storage = {
      listFiles: list,
      getPublicUrl: (path: string) => `https://cdn.invalid/${path}`,
    };
    return new WallpapersService(storage as unknown as SupabaseService);
  }

  it('are the images in the folder, in name order', async () => {
    const service = wallpapersWith(
      jest
        .fn()
        .mockResolvedValue([
          { name: 'b-dunes.jpg' },
          { name: '.emptyFolderPlaceholder' },
          { name: 'a-sea.webp' },
          { name: 'notes.txt' },
        ]),
    );

    await expect(service.list()).resolves.toEqual([
      { id: 'a-sea.webp', url: 'https://cdn.invalid/wallpapers/a-sea.webp' },
      { id: 'b-dunes.jpg', url: 'https://cdn.invalid/wallpapers/b-dunes.jpg' },
    ]);
  });

  it('asks storage once in a while, not on every open', async () => {
    const list = jest.fn().mockResolvedValue([{ name: 'a.jpg' }]);
    const service = wallpapersWith(list);

    await service.list(0);
    await service.list(WallpapersService.ttlMs - 1);
    expect(list).toHaveBeenCalledTimes(1);

    await service.list(WallpapersService.ttlMs + 1);
    expect(list).toHaveBeenCalledTimes(2);
  });

  it('keeps what it last knew through a storage blip', async () => {
    const list = jest
      .fn()
      .mockResolvedValueOnce([{ name: 'a.jpg' }])
      .mockRejectedValueOnce(new Error('timeout'));
    const service = wallpapersWith(list);

    await service.list(0);
    await expect(service.list(WallpapersService.ttlMs + 1)).resolves.toEqual([
      { id: 'a.jpg', url: 'https://cdn.invalid/wallpapers/a.jpg' },
    ]);
  });
});
