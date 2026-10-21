import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import {
  AccountStatus,
  AppealStatus,
  ModerationKind,
  Prisma,
  ReportReason,
  ReportStatus,
  ReportTarget,
  UserRole,
} from '@prisma/client';

import { emailHash } from '../../common/guards/standing';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';

/** Who is asking, as AuthGuard resolved them. */
export interface Staff {
  id: string;
  role: UserRole;
}

/** An account as the team sees it beside a case. */
export interface AccountSummary {
  id: string;
  name: string | null;
  username: string | null;
  avatarUrl: string | null;
  role: UserRole;
  status: AccountStatus;
  suspendedUntil: Date | null;
  createdAt: Date;
  /** Carries the verified badge. */
  verified: boolean;
  /** Decisions against it that still stand. */
  standingActions: number;
}

/** One reported thing, with everything said about it. */
export interface QueueItem {
  target: ReportTarget;
  targetId: string;
  /** Whose it is: the author, or the account itself. Null once deleted. */
  subject: AccountSummary | null;
  /** What it says now. Null when it has been deleted. */
  content: string | null;
  /** What it said when it was first reported. */
  snapshot: string | null;
  /** The post a comment is on, so the app can open it in place. */
  postId: string | null;
  reasons: { reason: ReportReason; count: number }[];
  reports: {
    id: string;
    reason: ReportReason;
    detail: string | null;
    createdAt: Date;
    reporter: { id: string; username: string | null };
  }[];
  firstAt: Date;
  lastAt: Date;
  /** Somebody may be at risk. Read first. */
  urgent: boolean;
}

/** A decision as the account it is about sees it. */
export interface ActionView {
  id: string;
  number: number;
  kind: ModerationKind;
  rule: ReportReason;
  message: string;
  target: ReportTarget | null;
  targetId: string | null;
  snapshot: string | null;
  endsAt: Date | null;
  createdAt: Date;
  seen: boolean;
  reversedAt: Date | null;
  reversal: string | null;
  appeal: {
    status: AppealStatus;
    statement: string;
    response: string | null;
    createdAt: Date;
    decidedAt: Date | null;
  } | null;
  /** Until when an appeal will be taken. Null when one cannot be made. */
  appealBy: Date | null;
}

/** What the team additionally sees about a decision. */
export interface StaffActionView extends ActionView {
  note: string | null;
  moderator: { id: string; username: string | null } | null;
  subject: AccountSummary | null;
}

export interface ActInput {
  subjectId?: string;
  kind: ModerationKind;
  rule: ReportReason;
  message: string;
  note?: string;
  target?: ReportTarget;
  targetId?: string;
  /** Whether the content comes down too. Default yes. */
  removeContent?: boolean;
  days?: number;
}

const STAFF: ReadonlySet<UserRole> = new Set([
  UserRole.ADMIN,
  UserRole.MODERATOR,
]);

/** Reasons that mean somebody may be in danger: they go to the top. */
const URGENT: ReadonlySet<ReportReason> = new Set([
  ReportReason.CHILD_SAFETY,
  ReportReason.SELF_HARM,
  ReportReason.VIOLENCE,
]);

const OPEN = [ReportStatus.RECEIVED, ReportStatus.REVIEWING];

const DAY = 86_400_000;

/** Rules, as a notice names them. */
const RULE_NAMES: Record<ReportReason, string> = {
  SPAM: 'spam',
  HARASSMENT: 'harassment',
  HATE: 'hate speech',
  VIOLENCE: 'violence and threats',
  SELF_HARM: 'suicide and self-harm',
  SEXUAL_CONTENT: 'adult content',
  CHILD_SAFETY: 'child safety',
  MISINFORMATION: 'false information',
  IMPERSONATION: 'impersonation',
  INTELLECTUAL_PROPERTY: 'intellectual property',
  ILLEGAL_GOODS: 'illegal goods and services',
  SOMETHING_ELSE: "Kyron's rules",
};

/**
 * Enforcing the rules: deciding about reports, telling the account why,
 * and hearing its appeal.
 *
 * Kyron had a report button and nothing behind it -- reports were written
 * down and never read, the account status column was set by nothing, and a
 * suspended account could do everything. See docs/MODERATION.md for the
 * policy; this is what carries it out.
 *
 * Everything an account is told comes from here, in the words of whoever
 * decided, with the rule it broke and what it said. Nothing is done to an
 * account that it is not told about, and nothing it is told cannot be
 * appealed.
 */
@Injectable()
export class EnforcementService {
  private readonly logger = new Logger(EnforcementService.name);

  /**
   * How long a decision can be appealed. Six months: the EU's Digital
   * Services Act asks platforms it covers for at least that, and nothing
   * about a smaller service makes a shorter window fairer.
   */
  static readonly APPEAL_DAYS = 180;

