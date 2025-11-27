"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var ProfileService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.ProfileService = void 0;
/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
// src/modules/profile/profile.service.ts
const common_1 = require("@nestjs/common");
const supabase_service_1 = require("../../infrastructure/supabase/supabase.service");
const prisma_service_1 = require("../../infrastructure/prisma/prisma.service");
const uuid_1 = require("uuid");
let ProfileService = ProfileService_1 = class ProfileService {
    constructor(supabase, prisma) {
        this.supabase = supabase;
        this.prisma = prisma;
        this.logger = new common_1.Logger(ProfileService_1.name);
    }
    buildFileName(userId, prefix, originalName) {
        const ext = originalName.includes('.')
            ? originalName.split('.').pop()
            : 'bin';
        return `${userId}_${prefix}_${Date.now()}.${ext}`;
    }
    async uploadAvatar(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'avatar', originalName);
        const { publicUrl } = await this.supabase.uploadFile(this.supabase.getAvatarFolder(), filename, fileBuffer, mimeType);
        // upsert user profile if missing
        await this.prisma.userProfile.upsert({
            where: { userId },
            update: { avatarUrl: publicUrl },
            create: { userId, avatarUrl: publicUrl },
        });
        this.logger.log(`Avatar uploaded for ${userId}: ${publicUrl}`);
        return publicUrl;
    }
    async uploadCover(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'cover', originalName);
        const { publicUrl } = await this.supabase.uploadFile(this.supabase.getCoverFolder(), filename, fileBuffer, mimeType);
        await this.prisma.userProfile.upsert({
            where: { userId },
            update: { coverUrl: publicUrl },
            create: { userId, coverUrl: publicUrl },
        });
        this.logger.log(`Cover uploaded for ${userId}: ${publicUrl}`);
        return publicUrl;
    }
    async updateProfile(userId, payload) {
        const { name, bio, location, website, interests } = payload;
        // upsert profile
        await this.prisma.userProfile.upsert({
            where: { userId },
            create: { userId, bio, location, website },
            update: { bio, location, website },
        });
        // update user display name
        if (typeof name !== 'undefined') {
            await this.prisma.user.update({
                where: { id: userId },
                data: { name },
            });
        }
        // replace interests
        if (Array.isArray(interests)) {
            // remove any existing then create new relations
            await this.prisma.userInterest.deleteMany({ where: { userId } });
            const connect = interests.map((interestId) => ({
                id: (0, uuid_1.v4)(),
                userId,
                interestId,
            }));
            if (connect.length > 0) {
                await this.prisma.userInterest.createMany({
                    data: connect,
                    skipDuplicates: true,
                });
            }
        }
        return { ok: true };
    }
    async getProfile(userId) {
        const user = await this.prisma.user.findUnique({
            where: { id: userId },
            include: { profile: true, interests: { include: { interest: true } } },
        });
        return user;
    }
};
exports.ProfileService = ProfileService;
exports.ProfileService = ProfileService = ProfileService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [supabase_service_1.SupabaseService,
        prisma_service_1.PrismaService])
], ProfileService);
//# sourceMappingURL=profile.service.js.map