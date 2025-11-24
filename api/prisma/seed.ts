import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('🚀 Seeding Kyron initial data...');

  // Give DB a moment to settle (even after healthcheck)
  await new Promise((resolve) => setTimeout(resolve, 2000));

  // ------------------------------------------
  // 1. Create admin user
  // ------------------------------------------
  const adminEmail = 'admin@kyron.app';
  try {
    const existingAdmin = await prisma.user.findUnique({
      where: { email: adminEmail },
    });

    if (!existingAdmin) {
      const hashedPassword = await bcrypt.hash('Admin123!', 10);
      await prisma.user.create({
        data: {
          email: adminEmail,
          password: hashedPassword,
          name: 'Kyron Administrator',
          role: 'ADMIN',
        },
      });
      console.log('✔ Admin user created');
    } else {
      console.log('✔ Admin user already exists');
    }
  } catch (error) {
    console.error('❌ Error with admin user:', error);
    throw error;
  }

  // ------------------------------------------
  // 2. Create baseline system modules
  // ------------------------------------------
  const modules = [
    { key: 'AUTH', name: 'Authentication Module', enabled: true },
    { key: 'USER_MANAGEMENT', name: 'User Management', enabled: true },
    { key: 'NOTIFICATIONS', name: 'Notifications Module', enabled: false },
    { key: 'ANALYTICS', name: 'Analytics Suite', enabled: false },
    { key: 'PAYMENTS', name: 'Payment Processing', enabled: false },
    { key: 'MESSAGING', name: 'Messaging Module', enabled: false },
  ];

  for (const mod of modules) {
    const exists = await prisma.systemModule.findUnique({
      where: { key: mod.key },
    });

    if (!exists) {
      await prisma.systemModule.create({ data: mod });
      console.log(`✔ Module created: ${mod.key}`);
    } else {
      console.log(`✔ Module exists: ${mod.key}`);
    }
  }

  // ------------------------------------------
  // 3. Create future-proof app settings
  // ------------------------------------------
  const settings = [
    { key: 'APP_NAME', value: 'Kyron' },
    { key: 'APP_STATUS', value: 'OPERATIONAL' },
    { key: 'ALLOW_REGISTRATION', value: 'true' },
    { key: 'MAINTENANCE_MODE', value: 'false' },
  ];

  for (const setting of settings) {
    const exists = await prisma.appSetting.findUnique({
      where: { key: setting.key },
    });

    if (!exists) {
      await prisma.appSetting.create({ data: setting });
      console.log(`✔ Setting created: ${setting.key}`);
    } else {
      console.log(`✔ Setting exists: ${setting.key}`);
    }
  }

  console.log('🎉 Kyron seed complete!');
}

main()
  .catch((e) => {
    console.error('❌ Seed failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