  /** The longest suspension. Anything longer is a ban, and should say so. */
  static readonly MAX_SUSPENSION_DAYS = 365;

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  static isStaff(role: UserRole): boolean {
    return STAFF.has(role);
  }

  // ---- The queue ------------------------------------------------------------

  /**
   * Open reports, one entry per reported thing.
   *
   * Grouped because ten people reporting one post is one decision, not ten,
   * and the count is part of what the reviewer needs to see. Urgent reasons
   * first, then oldest first: the longest wait is the one owed an answer.
   */
  async reportQueue(staff: Staff): Promise<{ items: QueueItem[] }> {
    this.assertStaff(staff);

    const reports = await this.prisma.report.findMany({
      where: { status: { in: OPEN } },
      orderBy: { createdAt: 'asc' },
      take: 500,
      select: {
        id: true,
        target: true,
        targetId: true,
        reason: true,
        detail: true,
        snapshot: true,
        createdAt: true,
        reporter: { select: { id: true, username: true } },
      },
    });

    const groups = new Map<string, typeof reports>();
    for (const report of reports) {
      const key = `${report.target}:${report.targetId}`;
      groups.set(key, [...(groups.get(key) ?? []), report]);
    }

    const ids = (target: ReportTarget) =>
      [...groups.values()]
        .filter((g) => g[0].target === target)
        .map((g) => g[0].targetId);
    const [posts, comments, chatMessages] = await Promise.all([
      this.prisma.post.findMany({
        where: { id: { in: ids(ReportTarget.POST) } },
        select: { id: true, authorId: true, content: true, deletedAt: true },
      }),
      this.prisma.comment.findMany({
        where: { id: { in: ids(ReportTarget.COMMENT) } },
        select: {
          id: true,
          authorId: true,
          content: true,
          deletedAt: true,
          postId: true,
        },
      }),
      this.prisma.communityChatMessage.findMany({
        where: { id: { in: ids(ReportTarget.COMMUNITY_MESSAGE) } },
        select: { id: true, senderId: true, body: true, deletedAt: true },
      }),
    ]);
    const postById = new Map(posts.map((p) => [p.id, p]));
    const commentById = new Map(comments.map((c) => [c.id, c]));
    const chatMessageById = new Map(chatMessages.map((m) => [m.id, m]));

    const subjectOf = (
      target: ReportTarget,
      id: string,
    ): string | undefined => {
      switch (target) {
        case ReportTarget.USER:
          return id;
        case ReportTarget.POST:
          return postById.get(id)?.authorId;
        case ReportTarget.COMMENT:
          return commentById.get(id)?.authorId;
        case ReportTarget.COMMUNITY_MESSAGE:
          return chatMessageById.get(id)?.senderId;
        default:
          return unreachable(target);
      }
    };
    const subjectIds = [
      ...new Set(
        [...groups.values()]
          .map((g) => subjectOf(g[0].target, g[0].targetId))
          .filter((id): id is string => !!id),
      ),
    ];
    const subjects = new Map(
      (await this.summaries(subjectIds)).map((s) => [s.id, s]),
    );

    const items = [...groups.values()].map((group): QueueItem => {
      const { target, targetId } = group[0];
      const post = postById.get(targetId);
      const comment = commentById.get(targetId);
      const chatMessage = chatMessageById.get(targetId);
      const live = (() => {
        switch (target) {
          case ReportTarget.POST:
            return post && !post.deletedAt ? post.content : null;
          case ReportTarget.COMMENT:
            return comment && !comment.deletedAt ? comment.content : null;
          case ReportTarget.COMMUNITY_MESSAGE:
            return chatMessage && !chatMessage.deletedAt
              ? chatMessage.body
              : null;
          case ReportTarget.USER:
            return null;
          default:
            return unreachable(target);
        }
      })();
      const subjectId = subjectOf(target, targetId);

      const counts = new Map<ReportReason, number>();
      for (const r of group)
        counts.set(r.reason, (counts.get(r.reason) ?? 0) + 1);

      return {
        target,
        targetId,
        subject: subjectId ? (subjects.get(subjectId) ?? null) : null,
        content: live,
        snapshot: readable(group[0].snapshot),
        postId:
          target === ReportTarget.POST
            ? targetId
            : target === ReportTarget.COMMENT
              ? (comment?.postId ?? null)
              : null,
        reasons: [...counts.entries()]
          .map(([reason, count]) => ({ reason, count }))
          .sort((a, b) => b.count - a.count),
        reports: group.map((r) => ({
          id: r.id,
          reason: r.reason,
          detail: r.detail,
          createdAt: r.createdAt,
          reporter: r.reporter,
        })),
        firstAt: group[0].createdAt,
        lastAt: group[group.length - 1].createdAt,
        urgent: group.some((r) => URGENT.has(r.reason)),
      };
    });

    items.sort(
      (a, b) =>
        Number(b.urgent) - Number(a.urgent) ||
        a.firstAt.getTime() - b.firstAt.getTime(),
    );
    return { items };
  }

