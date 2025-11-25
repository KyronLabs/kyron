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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const common_1 = require("@nestjs/common");
const common_2 = require("@nestjs/common");
const common_3 = require("@nestjs/common");
const common_4 = require("@nestjs/common");
const common_5 = require("@nestjs/common");
const auth_service_1 = require("./auth.service");
const email_service_1 = require("../../infrastructure/email/email.service");
const register_dto_1 = require("./dto/register.dto");
const verify_email_dto_1 = require("./dto/verify-email.dto");
const login_dto_1 = require("./dto/login.dto");
const refresh_dto_1 = require("./dto/refresh.dto");
const forgot_password_dto_1 = require("./dto/forgot-password.dto");
const reset_password_dto_1 = require("./dto/reset-password.dto");
let AuthController = class AuthController {
    constructor(svc, emailSvc) {
        this.svc = svc;
        this.emailSvc = emailSvc;
    }
    async register(body) {
        const { tempUserId, code } = await this.svc.register(body);
        // send code via SendGrid
        try {
            await this.emailSvc.sendVerificationEmail(body.email, code);
        }
        catch (err) {
            // if email fails, you may want to delete the user / verification record or let them retry
        }
        return { ok: true, message: 'verification_sent', tempUserId };
    }
    async verifyEmail(body) {
        const payload = await this.svc.verifyEmail(body.userId, body.code);
        return payload;
    }
    async login(body) {
        const payload = await this.svc.loginWithTokens(body.email, body.password);
        return payload;
    }
    async refresh(body) {
        const payload = await this.svc.refreshTokens(body.refreshToken);
        return payload;
    }
    async logout(body) {
        await this.svc.logout(body.refreshToken);
        return { ok: true };
    }
    async forgot(body) {
        // Here you might send an email with a reset link/token
        return this.svc.forgotPassword(body.email);
    }
    async reset(body) {
        return this.svc.resetPassword(body.token, body.newPassword);
    }
};
exports.AuthController = AuthController;
__decorate([
    (0, common_3.Post)('register'),
    (0, common_4.HttpCode)(common_5.HttpStatus.CREATED),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [register_dto_1.RegisterDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "register", null);
__decorate([
    (0, common_3.Post)('verify-email'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [verify_email_dto_1.VerifyEmailDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "verifyEmail", null);
__decorate([
    (0, common_3.Post)('login'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [login_dto_1.LoginDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "login", null);
__decorate([
    (0, common_3.Post)('refresh'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [refresh_dto_1.RefreshDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "refresh", null);
__decorate([
    (0, common_3.Post)('logout'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [refresh_dto_1.RefreshDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "logout", null);
__decorate([
    (0, common_3.Post)('forgot-password'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [forgot_password_dto_1.ForgotPasswordDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "forgot", null);
__decorate([
    (0, common_3.Post)('reset-password'),
    (0, common_4.HttpCode)(common_5.HttpStatus.OK),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [reset_password_dto_1.ResetPasswordDto]),
    __metadata("design:returntype", Promise)
], AuthController.prototype, "reset", null);
exports.AuthController = AuthController = __decorate([
    (0, common_2.Controller)('auth'),
    __metadata("design:paramtypes", [auth_service_1.AuthService,
        email_service_1.EmailService])
], AuthController);
//# sourceMappingURL=auth.controller.js.map