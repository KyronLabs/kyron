import { randomUUID } from 'node:crypto';

import {
  AccountStatus,
  AppealStatus,
  ModerationKind,
  PrismaClient,
  ReportReason,
  ReportStatus,
  ReportTarget,
  UserRole,
} from '@prisma/client';

import { AuthGuard } from '../../common/guards/auth.guard';
import {
  emailHash,
  refuses,
  restrictionOf,
} from '../../common/guards/standing';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { AccountService } from '../account/account.service';
import type { DeliveryService } from '../push/delivery.service';
import { EnforcementService } from './enforcement.service';
import { ModerationService } from './moderation.service';

/**
 * The whole of enforcement against a real Postgres: every query as Postgres
 * runs it, not as a double imagines it. Skipped unless
 * MODERATION_TEST_DATABASE_URL names a database with the migrations applied,
 * because CI has none. Run it before changing anything here:
 *
 *   MODERATION_TEST_DATABASE_URL=postgresql://... npx jest enforcement.db
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('enforcement, against a real database', () => {
  let prisma: PrismaClient;
  let svc: EnforcementService;
  let moderation: ModerationService;
  const told: { userId: string; body?: string }[] = [];

  const ids = {
    admin: randomUUID(),
    mod: randomUUID(),
    ada: randomUUID(),
    bo: randomUUID(),
    cy: randomUUID(),
  };
  const admin = { id: ids.admin, role: UserRole.ADMIN };
  const mod = { id: ids.mod, role: UserRole.MODERATOR };
  const stamp = Date.now();
  const email = (who: string) => `${who}.${stamp}@example.test`;

  let adaPost = '';
  let boPost = '';
  let boReply = '';

  const user = (id: string) => prisma.user.findUniqueOrThrow({ where: { id } });

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    const delivery = {
      tell: (userId: string, _e: unknown, push?: { body: string }) =>
        told.push({ userId, body: push?.body }),
      tellMany: (userIds: string[], _e: unknown, push?: { body: string }) =>
        userIds.forEach((userId) => told.push({ userId, body: push?.body })),
    } as unknown as DeliveryService;
    svc = new EnforcementService(prisma as PrismaService, delivery);
    moderation = new ModerationService(prisma as PrismaService, svc);

    for (const [who, id] of Object.entries(ids)) {
      await prisma.user.create({
        data: {
          id,
          email: email(who),
          username: `${who}_${stamp}`.slice(0, 30),
          role:
            who === 'admin'
              ? UserRole.ADMIN
              : who === 'mod'
                ? UserRole.MODERATOR
                : UserRole.USER,
        },
      });
    }
    adaPost = (
      await prisma.post.create({
        data: { authorId: ids.ada, content: 'buy followers cheap' },
      })
    ).id;
    boPost = (
      await prisma.post.create({
        data: { authorId: ids.bo, content: 'a perfectly fine post' },
      })
    ).id;
    boReply = (
      await prisma.comment.create({
        data: { postId: adaPost, authorId: ids.bo, content: 'you are awful' },
      })
    ).id;
    await prisma.post.update({
      where: { id: adaPost },
      data: { commentCount: 1 },
    });
  });

  afterAll(async () => {
    await prisma?.$disconnect();
  });

  it('a report reaches the queue, and the team hears of it', async () => {
    await moderation.report(
      ids.cy,
      ReportTarget.POST,
      adaPost,
      ReportReason.SPAM,
    );
    await moderation.report(
      ids.cy,
      ReportTarget.COMMENT,
      boReply,
      ReportReason.HARASSMENT,
    );

    const { items } = await svc.reportQueue(mod);
    const mine = items.filter((i) => [adaPost, boReply].includes(i.targetId));
    expect(mine).toHaveLength(2);
    expect(mine.find((i) => i.targetId === adaPost)).toMatchObject({
      content: 'buy followers cheap',
      snapshot: 'buy followers cheap',
      subject: { id: ids.ada },
      reasons: [{ reason: ReportReason.SPAM, count: 1 }],
    });
    expect(told.some((t) => t.userId === ids.mod)).toBe(true);
  });

  it("is nobody else's to read", async () => {
    await expect(
      svc.reportQueue({ id: ids.cy, role: UserRole.USER }),
    ).rejects.toMatchObject({ status: 404 });
  });

  it('removing a post and suspending its author is one decision', async () => {
    const action = await svc.act(mod, {
      kind: ModerationKind.SUSPEND,
      rule: ReportReason.SPAM,
      message: 'This post sells followers, which is spam on Kyron.',
      target: ReportTarget.POST,
      targetId: adaPost,
      days: 7,
    });

    expect(action).toMatchObject({
      kind: ModerationKind.SUSPEND,
      snapshot: 'buy followers cheap',
      subject: { id: ids.ada, status: AccountStatus.SUSPENDED },
    });
    const post = await prisma.post.findUniqueOrThrow({
      where: { id: adaPost },
    });
    expect(post.deletedAt).not.toBeNull();

    const ada = await user(ids.ada);
    const restriction = restrictionOf(ada);
    expect(restriction?.status).toBe('SUSPENDED');
    expect(refuses(restriction!, 'POST', undefined)).toBe(true);
    expect(refuses(restriction!, 'GET', undefined)).toBe(false);
    expect(refuses(restriction!, 'POST', 'suspended')).toBe(false);

    const report = await prisma.report.findFirstOrThrow({
      where: { targetId: adaPost },
    });
    expect(report).toMatchObject({
      status: ReportStatus.ACTIONED,
      actionId: action.id,
      resolvedById: ids.mod,
    });
    const notice = told.find((t) => t.userId === ids.ada)?.body ?? '';
    expect(notice).toMatch(
      /^Your post was removed, and your account is suspended until .+ for breaking the rule on spam\. Case \d+:/,
    );
  });

  it('the account sees it, can appeal once, and not to its decider', async () => {
    const standing = await svc.standing(ids.ada);
    expect(standing.status).toBe(AccountStatus.SUSPENDED);
    const [notice] = standing.actions;
    expect(notice).toMatchObject({ seen: false, appeal: null });
    expect(notice.appealBy).not.toBeNull();
    // The team's note and who decided are not the account's to see.
    expect(notice).not.toHaveProperty('note');
    expect(notice).not.toHaveProperty('moderator');

    await svc.appeal(
      ids.ada,
      notice.id,
      'I was sharing a scam warning, not selling.',
    );
    await expect(
      svc.appeal(ids.ada, notice.id, 'And again, in case the first was lost.'),
    ).rejects.toMatchObject({ status: 409 });
    await expect(
      svc.appeal(ids.bo, notice.id, 'Not my decision at all, but let me in.'),
    ).rejects.toMatchObject({ status: 404 });

    const { items } = await svc.appealQueue(mod);
    const appeal = items.find((a) => a.action.id === notice.id)!;
    expect(appeal.ownDecision).toBe(true);
    await expect(
      svc.decide(mod, appeal.id, true, 'Looked again: it was a warning.'),
    ).rejects.toMatchObject({ status: 403 });
  });

  it('overturning restores the post and lifts the suspension', async () => {
    const { items } = await svc.appealQueue(admin);
    const appeal = items.find((a) => a.action.subject?.id === ids.ada)!;
    await svc.decide(admin, appeal.id, true, 'It was a scam warning. Sorry.');

    const post = await prisma.post.findUniqueOrThrow({
      where: { id: adaPost },
    });
    expect(post.deletedAt).toBeNull();
    const ada = await user(ids.ada);
    expect(ada.status).toBe(AccountStatus.ACTIVE);
    expect(ada.suspendedUntil).toBeNull();

    const standing = await svc.standing(ids.ada);
    expect(standing.actions[0]).toMatchObject({
      appeal: { status: AppealStatus.OVERTURNED },
      appealBy: null,
    });
    expect(standing.actions[0].reversedAt).not.toBeNull();
    expect(standing.unseen).toBeGreaterThan(0);
    await svc.markSeen(ids.ada);
    expect((await svc.standing(ids.ada)).unseen).toBe(0);
  });

  it('a warning about a post can leave it up', async () => {
    const action = await svc.act(mod, {
      kind: ModerationKind.WARN,
      rule: ReportReason.MISINFORMATION,
      message: 'This needs a source; leaving it up with a warning this time.',
      target: ReportTarget.POST,
      targetId: boPost,
      removeContent: false,
    });
    expect(action).toMatchObject({
      target: ReportTarget.POST,
      snapshot: 'a perfectly fine post',
    });
    const post = await prisma.post.findUniqueOrThrow({ where: { id: boPost } });
    expect(post.deletedAt).toBeNull();
    expect((await user(ids.bo)).status).toBe(AccountStatus.ACTIVE);
    await svc.reverse(
      admin,
      action.id,
      'Clearing the slate for the next test.',
    );
  });

  it('nobody acts on themselves, and only an admin on the team', async () => {
    await expect(
      svc.act(mod, {
        subjectId: ids.mod,
        kind: ModerationKind.WARN,
        rule: ReportReason.SPAM,
        message: 'Warning myself, which should not be possible.',
      }),
    ).rejects.toMatchObject({ status: 403 });
    await expect(
      svc.act(mod, {
        subjectId: ids.admin,
        kind: ModerationKind.BAN,
        rule: ReportReason.SPAM,
        message: 'Banning the admin, which a moderator cannot do.',
      }),
    ).rejects.toMatchObject({ status: 403 });
  });

  let ban = '';

  it('a ban removes the reply, hides the account, and keeps its address', async () => {
    const action = await svc.act(mod, {
      kind: ModerationKind.BAN,
      rule: ReportReason.HARASSMENT,
      message: 'Replies like this one, aimed at a person, are harassment.',
      target: ReportTarget.COMMENT,
      targetId: boReply,
    });
    ban = action.id;

    const bo = await user(ids.bo);
    expect(bo.status).toBe(AccountStatus.BANNED);
    expect(refuses(restrictionOf(bo)!, 'GET', undefined)).toBe(true);
    expect(refuses(restrictionOf(bo)!, 'GET', 'banned')).toBe(false);

    const reply = await prisma.comment.findUniqueOrThrow({
      where: { id: boReply },
    });
    expect(reply.deletedAt).not.toBeNull();
    const parent = await prisma.post.findUniqueOrThrow({
      where: { id: adaPost },
    });
    expect(parent.commentCount).toBe(0);

    // The filter the feed uses, as Postgres runs it.
    expect(
      await prisma.post.findFirst({
        where: {
          id: boPost,
          author: { status: { not: AccountStatus.BANNED } },
        },
      }),
    ).toBeNull();
    expect(
      await prisma.bannedIdentity.findUnique({
        where: { emailHash: emailHash(email('bo')) },
      }),
    ).toMatchObject({ actionId: ban });
  });

  it('reversing it brings everything back', async () => {
    await svc.reverse(
      admin,
      ban,
      'Wrong account: it was a reply quoting somebody else.',
    );

    expect((await user(ids.bo)).status).toBe(AccountStatus.ACTIVE);
    const reply = await prisma.comment.findUniqueOrThrow({
      where: { id: boReply },
    });
    expect(reply.deletedAt).toBeNull();
    const parent = await prisma.post.findUniqueOrThrow({
      where: { id: adaPost },
    });
    expect(parent.commentCount).toBe(1);
    expect(
      await prisma.bannedIdentity.findUnique({
        where: { emailHash: emailHash(email('bo')) },
      }),
    ).toBeNull();
  });

  it('reversing a ban leaves a suspension that still runs', async () => {
    const suspension = await svc.act(admin, {
      subjectId: ids.cy,
      kind: ModerationKind.SUSPEND,
      rule: ReportReason.SPAM,
      message: 'Three days for posting the same link forty times.',
      days: 3,
    });
    const banned = await svc.act(admin, {
      subjectId: ids.cy,
      kind: ModerationKind.BAN,
      rule: ReportReason.SPAM,
      message: 'Banned for carrying on with the same link after that.',
    });
    expect((await user(ids.cy)).status).toBe(AccountStatus.BANNED);

    await svc.reverse(
      admin,
      banned.id,
      'The ban was too much; the suspension stands.',
    );
    const cy = await user(ids.cy);
    expect(cy.status).toBe(AccountStatus.SUSPENDED);
    expect(cy.suspendedUntil?.getTime()).toBe(suspension.endsAt?.getTime());

    await svc.reverse(admin, suspension.id, 'Lifting this one as well, early.');
    expect((await user(ids.cy)).status).toBe(AccountStatus.ACTIVE);
  });

  it('dismissing closes the reports and touches nothing else', async () => {
    await moderation.report(
      ids.ada,
      ReportTarget.POST,
      boPost,
      ReportReason.SPAM,
    );
    await expect(svc.dismiss(mod, ReportTarget.POST, boPost)).resolves.toEqual({
      dismissed: 1,
    });
    const post = await prisma.post.findUniqueOrThrow({ where: { id: boPost } });
    expect(post.deletedAt).toBeNull();
    const standing = await svc.standing(ids.ada);
    expect(
      standing.reports.find((r) => r.outcome === 'DISMISSED'),
    ).toBeDefined();
  });

  it('leaving does not wipe a ban: the address comes back banned', async () => {
    const action = await svc.act(admin, {
      subjectId: ids.bo,
      kind: ModerationKind.BAN,
      rule: ReportReason.HARASSMENT,
      message: 'Banned after a second round of the same harassment.',
      target: ReportTarget.COMMENT,
      targetId: boReply,
    });

    const accounts = new AccountService(prisma as PrismaService, {} as never);
    await prisma.$transaction((tx) => accounts.deleteData(tx, ids.bo));

    // The case stays on the record, without what it quoted.
    const kept = await prisma.moderationAction.findUniqueOrThrow({
      where: { id: action.id },
    });
    expect(kept.snapshot).toBeNull();
    expect(kept.kind).toBe(ModerationKind.BAN);

    // A new sign-up at the same address.
    const guard = new AuthGuard(
      prisma as PrismaService,
      { get: () => [] } as never,
      {} as never,
    ) as unknown as {
      resolveSupabaseUser(c: { sub: string; email: string }): Promise<{
        id: string;
        status: AccountStatus;
      }>;
    };
    const again = randomUUID();
    const back = await guard.resolveSupabaseUser({
      sub: again,
      email: email('bo').toUpperCase(),
    });
    expect(back.status).toBe(AccountStatus.BANNED);
    const inherited = await svc.standing(again);
    expect(inherited.actions[0]).toMatchObject({ kind: ModerationKind.BAN });
    expect(inherited.actions[0].message).toContain(`case ${kept.number}`);
    expect(inherited.actions[0].appealBy).not.toBeNull();
  });
});
