import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { ConversationKind, MemberRole, Prisma } from '@prisma/client';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { DeliveryService } from '../push/delivery.service';
import { MessagesService } from './messages.service';

/** Somebody named in a group's event line, as they were called then. */
interface EventPerson {
  id: string;
  name: string;
}

/**
 * A line about a group rather than in it. Stored readable on the message:
 * the server knows who is in a group already, because it delivers to them.
 * Names are kept as they were, so "Ada removed Ben" still reads after Ben has
 * gone and nobody can look him up.
 */
export type GroupEvent =
  | { type: 'created'; actor: EventPerson; title: string }
  | { type: 'renamed'; actor: EventPerson; title: string }
  | { type: 'added'; actor: EventPerson; users: EventPerson[] }
  | { type: 'removed'; actor: EventPerson; users: EventPerson[] }
  | { type: 'left'; actor: EventPerson }
  | { type: 'role'; actor: EventPerson; users: EventPerson[]; role: MemberRole }
  | { type: 'joinRole'; actor: EventPerson; role: MemberRole };

/** One person in a group, for its members page. */
export interface GroupMember {
  id: string;
  name: string | null;
  username: string | null;
  avatarUrl: string | null;
  verified: boolean;
  role: MemberRole;
  /** A spectator asking to write. Shown to admins and to themselves. */
  handRaised: boolean;
  joinedAt: Date;
}

/** Roles in the order a members page lists them. */
const RANK: Record<MemberRole, number> = {
  OWNER: 0,
  ADMIN: 1,
  MEMBER: 2,
  SPECTATOR: 3,
};

const isAdmin = (role: MemberRole) =>
  role === MemberRole.OWNER || role === MemberRole.ADMIN;

/**
 * Group conversations: up to [MessagesService.maxGroupMembers] people, end-to-
 * end encrypted like a direct thread, with roles.
 *
 * The owner started it and names admins. Admins add and remove people, rename
 * it, and decide who may write. Members write. Spectators read, react, and
 * raise a hand to ask to write -- the shape of a group where a few people talk
 * and the rest follow. Every rule is enforced here, not only drawn in the
 * app. See docs/MESSAGING.md.
 */
@Injectable()
export class GroupsService {
  private readonly logger = new Logger(GroupsService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly delivery: DeliveryService,
    private readonly messages: MessagesService,
  ) {}

  /** The longest a group's name may be. */
  static readonly maxTitle = 80;

  /** Starts a group with [viewerId] as its owner. */
  async create(
    viewerId: string,
    title: string,
    userIds: string[],
    joinRole: MemberRole = MemberRole.MEMBER,
  ): Promise<{ id: string }> {
    const name = GroupsService.title(title);
    GroupsService.joinable(joinRole);
    const others = [...new Set(userIds)].filter((id) => id !== viewerId);
    if (others.length === 0) {
      throw new BadRequestException('Add at least one person to the group.');
    }
    if (others.length + 1 > MessagesService.maxGroupMembers) {
      throw new BadRequestException(
        `A group can have at most ${MessagesService.maxGroupMembers} people.`,
      );
    }
    const people = await this.existing(others);
    for (const id of others) {
      await this.messages.requireNoBlock(viewerId, id);
    }
    const actor = await this.person(viewerId);

    const conversation = await this.prisma.conversation.create({
      data: {
        kind: ConversationKind.GROUP,
        title: name,
        joinRole,
        members: {
          create: [
            {
              userId: viewerId,
              role: MemberRole.OWNER,
              lastReadAt: new Date(),
            },
            // Everybody the creator chose can write: they were asked in by
            // name. [joinRole] is for people added later.
            ...others.map((userId) => ({ userId, role: MemberRole.MEMBER })),
          ],
        },
        // The first line, so a group nobody has written in yet is still a
        // conversation in everybody's list.
        messages: {
          create: {
            senderId: viewerId,
            body: '',
            event: {
              type: 'created',
              actor,
              title: name,
            } satisfies GroupEvent as unknown as Prisma.InputJsonValue,
          },
        },
      },
      select: { id: true },
    });

    this.delivery.tellMany(
      others,
      { type: 'conversation.updated', conversationId: conversation.id },
      {
        title: name,
        body: `${actor.name} added you to the group.`,
        data: { type: 'message', conversationId: conversation.id },
      },
    );
    this.logger.log(
      `group ${conversation.id} started by ${viewerId} with ${people.length}`,
    );
    return { id: conversation.id };
  }

