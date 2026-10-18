import { BadRequestException, NotFoundException } from '@nestjs/common';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { DeliveryService } from '../push/delivery.service';
import type { RealtimeEvent } from '../realtime/realtime.service';
import { KeySharesService } from './key-shares.service';

/**
 * A device asks for the keys of messages it was not sealed for; a device that
 * can open them answers. These run against a small in-memory store rather
 * than mocked calls, so what is checked is who can ask, who can answer, and
 * who is handed what -- not which query was written.
 */

const ADA = '00000000-0000-4000-8000-00000000000a';
const BO = '00000000-0000-4000-8000-00000000000b';
const CY = '00000000-0000-4000-8000-00000000000c';
const C1 = '00000000-0000-4000-8000-0000000000c1';

/** A public key of the right shape: 43 base64url characters. */
const key = (c: string) => c.repeat(43);
const ADA_PHONE = key('a');
const ADA_NEW = key('n');
const BO_PHONE = key('b');
const CY_PHONE = key('c');

/** An answer of the right shape, from [from]. */
const sealedBy = (from: string) => `${from}.bm9uY2U.a2V5.bWFj`;

interface Share {
  id: string;
  messageId: string;
  userId: string;
  publicKey: string;
  sealed: string | null;
  answeredAt: Date | null;
  createdAt: Date;
}

const days = (n: number) => new Date(Date.now() - n * 86_400_000);

function store() {
  const members = [
    { conversationId: C1, userId: ADA },
    { conversationId: C1, userId: BO },
  ];
  const keys = [
    { userId: ADA, deviceId: 'ada-phone', publicKey: ADA_PHONE },
    { userId: ADA, deviceId: 'ada-new', publicKey: ADA_NEW },
    { userId: BO, deviceId: 'bo-phone', publicKey: BO_PHONE },
    { userId: CY, deviceId: 'cy-phone', publicKey: CY_PHONE },
  ];
  const messages = [
    {
      id: 'm1',
      conversationId: C1,
      body: 'k2.sealed',
      linkCard: null as string | null,
      createdAt: days(1),
      deletedAt: null as Date | null,
    },
    {
      id: 'm2',
      conversationId: C1,
      body: 'k2.sealed',
      linkCard: null as string | null,
      createdAt: days(2),
      deletedAt: null as Date | null,
    },
    {
      id: 'old',
      conversationId: C1,
      body: 'k2.sealed',
      linkCard: null as string | null,
      createdAt: days(45),
      deletedAt: null as Date | null,
    },
    {
      id: 'plain',
      conversationId: C1,
      body: 'hello',
      createdAt: days(1),
      deletedAt: null as Date | null,
    },
  ];
  const shares: Share[] = [];
  let next = 0;

  const inMine = (viewer: string, conversationId: string) =>
    members.some(
      (m) => m.conversationId === conversationId && m.userId === viewer,
    );
  const messageOf = (id: string) => messages.find((m) => m.id === id)!;

  type Where = {
    id?: string | { in: string[] };
    messageId?: { in: string[] };
    publicKey?: string;
    sealed?: null;
    message?: {
      deletedAt: null;
      createdAt?: { gte: Date };
      conversation: { members: { some: { userId: string } } };
    };
  };
  const matches = (s: Share, where: Where) => {
    if (typeof where.id === 'string' && s.id !== where.id) return false;
    if (typeof where.id === 'object' && !where.id.in.includes(s.id))
      return false;
    if (where.messageId && !where.messageId.in.includes(s.messageId))
      return false;
    if (where.publicKey && s.publicKey !== where.publicKey) return false;
    if (where.sealed === null && s.sealed !== null) return false;
    if (where.message) {
      const m = messageOf(s.messageId);
      if (m.deletedAt) return false;
      if (where.message.createdAt && m.createdAt < where.message.createdAt.gte)
        return false;
      if (
        !inMine(
          where.message.conversation.members.some.userId,
          m.conversationId,
        )
      )
        return false;
    }
    return true;
  };

  const prisma = {
    conversationMember: {
      findMany: ({ where }: { where: { conversationId: string } }) =>
        Promise.resolve(
          members.filter((m) => m.conversationId === where.conversationId),
        ),
    },
    messageKey: {
      findUnique: ({
        where,
      }: {
        where: { userId_deviceId: { userId: string; deviceId: string } };
      }) =>
        Promise.resolve(
          keys.find(
            (k) =>
              k.userId === where.userId_deviceId.userId &&
              k.deviceId === where.userId_deviceId.deviceId,
          ) ?? null,
        ),
      findMany: ({
        where,
      }: {
        where: { userId?: string; publicKey?: { in: string[] } };
      }) =>
        Promise.resolve(
          keys.filter(
            (k) =>
              (where.userId === undefined || k.userId === where.userId) &&
              (where.publicKey === undefined ||
                where.publicKey.in.includes(k.publicKey)),
          ),
        ),
    },
    message: {
      findMany: ({
        where,
      }: {
        where: {
          id: { in: string[] };
          conversationId: string;
          createdAt: { gte: Date };
        };
      }) =>
        Promise.resolve(
          messages.filter(
            (m) =>
              where.id.in.includes(m.id) &&
              m.conversationId === where.conversationId &&
              m.deletedAt === null &&
              m.body.startsWith('k2.') &&
              m.createdAt >= where.createdAt.gte,
          ),
        ),
    },
    messageKeyShare: {
      findMany: ({ where }: { where: Where }) =>
        Promise.resolve(
          shares
            .filter((s) => matches(s, where))
            .map((s) => ({ ...s, message: messageOf(s.messageId) })),
        ),
      createMany: ({
        data,
      }: {
        data: { messageId: string; userId: string; publicKey: string }[];
      }) => {
        for (const row of data) {
          if (
            shares.some(
              (s) =>
                s.messageId === row.messageId && s.publicKey === row.publicKey,
            )
          )
            continue;
          shares.push({
            ...row,
            id: `s${++next}`,
            sealed: null,
            answeredAt: null,
            createdAt: new Date(),
          });
        }
        return Promise.resolve({ count: data.length });
      },
      updateMany: ({ where, data }: { where: Where; data: Partial<Share> }) => {
        const hit = shares.filter((s) => matches(s, where));
        for (const s of hit) Object.assign(s, data);
        return Promise.resolve({ count: hit.length });
      },
    },
  };

  const told: { userId: string; event: RealtimeEvent }[] = [];
  const delivery = {
    tell: (userId: string, event: RealtimeEvent) =>
      told.push({ userId, event }),
    tellMany: (userIds: string[], event: RealtimeEvent) => {
      for (const userId of userIds) told.push({ userId, event });
    },
  };

  const service = new KeySharesService(
    prisma as unknown as PrismaService,
    delivery as unknown as DeliveryService,
  );
  return { service, shares, keys, messages, told };
}

