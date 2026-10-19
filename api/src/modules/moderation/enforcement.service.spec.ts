import {
  AppealStatus,
  ModerationKind,
  ReportReason,
  ReportTarget,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { DeliveryService } from '../push/delivery.service';
import { EnforcementService, noticeFor } from './enforcement.service';

/**
 * The rules, on their own: who may decide, what an account is told, and
 * when it may appeal. enforcement.db.spec.ts runs the same decisions against
 * a real database; this runs everywhere, CI included.
 */

const ADMIN = { id: 'admin', role: UserRole.ADMIN };
const MOD = { id: 'mod', role: UserRole.MODERATOR };
const ADA = { id: 'ada', role: UserRole.USER };

function service(prisma: Record<string, unknown> = {}) {
  const delivery = { tell: jest.fn(), tellMany: jest.fn() };
  const svc = new EnforcementService(
    prisma as unknown as PrismaService,
    delivery as unknown as DeliveryService,
  );
  return { svc, delivery };
}

const message = 'This post sells followers, which is spam on Kyron.';

describe('who may decide', () => {
  it('nobody outside the team sees the queue, or that it exists', async () => {
    const { svc } = service();
    await expect(svc.reportQueue(ADA)).rejects.toMatchObject({ status: 404 });
    await expect(svc.appealQueue(ADA)).rejects.toMatchObject({ status: 404 });
  });

  it('nobody decides about their own account', async () => {
    const { svc } = service({
      user: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ ...MOD, status: 'ACTIVE', email: 'm@x' }),
      },
    });
    await expect(
      svc.act(MOD, {
        subjectId: MOD.id,
        kind: ModerationKind.WARN,
        rule: ReportReason.SPAM,
        message,
      }),
    ).rejects.toMatchObject({ status: 403 });
  });

  it('only an admin decides about somebody on the team', async () => {
    const { svc } = service({
      user: {
        findUnique: jest
          .fn()
          .mockResolvedValue({ ...ADMIN, status: 'ACTIVE', email: 'a@x' }),
      },
    });
    await expect(
      svc.act(MOD, {
        subjectId: ADMIN.id,
        kind: ModerationKind.BAN,
        rule: ReportReason.SPAM,
        message,
      }),
    ).rejects.toMatchObject({ status: 403 });
  });

  it('a moderator cannot hear the appeal against their own decision', async () => {
    const { svc } = service({
      appeal: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'ap1',
          userId: ADA.id,
          status: AppealStatus.OPEN,
          action: {
            id: 'a1',
            number: 4,
            moderatorId: MOD.id,
            reversedAt: null,
            subject: ADA,
          },
        }),
      },
    });
    await expect(
      svc.decide(MOD, 'ap1', true, 'Looking at my own call again.'),
    ).rejects.toMatchObject({ status: 403 });
  });

  it('an admin can, because a team of one has no second pair of eyes', async () => {
    const tx = {
      appeal: { update: jest.fn().mockResolvedValue({}) },
    };
    const { svc, delivery } = service({
      appeal: {
        findUnique: jest.fn().mockResolvedValue({
          id: 'ap1',
          userId: ADA.id,
          status: AppealStatus.OPEN,
          action: {
            id: 'a1',
            number: 4,
            moderatorId: ADMIN.id,
            reversedAt: null,
            subject: ADA,
          },
        }),
      },
      $transaction: (run: (t: typeof tx) => Promise<unknown>) => run(tx),
    });

    await expect(
      svc.decide(ADMIN, 'ap1', false, 'Looked again; the post was spam.'),
    ).resolves.toEqual({ status: AppealStatus.UPHELD });
    const [[update]] = tx.appeal.update.mock.calls as [
      [{ data: { status: AppealStatus; reviewerId: string } }],
    ];
    expect(update.data).toMatchObject({
      status: AppealStatus.UPHELD,
      reviewerId: ADMIN.id,
    });
    const [[to, , push]] = delivery.tell.mock.calls as [
      [string, unknown, { body: string }],
    ];
    expect(to).toBe(ADA.id);
    expect(push.body).toContain('stands');
  });
});

