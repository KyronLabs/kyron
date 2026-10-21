import { randomUUID } from 'node:crypto';

import {
  CommunityChatWriters,
  CommunityRole,
  MediaKind,
  ModerationKind,
  PrismaClient,
  ReportReason,
  ReportTarget,
  UserRole,
} from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { EnforcementService } from '../moderation/enforcement.service';
import { ModerationService } from '../moderation/moderation.service';
import { RecordingPrivateStorage } from '../../infrastructure/supabase/private-storage.test-double';
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
  let storage: RecordingPrivateStorage;

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
    storage = new RecordingPrivateStorage();
    chats = new CommunityChatsService(
      prisma as PrismaService,
      delivery,
      storage.asService,
    );
    communities = new CommunitiesService(prisma as PrismaService);
    enforcement = new EnforcementService(
      prisma as PrismaService,
      delivery,
      storage.asService,
    );
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
    // Every one of them, including those added since: messages, members,
    // reactions, edits, polls, their answers and votes.
    expect(rows.map((r) => r.relname).sort()).toEqual([
      'CommunityChat',
      'CommunityChatMember',
      'CommunityChatMessage',
      'CommunityChatMessageEdit',
      'CommunityChatPoll',
      'CommunityChatPollOption',
      'CommunityChatPollVote',
      'CommunityChatReaction',
    ]);
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

    it('opens one of a name when several ask at once', async () => {
      // Connections open first, or the first request is done before the
      // pool has made room for the rest, and nothing overlaps.
      await Promise.all(
        Array.from({ length: 8 }, () => prisma.$queryRaw`SELECT 1`),
      );
      const all = await Promise.allSettled(
        Array.from({ length: 8 }, (_, i) =>
          chats.create(i % 2 ? ids.mod : ids.owner, slug, {
            name: i % 2 ? 'twins' : 'Twins',
          }),
        ),
      );
      expect(all.filter((r) => r.status === 'fulfilled')).toHaveLength(1);
      const live = await prisma.communityChat.findMany({
        where: {
          communityId,
          deletedAt: null,
          name: { equals: 'twins', mode: 'insensitive' },
        },
      });
      expect(live).toHaveLength(1);
      await chats.remove(ids.owner, live[0].id);
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

    it('holds the burst when the requests arrive together', async () => {
      // A script sends a dozen at once: each must count the ones before it.
      const at = later(60);
      const sent = await Promise.allSettled(
        Array.from({ length: 12 }, (_, i) =>
          chats.send(ids.ben, general, { body: `flood ${i}` }, at),
        ),
      );
      const landed = sent.filter((r) => r.status === 'fulfilled');
      expect(landed).toHaveLength(CommunityChatsService.burst);
      for (const r of sent) {
        if (r.status === 'rejected') {
          expect(r.reason).toMatchObject({ status: 429 });
        }
      }
      later(60);
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

  describe('a second chat: muting, pushes, edits, search, media, polls', () => {
    let quiet = '';
    /** Up to date, by the spec's own clock: markRead stamps the real time,
     * which is behind the clock messages here are sent on. */
    const readUpTo = (userId: string) =>
      prisma.communityChatMember.updateMany({
        where: { userId },
        data: { lastReadAt: new Date(clock) },
      });
    const pushedTo = () => delivery.pushed.flatMap((p) => p.userIds).sort();
    const ref = (who: string, ext: string) =>
      `chat/${who}_${Date.now()}_${randomUUID()}.${ext}`;

    beforeAll(async () => {
      // Room for it: the cap test left the community full.
      const filler = await prisma.communityChat.findFirstOrThrow({
        where: { communityId, name: 'Room 2', deletedAt: null },
      });
      await chats.remove(ids.owner, filler.id);
      quiet = (await chats.create(ids.owner, slug, { name: 'Quiet room' })).id;
      await chats.join(ids.ada, quiet);
      await chats.join(ids.ben, quiet);
    });

    it('mutes only a chat the reader joined', async () => {
      // The moderator is in the community, not in this chat.
      await expect(chats.setMuted(ids.mod, quiet, true)).rejects.toMatchObject({
        status: 403,
      });
      await chats.setMuted(ids.ada, quiet, true);
      expect((await chats.get(ids.ada, quiet)).muted).toBe(true);
      expect((await chats.get(ids.ben, quiet)).muted).toBe(false);
    });

    it('badges chats with something new, not muted ones, nor anybody out of sight', async () => {
      await readUpTo(ids.ada);
      await readUpTo(ids.ben);
      expect((await chats.unreadChats(ids.ben)).chats).toBe(0);

      await chats.send(ids.owner, quiet, { body: 'news' }, later(11));
      expect((await chats.unreadChats(ids.ben)).chats).toBe(1);
      // Muted: not in the badge, still unread in the list.
      expect((await chats.unreadChats(ids.ada)).chats).toBe(0);
      expect((await chats.get(ids.ada, quiet)).unread).toBe(1);
      await chats.setMuted(ids.ada, quiet, false);
      expect((await chats.unreadChats(ids.ada)).chats).toBe(1);

      // What is never shown is never "new".
      await prisma.block.create({
        data: { blockerId: ids.ben, blockedId: ids.owner },
      });
      expect((await chats.unreadChats(ids.ben)).chats).toBe(0);
      expect((await chats.get(ids.ben, quiet)).unread).toBe(0);
      await prisma.block.deleteMany({ where: { blockerId: ids.ben } });
    });

    it('pushes once per run of unread messages, and again once read', async () => {
      await readUpTo(ids.ada);
      await readUpTo(ids.ben);
      await prisma.communityChatMember.updateMany({
        where: { chatId: quiet },
        data: { notifiedAt: null },
      });
      delivery.pushed.length = 0;

      await chats.send(ids.owner, quiet, { body: 'first' }, later(11));
      // Not the sender, not the moderator who never joined.
      expect(pushedTo()).toEqual([ids.ada, ids.ben].sort());
      expect(delivery.pushed[0].push).toMatchObject({
        title: `Quiet room · Birders ${stamp}`,
        body: 'Owner: first',
        data: { type: 'community.chat', chatId: quiet },
      });

      await chats.send(ids.owner, quiet, { body: 'second' }, later(11));
      expect(delivery.pushed).toHaveLength(1);

      await readUpTo(ids.ben);
      await chats.send(ids.owner, quiet, { body: 'third' }, later(11));
      expect(delivery.pushed).toHaveLength(2);
      expect(delivery.pushed[1].userIds).toEqual([ids.ben]);
    });

    it('pushes a reply to its author mid-run, never into a mute, never across a block', async () => {
      await readUpTo(ids.ada);
      const asked = await chats.send(
        ids.ada,
        quiet,
        { body: 'anyone for a walk?' },
        later(11),
      );
      await chats.send(ids.owner, quiet, { body: 'maybe' }, later(11));
      delivery.pushed.length = 0;
      // Ada was pushed about "maybe" and has not read since: a reply to her
      // still reaches her.
      await chats.send(
        ids.ben,
        quiet,
        { body: 'me!', replyToId: asked.id },
        later(11),
      );
      expect(pushedTo()).toContain(ids.ada);

      delivery.pushed.length = 0;
      await chats.setMuted(ids.ada, quiet, true);
      await chats.send(
        ids.ben,
        quiet,
        { body: 'and me', replyToId: asked.id },
        later(11),
      );
      expect(pushedTo()).not.toContain(ids.ada);
      await chats.setMuted(ids.ada, quiet, false);

      delivery.pushed.length = 0;
      await readUpTo(ids.ben);
      await prisma.block.create({
        data: { blockerId: ids.owner, blockedId: ids.ben },
      });
      await chats.send(ids.owner, quiet, { body: 'hello?' }, later(11));
      expect(pushedTo()).not.toContain(ids.ben);
      await prisma.block.deleteMany({ where: { blockerId: ids.owner } });
    });

    it('lets an author change their words for a while, keeping what it said', async () => {
      const sent = await chats.send(
        ids.ben,
        quiet,
        { body: 'teh plan' },
        later(11),
      );
      expect(sent.editableUntil).not.toBeNull();
      const edited = await chats.edit(
        ids.ben,
        quiet,
        sent.id,
        { body: 'the plan' },
        later(60),
      );
      expect(edited.body).toBe('the plan');
      expect(edited.editedAt).not.toBeNull();
      expect(
        (
          await prisma.communityChatMessageEdit.findMany({
            where: { messageId: sent.id },
          })
        ).map((e) => e.body),
      ).toEqual(['teh plan']);
      expect(delivery.ofType('community.chat.message.edited')).not.toHaveLength(
        0,
      );

      // Nobody else's, a moderator's or the owner's included.
      await expect(
        chats.edit(ids.owner, quiet, sent.id, { body: 'x' }, later(1)),
      ).rejects.toMatchObject({ status: 403 });
      // Not after the window.
      await expect(
        chats.edit(
          ids.ben,
          quiet,
          sent.id,
          { body: 'too late' },
          new Date(sent.createdAt.getTime() + 16 * 60_000),
        ),
      ).rejects.toMatchObject({ status: 403 });

      // Unsaid by its author: what it said before goes too.
      await chats.deleteMessage(ids.ben, quiet, sent.id);
      expect(
        await prisma.communityChatMessageEdit.count({
          where: { messageId: sent.id },
        }),
      ).toBe(0);
    });

    it('finds words in a chat, whatever their case, and only what it should', async () => {
      await chats.send(
        ids.ada,
        quiet,
        { body: 'Kingfisher at the BRIDGE' },
        later(11),
      );
      await chats.send(
        ids.ben,
        quiet,
        { body: '100% sure it was a heron' },
        later(11),
      );
      const bodies = async (q: string, who = ids.owner) =>
        (await chats.search(who, quiet, q)).items.map((i) => i.body);

      expect(await bodies('bridge')).toEqual(['Kingfisher at the BRIDGE']);
      // A % is a percent sign and a _ an underscore, not wildcards.
      expect(await bodies('0% s')).toEqual(['100% sure it was a heron']);
      expect(await bodies('e_')).toEqual([]);
      // One letter is no search.
      expect(await bodies('k')).toEqual([]);
      // Out of sight is out of the results.
      await prisma.block.create({
        data: { blockerId: ids.owner, blockedId: ids.ada },
      });
      expect(await bodies('bridge')).toEqual([]);
      await prisma.block.deleteMany({ where: { blockerId: ids.owner } });
      await expect(
        chats.search(ids.outsider, quiet, 'bridge'),
      ).rejects.toMatchObject({ status: 403 });
    });

    it('carries pictures from the private bucket, linked for an hour', async () => {
      const photo = ref(ids.ada, 'jpg');
      const sent = await chats.send(
        ids.ada,
        quiet,
        { media: [{ ref: photo, width: 800, height: 600 }] },
        later(11),
      );
      expect(sent.body).toBe('');
      expect(sent.media).toEqual([
        expect.objectContaining({
          kind: MediaKind.IMAGE,
          width: 800,
          height: 600,
          url: expect.stringContaining(photo) as unknown,
        }),
      ]);
      // As others read it, too.
      const seen = (await chats.messages(ids.ben, quiet)).items.find(
        (i) => i.id === sent.id,
      );
      expect(seen?.media[0].url).toContain(photo);
      // Never the path itself, anywhere in what goes out.
      expect(JSON.stringify(seen).includes(`"${photo}"`)).toBe(false);

      // Somebody else's upload, one already sent, one outside the folder.
      await expect(
        chats.send(ids.ben, quiet, { media: [{ ref: photo }] }, later(11)),
      ).rejects.toMatchObject({ status: 400 });
      await expect(
        chats.send(ids.ada, quiet, { media: [{ ref: photo }] }, later(11)),
      ).rejects.toMatchObject({ status: 409 });
      await expect(
        chats.send(
          ids.ada,
          quiet,
          { media: [{ ref: `chat/${ids.ada}_1_../../once/x.jpg` }] },
          later(11),
        ),
      ).rejects.toMatchObject({ status: 400 });
      // A voice note on its own; no more than four.
      await expect(
        chats.send(
          ids.ada,
          quiet,
          {
            media: [{ ref: ref(ids.ada, 'm4a') }, { ref: ref(ids.ada, 'jpg') }],
          },
          later(11),
        ),
      ).rejects.toMatchObject({ status: 400 });
      await expect(
        chats.send(
          ids.ada,
          quiet,
          {
            media: [1, 2, 3, 4, 5].map(() => ({ ref: ref(ids.ada, 'jpg') })),
          },
          later(11),
        ),
      ).rejects.toMatchObject({ status: 400 });
      // What it is, from the server's own name for the file.
      const voice = await chats.send(
        ids.ada,
        quiet,
        {
          media: [
            { ref: ref(ids.ada, 'm4a'), durationMs: 4200, waveform: [5, 250] },
          ],
        },
        later(11),
      );
      expect(voice.media[0]).toMatchObject({
        kind: MediaKind.VOICE,
        durationMs: 4200,
        waveform: [5, 100],
      });
      // Words with nothing else still need to be words.
      await expect(
        chats.send(ids.ada, quiet, { body: '   ' }, later(11)),
      ).rejects.toMatchObject({ status: 400 });
    });

    it('erases its author’s pictures with their words, keeps them for review otherwise', async () => {
      const mine = ref(ids.ada, 'jpg');
      const gone = await chats.send(
        ids.ada,
        quiet,
        { media: [{ ref: mine }] },
        later(11),
      );
      storage.removed.length = 0;
      await chats.deleteMessage(ids.ada, quiet, gone.id);
      expect(storage.removed).toEqual([mine]);
      expect(
        await prisma.media.count({ where: { communityMessageId: gone.id } }),
      ).toBe(0);

      const theirs = ref(ids.ben, 'jpg');
      const rude = await chats.send(
        ids.ben,
        quiet,
        { body: 'look', media: [{ ref: theirs }] },
        later(11),
      );
      await moderation.report(
        ids.ada,
        ReportTarget.COMMUNITY_MESSAGE,
        rude.id,
        ReportReason.HARASSMENT,
      );
      const report = await prisma.report.findFirstOrThrow({
        where: { target: ReportTarget.COMMUNITY_MESSAGE, targetId: rude.id },
      });
      expect(report.snapshot).toContain('[image]');

      storage.removed.length = 0;
      await chats.deleteMessage(ids.mod, quiet, rude.id);
      expect(storage.removed).toEqual([]);
      // The team, who are not in the community, can still look at it.
      const { items } = await enforcement.reportQueue({
        id: ids.staff,
        role: UserRole.ADMIN,
      });
      expect(items.find((i) => i.targetId === rude.id)?.media).toEqual([
        {
          id: expect.any(String) as unknown,
          kind: MediaKind.IMAGE,
          url: expect.stringContaining(theirs) as unknown,
        },
      ]);
    });

    it('asks a poll and counts answers, never who gave them', async () => {
      const asked = await chats.send(
        ids.owner,
        quiet,
        {
          body: 'Saturday or Sunday?',
          poll: { options: ['Saturday', ' Sunday '] },
        },
        later(11),
      );
      const poll = asked.poll!;
      expect(poll.options.map((o) => o.text)).toEqual(['Saturday', 'Sunday']);
      expect(asked.editableUntil).toBeNull();
      const [sat, sun] = poll.options;

      // A spectator answers too: the moderator never joined this chat.
      await chats.vote(ids.mod, quiet, asked.id, [sat.id]);
      const adas = await chats.vote(ids.ada, quiet, asked.id, [sun.id]);
      expect(adas.poll).toMatchObject({ voters: 2, mine: [sun.id] });
      expect(adas.poll?.options.map((o) => o.votes)).toEqual([1, 1]);
      // A second answer replaces the first.
      const again = await chats.vote(ids.ada, quiet, asked.id, [sat.id]);
      expect(again.poll?.options.map((o) => o.votes)).toEqual([2, 0]);
      expect(JSON.stringify(again)).not.toContain(ids.mod);

      await expect(
        chats.vote(ids.ben, quiet, asked.id, [sat.id, sun.id]),
      ).rejects.toMatchObject({ status: 400 });
      await expect(
        chats.vote(ids.ben, quiet, asked.id, [randomUUID()]),
      ).rejects.toMatchObject({ status: 400 });
      await expect(
        chats.edit(ids.owner, quiet, asked.id, { body: 'Monday?' }, later(1)),
      ).rejects.toMatchObject({ status: 400 });

      // Closed by its asker or a moderator, and then answered no more.
      await expect(
        chats.closePoll(ids.ben, quiet, asked.id),
      ).rejects.toMatchObject({ status: 403 });
      await chats.closePoll(ids.owner, quiet, asked.id);
      await expect(
        chats.vote(ids.ben, quiet, asked.id, [sat.id]),
      ).rejects.toMatchObject({ status: 403 });
      expect(
        (await chats.messages(ids.ben, quiet)).items.find(
          (i) => i.id === asked.id,
        )?.poll?.closed,
      ).toBe(true);
    });

    it('puts one upload in one message, even sent to two chats at once', async () => {
      const photo = ref(ids.ada, 'jpg');
      await Promise.all(
        Array.from({ length: 6 }, () => prisma.$queryRaw`SELECT 1`),
      );
      const sent = await Promise.allSettled(
        [quiet, general, quiet, general].map((chatId) =>
          chats.send(ids.ada, chatId, { media: [{ ref: photo }] }, later(11)),
        ),
      );
      expect(sent.filter((s) => s.status === 'fulfilled')).toHaveLength(1);
      for (const s of sent) {
        if (s.status === 'rejected') {
          expect(s.reason).toMatchObject({ status: 409 });
        }
      }
      expect(await prisma.media.count({ where: { privatePath: photo } })).toBe(
        1,
      );
    });

    it('takes one answer from taps on several at once', async () => {
      const asked = await chats.send(
        ids.owner,
        quiet,
        { body: 'Pick one', poll: { options: ['A', 'B', 'C'] } },
        later(11),
      );
      await Promise.all(
        Array.from({ length: 6 }, () => prisma.$queryRaw`SELECT 1`),
      );
      await Promise.allSettled(
        asked.poll!.options.map((o) =>
          chats.vote(ids.ben, quiet, asked.id, [o.id]),
        ),
      );
      expect(
        await prisma.communityChatPollVote.count({
          where: { pollId: asked.poll!.id, userId: ids.ben },
        }),
      ).toBe(1);
    });

    it('takes several answers where the poll allows them, and none badly made', async () => {
      const asked = await chats.send(
        ids.owner,
        quiet,
        {
          body: 'Which birds?',
          poll: { options: ['Heron', 'Kite', 'Wren'], multiple: true },
        },
        later(11),
      );
      const [heron, , wren] = asked.poll!.options;
      const voted = await chats.vote(ids.ben, quiet, asked.id, [
        heron.id,
        wren.id,
      ]);
      expect(voted.poll).toMatchObject({ voters: 1 });
      expect(voted.poll?.mine.sort()).toEqual([heron.id, wren.id].sort());
      await chats.unvote(ids.ben, quiet, asked.id);
      expect(
        (await chats.messages(ids.ben, quiet)).items.find(
          (i) => i.id === asked.id,
        )?.poll?.voters,
      ).toBe(0);

      for (const options of [
        ['Only one'],
        Array.from({ length: 11 }, (_, i) => `Option ${i}`),
        ['Same', 'same'],
        ['Fine', '  '],
      ]) {
        await expect(
          chats.send(
            ids.owner,
            quiet,
            { body: 'Bad poll', poll: { options } },
            later(11),
          ),
        ).rejects.toMatchObject({ status: 400 });
      }
    });

    it('lists the reader’s chats liveliest first, saying what came last', async () => {
      const { items } = await chats.joined(ids.ben);
      expect(items[0].id).toBe(quiet);
      expect(items[0].lastMessage).toMatchObject({
        body: 'Which birds?',
        poll: true,
        media: null,
      });
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