describe('KeySharesService', () => {
  it('a new device asks, and the sender answers', async () => {
    const { service, told } = store();

    await expect(
      service.request(ADA, C1, 'ada-new', ['m1', 'm2']),
    ).resolves.toEqual({ requested: 2 });
    // Everybody in it hears, the asker included: one of their own devices
    // may be the one that can answer.
    expect(told.map((t) => t.userId).sort()).toEqual([ADA, BO].sort());

    const pending = await service.pending(BO);
    expect(pending.map((p) => [p.messageId, p.publicKey])).toEqual([
      ['m1', ADA_NEW],
      ['m2', ADA_NEW],
    ]);
    // The sealed body travels with it, so the answering device can open it
    // without fetching the thread.
    expect(pending[0].body).toBe('k2.sealed');

    told.length = 0;
    await expect(
      service.answer(
        BO,
        pending.map((p) => ({ id: p.id, sealed: sealedBy(BO_PHONE) })),
      ),
    ).resolves.toEqual({ answered: 2 });
    expect(told).toEqual([
      {
        userId: ADA,
        event: { type: 'message.keys.shared', conversationId: C1 },
      },
    ]);
    await expect(service.pending(BO)).resolves.toEqual([]);
  });

  it('only for sealed messages inside the window', async () => {
    const { service } = store();
    await expect(
      service.request(ADA, C1, 'ada-new', ['old', 'plain', 'm1']),
    ).resolves.toEqual({ requested: 1 });
  });

  it('only from a device that has published a key', async () => {
    const { service } = store();
    await expect(
      service.request(ADA, C1, 'never-published', ['m1']),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('nobody outside the conversation can ask, see or answer', async () => {
    const { service } = store();
    await expect(
      service.request(CY, C1, 'cy-phone', ['m1']),
    ).rejects.toBeInstanceOf(NotFoundException);

    await service.request(ADA, C1, 'ada-new', ['m1']);
    await expect(service.pending(CY)).resolves.toEqual([]);

    const [request] = await service.pending(BO);
    await expect(
      service.answer(CY, [{ id: request.id, sealed: sealedBy(CY_PHONE) }]),
    ).resolves.toEqual({ answered: 0 });
  });

  it('an answer has to come from a key the answering account published', async () => {
    // Otherwise "answered" says nothing about who answered, and anyone in
    // the conversation could fill a request with noise in somebody's name.
    const { service } = store();
    await service.request(ADA, C1, 'ada-new', ['m1']);
    const [request] = await service.pending(BO);

    await expect(
      service.answer(BO, [{ id: request.id, sealed: sealedBy(ADA_PHONE) }]),
    ).rejects.toBeInstanceOf(BadRequestException);
    await expect(
      service.answer(BO, [{ id: request.id, sealed: 'not a key at all' }]),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('the first answer stands', async () => {
    const { service, shares } = store();
    await service.request(ADA, C1, 'ada-new', ['m1']);
    const [request] = await service.pending(BO);

    await service.answer(ADA, [
      { id: request.id, sealed: sealedBy(ADA_PHONE) },
    ]);
    await expect(
      service.answer(BO, [{ id: request.id, sealed: sealedBy(BO_PHONE) }]),
    ).resolves.toEqual({ answered: 0 });
    expect(shares[0].sealed).toBe(sealedBy(ADA_PHONE));
  });

  it('asking again clears an answer the device could not open', async () => {
    const { service, shares } = store();
    await service.request(ADA, C1, 'ada-new', ['m1']);
    const [request] = await service.pending(BO);
    await service.answer(BO, [{ id: request.id, sealed: sealedBy(BO_PHONE) }]);

    await service.request(ADA, C1, 'ada-new', ['m1']);

    expect(shares).toHaveLength(1);
    expect(shares[0].sealed).toBeNull();
    await expect(service.pending(BO)).resolves.toHaveLength(1);
  });

  it('a withdrawn key is not answered for', async () => {
    // Nothing anywhere holds the secret half to open an answer with.
    const { service, keys } = store();
    await service.request(ADA, C1, 'ada-new', ['m1']);
    keys.splice(
      keys.findIndex((k) => k.publicKey === ADA_NEW),
      1,
    );

    await expect(service.pending(BO)).resolves.toEqual([]);
  });

  it('a withdrawn message is not answered for', async () => {
    const { service, messages } = store();
    await service.request(ADA, C1, 'ada-new', ['m1']);
    messages[0].deletedAt = new Date();

    await expect(service.pending(BO)).resolves.toEqual([]);
  });
});