  /** Renames a group, or changes what people added to it start as. */
  async update(
    viewerId: string,
    conversationId: string,
    changes: { title?: string; joinRole?: MemberRole },
  ) {
    const group = await this.requireGroup(viewerId, conversationId);
    this.requireAdmin(group.me.role);
    const actor = await this.person(viewerId);
    const events: GroupEvent[] = [];
    const data: Prisma.ConversationUpdateInput = {};

    if (changes.title !== undefined) {
      const name = GroupsService.title(changes.title);
      if (name !== group.title) {
        data.title = name;
        events.push({ type: 'renamed', actor, title: name });
      }
    }
    if (changes.joinRole !== undefined) {
      GroupsService.joinable(changes.joinRole);
      if (changes.joinRole !== group.joinRole) {
        data.joinRole = changes.joinRole;
        events.push({ type: 'joinRole', actor, role: changes.joinRole });
      }
    }
    if (events.length === 0) return { ok: true };

    await this.prisma.conversation.update({
      where: { id: conversationId },
      data,
    });
    await this.record(conversationId, viewerId, events);
    this.tellGroup(conversationId, group.memberIds);
    return { ok: true };
  }

  /** Everybody in a group, owner first, then admins, members, spectators. */
  async members(
    viewerId: string,
    conversationId: string,
  ): Promise<{ items: GroupMember[] }> {
    const group = await this.requireGroup(viewerId, conversationId);
    const admin = isAdmin(group.me.role);
    const rows = await this.prisma.conversationMember.findMany({
      where: { conversationId },
      select: {
        userId: true,
        role: true,
        handRaisedAt: true,
        joinedAt: true,
        user: {
          select: {
            name: true,
            username: true,
            verifiedAt: true,
            profile: { select: { avatarUrl: true } },
          },
        },
      },
    });
    const items = rows
      .map((row) => ({
        id: row.userId,
        name: row.user.name,
        username: row.user.username,
        avatarUrl: row.user.profile?.avatarUrl ?? null,
        verified: !!row.user.verifiedAt,
        role: row.role,
        // A raised hand is a question for the admins; nobody else is told.
        handRaised:
          row.handRaisedAt != null && (admin || row.userId === viewerId),
        joinedAt: row.joinedAt,
      }))
      .sort(
        (a, b) =>
          RANK[a.role] - RANK[b.role] ||
          Number(b.handRaised) - Number(a.handRaised) ||
          a.joinedAt.getTime() - b.joinedAt.getTime(),
      );
    return { items };
  }

  /** Adds people to a group, as whatever the group starts people as. */
  async add(viewerId: string, conversationId: string, userIds: string[]) {
    const group = await this.requireGroup(viewerId, conversationId);
    this.requireAdmin(group.me.role);
    const adding = [...new Set(userIds)].filter(
      (id) => !group.memberIds.includes(id),
    );
    if (adding.length === 0) return { ok: true, added: 0 };
    if (
      group.memberIds.length + adding.length >
      MessagesService.maxGroupMembers
    ) {
      throw new BadRequestException(
        `A group can have at most ${MessagesService.maxGroupMembers} people.`,
      );
    }
    await this.existing(adding);
    for (const id of adding) {
      await this.messages.requireNoBlock(viewerId, id);
    }

    await this.prisma.conversationMember.createMany({
      data: adding.map((userId) => ({
        conversationId,
        userId,
        role: group.joinRole,
      })),
      skipDuplicates: true,
    });
    const actor = await this.person(viewerId);
    const users = await this.people(adding);
    await this.record(conversationId, viewerId, [
      { type: 'added', actor, users },
    ]);
    this.tellGroup(conversationId, group.memberIds);
    this.delivery.tellMany(
      adding,
      { type: 'conversation.updated', conversationId },
      {
        title: group.title,
        body: `${actor.name} added you to the group.`,
        data: { type: 'message', conversationId },
      },
    );
    return { ok: true, added: adding.length };
  }

