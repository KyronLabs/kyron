// src/infrastructure/scripts/set-role.ts
//
// Puts somebody on the moderation team, or takes them off it. There is no
// route for this on purpose: who can ban people is decided by whoever holds
// the database credentials, never by a request.
//
//   npm run account:role -- someone@example.com MODERATOR
//   npm run account:role -- @handle ADMIN
//   npm run account:role -- 8039e182-78d0-49c6-89bb-8d0009b8fee2 USER
//
// ADMIN can act on anybody but themselves, including the rest of the team,
// and can hear an appeal against their own decision when there is nobody
// else. MODERATOR works the queues. USER is everybody else. Needs
// DATABASE_URL. Recorded in AuditLog.

import { UserRole } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const ROLES = Object.values(UserRole) as string[];

async function main(): Promise<number> {
  const who = process.argv[2]?.trim();
  const role = process.argv[3]?.trim().toUpperCase();
  if (!who || !role || !ROLES.includes(role)) {
    console.error(
      `Usage: npm run account:role -- <email, @handle or id> <${ROLES.join('|')}>`,
    );
    return 2;
  }

  const prisma = new PrismaService();
  try {
    const user = await prisma.user.findFirst({
      where: UUID.test(who)
        ? { id: who }
        : who.startsWith('@')
          ? { username: { equals: who.slice(1), mode: 'insensitive' } }
          : { email: { equals: who, mode: 'insensitive' } },
      select: { id: true, email: true, username: true, role: true },
    });
    if (!user) {
      console.error(`No account for ${who}.`);
      return 1;
    }
    if (user.role === role) {
      console.log(`${user.id} is already ${role}.`);
      return 0;
    }

    await prisma.$transaction([
      prisma.user.update({
        where: { id: user.id },
        data: { role: role as UserRole },
      }),
      prisma.auditLog.create({
        data: {
          userId: user.id,
          action: 'role.changed',
          details: { from: user.role, to: role, by: 'set-role script' },
        },
      }),
    ]);
    console.log(
      `${user.id} (${user.email}, @${user.username ?? '-'}): ${user.role} -> ${role}`,
    );
    return 0;
  } finally {
    await prisma.$disconnect();
  }
}

main().then(
  (code) => process.exit(code),
  (error: unknown) => {
    console.error(error);
    process.exit(1);
  },
);
