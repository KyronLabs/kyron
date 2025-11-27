import { Injectable, Logger } from '@nestjs/common';
import * as sgMail from '@sendgrid/mail';

@Injectable()
export class EmailService {
  private readonly logger = new Logger(EmailService.name);

  constructor() {
    const apiKey = process.env.SENDGRID_API_KEY;

    if (!apiKey) {
      this.logger.error('SENDGRID_API_KEY is missing.');
      return;
    }

    sgMail.setApiKey(apiKey);
    this.logger.log('SendGrid initialized.');
  }

  async sendVerifyCode(email: string, code: string) {
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
      await sgMail.send(msg);
      this.logger.log(`Verification email sent to ${email}`);
    } catch (err) {
      const error = err instanceof Error ? err : new Error(String(err));
      this.logger.error(`SendGrid verify error: ${error.message}`);
      throw new Error('Failed to send verification email');
    }
  }

  async sendPasswordReset(email: string, token: string) {
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
          color:#fff;
          border-radius:5px;
          text-decoration:none;">
          Reset Password
        </a>
      `,
    };

    try {
      await sgMail.send(msg);
      this.logger.log(`Password reset email sent to ${email}`);
    } catch (err) {
      const error = err instanceof Error ? err : new Error(String(err));
      this.logger.error(`SendGrid reset error: ${error.message}`);
      throw new Error('Failed to send password reset email');
    }
  }
}