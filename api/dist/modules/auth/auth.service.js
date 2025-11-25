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
/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
const common_1 = require("@nestjs/common");
const common_2 = require("@nestjs/common");
const common_3 = require("@nestjs/common");
const common_4 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const jwt_1 = require("@nestjs/jwt");
const argon2 = __importStar(require("argon2"));
const prisma_service_1 = require("../../infrastructure/prisma/prisma.service");
const crypto = __importStar(require("crypto"));
let AuthService = AuthService_1 = class AuthService {
    constructor(users, jwt, prisma) {
        this.users = users;
        this.jwt = jwt;
        this.prisma = prisma;
        this.logger = new common_4.Logger(AuthService_1.name);
    }
    generateCode() {
        return Math.floor(100000 + Math.random() * 900000).toString();
    }
    /** Create user and email verification record */
    async register(payload) {
        const { email, password, username } = payload;
        const existing = await this.users.findByEmail(email);
        if (existing) {
            throw new common_2.BadRequestException('Email already exists');
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
        return { tempUserId: user.id, code };
    }
    /** Verify code and issue tokens */
    async verifyEmail(userId, code) {
        const rec = await this.prisma.emailVerification.findUnique({
            where: { userId },
        });
        if (!rec) {
            throw new common_2.BadRequestException('Invalid code');
        }
        if (rec.expiresAt < new Date()) {
            throw new common_2.BadRequestException('Code expired');
        }
        if (rec.code !== code) {
            throw new common_2.BadRequestException('Invalid code');
        }
        await this.prisma.user.update({
            where: { id: userId },
            data: { emailVerifiedAt: new Date() },
        });
        await this.prisma.emailVerification.delete({
            where: { userId },
        });
        const user = await this.prisma.user.findUnique({
            where: { id: userId },
        });
        return this.issueTokensForUser(user);
    }
    /** Validate credentials */
    async validatePassword(email, pass) {
        const user = await this.users.findByEmail(email);
        if (!user)
            return null;
        const ok = await argon2.verify(user.password, pass);
        if (!ok)
            return null;
        return user;
    }
    /** Login flow */
    async loginWithTokens(email, password) {
        const user = await this.validatePassword(email, password);
        if (!user) {
            throw new common_3.UnauthorizedException('Invalid credentials');
        }
        if (!user.emailVerifiedAt) {
            throw new common_3.UnauthorizedException('Email not verified');
        }
        return this.issueTokensForUser(user);
    }
    /** Issue access + refresh tokens (stores refresh token in DB) */
    async issueTokensForUser(user) {
        const jwtPayload = {
            sub: user.id,
            role: user.role,
        };
        const expiresInSeconds = Number(process.env.JWT_EXPIRES_SECONDS || 900);
        const accessToken = this.jwt.sign(jwtPayload, {
            secret: process.env.JWT_SECRET,
            expiresIn: `${expiresInSeconds}s`,
        });
        const refreshToken = crypto.randomBytes(64).toString('hex');
        const refreshDays = Number(process.env.REFRESH_TOKEN_EXPIRES_DAYS || 7);
        const refreshExpiryDate = new Date(Date.now() + refreshDays * 24 * 60 * 60 * 1000);
        await this.prisma.refreshToken.create({
            data: {
                token: refreshToken,
                userId: user.id,
                expiresAt: refreshExpiryDate,
            },
        });
        return {
            accessToken,
            refreshToken,
            expiresIn: expiresInSeconds,
            user: {
                id: user.id,
                email: user.email,
                username: user.username,
            },
        };
    }
    /** Refresh tokens (rotate refresh token) */
    async refreshTokens(refreshToken) {
        const stored = await this.prisma.refreshToken.findUnique({
            where: { token: refreshToken },
            include: { user: true },
        });
        if (!stored) {
            throw new common_3.UnauthorizedException('Invalid refresh token');
        }
        if (stored.expiresAt < new Date()) {
            // remove expired token
            await this.prisma.refreshToken.delete({ where: { id: stored.id } });
            throw new common_3.UnauthorizedException('Refresh token expired');
        }
        const user = stored.user;
        // Revoke the old refresh token (rotation)
        await this.prisma.refreshToken.delete({ where: { id: stored.id } });
        // Issue new tokens
        return this.issueTokensForUser(user);
    }
    /** Logout - revoke refresh token */
    async logout(refreshToken) {
        const stored = await this.prisma.refreshToken.findUnique({
            where: { token: refreshToken },
        });
        if (stored) {
            await this.prisma.refreshToken.delete({ where: { id: stored.id } });
        }
        return { ok: true };
    }
    /** Forgot password skeleton (you can implement email sending) */
    async forgotPassword(email) {
        const user = await this.users.findByEmail(email);
        if (!user) {
            // don't reveal email existence
            return { ok: true };
        }
        // create reset token, store expiry, send via EmailService (not injected here)
        const token = crypto.randomBytes(32).toString('hex');
        const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1h
        await this.prisma.passwordReset.upsert({
            where: { userId: user.id },
            update: {
                token,
                expiresAt,
            },
            create: {
                userId: user.id,
                token,
                expiresAt,
            },
        });
        // Return token (in prod you would send email)
        return { ok: true, token };
    }
    /** Reset password skeleton */
    async resetPassword(token, newPassword) {
        const rec = await this.prisma.passwordReset.findUnique({
            where: { token },
        });
        if (!rec || rec.expiresAt < new Date()) {
            throw new common_2.BadRequestException('Invalid or expired token');
        }
        const hashed = await argon2.hash(newPassword);
        await this.prisma.user.update({
            where: { id: rec.userId },
            data: { password: hashed },
        });
        await this.prisma.passwordReset.delete({ where: { id: rec.id } });
        return { ok: true };
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = AuthService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        jwt_1.JwtService,
        prisma_service_1.PrismaService])
], AuthService);
//# sourceMappingURL=auth.service.js.map