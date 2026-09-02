import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { getJwtSecret } from '../../config/jwt-secret';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { EmailService } from '../../infrastructure/email/email.service';
import { UsersModule } from '../users/users.module';
import { SupabaseModule } from '../../infrastructure/supabase/supabase.module';

@Module({
  imports: [
    UsersModule,
    SupabaseModule,
    JwtModule.register({
      secret: getJwtSecret(),
      signOptions: {
        expiresIn: Number(process.env.JWT_EXPIRES_SECONDS || 900),
      },
    }),
  ],
  controllers: [AuthController],
  // PrismaService comes from the @Global() PrismaModule. Re-providing it here
  // built a second PrismaClient with its own connection pool.
  providers: [AuthService, EmailService],
  exports: [AuthService],
})
export class AuthModule {}
