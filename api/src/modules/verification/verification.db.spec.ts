import { randomUUID } from 'node:crypto';

import {
  PrismaClient,
  UserRole,
  VerificationCategory,
  VerificationStatus,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { ProfileService } from '../profile/profile.service';
import type { DeliveryService } from '../push/delivery.service';
import { VerificationService } from './verification.service';

/**
 * The badge against a real Postgres: asking, answering, renaming, and the
 * badge showing where names show. Skipped unless
 * MODERATION_TEST_DATABASE_URL names a migrated database (see
 * docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('verification, against a real database', () => {
  let prisma: PrismaClient;
  let svc: VerificationService;
  let profiles: ProfileService;
  const told: { userId: string; body?: string }[] = [];

  const ada = randomUUID();
  const admin = { id: randomUUID(), role: UserRole.ADMIN };
  const stamp = Date.now();

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    const delivery = {
      tell: (userId: string, _e: unknown, push?: { body: string }) =>
        told.push({ userId, body: push?.body }),
      tellMany: () => undefined,
    } as unknown as DeliveryService;
    svc = new VerificationService(prisma as PrismaService, delivery);
    profiles = new ProfileService(
      {
        upsertProfileRow: () => Promise.resolve(),
      } as unknown as SupabaseService,
      prisma as PrismaService,
      delivery,
    );

    await prisma.user.create({
      data: {
        id: admin.id,
        email: `admin.${stamp}@example.test`,
        role: UserRole.ADMIN,
      },
    });
    await prisma.user.create({
      data: {
        id: ada,
        email: `ada.${stamp}@example.test`,
        name: 'Ada Birds',
        createdAt: new Date(Date.now() - 30 * 86_400_000),
        profile: {
          create: {
            avatarUrl: 'https://cdn.invalid/ada.jpg',
            bio: 'Writes about birds.',
          },
        },
      },
    });
  });

  afterAll(async () => {
    await prisma?.$disconnect();
  });

  it('asks, with links kept as a list', async () => {
    const status = await svc.status(ada);
    expect(status.canApply).toBe(true);

    const request = await svc.apply(ada, {
      category: VerificationCategory.CREATOR,
      about: 'I write about birds here and on my own site.',
      links: ['https://ada.example/about', 'https://birds.example/ada'],
    });
    expect(request).toMatchObject({
      status: VerificationStatus.PENDING,
      links: ['https://ada.example/about', 'https://birds.example/ada'],
    });
    expect((await svc.status(ada)).canApply).toBe(false);
  });

  it('the team sees it with the account and its requirements', async () => {
    const { items } = await svc.queue(admin);
    const mine = items.find((i) => i.account.id === ada)!;
    expect(mine.account).toMatchObject({ name: 'Ada Birds', posts: 0 });
    expect(mine.requirements.every((r) => r.met)).toBe(true);
  });

  it('a yes gives the badge, and it shows where the name shows', async () => {
    const { items } = await svc.queue(admin);
    const request = items.find((i) => i.account.id === ada)!.request;
    await svc.decide(admin, request.id, true);

    const status = await svc.status(ada);
    expect(status.verified).toBe(true);
    expect(status.request?.status).toBe(VerificationStatus.APPROVED);

    const mine = await profiles.getMe(ada);
    expect(mine.user).toMatchObject({ verified: true });
    expect(told.at(-1)).toMatchObject({ userId: ada });
  });

  it('keeping the name keeps the badge', async () => {
    await profiles.updateProfile(ada, {
      name: 'Ada Birds',
      bio: 'Still birds.',
    });
    expect((await svc.status(ada)).verified).toBe(true);
  });

  it('a new name takes it away, and says why', async () => {
    await profiles.updateProfile(ada, { name: 'Definitely Someone Else' });

    expect((await svc.status(ada)).verified).toBe(false);
    const audit = await prisma.auditLog.findFirst({
      where: { userId: ada, action: 'verification.lapsed' },
    });
    expect(audit?.details).toMatchObject({ reason: 'renamed' });
    expect(told.at(-1)?.body).toContain('because your name changed');
  });

  it('the team can give it back directly, on the record', async () => {
    await svc.setVerified(admin, ada, true, 'Checked the new name too.');
    expect((await svc.status(ada)).verified).toBe(true);
    const grants = await prisma.auditLog.findMany({
      where: { userId: ada, action: 'verification.granted' },
      orderBy: { createdAt: 'asc' },
    });
    // Once for the request, once directly, with the reason given.
    expect(grants.map((g) => g.details)).toEqual([
      expect.objectContaining({
        by: admin.id,
        request: expect.any(Number) as number,
      }),
      expect.objectContaining({
        by: admin.id,
        reason: 'Checked the new name too.',
      }),
    ]);
  });
});
