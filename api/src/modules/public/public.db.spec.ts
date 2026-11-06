import { randomUUID } from 'node:crypto';

import { AccountStatus, MediaKind, PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { PublicService } from './public.service';

/**
 * The public routes' queries, run against Postgres.
 *
 * The unit tests check what is asked for; this checks that Postgres answers
 * it the way they assume -- filtered counts, nested visibility, a quoted post
 * by an account that has since been banned. Skipped unless
 * MODERATION_TEST_DATABASE_URL points at a migrated database, like the other
 * *.db.spec files.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('the public routes, against a real database', () => {
  let prisma: PrismaClient;
  let svc: PublicService;

  const stamp = Date.now();
  const [ada, ben, gone] = [0, 1, 2].map(() => randomUUID());
  const ids: Record<string, string> = {};

  const picture = (position: number, privatePath: string | null = null) => ({
    kind: MediaKind.IMAGE,
    url: privatePath ? '' : `https://cdn.example/${position}.jpg`,
    privatePath,
    position,
  });

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    svc = new PublicService(prisma as PrismaService);

    await prisma.user.createMany({
      data: [
        {
          id: ada,
          name: 'Ada',
          username: `ada${stamp}`,
          email: `ada.${stamp}@example.test`,
          verifiedAt: new Date(),
        },
        {
          id: ben,
          name: 'Ben',
          username: `ben${stamp}`,
          email: `ben.${stamp}@example.test`,
        },
        {
          id: gone,
          name: 'Gone',
          username: `gone${stamp}`,
          email: `gone.${stamp}@example.test`,
          status: AccountStatus.BANNED,
        },
      ],
    });
    await prisma.userProfile.create({
      data: {
        userId: ada,
        bio: 'Sails.',
        location: 'Accra',
        dateOfBirth: new Date('1990-01-01'),
      },
    });

    // Eight public pictures, one in the private bucket, and a voice note.
    const gallery = await prisma.post.create({
      data: {
        authorId: ada,
        content: 'Eight pictures',
        media: {
          create: [
            ...Array.from({ length: 8 }, (_, i) => picture(i)),
            picture(8, `private/${stamp}.jpg`),
            {
              kind: MediaKind.VOICE,
              url: 'https://cdn.example/v.m4a',
              position: 9,
            },
          ],
        },
      },
    });
    ids.gallery = gallery.id;

    const banned = await prisma.post.create({
      data: { authorId: gone, content: 'By a banned account' },
    });
    ids.banned = banned.id;

    const quoting = await prisma.post.create({
      data: {
        authorId: ada,
        content: 'Quoting a gone one',
        quotedPostId: banned.id,
      },
    });
    ids.quotingGone = quoting.id;

    const quotingLive = await prisma.post.create({
      data: { authorId: ben, content: 'Quoting Ada', quotedPostId: gallery.id },
    });
    ids.quotingLive = quotingLive.id;

    const poll = await prisma.post.create({
      data: {
        authorId: ada,
        content: 'Tea or coffee?',
        poll: {
          create: {
            closesAt: new Date(Date.now() + 86_400_000),
            options: {
              create: [
                { text: 'Tea', position: 0 },
                { text: 'Coffee', position: 1 },
              ],
            },
          },
        },
      },
      select: { id: true, poll: { select: { id: true, options: true } } },
    });
    ids.poll = poll.id;
    const [tea, coffee] = poll.poll!.options.sort(
      (a, b) => a.position - b.position,
    );
    await prisma.pollVote.createMany({
      data: [
        { pollId: poll.poll!.id, optionId: tea.id, userId: ben },
        { pollId: poll.poll!.id, optionId: tea.id, userId: gone },
        { pollId: poll.poll!.id, optionId: coffee.id, userId: ada },
      ],
    });

    const deleted = await prisma.post.create({
      data: { authorId: ada, content: 'Deleted', deletedAt: new Date() },
    });
    ids.deleted = deleted.id;

    const comment = await prisma.comment.create({
      data: { postId: gallery.id, authorId: ben, content: 'Lovely.' },
    });
    ids.comment = comment.id;
    await prisma.comment.create({
      data: {
        postId: gallery.id,
        authorId: ada,
        content: 'Thanks',
        parentId: comment.id,
      },
    });
    await prisma.comment.create({
      data: {
        postId: gallery.id,
        authorId: ada,
        content: 'Removed',
        parentId: comment.id,
        deletedAt: new Date(),
      },
    });
    const byGone = await prisma.comment.create({
      data: {
        postId: gallery.id,
        authorId: gone,
        content: 'From a banned account',
      },
    });
    ids.commentByGone = byGone.id;
    const onDeleted = await prisma.comment.create({
      data: { postId: deleted.id, authorId: ben, content: 'On a deleted post' },
    });
    ids.commentOnDeleted = onDeleted.id;

    const community = await prisma.community.create({
      data: { slug: `sail${stamp}`, name: 'Sailing', createdById: ada },
    });
    ids.community = community.id;
    await prisma.communityMember.createMany({
      data: [
        { communityId: community.id, userId: ada },
        { communityId: community.id, userId: ben },
      ],
    });
    await prisma.post.createMany({
      data: [
        {
          authorId: ben,
          content: 'In the community',
          communityId: community.id,
        },
        {
          authorId: gone,
          content: 'Banned, in the community',
          communityId: community.id,
        },
      ],
    });
  });

  afterAll(async () => {
    await prisma.community.deleteMany({ where: { id: ids.community } });
    await prisma.user.deleteMany({ where: { id: { in: [ada, ben, gone] } } });
    await prisma.$disconnect();
  });

  it('shows four of eight pictures, counts all eight, and nothing private', async () => {
    const post = await svc.post(ids.gallery);
    expect(post.media.map((m) => m.url)).toEqual(
      [0, 1, 2, 3].map((i) => `https://cdn.example/${i}.jpg`),
    );
    expect(post.mediaCount).toBe(8);
    expect(post.hasVoice).toBe(true);
    expect(JSON.stringify(post)).not.toContain('private/');
  });

  it('hides a post by a banned account, and a deleted post', async () => {
    await expect(svc.post(ids.banned)).rejects.toThrow('Post not found.');
    await expect(svc.post(ids.deleted)).rejects.toThrow('Post not found.');
  });

  it('shows a quoted post, unless its author is gone', async () => {
    expect((await svc.post(ids.quotingLive)).quoted).toMatchObject({
      id: ids.gallery,
      author: { name: 'Ada', verified: true },
      media: [{ url: 'https://cdn.example/0.jpg' }],
    });
    const quotingGone = await svc.post(ids.quotingGone);
    expect(quotingGone.quoted).toBeNull();
    expect(JSON.stringify(quotingGone)).not.toContain('banned account');
  });

  it('counts a poll’s votes per option, in order', async () => {
    const { poll } = await svc.post(ids.poll);
    expect(poll?.options).toEqual([
      { text: 'Tea', votes: 2 },
      { text: 'Coffee', votes: 1 },
    ]);
    expect(poll?.totalVotes).toBe(3);
  });

  it('shows a comment with its post, counting live replies only', async () => {
    const comment = await svc.comment(ids.comment);
    expect(comment.content).toBe('Lovely.');
    expect(comment.post.id).toBe(ids.gallery);
    expect(comment.stats.replies).toBe(1);
  });

  it('hides a comment by a banned account, or on a deleted post', async () => {
    await expect(svc.comment(ids.commentByGone)).rejects.toThrow(
      'Comment not found.',
    );
    await expect(svc.comment(ids.commentOnDeleted)).rejects.toThrow(
      'Comment not found.',
    );
  });

  it('shows a profile without its location or birthday, with its live posts', async () => {
    const profile = await svc.profile(`ADA${stamp}`);
    expect(profile.bio).toBe('Sails.');
    expect(JSON.stringify(profile)).not.toContain('Accra');
    expect(JSON.stringify(profile)).not.toContain('1990');
    expect(profile.recent.map((p) => p.content)).not.toContain('Deleted');
    expect(profile.recent.length).toBeGreaterThanOrEqual(3);
  });

  it('hides a banned account’s profile', async () => {
    await expect(svc.profile(`gone${stamp}`)).rejects.toThrow(
      'Profile not found.',
    );
  });

  it('shows a community’s members and its posts by visible accounts', async () => {
    const community = await svc.community(`SAIL${stamp}`);
    expect(community.members).toBe(2);
    expect(community.recent.map((p) => p.content)).toEqual([
      'In the community',
    ]);
  });
});
