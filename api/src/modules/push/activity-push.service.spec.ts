import { AccountStatus } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  ActivityPushService,
  activityCopy,
  displayName,
  snippetOf,
} from './activity-push.service';
import { render } from './push-text';
import { renderPush } from './push.service';

/** What an English phone shows. */
const copy = (input: Parameters<typeof activityCopy>[0]) => {
  const words = activityCopy(input);
  return { title: render(words.title, 'en'), body: render(words.body, 'en') };
};

describe('what an activity push says', () => {
  it('names the person, as the title, and says what they did', () => {
    // It said "Kyron" over "Somebody liked your post." -- the app where the
    // person belongs, and nothing to say which post.
    expect(
      copy({ kind: 'like', actor: 'Ada', others: 0, snippet: 'Hi' }),
    ).toEqual({ title: 'Ada', body: 'Liked your post: “Hi”' });
    expect(
      copy({ kind: 'follow', actor: 'Ada', others: 0, snippet: null }),
    ).toEqual({ title: 'Ada', body: 'Followed you' });
    expect(
      copy({
        kind: 'comment',
        actor: 'Ada',
        others: 0,
        snippet: 'Yes',
      }),
    ).toEqual({ title: 'Ada', body: 'Replied: “Yes”' });
    expect(
      copy({ kind: 'repost', actor: 'Ada', others: 0, snippet: null }),
    ).toEqual({ title: 'Ada', body: 'Reposted your post' });
    // What they wrote where they named you.
    expect(
      copy({ kind: 'mention', actor: 'Ada', others: 0, snippet: 'cc @you' }),
    ).toEqual({ title: 'Ada', body: 'Mentioned you: “cc @you”' });
    expect(
      copy({ kind: 'mention', actor: 'Ada', others: 0, snippet: null }),
    ).toEqual({ title: 'Ada', body: 'Mentioned you' });
  });

  it('counts the ones a newer notification replaced', () => {
    expect(
      copy({ kind: 'like', actor: 'Ada', others: 1, snippet: null }).title,
    ).toBe('Ada and 1 other');
    expect(
      copy({ kind: 'follow', actor: 'Ada', others: 3, snippet: null }).title,
    ).toBe('Ada and 3 others');
  });

  it('names somebody by their name, then their handle', () => {
    expect(render(displayName({ name: ' Ada ', username: 'ada' }), 'en')).toBe(
      'Ada',
    );
    expect(render(displayName({ name: '  ', username: 'ada' }), 'en')).toBe(
      '@ada',
    );
    expect(render(displayName({ name: null, username: null }), 'en')).toBe(
      'Someone',
    );
  });

  it('keeps a snippet to one line, cut at a word', () => {
    expect(snippetOf('one\n\ntwo   three')).toBe('one two three');
    expect(snippetOf('   ')).toBeNull();
    const long = snippetOf('word '.repeat(40));
    expect(long!.length).toBeLessThanOrEqual(81);
    expect(long!.endsWith('word…')).toBe(true);
  });
});

describe('ActivityPushService', () => {
  /** A Prisma with just what the service reads, answering as told. */
  const prismaWith = (over: {
    actor?: object | null;
    blocks?: { blockerId: string; blockedId: string }[];
    likes?: number;
    follows?: number;
    post?: string;
  }) => {
    const counted: unknown[] = [];
    const prisma = {
      user: {
        findUnique: jest.fn(({ where }: { where: { id: string } }) =>
          Promise.resolve(
            where.id === 'actor'
              ? over.actor === undefined
                ? {
                    name: 'Ada',
                    username: 'ada',
                    status: AccountStatus.ACTIVE,
                    deletedAt: null,
                    profile: { avatarUrl: 'https://cdn.test/ada.jpg' },
                  }
                : over.actor
              : { notificationsSeenAt: new Date('2026-10-01') },
          ),
        ),
      },
      block: {
        findMany: jest.fn(() => Promise.resolve(over.blocks ?? [])),
      },
      postLike: {
        count: jest.fn((args: unknown) => {
          counted.push(args);
          return Promise.resolve(over.likes ?? 0);
        }),
      },
      repost: { count: jest.fn(() => Promise.resolve(0)) },
      follow: { count: jest.fn(() => Promise.resolve(over.follows ?? 0)) },
      post: {
        findUnique: jest.fn(() =>
          Promise.resolve({ content: over.post ?? 'Kingfisher at dawn' }),
        ),
      },
    };
    return {
      service: new ActivityPushService(prisma as unknown as PrismaService),
      counted,
    };
  };

  it('names the actor, quotes the post, and carries their picture', async () => {
    const { service } = prismaWith({ likes: 2 });
    const push = await service.message('me', {
      kind: 'like',
      actorId: 'actor',
      postId: 'p1',
    });
    expect(push && renderPush(push, 'en')).toEqual({
      title: 'Ada and 2 others',
      body: 'Liked your post: “Kingfisher at dawn”',
      image: 'https://cdn.test/ada.jpg',
      data: {
        type: 'notification',
        kind: 'like',
        actorId: 'actor',
        postId: 'p1',
      },
    });
  });

  it('leaves out the actor, the reader and anybody blocked when counting', async () => {
    const { service, counted } = prismaWith({
      blocks: [{ blockerId: 'me', blockedId: 'troll' }],
    });
    await service.message('me', {
      kind: 'like',
      actorId: 'actor',
      postId: 'p1',
    });
    expect(counted[0]).toMatchObject({
      where: {
        postId: 'p1',
        userId: { notIn: ['actor', 'me', 'troll'] },
        createdAt: { gt: new Date('2026-10-01') },
      },
    });
  });

  it('pushes nothing across a block, either way', async () => {
    for (const blocks of [
      [{ blockerId: 'me', blockedId: 'actor' }],
      [{ blockerId: 'actor', blockedId: 'me' }],
    ]) {
      const { service } = prismaWith({ blocks });
      expect(
        await service.message('me', { kind: 'follow', actorId: 'actor' }),
      ).toBeNull();
    }
  });

  it('pushes nothing for an account that is gone or banned', async () => {
    for (const actor of [
      null,
      { name: 'Ada', username: 'ada', status: AccountStatus.BANNED },
      {
        name: 'Ada',
        username: 'ada',
        status: AccountStatus.ACTIVE,
        deletedAt: new Date(),
      },
    ]) {
      const { service } = prismaWith({ actor });
      expect(
        await service.message('me', { kind: 'follow', actorId: 'actor' }),
      ).toBeNull();
    }
  });

  it('quotes the reply itself, not the post it is under', async () => {
    const { service } = prismaWith({});
    const push = await service.message('me', {
      kind: 'comment',
      actorId: 'actor',
      postId: 'p1',
      text: 'Lovely   shot',
    });
    expect(push && render(push.body, 'en')).toBe('Replied: “Lovely shot”');
  });

  it('carries no picture that is not an https address', async () => {
    const { service } = prismaWith({
      actor: {
        name: 'Ada',
        username: 'ada',
        status: AccountStatus.ACTIVE,
        deletedAt: null,
        profile: { avatarUrl: 'http://plain.test/a.jpg' },
      },
    });
    const push = await service.message('me', {
      kind: 'follow',
      actorId: 'actor',
    });
    expect(push).not.toHaveProperty('image');
  });
});
