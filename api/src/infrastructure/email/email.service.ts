import { Injectable, Logger } from '@nestjs/common';
import sgMail from '@sendgrid/mail';

@Injectable()
export class EmailService {
  private readonly logger = new Logger(EmailService.name);

  constructor() {
    this.logger.log('📨 Initializing SendGrid EmailService...');
    const apiKey = process.env.SENDGRID_API_KEY;
    if (!apiKey) {
      this.logger.error('❌ SENDGRID_API_KEY is missing in environment variables.');
      return;
    }
    this.logger.log(`🔐 SENDGRID_API_KEY loaded (length: ${apiKey.length})`);
    this.logger.log(`📤 EMAIL_FROM = ${process.env.EMAIL_FROM}`);
    this.logger.log('🧪 sgMail object BEFORE setApiKey():');
    this.logger.log(JSON.stringify(Object.keys(sgMail)));

    if ((sgMail as any).default && typeof (sgMail as any).default.setApiKey === 'function') {
      this.logger.warn('⚠ sgMail is wrapped in default export. Using sgMail.default instead.');
      (sgMail as any).default.setApiKey(apiKey);
      this.logger.log('✅ SendGrid initialized through sgMail.default');
      return;
    }
    if (typeof sgMail.setApiKey === 'function') {
      sgMail.setApiKey(apiKey);
      this.logger.log('✅ SendGrid initialized normally via sgMail.setApiKey()');
      return;
    }
    this.logger.error('❌ sgMail.setApiKey is NOT a function! Dumping sgMail object...');
    this.logger.error(JSON.stringify(sgMail, null, 2));
    throw new Error('SendGrid initialization failed: setApiKey not found.');
  }

  async sendVerifyCode(email: string, code: string) {
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
      await (sgMail as any).send(msg);
      this.logger.log(`✅ Verification email sent to ${email}`);
    } catch (err: any) {
      this.logger.error('SendGrid raw error:', err.response?.body || err.message || err);
      throw new Error('Failed to send verification email');
    }
  }

  async sendPasswordReset(email: string, token: string) {
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
      await (sgMail as any).send(msg);
      this.logger.log(`✅ Password reset email sent to ${email}`);
    } catch (err: any) {
      this.logger.error('SendGrid raw error:', err.response?.body || err.message || err);
      throw new Error('Failed to send password reset email');
    }
  }
}
