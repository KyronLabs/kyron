/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-call */
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('🚀 Seeding Kyron initial data...');

  await new Promise((resolve) => setTimeout(resolve, 1500));

  // ------------------------------------------
  // 1. ADMIN ACCOUNT
  // ------------------------------------------

  const adminEmail = 'admin@kyron.app';

  const existingAdmin = await prisma.user.findUnique({
    where: { email: adminEmail },
  });

  if (!existingAdmin) {
    const hashed = await bcrypt.hash('Admin123!', 10);

    await prisma.user.create({
      data: {
        email: adminEmail,
        password: hashed,
        role: 'ADMIN',
        name: 'Kyron Administrator',
        emailStatus: 'VERIFIED',
      },
    });

    console.log('✔ Admin user created');
  } else {
    console.log('✔ Admin user already exists');
  }

  // ------------------------------------------
  // 2. SYSTEM MODULES
  // ------------------------------------------

  const modules = [
    { key: 'AUTH', name: 'Authentication', enabled: true },
    { key: 'USER_MANAGEMENT', name: 'User Management', enabled: true },
    { key: 'NOTIFICATIONS', name: 'Notifications', enabled: false },
    { key: 'ANALYTICS', name: 'Analytics Suite', enabled: false },
    { key: 'PAYMENTS', name: 'Payments', enabled: false },
    { key: 'MESSAGING', name: 'Messaging System', enabled: false },
  ];

  for (const mod of modules) {
    await prisma.systemModule.upsert({
      where: { key: mod.key },
      update: {},
      create: mod,
    });
  }

  console.log('✔ System modules synced');

  // ------------------------------------------
  // 3. GLOBAL APP SETTINGS
  // ------------------------------------------

  const settings = [
    { key: 'APP_NAME', value: 'Kyron' },
    { key: 'APP_STATUS', value: 'OPERATIONAL' },
    { key: 'ALLOW_REGISTRATION', value: 'true' },
    { key: 'MAINTENANCE_MODE', value: 'false' },
  ];

  for (const s of settings) {
    await prisma.appSetting.upsert({
      where: { key: s.key },
      update: {},
      create: s,
    });
  }

  console.log('✔ App settings synced');

  // ------------------------------------------
  // 4. INTEREST SEED
  // ------------------------------------------

  const interests = [
    { slug: 'tech', name: 'Technology' },
    { slug: 'music', name: 'Music' },
    { slug: 'sports', name: 'Sports' },
    { slug: 'gaming', name: 'Gaming' },
    { slug: 'movies', name: 'Movies & TV' },
    { slug: 'business', name: 'Business' },
    { slug: 'finance', name: 'Finance' },
    { slug: 'science', name: 'Science' },
    { slug: 'ai', name: 'Artificial Intelligence' },
    { slug: 'crypto', name: 'Crypto & Web3' },
    { slug: 'art', name: 'Art & Design' },
    { slug: 'fashion', name: 'Fashion & Style' },
    { slug: 'food', name: 'Food & Cooking' },
    { slug: 'travel', name: 'Travel' },
    { slug: 'health', name: 'Health & Fitness' },
  ];

  for (const item of interests) {
    await prisma.interest.upsert({
      where: { slug: item.slug },
      update: {},
      create: item,
    });
  }

  console.log('✔ Interests seeded');

  console.log('🎉 Kyron initial seed complete!');
}

main()
  .catch((err) => {
    console.error('❌ Seed error:', err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
