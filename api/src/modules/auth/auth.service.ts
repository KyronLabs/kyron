/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */

/* eslint-disable @typescript-eslint/no-unsafe-call */
import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
  Logger,
} from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import * as crypto from 'crypto';
import { EmailService } from '../../infrastructure/email/email.service';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    private readonly users: UsersService,
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly emailService: EmailService,
  ) {}

  private generateCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  // ---------------------------
  // REGISTER
  // ---------------------------
  async register(payload: {
    email: string;
    password: string;
    username?: string;
  }) {
    const { email, password, username } = payload;

    const existing = await this.users.findByEmail(email);
    if (existing) {
      throw new BadRequestException('Email already exists');
    }

    const hashed = await argon2.hash(password);

    const user = await this.prisma.user.create({
      data: {
        email,
        password: hashed,
        name: username,
      },
    });

    const code = this.generateCode();

    await this.prisma.emailVerification.create({
      data: {
        userId: user.id,
        code,
        expiresAt: new Date(Date.now() + 10 * 60 * 1000),
      },
    });

    await this.emailService.sendVerifyCode(email, code);

    return { message: 'Verification email sent', tempUserId: user.id };
  }

  // ---------------------------
  // VERIFY EMAIL
  // ---------------------------
  async verifyEmail(userId: string, code: string) {
    const rec = await this.prisma.emailVerification.findUnique({
      where: { userId },
    });

    if (!rec) throw new BadRequestException('Invalid code');
    if (rec.expiresAt < new Date())
      throw new BadRequestException('Code expired');
    if (rec.code !== code) throw new BadRequestException('Invalid code');

    await this.prisma.user.update({
      where: { id: userId },
      data: { emailVerifiedAt: new Date() },
    });

    await this.prisma.emailVerification.delete({ where: { userId } });

    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    return this.issueTokensForUser(user);
  }

  // ---------------------------
  // LOGIN
  // ---------------------------
  async validatePassword(email: string, pass: string) {
    const user = await this.users.findByEmail(email);
    if (!user) return null;

    const ok = await argon2.verify(user.password, pass);
    return ok ? user : null;
  }

  async loginWithTokens(email: string, password: string) {
    const user = await this.validatePassword(email, password);
    if (!user) throw new UnauthorizedException('Invalid credentials');
    if (!user.emailVerifiedAt)
      throw new UnauthorizedException('Email not verified');

    return this.issueTokensForUser(user);
  }

  // ---------------------------
  // ISSUE TOKENS
  // ---------------------------
  private async issueTokensForUser(user: any) {
    const expiresIn = Number(process.env.JWT_EXPIRES_SECONDS || 900);

    const payload = { sub: user.id, role: user.role };
    const accessToken = this.jwt.sign(payload, {
      secret: process.env.JWT_SECRET,
      expiresIn,
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

    return {
      accessToken,
      refreshToken,
      expiresIn,
      user: {
        id: user.id,
        email: user.email,
        username: user.name,
      },
    };
  }

  // ---------------------------
  // REFRESH TOKEN
  // ---------------------------
  async refreshTokens(refreshToken: string) {
    const rec = await this.prisma.refreshToken.findUnique({
      where: { token: refreshToken },
      include: { user: true },
    });

    if (!rec) throw new UnauthorizedException('Invalid refresh token');
    if (rec.expiresAt < new Date()) {
      await this.prisma.refreshToken.delete({ where: { id: rec.id } });
      throw new UnauthorizedException('Refresh token expired');
    }

    await this.prisma.refreshToken.delete({ where: { id: rec.id } });

    return this.issueTokensForUser(rec.user);
  }

  // ---------------------------
  // LOGOUT
  // ---------------------------
  async logout(refreshToken: string) {
    await this.prisma.refreshToken.deleteMany({
      where: { token: refreshToken },
    });
    return { ok: true };
  }

  // ---------------------------
  // FORGOT PASSWORD
  // ---------------------------
  async forgotPassword(email: string) {
    const user = await this.users.findByEmail(email);
    if (!user) return { ok: true };

    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 3600000);

    await this.prisma.passwordReset.upsert({
      where: { userId: user.id },
      update: { token, expiresAt },
      create: { userId: user.id, token, expiresAt },
    });

    await this.emailService.sendPasswordReset(email, token);

    return { ok: true };
  }

  // ---------------------------
  // RESET PASSWORD
  // ---------------------------
  async resetPassword(token: string, newPassword: string) {
    const rec = await this.prisma.passwordReset.findUnique({
      where: { token },
    });
    if (!rec || rec.expiresAt < new Date())
      throw new BadRequestException('Invalid or expired token');

    const hashed = await argon2.hash(newPassword);
    await this.prisma.user.update({
      where: { id: rec.userId },
      data: { password: hashed },
    });

    await this.prisma.passwordReset.delete({ where: { id: rec.id } });

    return { ok: true };
  }
}
