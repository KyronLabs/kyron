import {
  AccountStatus,
  UserRole,
  VerificationCategory,
  VerificationStatus,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { DeliveryService } from '../push/delivery.service';
import { VerificationService } from './verification.service';

/**
 * The rules of the badge: who may ask, who answers, and what they are told.
 * verification.db.spec.ts runs the same against a real database.
 */

const DAY = 86_400_000;
const ADMIN = { id: 'admin', role: UserRole.ADMIN };
const ADA = { id: 'ada', role: UserRole.USER };

interface World {
  name?: string | null;
  avatarUrl?: string | null;
  bio?: string | null;
  ageDays?: number;
  status?: AccountStatus;
  decisions?: number;
  verifiedAt?: Date | null;
  latest?: {
    status: VerificationStatus;
    decidedAt?: Date | null;
    userId?: string;
  } | null;
}

function service(world: World = {}) {
  const w = {
    name: 'Ada',
    avatarUrl: 'https://cdn.invalid/ada.jpg',
    bio: 'Writes about birds.',
    ageDays: 30,
    status: AccountStatus.ACTIVE,
    decisions: 0,
    verifiedAt: null,
    ...world,
  };
  const latest = w.latest
    ? {
        id: 'r1',
        number: 3,
        userId: w.latest.userId ?? ADA.id,
        category: VerificationCategory.CREATOR,
        about: 'A writer on Kyron and elsewhere.',
        links: ['https://ada.example'],
        status: w.latest.status,
        response: null,
        createdAt: new Date(),
        decidedAt: w.latest.decidedAt ?? null,
      }
    : null;
  const created: unknown[] = [];
  const updates: unknown[] = [];
  const prisma = {
    user: {
      findUnique: jest.fn(() =>
        Promise.resolve({
          name: w.name,
          status: w.status,
          verifiedAt: w.verifiedAt,
          createdAt: new Date(Date.now() - w.ageDays * DAY),
          profile: { avatarUrl: w.avatarUrl, bio: w.bio },
        }),
      ),
      findMany: jest.fn(() => Promise.resolve([{ id: ADMIN.id }])),
      update: jest.fn((args: unknown) => {
        updates.push(args);
        return Promise.resolve({});
      }),
    },
    moderationAction: { count: jest.fn(() => Promise.resolve(w.decisions)) },
    verificationRequest: {
      findFirst: jest.fn(() => Promise.resolve(latest)),
      findUnique: jest.fn(() => Promise.resolve(latest)),
      create: jest.fn((args: { data: Record<string, unknown> }) => {
        created.push(args.data);
        return Promise.resolve({
          ...latest,
          id: 'r2',
          number: 4,
          status: VerificationStatus.PENDING,
          response: null,
          createdAt: new Date(),
          decidedAt: null,
          ...args.data,
        });
      }),
      update: jest.fn((args: unknown) => {
        updates.push(args);
        return Promise.resolve({});
      }),
    },
    auditLog: {
      create: jest.fn((args: { data: unknown }) => {
        audit.push(args.data);
        return Promise.resolve({});
      }),
    },
    $transaction: jest.fn((ops: Promise<unknown>[]) => Promise.all(ops)),
  };
  const audit: unknown[] = [];
  const delivery = { tell: jest.fn(), tellMany: jest.fn() };
  const svc = new VerificationService(
    prisma as unknown as PrismaService,
    delivery as unknown as DeliveryService,
  );
  return { svc, created, updates, audit, delivery };
}

const application = {
  category: VerificationCategory.CREATOR,
  about: 'I write about birds here and on my own site.',
  links: ['https://ada.example/about'],
};

describe('who may ask', () => {
  it('an account with a profile, a week behind it and a clean record', async () => {
    const { svc } = service();
    const status = await svc.status(ADA.id);
    expect(status.requirements.every((r) => r.met)).toBe(true);
    expect(status.canApply).toBe(true);
  });

  it.each([
    ['photo', { avatarUrl: null }],
    ['name', { name: '  ' }],
    ['bio', { bio: null }],
    ['age', { ageDays: 2 }],
    ['standing', { decisions: 1 }],
    ['standing', { status: AccountStatus.SUSPENDED }],
  ] as const)('not without %s', async (key, world) => {
    const { svc } = service(world);
    const status = await svc.status(ADA.id);
    expect(status.requirements.find((r) => r.key === key)?.met).toBe(false);
    expect(status.canApply).toBe(false);
    await expect(svc.apply(ADA.id, application)).rejects.toMatchObject({
      status: 400,
    });
  });

  it('once at a time', async () => {
    const { svc } = service({
      latest: { status: VerificationStatus.PENDING },
    });
    await expect(svc.apply(ADA.id, application)).rejects.toMatchObject({
      status: 409,
    });
  });

  it('not again for a month after a no', async () => {
    const { svc } = service({
      latest: {
        status: VerificationStatus.DENIED,
        decidedAt: new Date(Date.now() - 5 * DAY),
      },
    });
    expect((await svc.status(ADA.id)).canApply).toBe(false);
    await expect(svc.apply(ADA.id, application)).rejects.toMatchObject({
      status: 400,
    });
  });

  it('keeps the request, without repeated links, and tells the team', async () => {
    const { svc, created, delivery } = service();
    await svc.apply(ADA.id, {
      ...application,
      links: ['https://ada.example', ' https://ada.example '],
    });
    expect(created[0]).toMatchObject({
      userId: ADA.id,
      links: ['https://ada.example'],
    });
    expect(delivery.tellMany).toHaveBeenCalled();
  });
});

describe('who answers', () => {
  it('nobody outside the team sees the requests, or that they exist', async () => {
    const { svc } = service();
    await expect(svc.queue(ADA)).rejects.toMatchObject({ status: 404 });
  });

  it('nobody answers their own request', async () => {
    const { svc } = service({
      latest: { status: VerificationStatus.PENDING, userId: ADMIN.id },
    });
    await expect(svc.decide(ADMIN, 'r1', true)).rejects.toMatchObject({
      status: 403,
    });
  });

  it('a no says why', async () => {
    const { svc } = service({ latest: { status: VerificationStatus.PENDING } });
    await expect(svc.decide(ADMIN, 'r1', false)).rejects.toMatchObject({
      status: 400,
    });
  });

  it('a yes gives the badge, on the record, and says so', async () => {
    const { svc, updates, audit, delivery } = service({
      latest: { status: VerificationStatus.PENDING },
    });
    await svc.decide(ADMIN, 'r1', true);
    expect(updates).toContainEqual({
      where: { id: ADA.id },
      data: { verifiedAt: expect.any(Date) as Date },
    });
    expect(audit).toContainEqual({
      userId: ADA.id,
      action: 'verification.granted',
      details: { by: ADMIN.id, request: 3 },
    });
    const [[to, , push]] = delivery.tell.mock.calls as [
      [string, unknown, { body: string }],
    ];
    expect(to).toBe(ADA.id);
    expect(push.body).toContain("You're verified");
  });

  it('nobody gives themselves the badge directly', async () => {
    const { svc } = service();
    await expect(
      svc.setVerified(ADMIN, ADMIN.id, true, 'It is me, I promise.'),
    ).rejects.toMatchObject({ status: 403 });
  });

  it('a suspended account cannot be given it', async () => {
    const { svc } = service({ status: AccountStatus.SUSPENDED });
    await expect(
      svc.setVerified(ADMIN, ADA.id, true, 'Well known birdwatcher.'),
    ).rejects.toMatchObject({ status: 400 });
  });
});
