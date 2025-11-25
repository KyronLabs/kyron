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
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
const common_1 = require("@nestjs/common");
const common_2 = require("@nestjs/common");
const sgMail = __importStar(require("@sendgrid/mail"));
let EmailService = EmailService_1 = class EmailService {
    constructor() {
        this.logger = new common_2.Logger(EmailService_1.name);
        const key = process.env.SENDGRID_API_KEY;
        if (!key) {
            this.logger.warn('SENDGRID_API_KEY is not set — emails will fail.');
        }
        else {
            sgMail.setApiKey(key);
        }
    }
    async sendVerificationEmail(to, code) {
        const from = process.env.EMAIL_FROM || 'noreply@kyron.spidroid.com';
        const subject = 'Kyron — Verify your email';
        const html = `
      <div style="font-family: Arial, sans-serif; line-height:1.4;">
        <p>Hi —</p>
        <p>Use the following verification code to finish signing up on Kyron:</p>
        <h2 style="letter-spacing: 4px;">${code}</h2>
        <p>This code expires in 10 minutes.</p>
        <p>If you didn't create an account, ignore this email.</p>
      </div>
    `;
        const msg = {
            to,
            from,
            subject,
            html,
        };
        try {
            await sgMail.send(msg);
            this.logger.log(`Sent verification email to ${to}`);
        }
        catch (err) {
            this.logger.error('Failed to send verification email', err);
            throw err;
        }
    }
    // Optional: generic send method
    async sendRaw(to, subject, html) {
        const from = process.env.EMAIL_FROM || 'noreply@kyron.spidroid.com';
        try {
            await sgMail.send({ to, from, subject, html });
            this.logger.log(`Sent raw email to ${to}`);
        }
        catch (err) {
            this.logger.error('Failed to send raw email', err);
            throw err;
        }
    }
};
exports.EmailService = EmailService;
exports.EmailService = EmailService = EmailService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [])
], EmailService);
//# sourceMappingURL=email.service.js.map