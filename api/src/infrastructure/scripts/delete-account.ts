// src/infrastructure/scripts/delete-account.ts
//
// Deletes an account for somebody who asked without the app -- by email, as
// the deletion page on the terms-and-privacy site tells them to. Exactly what
// Settings -> Delete account does, through the same service:
//
//   npm run account:delete -- someone@example.com
//   npm run account:delete -- 8039e182-78d0-49c6-89bb-8d0009b8fee2
//
// Needs DATABASE_URL, SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY, as the API
// does. Check the request came from the address on the account before running
// it: there is no undo.

import { AccountStatus } from '@prisma/client';
import { AccountService } from '../../modules/account/account.service';
import { PrismaService } from '../prisma/prisma.service';
import { SupabaseService } from '../supabase/supabase.service';

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

async function main(): Promise<number> {
  const who = process.argv[2]?.trim();
  if (!who) {
    console.error('Usage: npm run account:delete -- <email or account id>');
    return 2;
  }

  const prisma = new PrismaService();
  try {
    const user = await prisma.user.findFirst({
      where: UUID.test(who)
        ? { id: who }
        : { email: { equals: who, mode: 'insensitive' } },
      select: { id: true, email: true, username: true, status: true },
    });
    if (!user) {
      console.error(`No account for ${who}.`);
      return 1;
    }
    if (user.status === AccountStatus.DELETED) {
      console.log(`${user.id} is already deleted.`);
      return 0;
    }

    console.log(
      `Deleting ${user.id} (${user.email}, @${user.username ?? '-'})`,
    );
    await new AccountService(prisma, new SupabaseService()).deleteAccount(
      user.id,
    );
    console.log('Deleted.');
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