  /** One account, with every decision about it and what is open against it. */
  async account(staff: Staff, subjectId: string) {
    this.assertStaff(staff);
    const [summary] = await this.summaries([subjectId]);
    if (!summary) throw new NotFoundException('No such account.');

    const [actions, reports] = await Promise.all([
      this.prisma.moderationAction.findMany({
        where: { subjectId },
        orderBy: { createdAt: 'desc' },
        include: actionInclude,
      }),
      this.prisma.report.count({
        where: {
          status: { in: OPEN },
          target: ReportTarget.USER,
          targetId: subjectId,
        },
      }),
    ]);

    return {
      account: summary,
      openReports: reports,
      actions: actions.map((a) => this.staffView(a, summary)),
    };
  }

  /** Closes the reports about one thing without doing anything to it. */
  async dismiss(
    staff: Staff,
    target: ReportTarget,
    targetId: string,
  ): Promise<{ dismissed: number }> {
    this.assertStaff(staff);
    const open = await this.prisma.report.findMany({
      where: { target, targetId, status: { in: OPEN } },
      select: { reporterId: true },
    });
    const { count } = await this.prisma.report.updateMany({
      where: { target, targetId, status: { in: OPEN } },
      data: {
        status: ReportStatus.DISMISSED,
        resolvedAt: new Date(),
        resolvedById: staff.id,
      },
    });
    this.tellReporters(
      open.map((r) => r.reporterId),
      'We looked at something you reported and did not find that it broke ' +
        "Kyron's rules. Thank you for telling us.",
    );
    return { dismissed: count };
  }

  // ---- Deciding --------------------------------------------------------------

  /**
   * One decision: content taken down, an account warned, suspended or
   * banned -- or content taken down and the account restricted, as one
   * decision with one notice and one appeal.
   */
  async act(staff: Staff, input: ActInput): Promise<StaffActionView> {
    this.assertStaff(staff);

    const content =
      input.target && input.target !== ReportTarget.USER
        ? await this.contentOf(input.target, input.targetId)
        : null;
    if (
      input.kind === ModerationKind.REMOVE &&
      (!content || input.removeContent === false)
    ) {
      throw new BadRequestException('Say which post or comment to remove.');
    }
    const subjectId = content?.authorId ?? input.subjectId;
    if (!subjectId) throw new BadRequestException('Say whose account.');
    if (content && input.subjectId && input.subjectId !== content.authorId) {
      throw new BadRequestException(
        'That post or comment belongs to a different account.',
      );
    }
    if (input.kind === ModerationKind.SUSPEND) {
      const days = input.days ?? 0;
      if (
        !Number.isInteger(days) ||
        days < 1 ||
        days > EnforcementService.MAX_SUSPENSION_DAYS
      ) {
        throw new BadRequestException(
          `A suspension is 1 to ${EnforcementService.MAX_SUSPENSION_DAYS} days.`,
        );
      }
    }

    const subject = await this.prisma.user.findUnique({
      where: { id: subjectId },
      select: { id: true, role: true, status: true, email: true },
    });
    if (!subject || subject.status === AccountStatus.DELETED) {
      throw new NotFoundException('That account no longer exists.');
    }
    this.assertMayAct(staff, subject);

    const now = new Date();
    const action = await this.prisma.$transaction(async (tx) => {
      const removed =
        content &&
        input.target &&
        input.targetId &&
        input.removeContent !== false
          ? await this.takeDown(tx, input.target, input.targetId)
          : false;

      const created = await tx.moderationAction.create({
        data: {
          subjectId,
          moderatorId: staff.id,
          kind: input.kind,
          rule: input.rule,
          message: input.message.trim(),
          note: input.note?.trim() || null,
          target: content ? input.target : null,
          targetId: content ? input.targetId : null,
          removedContent: removed,
          snapshot: content?.text ?? null,
          endsAt:
            input.kind === ModerationKind.SUSPEND
              ? new Date(now.getTime() + (input.days ?? 0) * DAY)
              : null,
        },
      });

      if (input.kind === ModerationKind.BAN) {
        await tx.bannedIdentity.upsert({
          where: { emailHash: emailHash(subject.email) },
          create: { emailHash: emailHash(subject.email), actionId: created.id },
          update: { actionId: created.id },
        });
      }
      await this.applyStanding(tx, subjectId);

      // Every open report this answers: the ones about the content, and,
      // for a decision about the account, the ones about the account.
      const answered: Prisma.ReportWhereInput[] = [];
      if (content && input.targetId) {
        answered.push({ target: input.target, targetId: input.targetId });
      }
      if (input.kind !== ModerationKind.REMOVE) {
        answered.push({ target: ReportTarget.USER, targetId: subjectId });
      }
      const reporters = answered.length
        ? await tx.report.findMany({
            where: { status: { in: OPEN }, OR: answered },
            select: { reporterId: true },
          })
        : [];
      if (answered.length) {
        await tx.report.updateMany({
          where: { status: { in: OPEN }, OR: answered },
          data: {
            status: ReportStatus.ACTIONED,
            actionId: created.id,
            resolvedAt: now,
            resolvedById: staff.id,
          },
        });
      }

      return { created, reporters: reporters.map((r) => r.reporterId) };
    });

    this.logger.log(
      `case ${action.created.number}: ${input.kind} ${subjectId} for ` +
        `${input.rule} by ${staff.id}`,
    );
    this.tellSubject(subjectId, noticeFor(action.created));
    this.tellReporters(
      action.reporters,
      'We acted on something you reported. Thank you for telling us.',
    );

    return this.staffAction(action.created.id);
  }

