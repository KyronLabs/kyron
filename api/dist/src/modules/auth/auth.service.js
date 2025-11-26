"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var AuthService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
/* eslint-disable @typescript-eslint/no-unsafe-argument */
/* eslint-disable @typescript-eslint/no-redundant-type-constituents */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
const common_1 = require("@nestjs/common");
const jwt_1 = require("@nestjs/jwt");
const argon2 = __importStar(require("argon2"));
const crypto = __importStar(require("crypto"));
const prisma_service_1 = require("../../infrastructure/prisma/prisma.service");
const email_service_1 = require("../../infrastructure/email/email.service");
const client_1 = require("@prisma/client");
const library_1 = require("@prisma/client/runtime/library");
let AuthService = AuthService_1 = class AuthService {
    constructor(prisma, jwt, emailService) {
        this.prisma = prisma;
        this.jwt = jwt;
        this.emailService = emailService;
        this.logger = new common_1.Logger(AuthService_1.name);
    }
    generateCode() {
        return Math.floor(100000 + Math.random() * 900000).toString();
    }
    isError(error) {
        return error instanceof Error;
    }
    isPrismaError(error) {
        return error instanceof library_1.PrismaClientKnownRequestError;
    }
    // ---------------------------
    // REGISTER
    // ---------------------------
    async register(payload) {
        try {
            const { email, password, username } = payload;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                throw new common_1.BadRequestException('Invalid email format');
            }
            const existingEmail = await this.prisma.user.findUnique({
                where: { email },
            });
            if (existingEmail) {
                throw new common_1.BadRequestException('Email already registered');
            }
            if (username) {
                const existingUsername = await this.prisma.user.findUnique({
                    where: { username },
                });
                if (existingUsername) {
                    throw new common_1.BadRequestException('Username already taken');
                }
                const usernameRegex = /^[a-z0-9_]+$/;
                if (!usernameRegex.test(username)) {
                    throw new common_1.BadRequestException('Username must be lowercase letters, numbers, and underscores only');
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
                    username: username || null,
                    role: client_1.UserRole.USER,
                    status: client_1.AccountStatus.ACTIVE,
                    emailStatus: client_1.EmailStatus.PENDING,
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
            // IMPORTANT: return a stable key called `userId` so clients can rely on it
            return {
                message: 'Verification email sent',
                userId: user.id,
                email: user.email,
            };
        }
        catch (error) {
            if (error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Registration failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Registration failed. Please try again.');
        }
    }
    // ---------------------------
    // VERIFY EMAIL
    // ---------------------------
    async verifyEmail(userId, code) {
        try {
            const rec = await this.prisma.emailVerification.findUnique({
                where: { userId },
            });
            if (!rec) {
                throw new common_1.BadRequestException('Invalid verification code');
            }
            if (rec.expiresAt < new Date()) {
                throw new common_1.BadRequestException('Verification code expired');
            }
            if (rec.code !== code) {
                await this.prisma.emailVerification.update({
                    where: { userId },
                    data: {
                        attempts: { increment: 1 },
                    },
                });
                throw new common_1.BadRequestException('Invalid verification code');
            }
            await this.prisma.user.update({
                where: { id: userId },
                data: {
                    emailVerifiedAt: new Date(),
                    emailStatus: client_1.EmailStatus.VERIFIED,
                },
            });
            await this.prisma.emailVerification.delete({ where: { userId } });
            const user = await this.prisma.user.findUnique({
                where: { id: userId },
                include: { profile: true },
            });
            if (!user) {
                throw new common_1.InternalServerErrorException('User not found after verification');
            }
            this.logger.log(`Email verified for user: ${userId}`);
            return this.issueTokensForUser(user);
        }
        catch (error) {
            if (error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Email verification failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Verification failed. Please try again.');
        }
    }
    // ---------------------------
    // LOGIN
    // ---------------------------
    async validatePassword(email, pass) {
        try {
            const user = await this.prisma.user.findUnique({
                where: { email },
            });
            if (!user)
                return null;
            if (user.status === client_1.AccountStatus.SUSPENDED) {
                throw new common_1.UnauthorizedException('Account is suspended');
            }
            if (user.status === client_1.AccountStatus.DELETED) {
                throw new common_1.UnauthorizedException('Account not found');
            }
            if (user.lockedUntil && user.lockedUntil > new Date()) {
                const remaining = Math.ceil((user.lockedUntil.getTime() - Date.now()) / 60000);
                throw new common_1.BadRequestException(`Account is locked. Try again in ${remaining} minutes`);
            }
            const ok = await argon2.verify(user.password, pass);
            if (!ok) {
                await this.prisma.user.update({
                    where: { id: user.id },
                    data: {
                        failedLoginAttempts: { increment: 1 },
                        lockedUntil: user.failedLoginAttempts >= 4
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
        }
        catch (error) {
            if (error instanceof common_1.UnauthorizedException ||
                error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Password validation failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw error;
        }
    }
    async loginWithTokens(email, password) {
        try {
            const user = await this.validatePassword(email, password);
            if (!user) {
                throw new common_1.UnauthorizedException('Invalid email or password');
            }
            if (!user.emailVerifiedAt) {
                throw new common_1.UnauthorizedException('Email not verified. Please check your inbox');
            }
            this.logger.log(`User logged in: ${user.id}`);
            return this.issueTokensForUser(user);
        }
        catch (error) {
            if (error instanceof common_1.UnauthorizedException ||
                error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Login failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Login failed. Please try again.');
        }
    }
    // ---------------------------
    // ISSUE TOKENS
    // ---------------------------
    async issueTokensForUser(user) {
        try {
            const expiresIn = Number(process.env.JWT_EXPIRES_SECONDS || 900);
            const payload = { sub: user.id, role: user.role };
            const accessToken = this.jwt.sign(payload, {
                secret: process.env.JWT_SECRET,
                expiresIn: `${expiresIn}s`,
            });
            const refreshToken = crypto.randomBytes(64).toString('hex');
            const refreshExpiry = new Date(Date.now() +
                Number(process.env.REFRESH_TOKEN_EXPIRES_DAYS || 7) * 86400000);
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
        }
        catch (error) {
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Token issuance failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Failed to generate tokens');
        }
    }
    // ---------------------------
    // REFRESH TOKENS
    // ---------------------------
    async refreshTokens(refreshToken) {
        try {
            const rec = await this.prisma.refreshToken.findUnique({
                where: { token: refreshToken },
                include: { user: true },
            });
            if (!rec) {
                throw new common_1.UnauthorizedException('Invalid refresh token');
            }
            if (rec.expiresAt < new Date()) {
                await this.prisma.refreshToken.delete({ where: { id: rec.id } });
                throw new common_1.UnauthorizedException('Refresh token expired');
            }
            if (rec.user.status !== client_1.AccountStatus.ACTIVE) {
                throw new common_1.UnauthorizedException('User account is not active');
            }
            await this.prisma.refreshToken.delete({ where: { id: rec.id } });
            this.logger.log(`Token refreshed for user: ${rec.userId}`);
            return this.issueTokensForUser(rec.user);
        }
        catch (error) {
            if (error instanceof common_1.UnauthorizedException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Token refresh failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Token refresh failed');
        }
    }
    // ---------------------------
    // LOGOUT
    // ---------------------------
    async logout(refreshToken) {
        try {
            await this.prisma.refreshToken.deleteMany({
                where: { token: refreshToken },
            });
            this.logger.log('User logged out successfully');
            return { ok: true };
        }
        catch (error) {
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Logout failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Logout failed');
        }
    }
    // ---------------------------
    // FORGOT PASSWORD
    // ---------------------------
    async forgotPassword(email) {
        try {
            const user = await this.prisma.user.findUnique({
                where: { email },
            });
            if (!user) {
                this.logger.log(`Password reset requested for non-existent email: ${email}`);
                return {
                    ok: true,
                    message: 'If an account exists, a reset link has been sent',
                };
            }
            if (user.status !== client_1.AccountStatus.ACTIVE) {
                throw new common_1.BadRequestException('Account is not active');
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
        }
        catch (error) {
            if (error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Forgot password failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Failed to process password reset');
        }
    }
    // ---------------------------
    // RESET PASSWORD
    // ---------------------------
    async resetPassword(token, newPassword) {
        try {
            const rec = await this.prisma.passwordReset.findUnique({
                where: { token },
                include: { user: true },
            });
            if (!rec || rec.expiresAt < new Date()) {
                throw new common_1.BadRequestException('Invalid or expired reset token');
            }
            if (rec.user.status !== client_1.AccountStatus.ACTIVE) {
                throw new common_1.BadRequestException('Account is not active');
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
        }
        catch (error) {
            if (error instanceof common_1.BadRequestException) {
                throw error;
            }
            const errorMessage = this.isError(error) ? error.message : String(error);
            this.logger.error(`Password reset failed: ${errorMessage}`, this.isError(error) ? error.stack : undefined);
            throw new common_1.InternalServerErrorException('Failed to reset password');
        }
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = AuthService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        jwt_1.JwtService,
        email_service_1.EmailService])
], AuthService);
//# sourceMappingURL=auth.service.js.map