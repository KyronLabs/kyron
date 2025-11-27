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
var EmailService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmailService = void 0;
const common_1 = require("@nestjs/common");
const sgMail = __importStar(require("@sendgrid/mail"));
let EmailService = EmailService_1 = class EmailService {
    constructor() {
        this.logger = new common_1.Logger(EmailService_1.name);
        this.logger.log('📨 Initializing SendGrid EmailService...');
        const apiKey = process.env.SENDGRID_API_KEY;
        if (!apiKey) {
            this.logger.error('❌ SENDGRID_API_KEY is missing in environment variables.');
            return;
        }
        // Log environment status safely
        this.logger.log(`🔐 SENDGRID_API_KEY loaded (length: ${apiKey.length})`);
        this.logger.log(`📤 EMAIL_FROM = ${process.env.EMAIL_FROM}`);
        // Log the raw import to see its structure
        this.logger.log('🧪 sgMail object BEFORE setApiKey():');
        this.logger.log(JSON.stringify(Object.keys(sgMail)));
        // Detect incorrect export shape
        if (
        // sgMail is wrapped inside "default"
        // This is EXACTLY what breaks setApiKey()
        sgMail.default &&
            typeof sgMail.default.setApiKey === 'function') {
            this.logger.warn('⚠ sgMail is wrapped in default export. Using sgMail.default instead.');
            sgMail.default.setApiKey(apiKey);
            this.logger.log('✅ SendGrid initialized through sgMail.default');
            return;
        }
        // Normal case
        if (typeof sgMail.setApiKey === 'function') {
            sgMail.setApiKey(apiKey);
            this.logger.log('✅ SendGrid initialized normally via sgMail.setApiKey()');
            return;
        }
        // If neither case works, warn with full introspection
        this.logger.error('❌ sgMail.setApiKey is NOT a function! Dumping sgMail object...');
        this.logger.error(JSON.stringify(sgMail, null, 2));
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
            await sgMail.send(msg);
            this.logger.log(`✅ Verification email sent to ${email}`);
        }
        catch (err) {
            this.handleSendGridError('verification code', email, err);
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

        <a href="${resetUrl}" style="
            display:inline-block;
            padding:10px 20px;
            background-color:#4f46e5;
            color:white;
            border-radius:5px;
            text-decoration:none;
            font-weight:bold;">
          Reset Password
        </a>

        <p>This link will expire in 1 hour.</p>
      `,
        };
        try {
            this.logger.debug('📤 Sending email via sgMail.send()...');
            await sgMail.send(msg);
            this.logger.log(`✅ Password reset email sent to ${email}`);
        }
        catch (err) {
            this.handleSendGridError('password reset', email, err);
        }
    }
    handleSendGridError(type, email, err) {
        const error = err instanceof Error ? err : new Error(String(err));
        this.logger.error(`❌ SendGrid error sending ${type} email to ${email}: ${error.message}`);
        // log raw object too
        this.logger.error(`RAW ERROR: ${JSON.stringify(err, null, 2)}`);
        throw new Error('Failed to send email');
    }
};
exports.EmailService = EmailService;
exports.EmailService = EmailService = EmailService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], EmailService);
//# sourceMappingURL=email.service.js.map