"use strict";
/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
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
const common_1 = require("@nestjs/common");
const supabase_service_1 = require("../../infrastructure/supabase/supabase.service");
const prisma_service_1 = require("../../infrastructure/prisma/prisma.service");
let ProfileService = ProfileService_1 = class ProfileService {
    constructor(supabase, prisma) {
        this.supabase = supabase;
        this.prisma = prisma;
        this.logger = new common_1.Logger(ProfileService_1.name);
    }
    buildFileName(userId, prefix, originalName) {
        const ext = originalName.includes('.') ? originalName.split('.').pop() : 'bin';
        return `${userId}_${prefix}_${Date.now()}.${ext}`;
    }
    /** Upload avatar buffer to storage, update profile row in Supabase */
    async uploadAvatar(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'avatar', originalName);
        const folder = this.supabase.getAvatarFolder(); // e.g. avatars
        const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);
        // Upsert profile row in Supabase table
        await this.supabase.upsertProfileRow({
            user_id: userId,
            avatar_url: publicUrl,
            updated_at: new Date().toISOString(),
        });
        this.logger.log(`Avatar uploaded for ${userId}: ${publicUrl}`);
        return publicUrl;
    }
    /** Upload cover buffer to storage, update profile row in Supabase */
    async uploadCover(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'cover', originalName);
        const folder = `${this.supabase.getCoverFolder()}`; // e.g. covers
        const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);
        await this.supabase.upsertProfileRow({
            user_id: userId,
            cover_url: publicUrl,
            updated_at: new Date().toISOString(),
        });
        this.logger.log(`Cover uploaded for ${userId}: ${publicUrl}`);
        return publicUrl;
    }
    /** Update profile fields and interests */
    async updateProfile(userId, payload) {
        const { name, bio, location, website, interests } = payload;
        await this.supabase.upsertProfileRow({
            user_id: userId,
            display_name: name ?? undefined,
            bio: bio ?? undefined,
            location: location ?? undefined,
            website: website ?? undefined,
            updated_at: new Date().toISOString(),
        });
        // If display name present, also persist to users via Prisma (optional)
        if (typeof name !== 'undefined') {
            await this.prisma.user.update({
                where: { id: userId },
                data: { name: name ?? null },
            });
        }
        // Replace interests using Supabase table
        if (Array.isArray(interests)) {
            // validate interest ids exist optionally
            await this.supabase.replaceUserInterests(userId, interests);
        }
        return { ok: true };
    }
    /** Get combined user + profile + interests */
    async getProfile(userId) {
        // get user from Prisma (authoritative)
        const user = await this.prisma.user.findUnique({
            where: { id: userId },
            select: {
                id: true,
                email: true,
                username: true,
                name: true,
                role: true,
                createdAt: true,
            },
        });
        // get profile from Supabase
        const profile = await this.supabase.getProfileRow(userId);
        // get interests joined
        const interests = await this.supabase.getClient()
            .from('user_interests')
            .select('interest_id, interests(name, slug)')
            .eq('user_id', userId);
        // Assemble clean object
        return {
            user,
            profile,
            interests: Array.isArray(interests.data) ? interests.data : [],
        };
    }
    async listInterests() {
        return await this.supabase.listInterests();
    }
    async getRandomDefaultCover() {
        return await this.supabase.getRandomDefaultCover();
    }
};
exports.ProfileService = ProfileService;
exports.ProfileService = ProfileService = ProfileService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [supabase_service_1.SupabaseService,
        prisma_service_1.PrismaService])
], ProfileService);
//# sourceMappingURL=profile.service.js.map