  /**
   * Undoes a decision the team now thinks was wrong, without waiting for an
   * appeal. Content comes back, restrictions lift, and the account is told.
   */
  async reverse(
    staff: Staff,
    actionId: string,
    reason: string,
  ): Promise<StaffActionView> {
    this.assertStaff(staff);
    const action = await this.prisma.moderationAction.findUnique({
      where: { id: actionId },
      include: { subject: { select: { id: true, role: true } } },
    });
    if (!action) throw new NotFoundException('No such decision.');
    if (action.reversedAt) {
      throw new ConflictException('That decision has already been undone.');
    }
    if (action.subject) this.assertMayAct(staff, action.subject);

    await this.prisma.$transaction(async (tx) => {
      await this.undo(tx, action, staff.id, reason.trim());
      // An appeal waiting on this has its answer.
      await tx.appeal.updateMany({
        where: { actionId, status: AppealStatus.OPEN },
        data: {
          status: AppealStatus.OVERTURNED,
          reviewerId: staff.id,
          response: reason.trim(),
          decidedAt: new Date(),
        },
      });
    });

    if (action.subjectId) {
      this.tellSubject(action.subjectId, {
        title: 'Kyron',
        body: `We reversed case ${action.number}. ${reason.trim()}`,
      });
    }
    return this.staffAction(actionId);
  }

  // ---- Appeals: the team's side ---------------------------------------------

  async appealQueue(staff: Staff) {
    this.assertStaff(staff);
    const appeals = await this.prisma.appeal.findMany({
      where: { status: AppealStatus.OPEN },
      orderBy: { createdAt: 'asc' },
      take: 200,
      include: { action: { include: actionInclude } },
    });
    const subjects = new Map(
      (
        await this.summaries(
          appeals
            .map((a) => a.action.subjectId)
            .filter((id): id is string => !!id),
        )
      ).map((s) => [s.id, s]),
    );
    return {
      items: appeals.map((a) => ({
        id: a.id,
        statement: a.statement,
        createdAt: a.createdAt,
        action: this.staffView(
          a.action,
          a.action.subjectId
            ? (subjects.get(a.action.subjectId) ?? null)
            : null,
        ),
        /** Whether this reviewer made the decision being appealed. */
        ownDecision: a.action.moderatorId === staff.id,
      })),
    };
  }

