import {
  Injectable,
  InternalServerErrorException,
  Logger,
  ServiceUnavailableException,
} from '@nestjs/common';
import {
  AccountStatus,
  CommunityRole,
  Prisma,
  ReportTarget,
} from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { MediaService } from '../media/media.service';
import { storedPathFromUrl } from '../media/stored-path';

/** What a deletion did, for the log. Counts only: nothing about the person. */
export interface DeletionReport {
  communitiesHandedOver: number;
  communitiesClosed: number;
  postsRecounted: number;
}

/**
 * Deleting an account: the sign-in, everything Kyron holds about it, and the
 * files it uploaded.
 *
 * Almost every table cascades from User, so most of this is one row going.
 * What is here is what a cascade gets wrong:
 *
 * - **Communities it runs** would be left with nobody who can moderate them.
 *   Each is handed to whoever has run it longest -- another owner, then the
 *   longest-serving moderator, then the longest-standing member -- and closed
 *   only when there is nobody left in it.
 * - **Bans it made** would cascade with it, quietly letting back in everybody
 *   a moderator had removed. They are kept, under the community's owner.
 * - **Counts on other people's posts** are kept on the post, so its likes,
 *   reposts and comments would go on counting rows that no longer exist.
 *   Every post it touched is counted again afterwards.
 * - **A way back in.** The guard makes a local account for any valid sign-in
 *   it has not seen, and an access token outlives the sign-in it came from
 *   by up to an hour. So the row is replaced by an empty one marked DELETED
 *   -- no email, no name, nothing it posted -- which the guard refuses.
 */
@Injectable()
export class AccountService {
  private readonly logger = new Logger(AccountService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly supabase: SupabaseService,
  ) {}

  async deleteAccount(userId: string): Promise<{ deleted: true }> {
    // The sign-in first. If this fails nothing has changed, and saying so is
    // the whole answer. Done the other way round, a failure here would leave
    // somebody who can still sign in to an account with nothing in it.
    try {
      await this.supabase.deleteAuthUser(userId);
    } catch (error) {
      this.logger.error(
        `Could not delete the sign-in for ${userId}`,
        error instanceof Error ? error.stack : String(error),
      );
      throw new ServiceUnavailableException(
        'Kyron could not delete your account just now, and nothing has been ' +
          'removed. Try again in a minute.',
      );
    }

    // Then everything else, together. If it fails the sign-in is already
    // gone -- but the access token the app holds is still good for a while,
    // and the sign-in step passes on a second attempt, so trying again from
    // the same screen finishes the job.
    let report: DeletionReport;
    try {
      report = await this.prisma.$transaction(
        (tx) => this.deleteData(tx, userId),
        { maxWait: 10_000, timeout: 60_000 },
      );
    } catch (error) {
      this.logger.error(
        `Deleted the sign-in for ${userId} but not the account's data`,
        error instanceof Error ? error.stack : String(error),
      );
      throw new InternalServerErrorException(
        'Your account was only partly deleted. Try again from this screen ' +
          'and it will finish.',
      );
    }

    // The files last, and best effort: they are named after the account, so
    // nothing reaches them once the rows pointing at them are gone, and a
    // storage hiccup is no reason to tell somebody their account still exists.
    const files = await this.removeFiles(userId);

    this.logger.log(
      `account ${userId} deleted: ${report.communitiesHandedOver} ` +
        `communities handed over, ${report.communitiesClosed} closed, ` +
        `${report.postsRecounted} posts recounted, ${files} files removed`,
    );
    return { deleted: true };
  }

