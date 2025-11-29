import { Module } from '@nestjs/common';
import { ProfileController } from './profile.controller';
import { ProfileService } from './profile.service';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

@Module({
  controllers: [ProfileController],
  providers: [ProfileService, PrismaService, SupabaseService],
})
export class ProfileModule {}