  /**
   * Decides an appeal. A moderator cannot decide an appeal against their own
   * decision -- the point of an appeal is a second pair of eyes. An admin
   * can, because a team of one has no second pair; the record shows it.
   */
  async decide(
    staff: Staff,
    appealId: string,
    overturn: boolean,
    response: string,
  ) {
    this.assertStaff(staff);
    const appeal = await this.prisma.appeal.findUnique({
      where: { id: appealId },
      include: {
        action: { include: { subject: { select: { id: true, role: true } } } },
      },
    });
    if (!appeal) throw new NotFoundException('No such appeal.');
    if (appeal.status !== AppealStatus.OPEN) {
      throw new ConflictException('That appeal has already been decided.');
    }
    if (
      appeal.action.moderatorId === staff.id &&
      staff.role !== UserRole.ADMIN
    ) {
      throw new ForbiddenException(
        'You made this decision, so somebody else has to hear its appeal.',
      );
    }
    if (appeal.action.subject) this.assertMayAct(staff, appeal.action.subject);
    if (appeal.action.reversedAt && !overturn) {
      throw new ConflictException(
        'That decision has already been undone, so it cannot be upheld.',
      );
    }

    const text = response.trim();
    await this.prisma.$transaction(async (tx) => {
      if (overturn && !appeal.action.reversedAt) {
        await this.undo(tx, appeal.action, staff.id, text);
      }
      await tx.appeal.update({
        where: { id: appealId },
        data: {
          status: overturn ? AppealStatus.OVERTURNED : AppealStatus.UPHELD,
          reviewerId: staff.id,
          response: text,
          decidedAt: new Date(),
        },
      });
    });

    this.logger.log(
      `appeal on case ${appeal.action.number} ${overturn ? 'overturned' : 'upheld'} by ${staff.id}`,
    );
    this.tellSubject(appeal.userId, {
      title: 'Kyron',
      body: overturn
        ? `Your appeal on case ${appeal.action.number} was accepted, and the decision is reversed.`
        : `We looked at your appeal on case ${appeal.action.number} again, and the decision stands.`,
    });
    return { status: overturn ? AppealStatus.OVERTURNED : AppealStatus.UPHELD };
  }

  // ---- The account's own side ----------------------------------------------

