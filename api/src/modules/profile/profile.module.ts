// src/modules/profile/profile.module.ts
import { Module } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { ProfileController } from './profile.controller';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

@Module({
  controllers: [ProfileController],
  providers: [ProfileService, SupabaseService, PrismaService],
  exports: [ProfileService],
})
export class ProfileModule {}
