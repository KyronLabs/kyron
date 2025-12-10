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
var SupabaseService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.SupabaseService = void 0;
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
const common_1 = require("@nestjs/common");
const supabase_js_1 = require("@supabase/supabase-js");
let SupabaseService = SupabaseService_1 = class SupabaseService {
    constructor() {
        this.logger = new common_1.Logger(SupabaseService_1.name);
        const url = process.env.SUPABASE_URL;
        const key = process.env.SUPABASE_SERVICE_ROLE_KEY; // service role for server
        this.bucketName = process.env.SUPABASE_BUCKET_NAME || 'kyron-media';
        this.avatarFolder = process.env.SUPABASE_AVATAR_FOLDER || 'avatars';
        this.coverFolder = process.env.SUPABASE_COVER_FOLDER || 'covers';
        if (!url || !key) {
            this.logger.error('SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY missing');
            throw new Error('Supabase config missing');
        }
        this.client = (0, supabase_js_1.createClient)(url, key, {
        // server-side; do not pass fetch override
        });
    }
    // ---------------------------
    // Storage helpers
    // ---------------------------
    /** Upload a Buffer (or Readable) to the bucket/folder and return { publicUrl, path } */
    async uploadFile(folder, filename, fileBuf, contentType) {
        const path = `${folder}/${filename}`;
        const { error } = await this.client.storage
            .from(this.bucketName)
            .upload(path, fileBuf, {
            contentType,
            upsert: true,
        });
        if (error) {
            this.logger.error('Supabase upload error', error);
            throw new Error(`Supabase upload failed: ${error.message}`);
        }
        const { data: urlData } = this.client.storage
            .from(this.bucketName)
            .getPublicUrl(path);
        return {
            publicUrl: urlData?.publicUrl ?? null,
            path,
        };
    }
    /** Generate a signed URL (useful if your bucket is private). Expires seconds default 3600 */
    async createSignedUrl(path, expiresInSeconds = 3600) {
        const { data, error } = await this.client.storage
            .from(this.bucketName)
            .createSignedUrl(path, expiresInSeconds);
        if (error) {
            this.logger.error('createSignedUrl error', error);
            throw error;
        }
        return data.signedUrl;
    }
    /** Return public URL for path */
    getPublicUrl(path) {
        const { data } = this.client.storage.from(this.bucketName).getPublicUrl(path);
        return data?.publicUrl ?? null;
    }
    /** List files in a folder (for default_covers random pick) */
    async listFiles(folder, opts) {
        const { data, error } = await this.client.storage.from(this.bucketName).list(folder, opts);
        if (error) {
            this.logger.error('Supabase list error', error);
            throw error;
        }
        return data ?? [];
    }
    /** Pick a random file under covers/default_covers and return public URL or null */
    async getRandomDefaultCover() {
        const folder = `${this.coverFolder}/default_covers`;
        const files = await this.listFiles(folder, { limit: 1000 });
        if (!files || files.length === 0)
            return null;
        const file = files[Math.floor(Math.random() * files.length)];
        const path = `${folder}/${file.name}`;
        return this.getPublicUrl(path);
    }
    // ---------------------------
    // Table helpers (Supabase Postgres)
    // Use the Supabase client to operate on Supabase-managed tables.
    // ---------------------------
    async upsertProfileRow(profileRow) {
        const { data, error } = await this.client.from('user_profiles').upsert(profileRow, { onConflict: 'user_id' });
        if (error) {
            this.logger.error('upsertProfileRow error', error);
            throw error;
        }
        return data;
    }
    async getProfileRow(userId) {
        const { data, error } = await this.client.from('user_profiles').select('*').eq('user_id', userId).limit(1).maybeSingle();
        if (error) {
            this.logger.error('getProfileRow error', error);
            throw error;
        }
        return data;
    }
    async replaceUserInterests(userId, interestIds) {
        // Delete existing
        const { error: delErr } = await this.client.from('user_interests').delete().eq('user_id', userId);
        if (delErr) {
            this.logger.error('replaceUserInterests delete error', delErr);
            throw delErr;
        }
        if (interestIds.length === 0)
            return;
        const rows = interestIds.map((id) => ({ id: this._uuid(), user_id: userId, interest_id: id }));
        const { error } = await this.client.from('user_interests').insert(rows);
        if (error) {
            this.logger.error('replaceUserInterests insert error', error);
            throw error;
        }
    }
    async listInterests() {
        const { data, error } = await this.client.from('interests').select('*').order('name', { ascending: true });
        if (error) {
            this.logger.error('listInterests error', error);
            throw error;
        }
        return data;
    }
    // Small helper for uuidv4 to avoid adding uuid here
    _uuid() {
        // simple fallback uuid generator (v4)
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            const r = (Math.random() * 16) | 0;
            const v = c === 'x' ? r : (r & 0x3) | 0x8;
            return v.toString(16);
        });
    }
    // Expose raw client if you ever need it
    getClient() {
        return this.client;
    }
    getAvatarFolder() {
        return this.avatarFolder;
    }
    getCoverFolder() {
        return this.coverFolder;
    }
    getBucketName() {
        return this.bucketName;
    }
};
exports.SupabaseService = SupabaseService;
exports.SupabaseService = SupabaseService = SupabaseService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], SupabaseService);
//# sourceMappingURL=supabase.service.js.map