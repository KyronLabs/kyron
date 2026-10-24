import { BadRequestException } from '@nestjs/common';
import type { PrismaService } from '../../infrastructure/prisma/prisma.service';

/**
 * How many chats one reader can keep at the top of Messages, conversations
 * and community chats together.
 *
 * Few on purpose: a pin is for the handful somebody opens every day. Pin
 * everything and nothing is at the top any more.
 */
export const MAX_PINNED = 5;

/**
 * Refuses a new pin past [MAX_PINNED]. Counts both kinds, since they share
 * one list.
 *
 * Two pins sent at the same moment can both pass and leave one over the
 * limit. Nothing breaks if they do: the list shows six pins until one is
 * taken off.
 */
export async function assertRoomForPin(
  prisma: PrismaService,
  userId: string,
): Promise<void> {
  const [conversations, chats] = await Promise.all([
    prisma.conversationMember.count({
      where: { userId, pinnedAt: { not: null } },
    }),
    prisma.communityChatMember.count({
      where: { userId, pinnedAt: { not: null } },
    }),
  ]);
  if (conversations + chats >= MAX_PINNED) {
    throw new BadRequestException(
      `You can pin up to ${MAX_PINNED} chats. Unpin one first.`,
    );
  }
}