describe('what a decision needs', () => {
  it('removing content needs the content', async () => {
    const { svc } = service();
    await expect(
      svc.act(MOD, {
        subjectId: ADA.id,
        kind: ModerationKind.REMOVE,
        rule: ReportReason.SPAM,
        message,
      }),
    ).rejects.toMatchObject({ status: 400 });
  });

  it('a suspension needs a length, and a year at most', async () => {
    const { svc } = service();
    for (const days of [undefined, 0, 366, 2.5]) {
      await expect(
        svc.act(MOD, {
          subjectId: ADA.id,
          kind: ModerationKind.SUSPEND,
          rule: ReportReason.SPAM,
          message,
          days,
        }),
      ).rejects.toMatchObject({ status: 400 });
    }
  });

  it('content and account must belong together', async () => {
    const { svc } = service({
      post: {
        findUnique: jest.fn().mockResolvedValue({
          authorId: 'bo',
          content: 'hi',
          deletedAt: null,
        }),
      },
    });
    await expect(
      svc.act(MOD, {
        subjectId: ADA.id,
        kind: ModerationKind.WARN,
        rule: ReportReason.SPAM,
        message,
        target: ReportTarget.POST,
        targetId: 'p1',
      }),
    ).rejects.toMatchObject({ status: 400 });
  });
});

describe('appealing', () => {
  const decision = (over: Record<string, unknown> = {}) => ({
    id: 'a1',
    subjectId: ADA.id,
    createdAt: new Date(),
    reversedAt: null,
    appeal: null,
    ...over,
  });

  function withDecision(over: Record<string, unknown> = {}) {
    return service({
      moderationAction: {
        findUnique: jest.fn().mockResolvedValue(decision(over)),
      },
    }).svc;
  }

  const statement = 'I was quoting the scam to warn people about it.';

  it("only your own decisions, and somebody else's look missing", async () => {
    await expect(
      withDecision({ subjectId: 'bo' }).appeal(ADA.id, 'a1', statement),
    ).rejects.toMatchObject({ status: 404 });
  });

  it('once', async () => {
    await expect(
      withDecision({ appeal: { id: 'ap1' } }).appeal(ADA.id, 'a1', statement),
    ).rejects.toMatchObject({ status: 409 });
  });

  it('not once it is reversed', async () => {
    await expect(
      withDecision({ reversedAt: new Date() }).appeal(ADA.id, 'a1', statement),
    ).rejects.toMatchObject({ status: 409 });
  });

  it('for six months', async () => {
    const old = new Date(
      Date.now() - (EnforcementService.APPEAL_DAYS + 1) * 86_400_000,
    );
    await expect(
      withDecision({ createdAt: old }).appeal(ADA.id, 'a1', statement),
    ).rejects.toMatchObject({ status: 400 });
  });
});

describe('what the account is told', () => {
  const at = new Date('2026-10-26T12:00:00Z');

  it('names what went, the rule, and the case to quote', () => {
    expect(
      noticeFor({
        kind: ModerationKind.REMOVE,
        rule: ReportReason.SPAM,
        target: ReportTarget.POST,
        endsAt: null,
        number: 7,
      }).body,
    ).toBe(
      'Your post was removed for breaking the rule on spam. Case 7: open ' +
        'Kyron to see why, or to appeal.',
    );
  });

  it('says until when, for a suspension', () => {
    expect(
      noticeFor({
        kind: ModerationKind.SUSPEND,
        rule: ReportReason.HARASSMENT,
        target: null,
        endsAt: at,
        number: 8,
      }).body,
    ).toContain(
      'suspended until Mon, 26 Oct 2026 for breaking the rule on harassment',
    );
  });

  it('says a reply when it was a reply', () => {
    expect(
      noticeFor({
        kind: ModerationKind.WARN,
        rule: ReportReason.HATE,
        target: ReportTarget.COMMENT,
        endsAt: null,
        number: 9,
      }).body,
    ).toMatch(/^Your reply was removed, and your account has a warning/);
  });

  it('never carries the content itself', () => {
    // A notification shows on a lock screen.
    const notice = noticeFor({
      kind: ModerationKind.BAN,
      rule: ReportReason.SEXUAL_CONTENT,
      target: ReportTarget.POST,
      endsAt: null,
      number: 10,
    });
    expect(notice.body).toBe(
      'Your account has been banned for breaking the rule on adult content. ' +
        'Case 10: open Kyron to see why, or to appeal.',
    );
  });
});
