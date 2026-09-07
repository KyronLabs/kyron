import { BadRequestException, NotFoundException } from '@nestjs/common';
import { MediaKind } from '@prisma/client';
import { MessagesService } from './messages.service';
import { RecordingRealtime } from '../realtime/realtime.test-double';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const ME = 'me';
const THEM = 'them';

function serviceWith({ members = [{ userId: ME }, { userId: THEM }] } = {}) {
  const creates: { data: Record<string, unknown> }[] = [];
  const writes: string[] = [];

  const prisma = {
    conversation: {
      // Membership is a filter in the query, not a check after it: a
      // conversation the reader is not in matches nothing.
      findFirst: jest.fn(() =>
        Promise.resolve(
          members.some((m) => m.userId === ME) ? { id: 'c1', members } : null,
        ),
      ),
      update: jest.fn(() => {
        writes.push('conversation.update');
        return Promise.resolve({});
      }),
    },
    conversationMember: {
      updateMany: jest.fn((args: { data: Record<string, unknown> }) => {
        writes.push(
          'mutedAt' in args.data
            ? 'member.mute'
            : 'hiddenAt' in args.data
              ? 'member.hide'
              : 'member.read',
        );
        return Promise.resolve({ count: 1 });
      }),
    },
    message: {
      create: jest.fn((args: { data: Record<string, unknown> }) => {
        creates.push(args);
        return Promise.resolve({
          id: 'm1',
          body: args.data.body,
          senderId: ME,
          createdAt: new Date(),
          media: [],
        });
      }),
    },
    block: {
      findFirst: jest.fn().mockResolvedValue(null),
      upsert: jest.fn(() => {
        writes.push('block.upsert');
        return Promise.resolve({});
      }),
    },
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  };

  return {
    svc: new MessagesService(
      prisma as unknown as PrismaService,
      new RecordingRealtime(),
    ),
    creates,
    writes,
  };
}

const picture = { kind: MediaKind.IMAGE, url: 'https://x/1.jpg' };

describe('message attachments', () => {
  it('sends a picture with no words', async () => {
    // An empty box is not a message; a picture is.
    const { svc, creates } = serviceWith();

    await svc.send(ME, 'c1', '', [picture]);

    expect(creates[0].data).toMatchObject({ body: '' });
  });

  it('still refuses a message with nothing in it at all', async () => {
    const { svc } = serviceWith();

    await expect(svc.send(ME, 'c1', '   ')).rejects.toThrow(
      BadRequestException,
    );
  });

  it('keeps the order they were picked in', async () => {
    const { svc, creates } = serviceWith();

    await svc.send(ME, 'c1', 'look', [
      { ...picture, url: 'a' },
      { ...picture, url: 'b' },
    ]);

    const created = creates[0].data.media as {
      create: { url: string; position: number }[];
    };
    expect(created.create.map((m) => [m.url, m.position])).toEqual([
      ['a', 0],
      ['b', 1],
    ]);
  });

  it('refuses more than the cap', async () => {
    const { svc } = serviceWith();

    await expect(
      svc.send(ME, 'c1', '', Array(5).fill(picture)),
    ).rejects.toThrow(BadRequestException);
  });

  it('takes an unlabelled upload for a picture', async () => {
    const { svc, creates } = serviceWith();

    await svc.send(ME, 'c1', '', [{ url: 'https://x/1.jpg' }]);

    const created = creates[0].data.media as {
      create: { kind: MediaKind }[];
    };
    expect(created.create[0].kind).toBe(MediaKind.IMAGE);
  });
});

describe('conversation actions', () => {
  it('mutes for the reader only', async () => {
    const { svc, writes } = serviceWith();

    await expect(svc.setMuted(ME, 'c1', true)).resolves.toEqual({
      id: 'c1',
      muted: true,
    });
    expect(writes).toContain('member.mute');
  });

  it('unmutes', async () => {
    const { svc } = serviceWith();

    await expect(svc.setMuted(ME, 'c1', false)).resolves.toEqual({
      id: 'c1',
      muted: false,
    });
  });

  it('blocks and hides the thread together', async () => {
    // Blocking somebody you are talking to and leaving their thread in your
    // list is not a state anybody wants.
    const { svc, writes } = serviceWith();

    await expect(svc.blockOther(ME, 'c1')).resolves.toEqual({
      ok: true,
      blockedId: THEM,
    });
    expect(writes).toEqual(['block.upsert', 'member.hide']);
  });

  it('has nobody to block in a thread with only you in it', async () => {
    const { svc } = serviceWith({ members: [{ userId: ME }] });

    await expect(svc.blockOther(ME, 'c1')).rejects.toThrow(BadRequestException);
  });

  it('does not confirm a conversation the reader is not in', async () => {
    // 404 rather than 403: telling somebody a thread exists but is not theirs
    // is telling them it exists.
    const { svc } = serviceWith({ members: [{ userId: THEM }] });

    await expect(svc.setMuted(ME, 'c1', true)).rejects.toThrow(
      NotFoundException,
    );
  });
});
