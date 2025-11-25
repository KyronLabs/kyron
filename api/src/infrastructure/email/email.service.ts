/* eslint-disable @typescript-eslint/no-require-imports */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-call */
import { Injectable, Logger } from '@nestjs/common';
import sgMail = require('@sendgrid/mail');

@Injectable()
export class EmailService {
  private readonly logger = new Logger(EmailService.name);

  constructor() {
    if (!process.env.SENDGRID_API_KEY) {
      this.logger.error('SENDGRID_API_KEY not set in environment');
    } else {
      sgMail.setApiKey(process.env.SENDGRID_API_KEY);
    }
  }

  // ---------------------------
  // Send Verification Code
  // ---------------------------
  async sendVerifyCode(email: string, code: string) {
    const msg = {
      to: email,
      from: process.env.EMAIL_FROM || 'noreply@kyron.spidroid.com',
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
      this.logger.error(`SendGrid error sending verify code`, err);
      throw err;
    }
  }

  // ---------------------------
  // Send Password Reset Email
  // ---------------------------
  async sendPasswordReset(email: string, token: string) {
    const resetUrl = `${process.env.FRONTEND_URL}/reset-password?token=${token}`;

    const msg = {
      to: email,
      from: process.env.EMAIL_FROM || 'noreply@kyron.spidroid.com',
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
      await sgMail.send(msg);
      this.logger.log(`Password reset email sent to ${email}`);
    } catch (err) {
      this.logger.error(`SendGrid error sending password reset`, err);
      throw err;
    }
  }
}
