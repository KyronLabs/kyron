import { Injectable, Logger } from '@nestjs/common';
import sgMail from '@sendgrid/mail';

/** The surface of @sendgrid/mail this service uses. */
interface SendGridClient {
  setApiKey(apiKey: string): void;
  send(msg: {
    to: string;
    from: string;
    subject: string;
    html: string;
  }): Promise<unknown>;
}

/**
 * Depending on how the package resolves under CJS, the mail service can arrive
 * either as the module itself or nested under `.default`. Pick whichever
 * actually carries setApiKey, once, so call sites get a typed client.
 */
function resolveSendGridClient(): SendGridClient {
  const mod = sgMail as unknown as SendGridClient & {
    default?: SendGridClient;
  };
  return typeof mod.default?.setApiKey === 'function' ? mod.default : mod;
}

/** SendGrid's error shape when a send is rejected. */
interface SendGridError {
  response?: { body?: unknown };
  message?: string;
}

function describeSendGridError(err: unknown): unknown {
  const e = err as SendGridError;
  return e?.response?.body ?? e?.message ?? err;
}

@Injectable()
export class EmailService {
  private readonly logger = new Logger(EmailService.name);

  /**
   * False when SENDGRID_API_KEY was absent at construction. The constructor
   * returns early in that case without calling setApiKey, so every send would
   * otherwise reach SendGrid unauthenticated and come back "Permission denied,
   * wrong credentials" -- which reads like a bad key rather than a missing one.
   */
  private configured = false;

  private readonly client: SendGridClient = resolveSendGridClient();

  constructor() {
    this.logger.log('📨 Initializing SendGrid EmailService...');
    const apiKey = process.env.SENDGRID_API_KEY;
    if (!apiKey) {
      this.logger.error(
        '❌ SENDGRID_API_KEY is missing in environment variables.',
      );
      return;
    }
    this.configured = true;
    this.logger.log(`🔐 SENDGRID_API_KEY loaded (length: ${apiKey.length})`);
    this.logger.log(`📤 EMAIL_FROM = ${process.env.EMAIL_FROM}`);
    if (typeof this.client.setApiKey === 'function') {
      this.client.setApiKey(apiKey);
      this.logger.log('✅ SendGrid initialized');
      return;
    }
    this.configured = false;
    this.logger.error(
      '❌ sgMail.setApiKey is NOT a function! Dumping sgMail object...',
    );
    this.logger.error(JSON.stringify(sgMail, null, 2));
    throw new Error('SendGrid initialization failed: setApiKey not found.');
  }

  private assertConfigured() {
    if (!this.configured) {
      throw new Error(
        'SENDGRID_API_KEY is not set, so no mail can be sent. Set it on the ' +
          'deployment (fly secrets set SENDGRID_API_KEY=...) and restart.',
      );
    }
  }

  async sendVerifyCode(email: string, code: string) {
    this.assertConfigured();
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
      await this.client.send(msg);
      this.logger.log(`✅ Verification email sent to ${email}`);
    } catch (err: unknown) {
      this.logger.error('SendGrid raw error:', describeSendGridError(err));
      throw new Error('Failed to send verification email');
    }
  }

  async sendPasswordReset(email: string, token: string) {
    this.assertConfigured();
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
      await this.client.send(msg);
      this.logger.log(`✅ Password reset email sent to ${email}`);
    } catch (err: unknown) {
      this.logger.error('SendGrid raw error:', describeSendGridError(err));
      throw new Error('Failed to send password reset email');
    }
  }
}
