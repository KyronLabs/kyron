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
  Prisma,
  VerificationCategory,
  VerificationStatus,
} from '@prisma/client';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  EnforcementService,
  type Staff,
} from '../moderation/enforcement.service';
import { DeliveryService } from '../push/delivery.service';
import { type PushText, say } from '../push/push-text';

/** One thing an account needs before it can ask for the badge. */
export interface Requirement {
  key: 'photo' | 'name' | 'bio' | 'age' | 'standing';
  label: string;
  met: boolean;
}

/** A request, as the account that made it sees it. */
export interface RequestView {
  id: string;
  number: number;
  category: VerificationCategory;
  about: string;
  links: string[];
  status: VerificationStatus;
  response: string | null;
  createdAt: Date;
  decidedAt: Date | null;
}

const DAY = 86_400_000;

/**
 * The verified badge: asking for it, and the team's answer.
 *
 * The badge means one thing -- somebody on the team checked this account is
 * who it says it is -- and nothing else: no reach, no ranking, no
 * endorsement. Evidence is links the reviewer can follow, not identity
 * documents. See docs/VERIFICATION.md.
 */
@Injectable()
export class VerificationService {
  private readonly logger = new Logger(VerificationService.name);

  /** How old an account must be to ask. Enough to rule out a throwaway. */
  static readonly MIN_AGE_DAYS = 7;

  /** How far back a moderation decision still counts against asking. */
  static readonly CLEAN_DAYS = 90;

