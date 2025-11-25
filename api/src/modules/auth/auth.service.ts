/* eslint-disable @typescript-eslint/no-redundant-type-constituents */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
  Logger,
  InternalServerErrorException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';
import * as crypto from 'crypto';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { EmailService } from '../../infrastructure/email/email.service';
import { User, UserRole, AccountStatus, EmailStatus } from '@prisma/client';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly emailService: EmailService,
  ) {}

  private generateCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  private isError(error: unknown): error is Error {
    return error instanceof Error;
  }

  private isPrismaError(
    error: unknown,
  ): error is PrismaClientKnownRequestError {
    return error instanceof PrismaClientKnownRequestError;
  }

  // ---------------------------
  // REGISTER
  // ---------------------------
  async register(payload: {
    email: string;
    password: string;
    username?: string;
  }) {
    try {
      const { email, password, username } = payload;

      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        throw new BadRequestException('Invalid email format');
      }

      const existingEmail = await this.prisma.user.findUnique({
        where: { email },
      });
      if (existingEmail) {
        throw new BadRequestException('Email already registered');
      }

      if (username) {
        const existingUsername = await this.prisma.user.findUnique({
          where: { username },
        });
        if (existingUsername) {
          throw new BadRequestException('Username already taken');
        }

        const usernameRegex = /^[a-z0-9_]+$/;
        if (!usernameRegex.test(username)) {
          throw new BadRequestException(
            'Username must be lowercase letters, numbers, and underscores only',
          );
        }
      }

      const hashed = await argon2.hash(password, {
        type: argon2.argon2id,
        memoryCost: 2 ** 16,
        timeCost: 3,
      });

      const user = await this.prisma.user.create({
        data: {
          email,
          password: hashed,
          username,
          role: UserRole.USER,
          status: AccountStatus.ACTIVE,
          emailStatus: EmailStatus.PENDING,
        },
      });

      const code = this.generateCode();
      await this.prisma.emailVerification.create({
        data: {
          userId: user.id,
          code,
          expiresAt: new Date(Date.now() + 10 * 60 * 1000),
          attempts: 0,
        },
      });

      await this.emailService.sendVerifyCode(email, code);

      this.logger.log(`User registered: ${user.id}`);

      return {
        message: 'Verification email sent',
        tempUserId: user.id,
        email: user.email,
      };
    } catch (error) {
      if (error instanceof BadRequestException) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Registration failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException(
        'Registration failed. Please try again.',
      );
    }
  }

  // ---------------------------
  // VERIFY EMAIL
  // ---------------------------
  async verifyEmail(userId: string, code: string) {
    try {
      const rec = await this.prisma.emailVerification.findUnique({
        where: { userId },
      });

      if (!rec) {
        throw new BadRequestException('Invalid verification code');
      }
      if (rec.expiresAt < new Date()) {
        throw new BadRequestException('Verification code expired');
      }
      if (rec.code !== code) {
        await this.prisma.emailVerification.update({
          where: { userId },
          data: {
            attempts: { increment: 1 },
          },
        });
        throw new BadRequestException('Invalid verification code');
      }

      await this.prisma.user.update({
        where: { id: userId },
        data: {
          emailVerifiedAt: new Date(),
          emailStatus: EmailStatus.VERIFIED,
        },
      });

      await this.prisma.emailVerification.delete({ where: { userId } });

      const user = await this.prisma.user.findUnique({
        where: { id: userId },
        include: { profile: true },
      });

      if (!user) {
        throw new InternalServerErrorException(
          'User not found after verification',
        );
      }

      this.logger.log(`Email verified for user: ${userId}`);

      return this.issueTokensForUser(user);
    } catch (error) {
      if (error instanceof BadRequestException) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Email verification failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException(
        'Verification failed. Please try again.',
      );
    }
  }

  // ---------------------------
  // LOGIN
  // ---------------------------
  async validatePassword(email: string, pass: string): Promise<User | null> {
    try {
      const user = await this.prisma.user.findUnique({
        where: { email },
      });

      if (!user) return null;

      if (user.status === AccountStatus.SUSPENDED) {
        throw new UnauthorizedException('Account is suspended');
      }
      if (user.status === AccountStatus.DELETED) {
        throw new UnauthorizedException('Account not found');
      }

      if (user.lockedUntil && user.lockedUntil > new Date()) {
        const remaining = Math.ceil(
          (user.lockedUntil.getTime() - Date.now()) / 60000,
        );
        throw new BadRequestException(
          `Account is locked. Try again in ${remaining} minutes`,
        );
      }

      const ok = await argon2.verify(user.password, pass);
      if (!ok) {
        await this.prisma.user.update({
          where: { id: user.id },
          data: {
            failedLoginAttempts: { increment: 1 },
            lockedUntil:
              user.failedLoginAttempts >= 4
                ? new Date(Date.now() + 15 * 60 * 1000)
                : null,
          },
        });
        return null;
      }

      await this.prisma.user.update({
        where: { id: user.id },
        data: {
          failedLoginAttempts: 0,
          lockedUntil: null,
          lastLoginAt: new Date(),
        },
      });

      return user;
    } catch (error) {
      if (
        error instanceof UnauthorizedException ||
        error instanceof BadRequestException
      ) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Password validation failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw error;
    }
  }

  async loginWithTokens(email: string, password: string) {
    try {
      const user = await this.validatePassword(email, password);
      if (!user) {
        throw new UnauthorizedException('Invalid email or password');
      }

      if (!user.emailVerifiedAt) {
        throw new UnauthorizedException(
          'Email not verified. Please check your inbox',
        );
      }

      this.logger.log(`User logged in: ${user.id}`);

      return this.issueTokensForUser(user);
    } catch (error) {
      if (
        error instanceof UnauthorizedException ||
        error instanceof BadRequestException
      ) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Login failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException('Login failed. Please try again.');
    }
  }

  // ---------------------------
  // ISSUE TOKENS
  // ---------------------------
  private async issueTokensForUser(user: User) {
    try {
      const expiresIn = Number(process.env.JWT_EXPIRES_SECONDS || 900);

      const payload = { sub: user.id, role: user.role };
      const accessToken = this.jwt.sign(payload, {
        secret: process.env.JWT_SECRET,
        expiresIn: `${expiresIn}s`,
      });

      const refreshToken = crypto.randomBytes(64).toString('hex');
      const refreshExpiry = new Date(
        Date.now() +
          Number(process.env.REFRESH_TOKEN_EXPIRES_DAYS || 7) * 86400000,
      );

      await this.prisma.refreshToken.create({
        data: {
          userId: user.id,
          token: refreshToken,
          expiresAt: refreshExpiry,
        },
      });

      this.logger.log(`Tokens issued for user: ${user.id}`);

      return {
        accessToken,
        refreshToken,
        expiresIn,
        user: {
          id: user.id,
          email: user.email,
          username: user.username,
          name: user.name,
          role: user.role,
        },
      };
    } catch (error) {
      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Token issuance failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException('Failed to generate tokens');
    }
  }

  // ---------------------------
  // REFRESH TOKENS
  // ---------------------------
  async refreshTokens(refreshToken: string) {
    try {
      const rec = await this.prisma.refreshToken.findUnique({
        where: { token: refreshToken },
        include: { user: true },
      });

      if (!rec) {
        throw new UnauthorizedException('Invalid refresh token');
      }
      if (rec.expiresAt < new Date()) {
        await this.prisma.refreshToken.delete({ where: { id: rec.id } });
        throw new UnauthorizedException('Refresh token expired');
      }

      if (rec.user.status !== AccountStatus.ACTIVE) {
        throw new UnauthorizedException('User account is not active');
      }

      await this.prisma.refreshToken.delete({ where: { id: rec.id } });

      this.logger.log(`Token refreshed for user: ${rec.userId}`);

      return this.issueTokensForUser(rec.user);
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Token refresh failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException('Token refresh failed');
    }
  }

  // ---------------------------
  // LOGOUT
  // ---------------------------
  async logout(refreshToken: string) {
    try {
      await this.prisma.refreshToken.deleteMany({
        where: { token: refreshToken },
      });
      this.logger.log('User logged out successfully');
      return { ok: true };
    } catch (error) {
      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Logout failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException('Logout failed');
    }
  }

  // ---------------------------
  // FORGOT PASSWORD
  // ---------------------------
  async forgotPassword(email: string) {
    try {
      const user = await this.prisma.user.findUnique({
        where: { email },
      });

      if (!user) {
        this.logger.log(
          `Password reset requested for non-existent email: ${email}`,
        );
        return {
          ok: true,
          message: 'If an account exists, a reset link has been sent',
        };
      }

      if (user.status !== AccountStatus.ACTIVE) {
        throw new BadRequestException('Account is not active');
      }

      const token = crypto.randomBytes(32).toString('hex');
      const expiresAt = new Date(Date.now() + 3600000);

      await this.prisma.passwordReset.upsert({
        where: { userId: user.id },
        update: { token, expiresAt },
        create: { userId: user.id, token, expiresAt },
      });

      await this.emailService.sendPasswordReset(email, token);

      this.logger.log(`Password reset email sent to: ${email}`);

      return {
        ok: true,
        message: 'If an account exists, a reset link has been sent',
      };
    } catch (error) {
      if (error instanceof BadRequestException) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Forgot password failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException(
        'Failed to process password reset',
      );
    }
  }

  // ---------------------------
  // RESET PASSWORD
  // ---------------------------
  async resetPassword(token: string, newPassword: string) {
    try {
      const rec = await this.prisma.passwordReset.findUnique({
        where: { token },
        include: { user: true },
      });

      if (!rec || rec.expiresAt < new Date()) {
        throw new BadRequestException('Invalid or expired reset token');
      }

      if (rec.user.status !== AccountStatus.ACTIVE) {
        throw new BadRequestException('Account is not active');
      }

      const hashed = await argon2.hash(newPassword, {
        type: argon2.argon2id,
        memoryCost: 2 ** 16,
        timeCost: 3,
      });

      await this.prisma.user.update({
        where: { id: rec.userId },
        data: { password: hashed },
      });

      await this.prisma.passwordReset.delete({ where: { id: rec.id } });

      await this.prisma.refreshToken.deleteMany({
        where: { userId: rec.userId },
      });

      this.logger.log(`Password reset successful for user: ${rec.userId}`);

      return { ok: true, message: 'Password reset successfully' };
    } catch (error) {
      if (error instanceof BadRequestException) {
        throw error;
      }

      const errorMessage = this.isError(error) ? error.message : String(error);
      this.logger.error(
        `Password reset failed: ${errorMessage}`,
        this.isError(error) ? error.stack : undefined,
      );

      throw new InternalServerErrorException('Failed to reset password');
    }
  }
}