  /**
   * Everything decided about this account, and what came of what it
   * reported. Answers a banned account too: it is the screen that says why.
   */
  async standing(userId: string) {
    const [user, actions, reports] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: { status: true, suspendedUntil: true },
      }),
      this.prisma.moderationAction.findMany({
        where: { subjectId: userId },
        orderBy: { createdAt: 'desc' },
        take: 100,
        include: { appeal: true },
      }),
      this.prisma.report.findMany({
        where: {
          reporterId: userId,
          createdAt: { gte: new Date(Date.now() - 90 * DAY) },
        },
        orderBy: { createdAt: 'desc' },
        take: 50,
        select: {
          id: true,
          target: true,
          reason: true,
          status: true,
          snapshot: true,
          createdAt: true,
          resolvedAt: true,
        },
      }),
    ]);
    if (!user) throw new NotFoundException('No such account.');

    const views = actions.map((a) => this.view(a));
    return {
      status: user.status,
      until: user.suspendedUntil,
      appealDays: EnforcementService.APPEAL_DAYS,
      actions: views,
      unseen:
        actions.filter((a) => !a.seenAt).length +
        actions.filter((a) => a.appeal?.decidedAt && !a.appeal.seenAt).length,
      reports: reports.map((r) => ({
        id: r.id,
        target: r.target,
        reason: r.reason,
        about: readable(r.snapshot),
        createdAt: r.createdAt,
        outcome:
          r.status === ReportStatus.ACTIONED
            ? 'ACTIONED'
            : r.status === ReportStatus.DISMISSED
              ? 'DISMISSED'
              : 'PENDING',
        resolvedAt: r.resolvedAt,
      })),
    };
  }

  /** The account has read its notices and any answers to its appeals. */
  async markSeen(userId: string): Promise<{ seen: true }> {
    const now = new Date();
    await this.prisma.$transaction([
      this.prisma.moderationAction.updateMany({
        where: { subjectId: userId, seenAt: null },
        data: { seenAt: now },
      }),
      this.prisma.appeal.updateMany({
        where: { userId, decidedAt: { not: null }, seenAt: null },
        data: { seenAt: now },
      }),
    ]);
    return { seen: true };
  }

  /** Asks for a decision to be looked at again. Once per decision. */
  async appeal(
    userId: string,
    actionId: string,
    statement: string,
  ): Promise<ActionView> {
    const action = await this.prisma.moderationAction.findUnique({
      where: { id: actionId },
      include: { appeal: true },
    });
    // Somebody else's decision is answered as missing, not forbidden, so
    // this cannot be used to learn which case numbers exist.
    if (!action || action.subjectId !== userId) {
      throw new NotFoundException('No such decision on your account.');
    }
    if (action.appeal) {
      throw new ConflictException('You have already appealed this decision.');
    }
    if (action.reversedAt) {
      throw new ConflictException('This decision has already been reversed.');
    }
    if (!this.appealBy(action)) {
      throw new BadRequestException(
        `Decisions can be appealed for ${EnforcementService.APPEAL_DAYS} ` +
          'days, and this one is older than that.',
      );
    }

    try {
      await this.prisma.appeal.create({
        data: { actionId, userId, statement: statement.trim() },
      });
    } catch (error) {
      if (
        error instanceof Prisma.PrismaClientKnownRequestError &&
        error.code === 'P2002'
      ) {
        throw new ConflictException('You have already appealed this decision.');
      }
      throw error;
    }

    await this.tellStaff('An appeal is waiting for review.');
    const fresh = await this.prisma.moderationAction.findUniqueOrThrow({
      where: { id: actionId },
      include: { appeal: true },
    });
    return this.view(fresh);
  }

  /** Tells the team a report arrived. Called by ModerationService.report. */
  async reportFiled(reason: ReportReason): Promise<void> {
    await this.tellStaff(
      URGENT.has(reason)
        ? 'An urgent report is waiting: somebody may be at risk.'
        : 'A report is waiting for review.',
    );
  }

  // ---- Internals --------------------------------------------------------------

  private assertStaff(staff: Staff): void {
    if (!EnforcementService.isStaff(staff.role)) {
      // Not found rather than forbidden: an ordinary account has no reason
      // to learn these routes exist.
      throw new NotFoundException();
    }
  }

  /**
   * Nobody decides about themselves, and only an admin decides about
   * somebody on the team: otherwise one moderator could ban the rest.
   */
  private assertMayAct(staff: Staff, subject: { id: string; role: UserRole }) {
    if (subject.id === staff.id) {
      throw new ForbiddenException(
        'Somebody else has to decide about your own account.',
      );
    }
    if (subject.role !== UserRole.USER && staff.role !== UserRole.ADMIN) {
      throw new ForbiddenException(
        'Only an admin can act on an account that is on the team.',
      );
    }
  }

  /**
   * Puts the account's status in step with the decisions that stand: banned
   * if any ban does, suspended until the latest suspension still running,
   * active otherwise. Worked out from the decisions every time rather than
   * stepped, so reversing one never lifts another that still applies.
   */
  private async applyStanding(
    tx: Prisma.TransactionClient,
    userId: string,
  ): Promise<void> {
    const user = await tx.user.findUnique({
      where: { id: userId },
      select: { status: true },
    });
    if (!user || user.status === AccountStatus.DELETED) return;

    const live = await tx.moderationAction.findMany({
      where: {
        subjectId: userId,
        reversedAt: null,
        kind: { in: [ModerationKind.BAN, ModerationKind.SUSPEND] },
      },
      select: { kind: true, endsAt: true },
    });
    const now = Date.now();
    const banned = live.some((a) => a.kind === ModerationKind.BAN);
    const until = live
      .filter((a) => a.kind === ModerationKind.SUSPEND && a.endsAt)
      .map((a) => a.endsAt!.getTime())
      .filter((t) => t > now)
      .sort((a, b) => b - a)[0];

    await tx.user.update({
      where: { id: userId },
      data: banned
        ? { status: AccountStatus.BANNED, suspendedUntil: null }
        : until
          ? { status: AccountStatus.SUSPENDED, suspendedUntil: new Date(until) }
          : { status: AccountStatus.ACTIVE, suspendedUntil: null },
    });
  }

  /** Reverses one decision inside [tx]. */
  private async undo(
    tx: Prisma.TransactionClient,
    action: {
      id: string;
      kind: ModerationKind;
      subjectId: string | null;
      target: ReportTarget | null;
      targetId: string | null;
      removedContent: boolean;
    },
    by: string,
    reason: string,
  ): Promise<void> {
    await tx.moderationAction.update({
      where: { id: action.id },
      data: { reversedAt: new Date(), reversedById: by, reversal: reason },
    });
    if (action.removedContent && action.target && action.targetId) {
      await this.restore(tx, action.target, action.targetId);
    }
    if (action.kind === ModerationKind.BAN) {
      await tx.bannedIdentity.deleteMany({ where: { actionId: action.id } });
    }
    if (action.subjectId) await this.applyStanding(tx, action.subjectId);
  }

  private async contentOf(
    target: ReportTarget,
    targetId: string | undefined,
  ): Promise<{ authorId: string; text: string; deleted: boolean } | null> {
    if (!targetId) throw new BadRequestException('Say which one.');
    if (target === ReportTarget.POST) {
      const post = await this.prisma.post.findUnique({
        where: { id: targetId },
        select: { authorId: true, content: true, deletedAt: true },
      });
      if (!post) throw new NotFoundException('No such post.');
      return {
        authorId: post.authorId,
        text: post.content,
        deleted: post.deletedAt !== null,
      };
    }
    if (target === ReportTarget.COMMUNITY_MESSAGE) {
      const message = await this.prisma.communityChatMessage.findUnique({
        where: { id: targetId },
        select: { senderId: true, body: true, deletedAt: true },
      });
      if (!message) throw new NotFoundException('No such message.');
      return {
        authorId: message.senderId,
        text: message.body,
        deleted: message.deletedAt !== null,
      };
    }
    if (target !== ReportTarget.COMMENT) {
      throw new BadRequestException('Say which post, comment or message.');
    }
    const comment = await this.prisma.comment.findUnique({
      where: { id: targetId },
      select: { authorId: true, content: true, deletedAt: true },
    });
    if (!comment) throw new NotFoundException('No such comment.');
    return {
      authorId: comment.authorId,
      text: comment.content,
      deleted: comment.deletedAt !== null,
    };
  }

  /**
   * Takes content down the way its author deleting it would, counts
   * included. False when it was already down: then this decision did not
   * remove it, and reversing the decision will not bring it back.
   */
  private async takeDown(
    tx: Prisma.TransactionClient,
    target: ReportTarget,
    targetId: string,
  ): Promise<boolean> {
    const now = new Date();
    if (target === ReportTarget.POST) {
      const { count } = await tx.post.updateMany({
        where: { id: targetId, deletedAt: null },
        data: { deletedAt: now },
      });
      return count > 0;
    }
    if (target === ReportTarget.COMMUNITY_MESSAGE) {
      // Its words are kept, unlike its author deleting it, so reversing the
      // decision can put it back as it was.
      const { count } = await tx.communityChatMessage.updateMany({
        where: { id: targetId, deletedAt: null },
        data: { deletedAt: now },
      });
      await tx.communityChat.updateMany({
        where: { pinnedMessageId: targetId },
        data: { pinnedMessageId: null },
      });
      return count > 0;
    }
    if (target !== ReportTarget.COMMENT) return false;
    const comment = await tx.comment.findUnique({
      where: { id: targetId },
      select: { postId: true },
    });
    if (!comment) return false;
    const { count } = await tx.comment.updateMany({
      where: { id: targetId, deletedAt: null },
      data: { deletedAt: now },
    });
    // Off the number as well as out of the thread, as FeedService does.
    if (count > 0) {
      await tx.post.update({
        where: { id: comment.postId },
        data: { commentCount: { decrement: count } },
      });
    }
    return count > 0;
  }

  /** Puts back what [takeDown] removed. */
  private async restore(
    tx: Prisma.TransactionClient,
    target: ReportTarget,
    targetId: string,
  ): Promise<void> {
    if (target === ReportTarget.POST) {
      await tx.post.updateMany({
        where: { id: targetId, deletedAt: { not: null } },
        data: { deletedAt: null },
      });
      return;
    }
    if (target === ReportTarget.COMMUNITY_MESSAGE) {
      // Only what a decision took down: its words still there, and no
      // community moderator's name on the removal.
      await tx.communityChatMessage.updateMany({
        where: {
          id: targetId,
          deletedAt: { not: null },
          deletedById: null,
          body: { not: '' },
        },
        data: { deletedAt: null },
      });
      return;
    }
    if (target !== ReportTarget.COMMENT) return;
    const comment = await tx.comment.findUnique({
      where: { id: targetId },
      select: { postId: true },
    });
    if (!comment) return;
    const { count } = await tx.comment.updateMany({
      where: { id: targetId, deletedAt: { not: null } },
      data: { deletedAt: null },
    });
    if (count > 0) {
      await tx.post.update({
        where: { id: comment.postId },
        data: { commentCount: { increment: count } },
      });
    }
  }

  private async summaries(ids: string[]): Promise<AccountSummary[]> {
    if (ids.length === 0) return [];
    const [users, standing] = await Promise.all([
      this.prisma.user.findMany({
        where: { id: { in: ids } },
        select: {
          id: true,
          name: true,
          username: true,
          role: true,
          status: true,
          suspendedUntil: true,
          createdAt: true,
          verifiedAt: true,
          profile: { select: { avatarUrl: true } },
        },
      }),
      this.prisma.moderationAction.groupBy({
        by: ['subjectId'],
        where: { subjectId: { in: ids }, reversedAt: null },
        _count: { _all: true },
      }),
    ]);
    const counts = new Map(
      standing.map((s) => [s.subjectId, s._count._all] as const),
    );
    return users.map((u) => ({
      id: u.id,
      name: u.name,
      username: u.username,
      avatarUrl: u.profile?.avatarUrl ?? null,
      verified: !!u.verifiedAt,
      role: u.role,
      status: u.status,
      suspendedUntil: u.suspendedUntil,
      createdAt: u.createdAt,
      standingActions: counts.get(u.id) ?? 0,
    }));
  }

  private appealBy(action: {
    createdAt: Date;
    reversedAt: Date | null;
    appeal?: unknown;
  }): Date | null {
    if (action.reversedAt || action.appeal) return null;
    const by = new Date(
      action.createdAt.getTime() + EnforcementService.APPEAL_DAYS * DAY,
    );
    return by.getTime() > Date.now() ? by : null;
  }

  private view(
    a: Prisma.ModerationActionGetPayload<{ include: { appeal: true } }>,
  ): ActionView {
    return {
      id: a.id,
      number: a.number,
      kind: a.kind,
      rule: a.rule,
      message: a.message,
      target: a.target,
      targetId: a.targetId,
      snapshot: a.snapshot,
      endsAt: a.endsAt,
      createdAt: a.createdAt,
      seen: a.seenAt !== null,
      reversedAt: a.reversedAt,
      reversal: a.reversal,
      appeal: a.appeal
        ? {
            status: a.appeal.status,
            statement: a.appeal.statement,
            response: a.appeal.response,
            createdAt: a.appeal.createdAt,
            decidedAt: a.appeal.decidedAt,
          }
        : null,
      appealBy: this.appealBy(a),
    };
  }

  private staffView(
    a: Prisma.ModerationActionGetPayload<{ include: typeof actionInclude }>,
    subject: AccountSummary | null,
  ): StaffActionView {
    return {
      ...this.view(a),
      note: a.note,
      moderator: a.moderator,
      subject,
    };
  }

  private async staffAction(id: string): Promise<StaffActionView> {
    const action = await this.prisma.moderationAction.findUniqueOrThrow({
      where: { id },
      include: actionInclude,
    });
    const [subject] = action.subjectId
      ? await this.summaries([action.subjectId])
      : [];
    return this.staffView(action, subject ?? null);
  }

  private tellSubject(
    userId: string,
    push: { title: string; body: string },
  ): void {
    this.delivery.tell(
      userId,
      { type: 'moderation.updated' },
      { ...push, data: { type: 'moderation' } },
    );
  }

  private tellReporters(userIds: string[], body: string): void {
    const unique = [...new Set(userIds)];
    if (unique.length === 0) return;
    this.delivery.tellMany(
      unique,
      { type: 'moderation.updated' },
      { title: 'Kyron', body, data: { type: 'moderation' } },
    );
  }

  private async tellStaff(body: string): Promise<void> {
    const staff = await this.prisma.user.findMany({
      where: {
        role: { in: [...STAFF] },
        status: { notIn: [AccountStatus.BANNED, AccountStatus.DELETED] },
      },
      select: { id: true },
    });
    if (staff.length === 0) return;
    this.delivery.tellMany(
      staff.map((s) => s.id),
      { type: 'moderation.queue' },
      { title: 'Kyron moderation', body, data: { type: 'moderation.queue' } },
    );
  }
}