  /** How long after a "no" before asking again. */
  static readonly COOLDOWN_DAYS = 30;

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
  ) {}

  // ---- The account's own --------------------------------------------------

  /** Whether the account is verified, what it still needs, and its request. */
  async status(userId: string) {
    const [user, latest, requirements] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: { verifiedAt: true },
      }),
      this.prisma.verificationRequest.findFirst({
        where: { userId },
        orderBy: { createdAt: 'desc' },
      }),
      this.requirements(userId),
    ]);
    if (!user) throw new NotFoundException('No such account.');

    const nextApplyAt = this.nextApplyAt(latest);
    const pending = latest?.status === VerificationStatus.PENDING;
    return {
      verified: user.verifiedAt !== null,
      verifiedAt: user.verifiedAt,
      requirements,
      eligible: requirements.every((r) => r.met),
      request: latest ? this.view(latest) : null,
      canApply:
        user.verifiedAt === null &&
        !pending &&
        requirements.every((r) => r.met) &&
        (nextApplyAt === null || nextApplyAt.getTime() <= Date.now()),
      nextApplyAt,
    };
  }

  /** Asks for the badge. One request open at a time. */
  async apply(
    userId: string,
    input: { category: VerificationCategory; about: string; links: string[] },
  ): Promise<RequestView> {
    const status = await this.status(userId);
    if (status.verified) {
      throw new ConflictException('This account is already verified.');
    }
    if (status.request?.status === VerificationStatus.PENDING) {
      throw new ConflictException(
        'You already have a request waiting. You will hear when it is decided.',
      );
    }
    const missing = status.requirements.filter((r) => !r.met);
    if (missing.length > 0) {
      throw new BadRequestException(
        `Not yet: ${missing.map((r) => r.label.toLowerCase()).join('; ')}.`,
      );
    }
    if (status.nextApplyAt && status.nextApplyAt.getTime() > Date.now()) {
      throw new BadRequestException(
        `You can ask again from ${status.nextApplyAt.toUTCString().slice(0, 16)}.`,
      );
    }

    const links = [...new Set(input.links.map((l) => l.trim()))];
    const created = await this.prisma.verificationRequest.create({
      data: {
        userId,
        category: input.category,
        about: input.about.trim(),
        links,
      },
    });
    this.logger.log(`verification request ${created.number} from ${userId}`);
    await this.tellStaff(say('staff_verify'));
    return this.view(created);
  }

  /** Takes a waiting request back. */
  async withdraw(userId: string): Promise<RequestView> {
    const pending = await this.prisma.verificationRequest.findFirst({
      where: { userId, status: VerificationStatus.PENDING },
    });
    if (!pending) throw new NotFoundException('There is no request waiting.');
    const updated = await this.prisma.verificationRequest.update({
      where: { id: pending.id },
      data: { status: VerificationStatus.WITHDRAWN, decidedAt: new Date() },
    });
    return this.view(updated);
  }

  // ---- The team's -------------------------------------------------------------

  /** Requests waiting for an answer, oldest first. */
  async queue(staff: Staff) {
    this.assertStaff(staff);
    const pending = await this.prisma.verificationRequest.findMany({
      where: { status: VerificationStatus.PENDING },
      orderBy: { createdAt: 'asc' },
      take: 200,
      include: {
        user: {
          select: {
            id: true,
            name: true,
            username: true,
            createdAt: true,
            verifiedAt: true,
            profile: { select: { avatarUrl: true, bio: true } },
            _count: { select: { followers: true, posts: true } },
          },
        },
      },
    });
    const items = [];
    for (const request of pending) {
      items.push({
        request: this.view(request),
        account: {
          id: request.user.id,
          name: request.user.name,
          username: request.user.username,
          avatarUrl: request.user.profile?.avatarUrl ?? null,
          bio: request.user.profile?.bio ?? null,
          createdAt: request.user.createdAt,
          followers: request.user._count.followers,
          posts: request.user._count.posts,
        },
        // Checked again now, not as they stood when it was sent: an account
        // suspended since is not one to verify.
        requirements: await this.requirements(request.user.id),
        ownRequest: request.user.id === staff.id,
      });
    }
    return { items };
  }

  /** Answers a request. Nobody answers their own. */
  async decide(
    staff: Staff,
    requestId: string,
    approve: boolean,
    response?: string,
  ) {
    this.assertStaff(staff);
    const request = await this.prisma.verificationRequest.findUnique({
      where: { id: requestId },
    });
    if (!request) throw new NotFoundException('No such request.');
    if (request.status !== VerificationStatus.PENDING) {
      throw new ConflictException('That request has already been answered.');
    }
    if (request.userId === staff.id) {
      throw new ForbiddenException(
        'Somebody else has to answer your own request.',
      );
    }
    const text = response?.trim() || null;
    if (!approve && (text?.length ?? 0) < 10) {
      throw new BadRequestException(
        'Say why it was not approved, so they know what to do next.',
      );
    }

    const now = new Date();
    await this.prisma.$transaction([
      this.prisma.verificationRequest.update({
        where: { id: requestId },
        data: {
          status: approve
            ? VerificationStatus.APPROVED
            : VerificationStatus.DENIED,
          reviewerId: staff.id,
          response: text,
          decidedAt: now,
        },
      }),
      // Every badge has a row in the audit log, whichever way it was given,
      // so "why is this account verified" has one place to look.
      ...(approve
        ? [
            this.prisma.user.update({
              where: { id: request.userId },
              data: { verifiedAt: now },
            }),
            this.prisma.auditLog.create({
              data: {
                userId: request.userId,
                action: 'verification.granted',
                details: { by: staff.id, request: request.number },
              },
            }),
          ]
        : []),
    ]);

    this.logger.log(
      `verification request ${request.number} ${approve ? 'approved' : 'denied'} by ${staff.id}`,
    );
    this.tell(
      request.userId,
      // The team's own words follow as they wrote them.
      approve ? say('verified') : [say('verify_declined'), text ?? ''],
    );
    return { status: approve ? 'APPROVED' : 'DENIED' };
  }

  /**
   * Gives or takes the badge without a request: for an account the team
   * already knows, or one whose badge no longer fits.
   */
  async setVerified(
    staff: Staff,
    userId: string,
    verified: boolean,
    reason: string,
  ) {
    this.assertStaff(staff);
    if (userId === staff.id) {
      throw new ForbiddenException(
        'Somebody else has to decide about your own badge.',
      );
    }
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { status: true, verifiedAt: true },
    });
    if (!user || user.status === AccountStatus.DELETED) {
      throw new NotFoundException('That account no longer exists.');
    }
    if (verified && user.status !== AccountStatus.ACTIVE) {
      throw new BadRequestException(
        'A suspended or banned account cannot be verified.',
      );
    }
    if ((user.verifiedAt !== null) === verified) {
      return { verified };
    }

    await this.prisma.$transaction([
      this.prisma.user.update({
        where: { id: userId },
        data: { verifiedAt: verified ? new Date() : null },
      }),
      this.prisma.auditLog.create({
        data: {
          userId,
          action: verified ? 'verification.granted' : 'verification.revoked',
          details: { by: staff.id, reason: reason.trim() },
        },
      }),
    ]);
    this.tell(
      userId,
      verified ? say('verified') : [say('verify_removed'), reason.trim()],
    );
    return { verified };
  }

  // ---- Internals ----------------------------------------------------------------

  /**
   * What an account needs before it asks: enough of a profile for the
   * reviewer to recognise, an account older than a throwaway, and nothing
   * recent on its record.
   */
  async requirements(userId: string): Promise<Requirement[]> {
    const since = new Date(Date.now() - VerificationService.CLEAN_DAYS * DAY);
    const [user, decisions] = await Promise.all([
      this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          name: true,
          status: true,
          createdAt: true,
          profile: { select: { avatarUrl: true, bio: true } },
        },
      }),
      this.prisma.moderationAction.count({
        where: {
          subjectId: userId,
          reversedAt: null,
          createdAt: { gte: since },
        },
      }),
    ]);
    if (!user) throw new NotFoundException('No such account.');

    const ageDays = (Date.now() - user.createdAt.getTime()) / DAY;
    return [
      {
        key: 'photo',
        label: 'A profile photo',
        met: !!user.profile?.avatarUrl,
      },
      {
        key: 'name',
        label: 'Your name on the profile',
        met: !!user.name?.trim(),
      },
      {
        key: 'bio',
        label: 'A bio that says who you are',
        met: !!user.profile?.bio?.trim(),
      },
      {
        key: 'age',
        label: `An account at least ${VerificationService.MIN_AGE_DAYS} days old`,
        met: ageDays >= VerificationService.MIN_AGE_DAYS,
      },
      {
        key: 'standing',
        label: `Nothing on your record in the last ${VerificationService.CLEAN_DAYS} days`,
        met: user.status === AccountStatus.ACTIVE && decisions === 0,
      },
    ];
  }

  private nextApplyAt(
    latest: { status: VerificationStatus; decidedAt: Date | null } | null,
  ): Date | null {
    if (latest?.status !== VerificationStatus.DENIED || !latest.decidedAt) {
      return null;
    }
    return new Date(
      latest.decidedAt.getTime() + VerificationService.COOLDOWN_DAYS * DAY,
    );
  }

  private view(
    r: Prisma.VerificationRequestGetPayload<Record<string, never>>,
  ): RequestView {
    return {
      id: r.id,
      number: r.number,
      category: r.category,
      about: r.about,
      links: r.links,
      status: r.status,
      response: r.response,
      createdAt: r.createdAt,
      decidedAt: r.decidedAt,
    };
  }

  private assertStaff(staff: Staff): void {
    // Not found rather than forbidden, as the rest of the team's routes.
    if (!EnforcementService.isStaff(staff.role)) throw new NotFoundException();
  }

  private tell(userId: string, body: PushText): void {
    this.delivery.tell(
      userId,
      { type: 'moderation.updated' },
      { title: 'Kyron', body, data: { type: 'verification' } },
    );
  }

  private async tellStaff(body: PushText): Promise<void> {
    const staff = await this.prisma.user.findMany({
      where: {
        role: { in: ['ADMIN', 'MODERATOR'] },
        status: AccountStatus.ACTIVE,
      },
      select: { id: true },
    });
    if (staff.length === 0) return;
    this.delivery.tellMany(
      staff.map((s) => s.id),
      { type: 'moderation.queue' },
      {
        title: say('staff_title'),
        body,
        data: { type: 'moderation.queue' },
      },
    );
  }
}