  /** Everything in the database. Run inside one transaction. */
  async deleteData(
    tx: Prisma.TransactionClient,
    userId: string,
  ): Promise<DeletionReport> {
    const report: DeletionReport = {
      communitiesHandedOver: 0,
      communitiesClosed: 0,
      postsRecounted: 0,
    };

    const user = await tx.user.findUnique({
      where: { id: userId },
      select: { status: true },
    });
    // Already done, by an earlier attempt that got this far.
    if (!user || user.status === AccountStatus.DELETED) return report;

    // Communities it runs.
    const owned = await tx.communityMember.findMany({
      where: { userId, role: CommunityRole.OWNER },
      select: { communityId: true },
    });
    for (const { communityId } of owned) {
      // Roles sort in the order they are declared: owner, moderator, member.
      const successor = await tx.communityMember.findFirst({
        where: { communityId, userId: { not: userId } },
        orderBy: [{ role: 'asc' }, { joinedAt: 'asc' }],
        select: { userId: true },
      });
      if (successor) {
        await tx.communityMember.update({
          where: {
            communityId_userId: { communityId, userId: successor.userId },
          },
          data: { role: CommunityRole.OWNER },
        });
        // createdById is what stops an owner leaving, so it moves too.
        await tx.community.update({
          where: { id: communityId },
          data: { createdById: successor.userId },
        });
        report.communitiesHandedOver += 1;
      } else {
        // Nobody else in it. Its posts by anybody who has since left stay
        // up, outside it, as a community's posts do when it goes.
        await tx.community.delete({ where: { id: communityId } });
        report.communitiesClosed += 1;
      }
    }

    // Bans it made, kept under the owner. A community it ran has just been
    // handed over, so its owner is somebody else by now.
    const bans = await tx.communityBan.findMany({
      where: { bannedById: userId },
      select: {
        communityId: true,
        community: { select: { createdById: true } },
      },
    });
    const owners = new Map(
      bans.map((ban) => [ban.communityId, ban.community.createdById]),
    );
    for (const [communityId, owner] of owners) {
      if (owner === userId) continue;
      await tx.communityBan.updateMany({
        where: { communityId, bannedById: userId },
        data: { bannedById: owner },
      });
    }

    // Other people's posts whose numbers include this account.
    const [liked, reposted, commented] = [
      await tx.postLike.findMany({
        where: { userId },
        select: { postId: true },
      }),
      await tx.repost.findMany({ where: { userId }, select: { postId: true } }),
      await tx.comment.findMany({
        where: { authorId: userId },
        select: { postId: true },
        distinct: ['postId'],
      }),
    ];
    const touched = [
      ...new Set(
        [...liked, ...reposted, ...commented].map((row) => row.postId),
      ),
    ];

    // Re-encodes waiting on its clips; their files are about to go.
    await tx.mediaJob.deleteMany({ where: { userId } });

    // Decisions about it stay on the record, so leaving does not undo a ban
    // (BannedIdentity keeps the address) -- but without what it wrote. The
    // case, the rule and the dates are the team's; the words were the
    // account's, and they go with it like everything else it wrote.
    const [ownPosts, ownComments, ownChatMessages] = [
      await tx.post.findMany({
        where: { authorId: userId },
        select: { id: true },
      }),
      await tx.comment.findMany({
        where: { authorId: userId },
        select: { id: true },
      }),
      await tx.communityChatMessage.findMany({
        where: { senderId: userId },
        select: { id: true },
      }),
    ];
    await tx.moderationAction.updateMany({
      where: { subjectId: userId },
      data: { snapshot: null },
    });
    await tx.report.updateMany({
      where: {
        OR: [
          { target: ReportTarget.USER, targetId: userId },
          {
            target: ReportTarget.POST,
            targetId: { in: ownPosts.map((p) => p.id) },
          },
          {
            target: ReportTarget.COMMENT,
            targetId: { in: ownComments.map((c) => c.id) },
          },
          {
            target: ReportTarget.COMMUNITY_MESSAGE,
            targetId: { in: ownChatMessages.map((m) => m.id) },
          },
        ],
      },
      data: { snapshot: null },
    });

    // The account, and through the cascade everything hanging off it.
    await tx.user.delete({ where: { id: userId } });
    await tx.user.create({
      data: {
        id: userId,
        // Unique, and nobody's: `.invalid` is reserved for exactly this.
        email: `${userId}@deleted.invalid`,
        status: AccountStatus.DELETED,
        deletedAt: new Date(),
        password: null,
      },
    });

    // Counted again from what is left, the same way each write path keeps
    // them: likes and reposts as rows, comments that are not deleted. Its own
    // posts are already gone, so they simply do not match.
    if (touched.length > 0) {
      report.postsRecounted = await tx.$executeRaw(Prisma.sql`
        UPDATE "Post" p
        SET "likeCount" = (
              SELECT count(*)::int FROM "PostLike" l WHERE l."postId" = p.id
            ),
            "repostCount" = (
              SELECT count(*)::int FROM "Repost" r WHERE r."postId" = p.id
            ),
            "commentCount" = (
              SELECT count(*)::int FROM "Comment" c
              WHERE c."postId" = p.id AND c."deletedAt" IS NULL
            )
        WHERE p.id = ANY(${touched}::uuid[])
      `);
    }

    return report;
  }

  /**
   * Its uploads: post and message media, avatars and covers, all named
   * `<userId>_...`. A picture a community still shows is kept -- a moderator
   * who set one and then left should not blank it for everybody else.
   */
  async removeFiles(userId: string): Promise<number> {
    try {
      const folders = [
        MediaService.folder,
        this.supabase.getAvatarFolder(),
        this.supabase.getCoverFolder(),
      ];
      const found: string[] = [];
      for (const folder of folders) {
        found.push(...(await this.supabase.listByPrefix(folder, `${userId}_`)));
      }
      const bucket = this.supabase.getBucketName();
      const pictures = await this.prisma.community.findMany({
        select: { avatarUrl: true, bannerUrl: true },
      });
      const keep = new Set<string>();
      for (const url of pictures.flatMap((c) => [c.avatarUrl, c.bannerUrl])) {
        if (!url) continue;
        const stored = storedPathFromUrl(url, bucket);
        if ('path' in stored) keep.add(stored.path);
      }

      const doomed = found.filter((path) => !keep.has(path));
      await this.supabase.removeFiles(doomed);

      // View-once attachments it sent and nobody opened yet, and what it
      // sent in community chats -- or uploaded and never sent. Their
      // messages went with the account, so nothing would ever sweep these.
      const private_ = [
        ...(await this.supabase.listPrivateByPrefix(
          MediaService.onceFolder,
          `${userId}_`,
        )),
        ...(await this.supabase.listPrivateByPrefix(
          MediaService.chatFolder,
          `${userId}_`,
        )),
      ];
      await this.supabase.removePrivate(private_);
      return doomed.length + private_.length;
    } catch (error) {
      this.logger.warn(
        `Deleted account ${userId} but not all of its files: ${String(error)}`,
      );
      return 0;
    }
  }
}
