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
    /* ------------------------------------------
     *  UPLOAD AVATAR
     * ---------------------------------------- */
    async uploadAvatar(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'avatar', originalName);
        const folder = this.supabase.getAvatarFolder();
        const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);
        await this.supabase.upsertProfileRow({
            user_id: userId,
            avatar_url: publicUrl,
            updated_at: new Date().toISOString(),
        });
        this.logger.log(`Avatar updated for ${userId}`);
        return publicUrl;
    }
    /* ------------------------------------------
     *  UPLOAD COVER
     * ---------------------------------------- */
    async uploadCover(userId, fileBuffer, originalName, mimeType) {
        if (!fileBuffer || fileBuffer.length === 0)
            throw new common_1.BadRequestException('Empty file');
        const filename = this.buildFileName(userId, 'cover', originalName);
        const folder = this.supabase.getCoverFolder();
        const { publicUrl } = await this.supabase.uploadFile(folder, filename, fileBuffer, mimeType);
        await this.supabase.upsertProfileRow({
            user_id: userId,
            cover_url: publicUrl,
            updated_at: new Date().toISOString(),
        });
        this.logger.log(`Cover updated for ${userId}`);
        return publicUrl;
    }
    /* ------------------------------------------
     *  UPDATE PROFILE DATA
     * ---------------------------------------- */
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
        if (typeof name !== 'undefined') {
            await this.prisma.user.update({
                where: { id: userId },
                data: { name: name ?? null },
            });
        }
        if (Array.isArray(interests)) {
            await this.supabase.replaceUserInterests(userId, interests);
        }
        return { ok: true };
    }
    /* ------------------------------------------
     *  GET USER PROFILE
     * ---------------------------------------- */
    async getProfile(userId) {
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
        const profile = await this.supabase.getProfileRow(userId);
        const interests = await this.supabase
            .getClient()
            .from('user_interests')
            .select('interest_id, interest(id, name, slug)')
            .eq('user_id', userId);
        return {
            user,
            profile,
            interests: Array.isArray(interests.data)
                ? interests.data
                : [],
        };
    }
    async listInterests() {
        return this.supabase.listInterests();
    }
    async getRandomDefaultCover() {
        return this.supabase.getRandomDefaultCover();
    }
    /* ------------------------------------------
     *  SAVE INTERESTS
     * ---------------------------------------- */
    async saveInterests(userId, labels) {
        this.logger.log(`Saving interests for ${userId}`);
        const normalized = labels.map((l) => l.toLowerCase().trim());
        const { data: interestRows, error: fetchErr } = await this.supabase
            .getClient()
            .from('interests')
            .select('id, slug, name')
            .in('slug', normalized);
        if (fetchErr)
            throw new Error(fetchErr.message);
        if (!interestRows || interestRows.length === 0)
            throw new common_1.BadRequestException('No valid interests found');
        const { error: delErr } = await this.supabase
            .getClient()
            .from('user_interests')
            .delete()
            .eq('user_id', userId);
        if (delErr)
            throw new Error(delErr.message);
        const payload = interestRows.map((row) => ({
            user_id: userId,
            interest_id: row.id,
        }));
        const { error: insertErr } = await this.supabase
            .getClient()
            .from('user_interests')
            .insert(payload);
        if (insertErr)
            throw new Error(insertErr.message);
        return { ok: true, count: payload.length };
    }
    /* ------------------------------------------
     *  BULK FOLLOW
     * ---------------------------------------- */
    async followMany(userId, targetIds) {
        if (targetIds.length === 0)
            return { ok: true, count: 0 };
        const cleanIds = targetIds
            .filter((id) => id !== userId)
            .filter((v, i, a) => a.indexOf(v) === i);
        await this.prisma.userFollowers.createMany({
            data: cleanIds.map((id) => ({
                followerId: userId,
                followingId: id,
            })),
            skipDuplicates: true,
        });
        return { ok: true, count: cleanIds.length };
    }
    /* ------------------------------------------
     *  SUGGESTED USERS (interest matching)
     * ---------------------------------------- */
    async getSuggestedUsers(userId) {
        this.logger.log(`Generating suggestions for ${userId}`);
        const client = this.supabase.getClient();
        const { data: myInterests, error: myErr } = await client
            .from('user_interests')
            .select('interest_id')
            .eq('user_id', userId);
        if (myErr)
            throw new Error(myErr.message);
        const interestIds = (myInterests ?? []).map((i) => i.interest_id);
        if (interestIds.length === 0) {
            return this.getRandomSuggestedUsers(userId);
        }
        const { data: matches, error: matchErr } = await client
            .from('user_interests')
            .select('user_id')
            .in('interest_id', interestIds);
        if (matchErr)
            throw new Error(matchErr.message);
        const relatedUserIds = [
            ...new Set(matches.map((m) => m.user_id).filter((id) => id !== userId)),
        ];
        if (relatedUserIds.length === 0) {
            return this.getRandomSuggestedUsers(userId);
        }
        const { data: profiles, error: profileErr } = await client
            .from('profiles')
            .select('*')
            .in('user_id', relatedUserIds)
            .limit(50);
        if (profileErr)
            throw new Error(profileErr.message);
        const followingRows = await this.prisma.userFollowers.findMany({
            where: {
                followerId: userId,
                followingId: { in: relatedUserIds },
            },
        });
        const followingSet = new Set(followingRows.map((f) => f.followingId));
        return profiles.map((p) => ({
            id: p.user_id,
            avatar: p.avatar_url,
            handle: p.display_name ?? '@user',
            bio: p.bio,
            isFollowing: followingSet.has(p.user_id),
        }));
    }
    /* ------------------------------------------
     *  FALLBACK SUGGESTED USERS
     * ---------------------------------------- */
    async getRandomSuggestedUsers(userId) {
        const client = this.supabase.getClient();
        const { data, error } = await client
            .from('profiles')
            .select('*')
            .neq('user_id', userId)
            .order('updated_at', { ascending: false })
            .limit(20);
        if (error)
            throw new Error(error.message);
        const followingRows = await this.prisma.userFollowers.findMany({
            where: {
                followerId: userId,
                followingId: { in: data.map((x) => x.user_id) },
            },
        });
        const followingSet = new Set(followingRows.map((f) => f.followingId));
        return data.map((p) => ({
            id: p.user_id,
            avatar: p.avatar_url,
            handle: p.display_name ?? '@user',
            bio: p.bio,
            isFollowing: followingSet.has(p.user_id),
        }));
    }
};
exports.ProfileService = ProfileService;
exports.ProfileService = ProfileService = ProfileService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [supabase_service_1.SupabaseService,
        prisma_service_1.PrismaService])
], ProfileService);
//# sourceMappingURL=profile.service.js.map