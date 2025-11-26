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
// src/infrastructure/supabase/supabase.service.ts
// src/infrastructure/supabase/supabase.service.ts
const common_1 = require("@nestjs/common");
const supabase_js_1 = require("@supabase/supabase-js");
let SupabaseService = SupabaseService_1 = class SupabaseService {
    constructor() {
        this.logger = new common_1.Logger(SupabaseService_1.name);
        const url = process.env.SUPABASE_URL;
        const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
        if (!url || !key) {
            throw new Error('Supabase environment variables missing');
        }
        this.client = (0, supabase_js_1.createClient)(url, key, {
            auth: {
                persistSession: false,
            },
        });
    }
    // -----------------------------------------------------------------------
    // FOLDER HELPERS (required by ProfileService)
    // -----------------------------------------------------------------------
    getAvatarFolder() {
        return 'avatars';
    }
    getCoverFolder() {
        return 'covers';
    }
    // -----------------------------------------------------------------------
    // UNIVERSAL UPLOAD (returns { publicUrl })
    // -----------------------------------------------------------------------
    async uploadFile(bucket, path, buffer, mime) {
        const { error: uploadErr } = await this.client.storage
            .from(bucket)
            .upload(path, buffer, {
            upsert: true,
            contentType: mime,
        });
        if (uploadErr) {
            this.logger.error(uploadErr);
            throw new common_1.InternalServerErrorException(uploadErr.message);
        }
        // get public URL (Supabase returns: { data: { publicUrl } })
        const { data } = this.client.storage.from(bucket).getPublicUrl(path);
        const publicUrl = data.publicUrl;
        if (!publicUrl) {
            throw new common_1.InternalServerErrorException('Failed to generate public URL');
        }
        return { publicUrl };
    }
    // -----------------------------------------------------------------------
    // Signed URL
    // -----------------------------------------------------------------------
    async createSignedUrl(bucket, path) {
        const { data, error } = await this.client.storage
            .from(bucket)
            .createSignedUrl(path, 60 * 60);
        if (error) {
            throw new common_1.InternalServerErrorException(error.message);
        }
        return data.signedUrl;
    }
    // -----------------------------------------------------------------------
    // DELETE FILE
    // -----------------------------------------------------------------------
    async deleteFile(bucket, path) {
        const { error } = await this.client.storage.from(bucket).remove([path]);
        if (error) {
            throw new common_1.InternalServerErrorException(error.message);
        }
    }
};
exports.SupabaseService = SupabaseService;
exports.SupabaseService = SupabaseService = SupabaseService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], SupabaseService);
//# sourceMappingURL=supabase.service.js.map