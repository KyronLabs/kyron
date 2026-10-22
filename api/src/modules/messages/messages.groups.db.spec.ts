import { randomUUID } from 'node:crypto';

import { MediaKind, MemberRole, PrismaClient } from '@prisma/client';

import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import type { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { GroupsService } from './groups.service';
import { KeySharesService } from './key-shares.service';
import { MessagesService } from './messages.service';
import { ViewOnceService } from './view-once.service';

/**
 * Groups and view-once against a real Postgres: roles, spectators, raised
 * hands, history from when somebody joined, and an attachment opened once
 * and then deleted. Skipped unless MODERATION_TEST_DATABASE_URL names a
 * migrated database (see docs/MODERATION.md), because CI has none.
 */
const url = process.env.MODERATION_TEST_DATABASE_URL;
const run = url ? describe : describe.skip;

/** Storage as far as view-once uses it, recording instead of storing. */
class FakeStorage {
  signed: { path: string; seconds: number }[] = [];
  removed: string[] = [];
  signPrivate(path: string, seconds: number) {
    this.signed.push({ path, seconds });
    return Promise.resolve(`https://storage.invalid/sign/${path}?t=${seconds}`);
  }
  removePrivate(paths: readonly string[]) {
    this.removed.push(...paths);
    return Promise.resolve();
  }
}

run('groups and view-once, against a real database', () => {
  let prisma: PrismaClient;
  let messages: MessagesService;
  let groups: GroupsService;
  let once: ViewOnceService;
  let keys: KeySharesService;
  let delivery: RecordingDelivery;
  let storage: FakeStorage;

  const [ada, ben, cy, dee] = [0, 1, 2, 3].map(() => randomUUID());
  const stamp = Date.now();
  let groupId = '';

  beforeAll(async () => {
    prisma = new PrismaClient({ datasources: { db: { url } } });
    delivery = new RecordingDelivery();
    storage = new FakeStorage();
    messages = new MessagesService(prisma as PrismaService, delivery);
    groups = new GroupsService(prisma as PrismaService, delivery, messages);
    once = new ViewOnceService(
      prisma as PrismaService,
      storage as unknown as SupabaseService,
      delivery,
    );
    keys = new KeySharesService(prisma as PrismaService, delivery);
    for (const [id, name] of [
      [ada, 'Ada'],
      [ben, 'Ben'],
      [cy, 'Cy'],
      [dee, 'Dee'],
    ]) {
      await prisma.user.create({
        data: { id, name, email: `${name}.${stamp}@example.test` },
      });
    }
  });

  afterAll(async () => {
    await prisma?.user.deleteMany({
      where: { id: { in: [ada, ben, cy, dee] } },
    });
    await prisma?.$disconnect();
  });

  describe('a group', () => {
    it('starts with its owner, the people chosen, and a first line', async () => {
      ({ id: groupId } = await groups.create(ada, '  Birders  ', [ben, cy]));

      const { items } = await groups.members(ada, groupId);
      expect(items.map((m) => [m.name, m.role])).toEqual([
        ['Ada', MemberRole.OWNER],
        ['Ben', MemberRole.MEMBER],
        ['Cy', MemberRole.MEMBER],
      ]);
      const page = await messages.messages(ben, groupId);
      expect(page.group).toMatchObject({ title: 'Birders', memberCount: 3 });
      expect(page.items[0].event).toMatchObject({
        type: 'created',
        actor: { id: ada, name: 'Ada' },
      });
      // In everybody's list at once, before anybody has written.
      const { items: list } = await messages.list(cy);
      expect(list.find((c) => c.id === groupId)?.group?.title).toBe('Birders');
    });

    it('is never "the conversation with" one of its members', async () => {
      const { id } = await messages.openWith(ada, ben);
      expect(id).not.toBe(groupId);
    });

    it('lets members write, and names the group in the push', async () => {
      await messages.send(ben, groupId, 'Kingfisher at the bridge');
      const push = delivery.told.at(-1)?.push;
      expect(push).toMatchObject({
        title: 'Birders',
        body: 'Ben: Sent a message',
      });
    });

    it('can be listed apart from conversations between two', async () => {
      const { id: direct } = await messages.openWith(ada, ben);
      await messages.send(ada, direct, 'Are you coming on Saturday?');

      const all = (await messages.list(ben)).items.map((c) => c.id);
      expect(all).toEqual(expect.arrayContaining([groupId, direct]));
      const groupsOnly = (
        await messages.list(ben, { filter: 'groups' })
      ).items.map((c) => c.id);
      expect(groupsOnly).toContain(groupId);
      expect(groupsOnly).not.toContain(direct);
    });

    it('keeps spectators to reading, reacting and asking', async () => {
      await groups.setRole(ada, groupId, cy, MemberRole.SPECTATOR);
      await expect(messages.send(cy, groupId, 'hello')).rejects.toMatchObject({
        status: 403,
      });

      const [first] = (await messages.messages(cy, groupId)).items;
      await expect(
        messages.react(cy, groupId, first.id, '❤️'),
      ).resolves.toBeDefined();

      await groups.raiseHand(cy, groupId);
      // The admins are told; the hand shows to them and to Cy, nobody else.
      expect(delivery.told.at(-2)?.push?.body).toBe(
        'Cy raised a hand to ask to write.',
      );
      const asAdmin = await groups.members(ada, groupId);
      const asBen = await groups.members(ben, groupId);
      expect(asAdmin.items.find((m) => m.id === cy)?.handRaised).toBe(true);
      expect(asBen.items.find((m) => m.id === cy)?.handRaised).toBe(false);
      expect((await messages.messages(ada, groupId)).group?.handsRaised).toBe(
        1,
      );
    });

    it('answers a raised hand yes by letting them write', async () => {
      await groups.setRole(ada, groupId, cy, MemberRole.MEMBER);
      await expect(
        messages.send(cy, groupId, 'Thanks!'),
      ).resolves.toBeDefined();
      const cyRow = (await groups.members(ada, groupId)).items.find(
        (m) => m.id === cy,
      );
      expect(cyRow?.handRaised).toBe(false);
    });

    it('holds each role to what it may do', async () => {
      // A member can do none of an admin's things.
      await expect(groups.add(ben, groupId, [dee])).rejects.toMatchObject({
        status: 403,
      });
      await expect(
        groups.update(ben, groupId, { title: 'Ben’s now' }),
      ).rejects.toMatchObject({ status: 403 });

      // An admin cannot make admins, or take one out.
      await groups.setRole(ada, groupId, ben, MemberRole.ADMIN);
      await expect(
        groups.setRole(ben, groupId, cy, MemberRole.ADMIN),
      ).rejects.toMatchObject({ status: 403 });
      // Nobody removes the owner.
      await expect(groups.remove(ben, groupId, ada)).rejects.toMatchObject({
        status: 403,
      });
    });

    it('shows somebody added later only what was said after', async () => {
      await groups.add(ben, groupId, [dee]);
      await messages.send(ada, groupId, 'Welcome, Dee');

      const page = await messages.messages(dee, groupId);
      const lines = page.items.map((m) => m.body || m.event);
      expect(lines).toContainEqual('Welcome, Dee');
      expect(lines).not.toContainEqual('Kingfisher at the bridge');
    });

    it('will not share keys from before somebody joined', async () => {
      const early = await prisma.message.create({
        data: {
          conversationId: groupId,
          senderId: ada,
          body: 'k2.sealed-for-the-group-before-dee',
          createdAt: new Date(Date.now() - 86_400_000),
        },
      });
      await prisma.messageKey.create({
        data: { userId: dee, deviceId: 'phone', publicKey: `dee-${stamp}` },
      });
      await expect(
        keys.request(dee, groupId, 'phone', [early.id]),
      ).resolves.toEqual({ requested: 0 });
    });

    it('hands itself on when the owner leaves', async () => {
      await groups.remove(ada, groupId, ada);
      const { items } = await groups.members(ben, groupId);
      expect(items.find((m) => m.id === ben)?.role).toBe(MemberRole.OWNER);
      await expect(messages.messages(ada, groupId)).rejects.toMatchObject({
        status: 404,
      });
    });
  });

  describe('view once', () => {
    let directId = '';
    let messageId = '';
    const ref = () => `once/${ada}_${stamp}_photo.jpg`;

    beforeAll(async () => {
      ({ id: directId } = await messages.openWith(ada, ben));
    });

    it('sends one thing, with no address anybody can keep', async () => {
      const sent = await messages.send(
        ada,
        directId,
        '',
        [],
        undefined,
        undefined,
        { ref: ref(), kind: MediaKind.IMAGE, width: 800, height: 600 },
      );
      messageId = sent.id;
      expect(sent.viewOnce).toBe(true);
      expect(sent.media[0]).toMatchObject({ url: '', thumbnailUrl: null });
      expect(JSON.stringify(sent)).not.toContain(ref());

      const page = await messages.messages(ben, directId);
      const item = page.items.find((m) => m.id === messageId)!;
      expect(JSON.stringify(item)).not.toContain(ref());
      expect(item.once).toEqual({
        opened: false,
        openedCount: 0,
        recipients: 1,
        gone: false,
      });
      // Not in the conversation's shared media, ever.
      const shared = await messages.sharedMedia(ben, directId);
      expect(shared.items.map((m) => m.messageId)).not.toContain(messageId);
    });

    it('refuses somebody else’s upload, and words alongside', async () => {
      await expect(
        messages.send(ben, directId, '', [], undefined, undefined, {
          ref: ref(),
          kind: MediaKind.IMAGE,
        }),
      ).rejects.toMatchObject({ status: 400 });
      await expect(
        messages.send(ada, directId, 'look', [], undefined, undefined, {
          ref: ref(),
          kind: MediaKind.IMAGE,
        }),
      ).rejects.toMatchObject({ status: 400 });
    });

    it('is not for its sender to open again', async () => {
      await expect(once.open(ada, directId, messageId)).rejects.toMatchObject({
        status: 403,
      });
    });

    it('opens once, with a link that lasts minutes', async () => {
      const opened = await once.open(ben, directId, messageId);
      expect(opened.url).toContain(ref());
      expect(storage.signed.at(-1)).toEqual({ path: ref(), seconds: 120 });
      // The sender is told, by id.
      expect(delivery.ofType('message.opened').at(-1)).toEqual({
        type: 'message.opened',
        conversationId: directId,
        messageId,
      });

      await expect(once.open(ben, directId, messageId)).rejects.toMatchObject({
        status: 410,
      });
      const page = await messages.messages(ada, directId);
      expect(page.items.find((m) => m.id === messageId)?.once).toMatchObject({
        openedCount: 1,
        recipients: 1,
      });
    });

    it('is deleted once its last link has run out, and not before', async () => {
      const row = await prisma.message.findUniqueOrThrow({
        where: { id: messageId },
        select: { purgeAfter: true },
      });
      expect(row.purgeAfter).not.toBeNull();

      // Swept before the link runs out: still there.
      await once.sweep(new Date(row.purgeAfter!.getTime() - 1000));
      expect(storage.removed).not.toContain(ref());

      await once.sweep(new Date(row.purgeAfter!.getTime() + 1000));
      expect(storage.removed).toContain(ref());
      const media = await prisma.media.findFirstOrThrow({
        where: { messageId },
        select: { privatePath: true },
      });
      expect(media.privatePath).toBeNull();
      const page = await messages.messages(ben, directId);
      expect(page.items.find((m) => m.id === messageId)?.once?.gone).toBe(true);
    });

    it('is deleted unopened after its time is up', async () => {
      const stale = await messages.send(
        ada,
        directId,
        '',
        [],
        undefined,
        undefined,
        {
          ref: `once/${ada}_${stamp}_voice.m4a`,
          kind: MediaKind.VOICE,
          durationMs: 30_000,
        },
      );
      const later = new Date(
        Date.now() + (ViewOnceService.ttlDays + 1) * 86_400_000,
      );
      await once.sweep(later);
      expect(storage.removed).toContain(`once/${ada}_${stamp}_voice.m4a`);
      await expect(once.open(ben, directId, stale.id)).rejects.toMatchObject({
        status: 410,
      });
    });
  });
});
