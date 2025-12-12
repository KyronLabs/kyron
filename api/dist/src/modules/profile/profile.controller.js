"use strict";
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var ProfileController_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.ProfileController = void 0;
const common_1 = require("@nestjs/common");
const auth_guard_1 = require("../../common/guards/auth.guard");
const profile_service_1 = require("./profile.service");
let ProfileController = ProfileController_1 = class ProfileController {
    constructor(svc) {
        this.svc = svc;
        this.logger = new common_1.Logger(ProfileController_1.name);
    }
    // ------------------------------------
    // GET MY PROFILE
    // ------------------------------------
    async me(req) {
        return this.svc.getProfile(req.user.id);
    }
    // ------------------------------------
    // UPDATE PROFILE
    // ------------------------------------
    async update(req, body) {
        return this.svc.updateProfile(req.user.id, body);
    }
    // ------------------------------------
    // UPLOAD AVATAR
    // ------------------------------------
    async uploadAvatar(req) {
        const userId = req.user.id;
        const file = await req.file();
        if (!file)
            throw new Error('No file uploaded');
        const buffer = await file.toBuffer();
        const url = await this.svc.uploadAvatar(userId, buffer, file.filename, file.mimetype);
        return { url };
    }
    // ------------------------------------
    // UPLOAD COVER
    // ------------------------------------
    async uploadCover(req) {
        const userId = req.user.id;
        const file = await req.file();
        if (!file)
            throw new Error('No file uploaded');
        const buffer = await file.toBuffer();
        const url = await this.svc.uploadCover(userId, buffer, file.filename, file.mimetype);
        return { url };
    }
    async randomDefaultCover() {
        return { url: await this.svc.getRandomDefaultCover() };
    }
    // ------------------------------------
    // LIST INTERESTS
    // ------------------------------------
    async interests() {
        return { data: await this.svc.listInterests() };
    }
    // ------------------------------------
    // SAVE INTERESTS
    // ------------------------------------
    async saveInterests(req, body) {
        const interests = body.interests;
        if (!Array.isArray(interests)) {
            throw new common_1.BadRequestException('Invalid interests array');
        }
        return this.svc.saveInterests(req.user.id, interests);
    }
    // ------------------------------------
    // FOLLOW MANY
    // ------------------------------------
    async followMany(req, body) {
        const ids = body.ids;
        if (!Array.isArray(ids)) {
            throw new common_1.BadRequestException('ids must be an array of user IDs');
        }
        return this.svc.followMany(req.user.id, ids);
    }
    // ------------------------------------
    // GET SUGGESTED USERS
    // ------------------------------------
    async getSuggested(req) {
        return this.svc.getSuggestedUsers(req.user.id);
    }
};
exports.ProfileController = ProfileController;
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Get)('me'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "me", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Patch)(),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "update", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Post)('avatar'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "uploadAvatar", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Post)('cover'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "uploadCover", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Get)('default-cover/random'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "randomDefaultCover", null);
__decorate([
    (0, common_1.Get)('interests'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "interests", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Post)('interests'),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "saveInterests", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Post)('follow-many'),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "followMany", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Get)('suggested'),
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "getSuggested", null);
exports.ProfileController = ProfileController = ProfileController_1 = __decorate([
    (0, common_1.Controller)('profile'),
    __metadata("design:paramtypes", [profile_service_1.ProfileService])
], ProfileController);
//# sourceMappingURL=profile.controller.js.map