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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var EmailService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmailService = void 0;
const common_1 = require("@nestjs/common");
const mail_1 = __importDefault(require("@sendgrid/mail"));
let EmailService = EmailService_1 = class EmailService {
    constructor() {
        this.logger = new common_1.Logger(EmailService_1.name);
        this.logger.log('📨 Initializing SendGrid EmailService...');
        const apiKey = process.env.SENDGRID_API_KEY;
        if (!apiKey) {
            this.logger.error('❌ SENDGRID_API_KEY is missing in environment variables.');
            return;
        }
        this.logger.log(`🔐 SENDGRID_API_KEY loaded (length: ${apiKey.length})`);
        this.logger.log(`📤 EMAIL_FROM = ${process.env.EMAIL_FROM}`);
        this.logger.log('🧪 sgMail object BEFORE setApiKey():');
        this.logger.log(JSON.stringify(Object.keys(mail_1.default)));
        if (mail_1.default.default && typeof mail_1.default.default.setApiKey === 'function') {
            this.logger.warn('⚠ sgMail is wrapped in default export. Using sgMail.default instead.');
            mail_1.default.default.setApiKey(apiKey);
            this.logger.log('✅ SendGrid initialized through sgMail.default');
            return;
        }
        if (typeof mail_1.default.setApiKey === 'function') {
            mail_1.default.setApiKey(apiKey);
            this.logger.log('✅ SendGrid initialized normally via sgMail.setApiKey()');
            return;
        }
        this.logger.error('❌ sgMail.setApiKey is NOT a function! Dumping sgMail object...');
        this.logger.error(JSON.stringify(mail_1.default, null, 2));
        throw new Error('SendGrid initialization failed: setApiKey not found.');
    }
    async sendVerifyCode(email, code) {
        this.logger.log(`➡ Sending verification code to: ${email}`);
        const msg = {
            to: email,
            from: process.env.EMAIL_FROM || 'noreply@kyron.app',
            subject: 'Verify your Kyron account',
            html: `
        <h2>Your Verification Code</h2>
        <p>Your 6-digit verification code is:</p>
        <h1 style="font-size:32px; font-weight:bold;">${code}</h1>
        <p>This code expires in 10 minutes.</p>
      `,
        };
        try {
            this.logger.debug('📤 Sending email via sgMail.send()...');
            await mail_1.default.send(msg);
            this.logger.log(`✅ Verification email sent to ${email}`);
        }
        catch (err) {
            this.logger.error('SendGrid raw error:', err.response?.body || err.message || err);
            throw new Error('Failed to send verification email');
        }
    }
    async sendPasswordReset(email, token) {
        this.logger.log(`➡ Sending password reset email to: ${email}`);
        const resetUrl = `${process.env.FRONTEND_URL}/reset-password?token=${token}`;
        const msg = {
            to: email,
            from: process.env.EMAIL_FROM || 'noreply@kyron.app',
            subject: 'Reset your Kyron password',
            html: `
        <h2>Password Reset Request</h2>
        <p>Click the link below to reset your password:</p>
        <a href="${resetUrl}" style="display:inline-block;padding:10px 20px;background-color:#4f46e5;color:white;border-radius:5px;text-decoration:none;font-weight:bold;">Reset Password</a>
        <p>This link will expire in 1 hour.</p>
      `,
        };
        try {
            this.logger.debug('📤 Sending email via sgMail.send()...');
            await mail_1.default.send(msg);
            this.logger.log(`✅ Password reset email sent to ${email}`);
        }
        catch (err) {
            this.logger.error('SendGrid raw error:', err.response?.body || err.message || err);
            throw new Error('Failed to send password reset email');
        }
    }
};
exports.EmailService = EmailService;
exports.EmailService = EmailService = EmailService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], EmailService);
//# sourceMappingURL=email.service.js.map