const actionInclude = {
  appeal: true,
  moderator: { select: { id: true, username: true } },
} satisfies Prisma.ModerationActionInclude;

/** The notice an account gets when a decision is made about it. */
export function noticeFor(action: {
  kind: ModerationKind;
  rule: ReportReason;
  target: ReportTarget | null;
  endsAt: Date | null;
  number: number;
}): { title: string; body: string } {
  const rule = RULE_NAMES[action.rule];
  const what =
    action.target === ReportTarget.COMMENT
      ? 'Your reply was removed'
      : action.target === ReportTarget.POST
        ? 'Your post was removed'
        : action.target === ReportTarget.COMMUNITY_MESSAGE
          ? 'Your message in a community chat was removed'
          : null;
  const body = (() => {
    switch (action.kind) {
      case ModerationKind.REMOVE:
        return `${what ?? 'Something you posted was removed'} for breaking the rule on ${rule}.`;
      case ModerationKind.WARN:
        return `${what ? `${what}, and your` : 'Your'} account has a warning for breaking the rule on ${rule}.`;
      case ModerationKind.SUSPEND:
        return `${what ? `${what}, and your` : 'Your'} account is suspended until ${action.endsAt?.toUTCString().slice(0, 16)} for breaking the rule on ${rule}.`;
      case ModerationKind.BAN:
        return `Your account has been banned for breaking the rule on ${rule}.`;
    }
  })();
  return {
    title: 'Kyron',
    body: `${body} Case ${action.number}: open Kyron to see why, or to appeal.`,
  };
}

/**
 * A report's snapshot, as a person would read it. The snapshot leads with
 * the author's id, which is for the record rather than for reading.
 */
function readable(snapshot: string | null): string | null {
  if (!snapshot) return null;
  return snapshot.replace(/^(post|comment) by [0-9a-f-]{36}: /, '');
}

/**
 * Where a switch over every report target ends. A target added to the enum
 * and not handled is a compile error here, rather than a case that quietly
 * falls through to somebody else's branch at run time.
 */
function unreachable(target: never): never {
  throw new Error(`Unhandled report target: ${String(target)}`);
}