  /**
   * Takes somebody out of a group -- or, when it is the reader, leaves.
   *
   * An owner who leaves hands the group to whoever has been in it longest,
   * admins first, so a group is never left with nobody to run it.
   */
  async remove(viewerId: string, conversationId: string, userId: string) {
    const group = await this.requireGroup(viewerId, conversationId);
    const actor = await this.person(viewerId);

    if (userId === viewerId) {
      await this.prisma.$transaction(async (tx) => {
        await tx.conversationMember.delete({
          where: { conversationId_userId: { conversationId, userId } },
        });
        if (group.me.role === MemberRole.OWNER) {
          const heir = await tx.conversationMember.findFirst({
            where: { conversationId },
            orderBy: [{ role: 'asc' }, { joinedAt: 'asc' }],
            select: { userId: true },
          });
          if (heir) {
            await tx.conversationMember.update({
              where: {
                conversationId_userId: { conversationId, userId: heir.userId },
              },
              data: { role: MemberRole.OWNER, handRaisedAt: null },
            });
          }
        }
      });
      await this.record(conversationId, viewerId, [{ type: 'left', actor }]);
      this.tellGroup(conversationId, group.memberIds);
      return { ok: true };
    }

    const target = group.members.find((m) => m.userId === userId);
    if (!target) throw new NotFoundException('They are not in this group.');
    this.requireAdmin(group.me.role);
    // An admin can take out members and spectators. Only the owner can take
    // out an admin, and nobody can take out the owner.
    if (
      target.role === MemberRole.OWNER ||
      (target.role === MemberRole.ADMIN && group.me.role !== MemberRole.OWNER)
    ) {
      throw new ForbiddenException(
        'Only the owner can remove an admin, and nobody can remove the owner.',
      );
    }
    await this.prisma.conversationMember.delete({
      where: { conversationId_userId: { conversationId, userId } },
    });
    await this.record(conversationId, viewerId, [
      { type: 'removed', actor, users: await this.people([userId]) },
    ]);
    // The person removed is told too, so the group goes from their list.
    this.tellGroup(conversationId, group.memberIds);
    return { ok: true };
  }

  /**
   * Changes what somebody may do in a group.
   *
   * The owner makes and unmakes admins, and can hand the group over by
   * making somebody else the owner. An admin moves people between member
   * and spectator -- which is how a raised hand is answered yes -- but not
   * to or from admin.
   */
  async setRole(
    viewerId: string,
    conversationId: string,
    userId: string,
    role: MemberRole,
  ) {
    const group = await this.requireGroup(viewerId, conversationId);
    if (userId === viewerId) {
      throw new BadRequestException('Somebody else has to change your role.');
    }
    const target = group.members.find((m) => m.userId === userId);
    if (!target) throw new NotFoundException('They are not in this group.');
    this.requireAdmin(group.me.role);
    const owner = group.me.role === MemberRole.OWNER;
    const ordinary = (r: MemberRole) =>
      r === MemberRole.MEMBER || r === MemberRole.SPECTATOR;
    if (!owner && (!ordinary(target.role) || !ordinary(role))) {
      throw new ForbiddenException(
        'Only the owner can make or unmake an admin.',
      );
    }

    await this.prisma.$transaction([
      this.prisma.conversationMember.update({
        where: { conversationId_userId: { conversationId, userId } },
        data: { role, handRaisedAt: null },
      }),
      // There is one owner. Handing it on makes the old one an admin.
      ...(role === MemberRole.OWNER
        ? [
            this.prisma.conversationMember.update({
              where: {
                conversationId_userId: { conversationId, userId: viewerId },
              },
              data: { role: MemberRole.ADMIN },
            }),
          ]
        : []),
    ]);
    const actor = await this.person(viewerId);
    await this.record(conversationId, viewerId, [
      { type: 'role', actor, users: await this.people([userId]), role },
    ]);
    this.tellGroup(conversationId, group.memberIds);
    return { ok: true };
  }

  /** A spectator asks to write. The admins are told. */
  async raiseHand(viewerId: string, conversationId: string) {
    const group = await this.requireGroup(viewerId, conversationId);
    if (group.me.role !== MemberRole.SPECTATOR) {
      throw new BadRequestException('You can already write in this group.');
    }
    if (group.me.handRaisedAt) return { ok: true };
    await this.prisma.conversationMember.update({
      where: { conversationId_userId: { conversationId, userId: viewerId } },
      data: { handRaisedAt: new Date() },
    });
    const actor = await this.person(viewerId);
    const admins = group.members
      .filter((m) => isAdmin(m.role))
      .map((m) => m.userId);
    this.delivery.tellMany(
      admins,
      { type: 'conversation.updated', conversationId },
      {
        title: group.title,
        body: `${actor.name} raised a hand to ask to write.`,
        data: { type: 'message', conversationId },
      },
    );
    this.delivery.tell(viewerId, {
      type: 'conversation.updated',
      conversationId,
    });
    return { ok: true };
  }

