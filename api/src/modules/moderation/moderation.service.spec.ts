import { NotFoundException } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import {
  InterestKind,
  MuteKind,
  ReportReason,
  ReportTarget,
} from '@prisma/client';
import { ModerationService } from './moderation.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const VIEWER = 'viewer-1';

describe('ModerationService', () => {
  const block = {
    findMany: jest.fn<Promise<Record<string, string>[]>, [unknown]>(),
    upsert: jest.fn<Promise<unknown>, [unknown]>(),
    deleteMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };
  const mute = {
    findMany: jest.fn<Promise<Record<string, unknown>[]>, [unknown]>(),
    create: jest.fn<Promise<unknown>, [unknown]>(),
    deleteMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };
  const hiddenPost = {
    findMany: jest.fn<Promise<{ postId: string }[]>, [unknown]>(),
    upsert: jest.fn<Promise<unknown>, [unknown]>(),
    deleteMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };
  const interestSignal = { upsert: jest.fn<Promise<unknown>, [unknown]>() };
  const follow = {
    deleteMany: jest.fn<Promise<{ count: number }>, [unknown]>(),
  };
  const report = {
    upsert: jest.fn<
      Promise<{ id: string; status: string; createdAt: Date }>,
      [unknown]
    >(),
  };
  const post = {
    findUnique: jest.fn<
      Promise<{ content: string; authorId: string } | null>,
      [unknown]
    >(),
  };
  const comment = { findUnique: jest.fn<Promise<unknown>, [unknown]>() };
  const user = { findUnique: jest.fn<Promise<unknown>, [unknown]>() };

  const service = async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        ModerationService,
        {
          provide: PrismaService,
          useValue: {
            block,
            mute,
            hiddenPost,
            interestSignal,
            follow,
            report,
            post,
            comment,
            user,
          },
        },
      ],
    }).compile();
    return moduleRef.get(ModerationService);
  };

  beforeEach(() => {
    jest.resetAllMocks();
    block.findMany.mockResolvedValue([]);
    mute.findMany.mockResolvedValue([]);
    hiddenPost.findMany.mockResolvedValue([]);
  });

  describe('filtersFor', () => {
    it('cuts both ways: someone who blocked you is excluded too', async () => {
      // Otherwise blocking would be a one-way mute -- the person you blocked
      // would still appear in your feed if they blocked you first.
      block.findMany
        .mockResolvedValueOnce([{ blockedId: 'i-blocked' }])
        .mockResolvedValueOnce([{ blockerId: 'blocked-me' }]);

      const filters = await (await service()).filtersFor(VIEWER);

      expect(filters.blockedUserIds).toEqual(['i-blocked', 'blocked-me']);
    });

    it('sorts the three kinds of mute into their own lists', async () => {
      mute.findMany.mockResolvedValue([
        {
          kind: MuteKind.USER,
          targetUserId: 'u9',
          targetPostId: null,
          phrase: null,
        },
        {
          kind: MuteKind.THREAD,
          targetUserId: null,
          targetPostId: 'p9',
          phrase: null,
        },
        {
          kind: MuteKind.WORD,
          targetUserId: null,
          targetPostId: null,
          phrase: 'spoiler',
        },
      ]);

      const filters = await (await service()).filtersFor(VIEWER);

      expect(filters.mutedUserIds).toEqual(['u9']);
      expect(filters.mutedPostIds).toEqual(['p9']);
      expect(filters.mutedPhrases).toEqual(['spoiler']);
    });
  });

  describe('setBlocked', () => {
    it('severs the follow in both directions', async () => {
      // A block that leaves a follower behind leaves someone counted as
      // following an account they can no longer see.
      await (await service()).setBlocked(VIEWER, 'them', true);

      expect(follow.deleteMany).toHaveBeenCalledWith({
        where: {
          OR: [
            { followerId: VIEWER, followingId: 'them' },
            { followerId: 'them', followingId: VIEWER },
          ],
        },
      });
    });

    it('refuses to block yourself', async () => {
      await expect(
        (await service()).setBlocked(VIEWER, VIEWER, true),
      ).rejects.toThrow(NotFoundException);
    });

    it('leaves follows alone when unblocking', async () => {
      await (await service()).setBlocked(VIEWER, 'them', false);

      expect(follow.deleteMany).not.toHaveBeenCalled();
      expect(block.deleteMany).toHaveBeenCalled();
    });
  });

  describe('mutePhrase', () => {
    it('lower-cases and trims, so case is not something to remember', async () => {
      await (await service()).mutePhrase(VIEWER, '  SpoiLer  ', true);

      expect(mute.create).toHaveBeenCalledWith({
        data: expect.objectContaining({ phrase: 'spoiler' }) as unknown,
      });
    });

    it('refuses an empty phrase', async () => {
      await expect(
        (await service()).mutePhrase(VIEWER, '   ', true),
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('setInterest', () => {
    it('hides the post that prompted a "less" signal', async () => {
      // The recorded signal cannot be seen working; the post disappearing can.
      await (await service()).setInterest(VIEWER, 'p1', InterestKind.LESS);

      expect(interestSignal.upsert).toHaveBeenCalled();
      expect(hiddenPost.upsert).toHaveBeenCalled();
    });

    it('leaves the post in place for a "more" signal', async () => {
      await (await service()).setInterest(VIEWER, 'p1', InterestKind.MORE);

      expect(interestSignal.upsert).toHaveBeenCalled();
      expect(hiddenPost.upsert).not.toHaveBeenCalled();
    });
  });

  describe('report', () => {
    it('copies the reported content into the report', async () => {
      // Without a snapshot a report is unreviewable the moment its subject
      // deletes what was reported, which is the first thing anyone does.
      post.findUnique.mockResolvedValue({
        content: 'the post',
        authorId: 'a1',
      });
      report.upsert.mockResolvedValue({
        id: 'r1',
        status: 'RECEIVED',
        createdAt: new Date(),
      });

      await (
        await service()
      ).report(VIEWER, ReportTarget.POST, 'p1', ReportReason.SPAM);

      expect(report.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          create: expect.objectContaining({
            snapshot: 'post by a1: the post',
          }) as unknown,
        }),
      );
    });

    it('keeps one report per person, so a repeat is not a second voice', async () => {
      post.findUnique.mockResolvedValue({ content: 'x', authorId: 'a1' });
      report.upsert.mockResolvedValue({
        id: 'r1',
        status: 'RECEIVED',
        createdAt: new Date(),
      });

      await (
        await service()
      ).report(VIEWER, ReportTarget.POST, 'p1', ReportReason.SPAM);

      expect(report.upsert).toHaveBeenCalledWith(
        expect.objectContaining({
          where: {
            reporterId_target_targetId: {
              reporterId: VIEWER,
              target: ReportTarget.POST,
              targetId: 'p1',
            },
          },
        }),
      );
    });

    it('refuses to file a report about something that is not there', async () => {
      post.findUnique.mockResolvedValue(null);

      await expect(
        (await service()).report(
          VIEWER,
          ReportTarget.POST,
          'gone',
          ReportReason.SPAM,
        ),
      ).rejects.toThrow(NotFoundException);
      expect(report.upsert).not.toHaveBeenCalled();
    });
  });
});
