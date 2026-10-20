import { randomUUID } from 'node:crypto';

import {
  CommunityChatWriters,
  CommunityRole,
  ModerationKind,
  PrismaClient,
  ReportReason,
  ReportTarget,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { CommunitiesService } from './communities.service';
import { CommunityChatsService } from './community-chats.service';

/**
 * Community chats against a real Postgres: who may read, write, run and
 * report them, and what removal, blocks, slow mode and moderation do.
 * Skipped unless MODERATION_TEST_DATABASE_URL names a migrated database
 * (see docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

run('community chats, against a real database', () => {
  let prisma: PrismaClient;
  let chats: CommunityChatsService;
  let communities: CommunitiesService;
  let moderation: ModerationService;
  let enforcement: EnforcementService;
  let delivery: RecordingDelivery;

  const ids = {
    owner: randomUUID(),
    mod: randomUUID(),
    ada: randomUUID(),
    ben: randomUUID(),
    outsider: randomUUID(),
    staff: randomUUID(),
  };
  const stamp = Date.now();
  const slug = `birders-${stamp}`;
  let communityId = '';
  let general = '';

  /** Seconds after the start, so throttles can be stepped past. */
  const t0 = Date.now() + 60_000;
  let clock = t0;
  const later = (seconds: number) => new Date((clock += seconds * 1000));

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    chats = new CommunityChatsService(prisma as PrismaService, delivery);
    communities = new CommunitiesService(prisma as PrismaService);
    enforcement = new EnforcementService(prisma as PrismaService, delivery);
    moderation = new ModerationService(prisma as PrismaService, enforcement);

    for (const [who, id] of Object.entries(ids)) {
      await prisma.user.create({
        data: {
          id,
          email: `${who}.${stamp}@example.test`,
          name: who[0].toUpperCase() + who.slice(1),
          username: `${who}_${stamp}`.slice(0, 30),
          role: who === 'staff' ? UserRole.MODERATOR : UserRole.USER,
        },
      });
    }
    ({ id: communityId } = await communities.create(ids.owner, {
      name: `Birders ${stamp}`,
    }));
    await prisma.community.update({
      where: { id: communityId },
      data: { slug },
    });
    for (const who of ['mod', 'ada', 'ben'] as const) {
      await communities.setMembership(ids[who], slug, true);
    }
    await communities.setRole(
      ids.owner,
      slug,
      ids.mod,
      CommunityRole.MODERATOR,
    );
  });

  afterAll(async () => {
    await prisma?.community.deleteMany({ where: { id: communityId } });
    await prisma?.user.deleteMany({
      where: { id: { in: Object.values(ids) } },
    });
    await prisma?.$disconnect();
  });

  it('is locked away from Supabase’s own API roles', async () => {
    // RLS on, and no grants: the anon key in the app cannot read a word.
    const rows = await prisma.$queryRaw<
      { relname: string; relrowsecurity: boolean }[]
    >`select relname, relrowsecurity from pg_class
      where relkind = 'r' and relname like 'CommunityChat%'`;
    expect(rows).toHaveLength(4);
    expect(rows.every((r) => r.relrowsecurity)).toBe(true);
    const grants = await prisma.$queryRaw<{ n: bigint }[]>`
      select count(*)::bigint as n from information_schema.role_table_grants
      where table_name like 'CommunityChat%'
        and grantee in ('anon', 'authenticated')`;
    expect(Number(grants[0].n)).toBe(0);
  });

  describe('running chats', () => {
    it('is for the owner and moderators to open', async () => {
      await expect(
        chats.create(ids.ada, slug, { name: 'Mine' }),
      ).rejects.toMatchObject({ status: 403 });

      const chat = await chats.create(ids.mod, slug, {
        name: '  General   chat ',
      });
      general = chat.id;
      expect(chat).toMatchObject({
        name: 'General chat',
        joined: true,
        canModerate: true,
        role: CommunityRole.MODERATOR,
        joinedCount: 1,
      });
      // One name once, whatever the case.
      await expect(
        chats.create(ids.owner, slug, { name: 'GENERAL CHAT' }),
      ).rejects.toMatchObject({ status: 409 });
    });

    it('holds a community to twenty', async () => {
      const live = await prisma.communityChat.count({
        where: { communityId, deletedAt: null },
      });
      for (let i = live; i < CommunityChatsService.maxChats; i++) {
        await chats.create(ids.owner, slug, { name: `Room ${i}` });
      }
      await expect(
        chats.create(ids.owner, slug, { name: 'One too many' }),
      ).rejects.toMatchObject({ status: 403 });
      // Closing one makes room.
      const extra = await prisma.communityChat.findFirstOrThrow({
        where: { communityId, name: 'Room 1' },
      });
      await chats.remove(ids.owner, extra.id);
      const made = await chats.create(ids.owner, slug, {
        name: 'One too many',
      });
      // And closed again, so the tests after this have room.
      await chats.remove(ids.owner, made.id);
    });
  });

  describe('reading', () => {
    it('is for members of the community, and nobody else', async () => {
      await expect(chats.list(ids.outsider, slug)).rejects.toMatchObject({
        status: 403,
      });
      await expect(chats.messages(ids.outsider, general)).rejects.toMatchObject(
        {
          status: 403,
        },
      );
      const { items } = await chats.list(ids.ada, slug);
      expect(items.map((c) => c.name)).toContain('General chat');
    });

    it('lets a member who has not joined read and react, not write', async () => {
      await chats.join(ids.ben, general);
      const said = await chats.send(
        ids.ben,
        general,
        { body: 'Kingfisher!' },
        later(1),
      );

      // Ada is in the community but not the chat: a spectator.
      const page = await chats.messages(ids.ada, general);
      expect(page.items.map((m) => m.body)).toContain('Kingfisher!');
      await chats.react(ids.ada, general, said.id, '❤️');
      await expect(
        chats.send(ids.ada, general, { body: 'hi' }, later(1)),
      ).rejects.toMatchObject({ status: 403 });

      const again = await chats.messages(ids.ben, general);
      expect(again.items.find((m) => m.id === said.id)?.reactions).toEqual([
        { emoji: '❤️', count: 1 },
      ]);
      // Counts, not names.
      expect(JSON.stringify(again.items)).not.toContain(ids.ada);
    });
  });

  describe('writing', () => {
    it('keeps an announcements chat to its moderators', async () => {
      const news = await chats.create(ids.owner, slug, {
        name: 'Announcements',
        writers: CommunityChatWriters.MODERATORS,
      });
      await chats.join(ids.ada, news.id);
      await expect(
        chats.send(ids.ada, news.id, { body: 'me too' }, later(1)),
      ).rejects.toMatchObject({ status: 403 });
      await chats.join(ids.mod, news.id);
      await expect(
        chats.send(ids.mod, news.id, { body: 'Walk on Saturday' }, later(1)),
      ).resolves.toBeDefined();
    });

    it('refuses a burst, and slow mode, but not to a moderator', async () => {
      await chats.join(ids.ada, general);
      for (let i = 0; i < CommunityChatsService.burst; i++) {
        await chats.send(ids.ada, general, { body: `n${i}` }, later(1));
      }
      await expect(
        chats.send(ids.ada, general, { body: 'one more' }, later(1)),
      ).rejects.toMatchObject({ status: 429 });

      await chats.update(ids.mod, general, { slowModeSeconds: 30 });
      later(60);
      await chats.send(ids.ada, general, { body: 'after the burst' }, later(0));
      await expect(
        chats.send(ids.ada, general, { body: 'too soon' }, later(10)),
      ).rejects.toMatchObject({ status: 429 });
      await expect(
        chats.send(ids.ada, general, { body: 'now' }, later(25)),
      ).resolves.toBeDefined();

      await chats.join(ids.mod, general);
      await chats.send(
        ids.mod,
        general,
        { body: 'mods are not slowed' },
        later(1),
      );
      await chats.send(ids.mod, general, { body: 'see' }, later(1));
      await chats.update(ids.mod, general, { slowModeSeconds: 0 });
    });

    it('answers only a message that is in the same chat and still up', async () => {
      const news = await prisma.communityChat.findFirstOrThrow({
        where: { communityId, name: 'Announcements' },
      });
      const there = await prisma.communityChatMessage.findFirstOrThrow({
        where: { chatId: news.id },
      });
      await expect(
        chats.send(
          ids.ben,
          general,
          { body: 'x', replyToId: there.id },
          later(5),
        ),
      ).rejects.toMatchObject({ status: 400 });
    });
  });

  describe('taking messages down', () => {
    it('lets an author unsay, and erases the words', async () => {
      const m = await chats.send(ids.ben, general, { body: 'oops' }, later(5));
      await chats.deleteMessage(ids.ben, general, m.id);
      const row = await prisma.communityChatMessage.findUniqueOrThrow({
        where: { id: m.id },
      });
      expect(row.deletedAt).not.toBeNull();
      expect(row.body).toBe('');
    });

    it('lets a moderator take down a member’s, keeping the words for review', async () => {
      const m = await chats.send(ids.ben, general, { body: 'rude' }, later(5));
      await expect(
        chats.deleteMessage(ids.ada, general, m.id),
      ).rejects.toMatchObject({ status: 403 });
      await chats.deleteMessage(ids.mod, general, m.id);
      const row = await prisma.communityChatMessage.findUniqueOrThrow({
        where: { id: m.id },
      });
      expect(row).toMatchObject({ body: 'rude', deletedById: ids.mod });
      expect(
        (await chats.messages(ids.ben, general)).items.map((i) => i.id),
      ).not.toContain(m.id);
    });

    it('keeps the owner’s messages out of a moderator’s reach', async () => {
      await chats.join(ids.owner, general);
      const m = await chats.send(
        ids.owner,
        general,
        { body: 'mine' },
        later(5),
      );
      await expect(
        chats.deleteMessage(ids.mod, general, m.id),
      ).rejects.toMatchObject({ status: 403 });
      // Each reader is told their place, so the app offers no more than this.
      expect((await chats.get(ids.owner, general)).role).toBe(
        CommunityRole.OWNER,
      );
      expect((await chats.get(ids.ada, general)).role).toBe(
        CommunityRole.MEMBER,
      );
    });

    it('lets go of a pin when the pinned message goes', async () => {
      const m = await chats.send(
        ids.mod,
        general,
        { body: 'Rules: be kind' },
        later(5),
      );
      const pinned = await chats.pin(ids.mod, general, m.id);
      expect(pinned.pinned?.body).toBe('Rules: be kind');
      await expect(chats.pin(ids.ada, general, m.id)).rejects.toMatchObject({
        status: 403,
      });
      await chats.deleteMessage(ids.mod, general, m.id);
      expect((await chats.get(ids.ada, general)).pinned).toBeNull();
    });
  });

  describe('blocks', () => {
    it('hides either side’s messages from the other, and their quotes', async () => {
      const m = await chats.send(
        ids.ben,
        general,
        { body: 'from ben' },
        later(5),
      );
      const reply = await chats.send(
        ids.ada,
        general,
        { body: 'answering ben', replyToId: m.id },
        later(5),
      );
      await prisma.block.create({
        data: { blockerId: ids.owner, blockedId: ids.ben },
      });

      const seen = (await chats.messages(ids.owner, general)).items;
      expect(seen.map((i) => i.id)).not.toContain(m.id);
      expect(seen.find((i) => i.id === reply.id)?.replyTo).toEqual({
        id: m.id,
        unavailable: true,
      });
      // Ben, blocked, does not see the owner's either.
      expect(
        (await chats.messages(ids.ben, general)).items.some(
          (i) => i.sender.id === ids.owner,
        ),
      ).toBe(false);
      await expect(
        chats.react(ids.owner, general, m.id, '👍'),
      ).rejects.toMatchObject({ status: 404 });
      await prisma.block.deleteMany({ where: { blockerId: ids.owner } });
    });
  });

  describe('reports', () => {
    let rude = '';

    it('takes one only from somebody who can read it', async () => {
      rude = (
        await chats.send(
          ids.ben,
          general,
          { body: 'you are all idiots' },
          later(5),
        )
      ).id;
      await expect(
        moderation.report(
          ids.outsider,
          ReportTarget.COMMUNITY_MESSAGE,
          rude,
          ReportReason.HARASSMENT,
        ),
      ).rejects.toMatchObject({ status: 404 });

      await moderation.report(
        ids.ada,
        ReportTarget.COMMUNITY_MESSAGE,
        rude,
        ReportReason.HARASSMENT,
      );
      const report = await prisma.report.findFirstOrThrow({
        where: { target: ReportTarget.COMMUNITY_MESSAGE, targetId: rude },
      });
      expect(report.snapshot).toContain('you are all idiots');
      expect(report.snapshot).toContain(`c/${slug}`);
    });

    it('shows in the team’s queue against its author', async () => {
      const staff = { id: ids.staff, role: UserRole.MODERATOR };
      const { items } = await enforcement.reportQueue(staff);
      const item = items.find((i) => i.targetId === rude);
      expect(item).toMatchObject({
        target: ReportTarget.COMMUNITY_MESSAGE,
        content: 'you are all idiots',
      });
      expect(item?.subject?.id).toBe(ids.ben);
    });

    it('comes down with a decision, and back up if it is reversed', async () => {
      const staff = { id: ids.staff, role: UserRole.MODERATOR };
      const action = await enforcement.act(staff, {
        kind: ModerationKind.REMOVE,
        rule: ReportReason.HARASSMENT,
        message: 'Calling the whole room names is harassment here.',
        target: ReportTarget.COMMUNITY_MESSAGE,
        targetId: rude,
      });
      expect(action.subject?.id).toBe(ids.ben);
      let row = await prisma.communityChatMessage.findUniqueOrThrow({
        where: { id: rude },
      });
      expect(row.deletedAt).not.toBeNull();
      expect(row.body).toBe('you are all idiots');
      expect(
        (await chats.messages(ids.ada, general)).items.map((i) => i.id),
      ).not.toContain(rude);

      const admin = { id: ids.staff, role: UserRole.ADMIN };
      await prisma.user.update({
        where: { id: ids.staff },
        data: { role: UserRole.ADMIN },
      });
      await enforcement.reverse(
        admin,
        action.id,
        'On review this was banter between friends.',
      );
      row = await prisma.communityChatMessage.findUniqueOrThrow({
        where: { id: rude },
      });
      expect(row.deletedAt).toBeNull();
    });
  });

  describe('leaving the community', () => {
    it('shuts out somebody removed, on their very next request', async () => {
      await chats.join(ids.ben, general);
      await communities.removeMember(ids.owner, slug, ids.ben, 'spam');

      await expect(chats.messages(ids.ben, general)).rejects.toMatchObject({
        status: 403,
      });
      await expect(
        chats.send(ids.ben, general, { body: 'let me back' }, later(5)),
      ).rejects.toMatchObject({ status: 403 });
      // Out of its chats too, so the counts and their list are right.
      expect(
        await prisma.communityChatMember.count({
          where: { userId: ids.ben, chat: { communityId } },
        }),
      ).toBe(0);
      expect((await chats.joined(ids.ben)).items).toEqual([]);
    });

    it('tells only people still in the community', async () => {
      // A chat membership left behind -- by a bug, or a removal from before
      // chats existed -- must not let somebody back in through the side.
      await prisma.communityChatMember.create({
        data: { chatId: general, userId: ids.ben },
      });
      expect((await chats.joined(ids.ben)).items).toEqual([]);
      delivery.told.length = 0;
      await chats.send(ids.ada, general, { body: 'who hears this' }, later(5));
      const heard = delivery.told.flatMap((t) => t.userIds);
      expect(heard).toContain(ids.ada);
      expect(heard).not.toContain(ids.ben);
      expect(delivery.told.every((t) => !t.push)).toBe(true);
    });

    it('closes with the community', async () => {
      await communities.remove(ids.owner, slug);
      await expect(chats.messages(ids.ada, general)).rejects.toMatchObject({
        status: 404,
      });
      expect((await chats.joined(ids.ada)).items).toEqual([]);
    });
  });
});
