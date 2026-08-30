// scripts/sync-profiles-bidirectional.ts
// Ensures all users have profiles in BOTH Prisma AND Supabase

import { PrismaClient } from '@prisma/client';
import { createClient } from '@supabase/supabase-js';

/** Columns this script reads back from the untyped supabase-js client. */
interface SupabaseProfile {
  user_id: string;
  avatar_url?: string | null;
  cover_url?: string | null;
  bio?: string | null;
}

const prisma = new PrismaClient();

async function syncProfiles() {
  console.log('🔄 Starting bidirectional profile sync...\n');

  const supabase = createClient(
    process.env.SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
  );

  try {
    // ========================================
    // STEP 1: Get all users from Prisma
    // ========================================
    const allUsers = await prisma.user.findMany({
      include: {
        profile: true,
      },
    });

    console.log(`📊 Found ${allUsers.length} users in Prisma\n`);

    let prismaCreated = 0;
    let supabaseCreated = 0;
    let supabaseSynced = 0;
    let errors = 0;

    for (const user of allUsers) {
      try {
        console.log(`\n👤 Processing: ${user.email} (${user.id})`);

        // ========================================
        // Create Prisma profile if missing
        // ========================================
        if (!user.profile) {
          console.log('   ⚠️  Missing Prisma profile, creating...');

          await prisma.userProfile.create({
            data: {
              userId: user.id,
            },
          });

          prismaCreated++;
          console.log('   ✅ Prisma profile created');
        } else {
          console.log('   ✅ Prisma profile exists');
        }

        // ========================================
        // Check/Create Supabase profile
        // ========================================
        const { data: supabaseProfile } = (await supabase
          .from('user_profiles')
          .select('*')
          .eq('user_id', user.id)
          .maybeSingle()) as { data: SupabaseProfile | null };

        if (!supabaseProfile) {
          console.log('   ⚠️  Missing Supabase profile, creating...');

          // Get the latest Prisma profile data
          const latestProfile =
            user.profile ||
            (await prisma.userProfile.findUnique({
              where: { userId: user.id },
            }));

          const { error } = await supabase.from('user_profiles').insert({
            user_id: user.id,
            avatar_url: latestProfile?.avatarUrl || null,
            cover_url: latestProfile?.coverUrl || null,
            bio: latestProfile?.bio || null,
            location: latestProfile?.location || null,
            website: latestProfile?.website || null,
            display_name: user.name || user.username || null,
            created_at: user.createdAt.toISOString(),
            updated_at: new Date().toISOString(),
          });

          if (error) {
            console.error('   ❌ Supabase creation failed:', error.message);
            errors++;
          } else {
            supabaseCreated++;
            console.log('   ✅ Supabase profile created');
          }
        } else {
          // Profile exists, check if we need to sync data from Prisma
          const latestProfile =
            user.profile ||
            (await prisma.userProfile.findUnique({
              where: { userId: user.id },
            }));

          if (latestProfile) {
            const needsUpdate =
              supabaseProfile.avatar_url !== latestProfile.avatarUrl ||
              supabaseProfile.cover_url !== latestProfile.coverUrl ||
              supabaseProfile.bio !== latestProfile.bio;

            if (needsUpdate) {
              console.log('   🔄 Syncing Prisma data to Supabase...');

              const { error } = await supabase
                .from('user_profiles')
                .update({
                  avatar_url: latestProfile.avatarUrl,
                  cover_url: latestProfile.coverUrl,
                  bio: latestProfile.bio,
                  location: latestProfile.location,
                  website: latestProfile.website,
                  updated_at: new Date().toISOString(),
                })
                .eq('user_id', user.id);

              if (error) {
                console.error('   ❌ Supabase sync failed:', error.message);
                errors++;
              } else {
                supabaseSynced++;
                console.log('   ✅ Supabase profile synced');
              }
            } else {
              console.log('   ✅ Supabase profile up-to-date');
            }
          }
        }
      } catch (err) {
        console.error(`   ❌ Error processing user ${user.id}:`, err);
        errors++;
      }
    }

    // ========================================
    // STEP 2: Check for orphaned Supabase profiles
    // ========================================
    console.log('\n\n🔍 Checking for orphaned Supabase profiles...');

    const { data: allSupabaseProfiles } = (await supabase
      .from('user_profiles')
      .select('user_id')) as {
      data: Pick<SupabaseProfile, 'user_id'>[] | null;
    };

    let orphanedCount = 0;

    if (allSupabaseProfiles) {
      for (const sp of allSupabaseProfiles) {
        const userExists = await prisma.user.findUnique({
          where: { id: sp.user_id },
        });

        if (!userExists) {
          orphanedCount++;
          console.log(
            `⚠️  Orphaned profile: ${sp.user_id} (user doesn't exist in Prisma)`,
          );
        }
      }
    }

    // ========================================
    // Summary
    // ========================================
    console.log('\n' + '='.repeat(60));
    console.log('📊 SYNC SUMMARY');
    console.log('='.repeat(60));
    console.log(`Total Users:              ${allUsers.length}`);
    console.log(`Prisma Profiles Created:  ${prismaCreated}`);
    console.log(`Supabase Profiles Created: ${supabaseCreated}`);
    console.log(`Supabase Profiles Synced:  ${supabaseSynced}`);
    console.log(`Orphaned Supabase Profiles: ${orphanedCount}`);
    console.log(`Errors:                    ${errors}`);
    console.log('='.repeat(60));

    if (errors === 0) {
      console.log('\n✨ All profiles synced successfully!');
    } else {
      console.log('\n⚠️  Some errors occurred, check logs above');
    }
  } catch (error) {
    console.error('❌ Fatal error during sync:', error);
    throw error;
  } finally {
    await prisma.$disconnect();
  }
}

// Run the sync
syncProfiles()
  .then(() => {
    console.log('\n🎉 Sync complete!');
    process.exit(0);
  })
  .catch((error) => {
    console.error('💥 Sync failed:', error);
    process.exit(1);
  });
