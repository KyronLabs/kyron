"use strict";
/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var ProfileController_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.ProfileController = void 0;
const common_1 = require("@nestjs/common");
const platform_express_1 = require("@nestjs/platform-express");
const profile_service_1 = require("./profile.service");
const auth_guard_1 = require("../../common/guards/auth.guard"); // your existing auth guard
let ProfileController = ProfileController_1 = class ProfileController {
    constructor(svc) {
        this.svc = svc;
        this.logger = new common_1.Logger(ProfileController_1.name);
    }
    // get my profile
    async me(req) {
        // assume your AuthGuard attaches userId to req.user?.id
        const userId = req.user?.id;
        return await this.svc.getProfile(userId);
    }
    // update profile body fields
    async update(req, body) {
        const userId = req.user?.id;
        return await this.svc.updateProfile(userId, body);
    }
    // upload avatar (multipart form-data with file field 'file')
    async uploadAvatar(req, file) {
        const userId = req.user?.id;
        if (!file)
            throw new Error('no file uploaded');
        const url = await this.svc.uploadAvatar(userId, file.buffer, file.originalname, file.mimetype);
        return { url };
    }
    // upload cover
    async uploadCover(req, file) {
        const userId = req.user?.id;
        if (!file)
            throw new Error('no file uploaded');
        const url = await this.svc.uploadCover(userId, file.buffer, file.originalname, file.mimetype);
        return { url };
    }
    async randomDefaultCover() {
        const url = await this.svc.getRandomDefaultCover();
        return { url };
    }
    async interests() {
        const rows = await this.svc.listInterests();
        return { data: rows };
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
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file')),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", Promise)
], ProfileController.prototype, "uploadAvatar", null);
__decorate([
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, common_1.Post)('cover'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file')),
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
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
exports.ProfileController = ProfileController = ProfileController_1 = __decorate([
    (0, common_1.Controller)('profile'),
    __metadata("design:paramtypes", [profile_service_1.ProfileService])
], ProfileController);
//# sourceMappingURL=profile.controller.js.map