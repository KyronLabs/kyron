import { MediaKind, Prisma } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { ViewOnceService } from './view-once.service';

/**
 * The rules of view-once, without a database. messages.groups.db.spec.ts
 * runs the same against a real one.
 */

const SENT = new Date('2026-10-20T12:00:00Z');
const ADA = 'ada';
const BEN = 'ben';

describe('what view-once allows', () => {
  it('opens a picture for two minutes, a clip or voice note for its length', () => {
    expect(ViewOnceService.linkSeconds(MediaKind.IMAGE, null)).toBe(120);
    expect(ViewOnceService.linkSeconds(MediaKind.VOICE, 30_000)).toBe(120);
    expect(ViewOnceService.linkSeconds(MediaKind.VIDEO, 5 * 60_000)).toBe(360);
    // And never for long, however long the clip says it is.
    expect(ViewOnceService.linkSeconds(MediaKind.VIDEO, 60 * 60_000)).toBe(900);
  });

  it('takes only a file its sender uploaded', () => {
    expect(ViewOnceService.isOwnRef(`once/${ADA}_1_a.jpg`, ADA)).toBe(true);
    expect(ViewOnceService.isOwnRef(`once/${BEN}_1_a.jpg`, ADA)).toBe(false);
    // Nothing that climbs out of the folder, or names another bucket path.
    expect(ViewOnceService.isOwnRef(`once/${ADA}_/../x.jpg`, ADA)).toBe(false);
    expect(ViewOnceService.isOwnRef(`post-media/${ADA}_1.jpg`, ADA)).toBe(
      false,
    );
  });

  it('goes to everybody there when it was sent, but its sender', () => {
    const members = [
      { userId: ADA, joinedAt: new Date('2026-10-01') },
      { userId: BEN, joinedAt: new Date('2026-10-01') },
      // Added after: not sent it.
      { userId: 'cy', joinedAt: new Date('2026-10-21') },
    ];
    expect(
      ViewOnceService.recipientsOf({ senderId: ADA, createdAt: SENT }, members),
    ).toEqual([BEN]);
  });

  it('says where it stands for each reader', () => {
    const members = [
      { userId: ADA, joinedAt: new Date('2026-10-01') },
      { userId: BEN, joinedAt: new Date('2026-10-01') },
    ];
    const message = {
      senderId: ADA,
      createdAt: SENT,
      mediaGoneAt: null,
      opens: [{ userId: BEN }],
    };
    expect(ViewOnceService.stateFor(BEN, message, members, SENT)).toEqual({
      opened: true,
      openedCount: 1,
      recipients: 1,
      gone: false,
    });
    // The sender never "opened" their own.
    expect(ViewOnceService.stateFor(ADA, message, members, SENT).opened).toBe(
      false,
    );
    const later = new Date(
      SENT.getTime() + (ViewOnceService.ttlDays + 1) * 86_400_000,
    );
    expect(ViewOnceService.stateFor(BEN, message, members, later).gone).toBe(
      true,
    );
  });

  it('never hands out an address', () => {
    expect(
      ViewOnceService.withoutAddress([
        { url: 'https://x/a.jpg', thumbnailUrl: 'https://x/t.jpg', id: '1' },
      ]),
    ).toEqual([{ url: '', thumbnailUrl: null, id: '1' }]);
  });
});

describe('ViewOnceService.open', () => {
  function service({
    sender = ADA,
    gone = false,
    opensBefore = 0,
    duplicate = false,
  } = {}) {
    const created: unknown[] = [];
    const updates: unknown[] = [];
    const prisma = {
      message: {
        findFirst: jest.fn(() =>
          Promise.resolve({
            id: 'm1',
            senderId: sender,
            createdAt: new Date(),
            viewOnce: true,
            mediaGoneAt: gone ? new Date() : null,
            media: [
              {
                kind: MediaKind.IMAGE,
                privatePath: `once/${sender}_1_a.jpg`,
                width: 10,
                height: 10,
                durationMs: null,
                waveform: [],
              },
            ],
            conversation: {
              members: [
                { userId: ADA, joinedAt: new Date(0) },
                { userId: BEN, joinedAt: new Date(0) },
              ],
            },
          }),
        ),
        update: jest.fn((args: unknown) => {
          updates.push(args);
          return Promise.resolve({});
        }),
      },
      messageOpen: {
        create: jest.fn((args: unknown) => {
          if (duplicate) {
            return Promise.reject(
              new Prisma.PrismaClientKnownRequestError('dup', {
                code: 'P2002',
                clientVersion: 'test',
              }),
            );
          }
          created.push(args);
          return Promise.resolve({});
        }),
        count: jest.fn(() => Promise.resolve(opensBefore + 1)),
      },
    };
    const storage = {
      signPrivate: jest.fn((path: string, seconds: number) =>
        Promise.resolve(`https://signed/${path}?${seconds}`),
      ),
    };
    const delivery = new RecordingDelivery();
    const svc = new ViewOnceService(
      prisma as unknown as PrismaService,
      storage as unknown as SupabaseService,
      delivery,
    );
    return { svc, created, updates, storage, delivery };
  }

  it('records the open before it hands out a link', async () => {
    const { svc, created, storage } = service();
    const opened = await svc.open(BEN, 'c1', 'm1');
    expect(created).toEqual([{ data: { messageId: 'm1', userId: BEN } }]);
    expect(storage.signPrivate).toHaveBeenCalledWith(
      `once/${ADA}_1_a.jpg`,
      120,
    );
    expect(opened.url).toContain('signed');
  });

  it('refuses a second open', async () => {
    const { svc, storage } = service({ duplicate: true });
    await expect(svc.open(BEN, 'c1', 'm1')).rejects.toMatchObject({
      status: 410,
    });
    expect(storage.signPrivate).not.toHaveBeenCalled();
  });

  it('refuses its sender', async () => {
    const { svc } = service();
    await expect(svc.open(ADA, 'c1', 'm1')).rejects.toMatchObject({
      status: 403,
    });
  });

  it('refuses one already deleted', async () => {
    const { svc } = service({ gone: true });
    await expect(svc.open(BEN, 'c1', 'm1')).rejects.toMatchObject({
      status: 410,
    });
  });

  it('schedules the delete for when the last link runs out', async () => {
    const { svc, updates, delivery } = service();
    const opened = await svc.open(BEN, 'c1', 'm1');
    expect(updates).toEqual([
      { where: { id: 'm1' }, data: { purgeAfter: opened.expiresAt } },
    ]);
    expect(delivery.ofType('message.opened')).toHaveLength(1);
  });
});