  /**
   * Puts a hand down: the spectator's own, or -- for an admin -- the answer
   * no to somebody else's.
   */
  async lowerHand(viewerId: string, conversationId: string, userId?: string) {
    const group = await this.requireGroup(viewerId, conversationId);
    const whose = userId ?? viewerId;
    if (whose !== viewerId) this.requireAdmin(group.me.role);
    await this.prisma.conversationMember.updateMany({
      where: { conversationId, userId: whose },
      data: { handRaisedAt: null },
    });
    const admins = group.members
      .filter((m) => isAdmin(m.role))
      .map((m) => m.userId);
    this.delivery.tellMany([...new Set([...admins, whose])], {
      type: 'conversation.updated',
      conversationId,
    });
    return { ok: true };
  }

  // ---- What every action needs ------------------------------------------

  /** The group, if [viewerId] is in it, with what each action checks. */
  private async requireGroup(viewerId: string, conversationId: string) {
    const conversation = await this.messages.requireMembership(
      viewerId,
      conversationId,
    );
    if (conversation.kind !== ConversationKind.GROUP) {
      throw new BadRequestException('That is not a group.');
    }
    const me = conversation.members.find((m) => m.userId === viewerId)!;
    return {
      title: conversation.title ?? 'Group',
      joinRole: conversation.joinRole,
      me,
      members: conversation.members,
      memberIds: conversation.members.map((m) => m.userId),
    };
  }

  private requireAdmin(role: MemberRole) {
    if (!isAdmin(role)) {
      throw new ForbiddenException('Only the group’s admins can do that.');
    }
  }

  /** A group's name, trimmed, and refused when empty or too long. */
  static title(raw: string): string {
    const name = (raw ?? '').trim().replace(/\s+/g, ' ');
    if (!name) throw new BadRequestException('A group needs a name.');
    if (name.length > GroupsService.maxTitle) {
      throw new BadRequestException(
        `A group's name can be at most ${GroupsService.maxTitle} characters.`,
      );
    }
    return name;
  }

  /** What people can be added as: writing, or watching. Never an admin. */
  static joinable(role: MemberRole) {
    if (role !== MemberRole.MEMBER && role !== MemberRole.SPECTATOR) {
      throw new BadRequestException(
        'People join a group as members or as spectators.',
      );
    }
  }

  /** The accounts, all of them, or a refusal: nobody is added by mistake. */
  private async existing(ids: string[]) {
    const found = await this.prisma.user.findMany({
      where: { id: { in: ids }, deletedAt: null },
      select: { id: true },
    });
    if (found.length !== ids.length) {
      throw new NotFoundException('One of those accounts no longer exists.');
    }
    return found;
  }

  private async person(id: string): Promise<EventPerson> {
    return (await this.people([id]))[0] ?? { id, name: 'Someone' };
  }

  /** People as an event line names them: their name as it is now. */
  private async people(ids: string[]): Promise<EventPerson[]> {
    const rows = await this.prisma.user.findMany({
      where: { id: { in: ids } },
      select: { id: true, name: true, username: true },
    });
    const byId = new Map(rows.map((r) => [r.id, r]));
    return ids.map((id) => {
      const row = byId.get(id);
      return {
        id,
        name: row?.name?.trim() || row?.username?.trim() || 'Someone',
      };
    });
  }

  /** Writes event lines into a group, and moves it up everybody's list. */
  private async record(
    conversationId: string,
    actorId: string,
    events: GroupEvent[],
  ) {
    const now = new Date();
    await this.prisma.$transaction([
      ...events.map((event) =>
        this.prisma.message.create({
          data: {
            conversationId,
            senderId: actorId,
            body: '',
            event: event as unknown as Prisma.InputJsonValue,
          },
        }),
      ),
      this.prisma.conversation.update({
        where: { id: conversationId },
        data: { lastMessageAt: now },
      }),
    ]);
  }

  /** Tells everybody who was in it that the group changed. No push. */
  private tellGroup(conversationId: string, memberIds: string[]) {
    this.delivery.tellMany(memberIds, {
      type: 'conversation.updated',
      conversationId,
    });
  }
}
