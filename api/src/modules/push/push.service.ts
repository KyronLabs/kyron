import {
  Injectable,
  Logger,
  OnApplicationBootstrap,
  OnModuleInit,
} from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import {
  readSecretFiles,
  readServiceAccount,
  type ServiceAccount,
} from './service-account';

/** What a push says when it lands on a locked screen. */
export interface PushMessage {
  title: string;
  body: string;
  /** Carried through so a tap can open the right screen. */
  data?: Record<string, string>;
}

/** Google's endpoint for a single send, per project. */
const FCM_SEND = (projectId: string) =>
  `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`;

const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const SCOPE = 'https://www.googleapis.com/auth/firebase.messaging';

/**
 * Sends a notification to somebody's phone.
 *
 * Configured by `FCM_SERVICE_ACCOUNT_JSON`, the service account key downloaded
 * from the Firebase console (or a Render secret file holding it; see
 * `readServiceAccount` for what else it forgives). Without it this class does
 * nothing -- and says so once at boot and once per attempt at debug level,
 * rather than reporting success it did not have. A silent no-op here is worse
 * than no push at all: it looks like delivery works right up until somebody
 * checks why nobody is opening the app.
 */
@Injectable()
export class PushService implements OnModuleInit, OnApplicationBootstrap {
  private readonly logger = new Logger(PushService.name);

  private credentials: ServiceAccount | null = null;
  private accessToken: { value: string; expiresAt: number } | null = null;

  /** Why push is not working, in words /health can show. */
  private problem: string | null = null;

  /** Whether Google refused the key outright, as against being unreachable. */
  private keyRefused = false;

  /** The last thing Google said when it would not deliver a notification. */
  private lastFailure: string | null = null;

  constructor(private readonly prisma: PrismaService) {}

  onModuleInit(): void {
    const reading = readServiceAccount(process.env, readSecretFiles());
    if ('problem' in reading) {
      this.problem = reading.problem;
      this.logger.error(
        `No push notification will be delivered. ${reading.problem}`,
      );
      return;
    }
    this.credentials = reading.account;
    this.logger.log(
      `Push notifications are on, for Firebase project ` +
        `${reading.account.project_id}, with the key from ${reading.source}.`,
    );
  }

  /**
   * Asks Google for an access token once the app is up, rather than at the
   * first notification: a key Google refuses then shows on /health from boot,
   * not after somebody wonders why their phone is quiet. Not awaited, so a
   * slow Google does not hold up the server starting.
   */
  onApplicationBootstrap(): void {
    if (this.credentials) void this.authorize();
  }

  get isConfigured(): boolean {
    return this.credentials !== null && !this.keyRefused;
  }

  /** What /health says about push. */
  get status(): {
    push: 'configured' | 'off';
    problem?: string;
    lastFailure?: string;
  } {
    return {
      push: this.isConfigured ? 'configured' : 'off',
      ...(this.problem ? { problem: this.problem } : {}),
      ...(this.lastFailure ? { lastFailure: this.lastFailure } : {}),
    };
  }

  /** Remembers where to reach somebody, moving the token if it has moved. */
  async register(
    userId: string,
    token: string,
    platform: string,
  ): Promise<void> {
    await this.prisma.deviceToken.upsert({
      where: { token },
      // A handset that changed hands belongs to whoever is signed in now.
      update: { userId, platform, updatedAt: new Date() },
      create: { userId, token, platform },
    });
  }

  /** Forgets one device. Called on sign-out. */
  async forget(token: string): Promise<void> {
    await this.prisma.deviceToken.deleteMany({ where: { token } });
  }

  /** Forgets every device of one account. */
  async forgetAll(userId: string): Promise<void> {
    await this.prisma.deviceToken.deleteMany({ where: { userId } });
  }

  /**
   * Pushes to every device one person has.
   *
   * Never awaited by a request handler: a slow round trip to Google must not
   * hold up the reply to whoever sent the message. Failures are logged, and a
   * token the platform rejects is deleted so it is not tried forever.
   */
  async sendTo(userId: string, message: PushMessage): Promise<void> {
    await this.sendCounting(userId, message);
  }

  /**
   * Sends somebody a notification so they can see push working -- or be told
   * which part of it is not.
   *
   * Push has three halves that fail silently and separately: this server's
   * key, the phone's registration, and Google accepting the pair. The answer
   * names which, so "I never get notifications" has a cause on screen rather
   * than a guess.
   */
  async test(userId: string): Promise<PushTestResult> {
    const devices = await this.prisma.deviceToken.count({ where: { userId } });
    if (!this.isConfigured) {
      return { configured: false, devices, delivered: 0 };
    }
    const delivered = await this.sendCounting(userId, {
      title: 'Kyron',
      body: 'Notifications are working.',
      data: { type: 'test' },
    });
    return { configured: true, devices, delivered };
  }

  /** Sends to every device somebody has, and answers how many took it. */
  private async sendCounting(
    userId: string,
    message: PushMessage,
  ): Promise<number> {
    if (!this.credentials) return 0;

    const devices = await this.prisma.deviceToken.findMany({
      where: { userId },
      select: { token: true },
    });
    if (devices.length === 0) return 0;

    const accessToken = await this.authorize();
    if (!accessToken) return 0;

    const outcomes = await Promise.all(
      devices.map((device) => this.deliver(device.token, message, accessToken)),
    );
    return outcomes.filter((outcome) => outcome === 'sent').length;
  }

  private async deliver(
    token: string,
    message: PushMessage,
    accessToken: string,
  ): Promise<'sent' | 'gone' | 'failed'> {
    const projectId = this.credentials?.project_id;
    if (!projectId) return 'failed';

    try {
      const response = await fetch(FCM_SEND(projectId), {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: PushService.payload(token, message) }),
      });

      if (response.ok) {
        this.lastFailure = null;
        return 'sent';
      }

      const detail = await response.text();
      if (PushService.tokenIsGone(response.status, detail)) {
        await this.prisma.deviceToken.deleteMany({ where: { token } });
        return 'gone';
      }

      this.lastFailure = PushService.describeRejection(response.status, detail);
      this.logger.warn(`Push rejected with ${response.status}: ${detail}`);
      return 'failed';
    } catch (error) {
      this.logger.warn(`Push could not be delivered: ${String(error)}`);
      return 'failed';
    }
  }

  /**
   * The FCM message for one device.
   *
   * High priority on Android, or a phone in Doze holds the notification until
   * it next wakes on its own, which can be most of an hour. On a channel the
   * app creates -- Messages, which may pop up over whatever is on screen, and
   * Activity, which may not -- so people can silence one without the other.
   * Messages from one conversation share a tag and replace each other rather
   * than stacking, since each says only that something arrived.
   */
  static payload(token: string, message: PushMessage): object {
    const data = message.data ?? {};
    const isMessage = data.type === 'message';
    const tag = PushService.tagFor(data);
    return {
      token,
      notification: { title: message.title, body: message.body },
      data,
      android: {
        priority: 'HIGH',
        notification: {
          channel_id: isMessage ? 'messages' : 'activity',
          sound: 'default',
          ...(tag ? { tag } : {}),
        },
      },
      apns: { payload: { aps: { sound: 'default' } } },
    };
  }

  /**
   * Which notification on the phone a new one replaces.
   *
   * One per conversation, one per post, and one for new followers: a third
   * like on the same post updates the notification already there instead of
   * stacking a third. Fewer of them matters beyond tidiness -- at four,
   * Android bundles an app's notifications under a summary of its own
   * making, and a tap on that summary opens the app with nothing to say
   * where it was meant to go.
   */
  static tagFor(data: Record<string, string>): string | undefined {
    if (data.type === 'message') {
      return data.conversationId
        ? `conversation-${data.conversationId}`
        : undefined;
    }
    if (data.type !== 'notification') return undefined;
    if (data.postId) return `post-${data.postId}`;
    if (data.kind === 'follow') return 'follows';
    return undefined;
  }

  /**
   * Whether Google said this token will never work again.
   *
   * 404, or an error naming the token as unregistered or invalid. Not any
   * 400: Google answers 400 for a malformed *message* too, and deleting on
   * that wiped every device anybody had registered the first time one payload
   * was wrong.
   */
  static tokenIsGone(status: number, detail: string): boolean {
    if (status === 404) return true;
    if (status !== 400) return false;
    if (/UNREGISTERED/.test(detail)) return true;
    return /registration token/i.test(detail) && /not a valid/i.test(detail);
  }

  /**
   * What Google's refusal to deliver means, for whoever has to fix it.
   *
   * Two refusals are configuration rather than the phone, and say nothing
   * useful in Google's own words: a key from a different Firebase project
   * than the app's, and a project where the messaging API is switched off.
   */
  static describeRejection(status: number, detail: string): string {
    let code = '';
    let message = '';
    try {
      const body = JSON.parse(detail) as {
        error?: {
          message?: string;
          status?: string;
          details?: Array<{ errorCode?: string }>;
        };
      };
      code =
        body.error?.details?.find((d) => d.errorCode)?.errorCode ??
        body.error?.status ??
        '';
      message = body.error?.message ?? '';
    } catch {
      message = detail;
    }

    const said = `Google answered ${status}${code ? ` ${code}` : ''}`;
    if (code === 'SENDER_ID_MISMATCH') {
      return (
        `${said}: the key is for a different Firebase project than the ` +
        "app's google-services.json. Generate the key in the app's project."
      );
    }
    if (/has not been used|is disabled|SERVICE_DISABLED/i.test(detail)) {
      return (
        `${said}: the Firebase Cloud Messaging API is off for the key's ` +
        'project. Turn it on in the Google Cloud console, APIs and services.'
      );
    }
    return `${said}: ${message.slice(0, 200)}`;
  }

  /**
   * An OAuth access token for the service account, cached until it expires.
   *
   * Signed here rather than through firebase-admin: the whole of what that
   * package would be used for is this one exchange and one POST, and it pulls
   * in a large dependency tree to do it.
   */
  private async authorize(): Promise<string | null> {
    const credentials = this.credentials;
    if (!credentials) return null;

    const now = Math.floor(Date.now() / 1000);
    // A minute of slack, so a token that expires mid-flight is not used.
    if (this.accessToken && this.accessToken.expiresAt > now + 60) {
      return this.accessToken.value;
    }

    let assertion: string;
    try {
      assertion = this.signAssertion(credentials, now);
    } catch (error) {
      // Nothing to retry: a key that cannot sign never will.
      this.keyRefused = true;
      this.problem =
        'The private_key in the service account key could not sign ' +
        `(${String(error)}). Generate a new key and paste the whole file.`;
      this.logger.error(this.problem);
      return null;
    }

    try {
      const response = await fetch(TOKEN_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion,
        }),
      });

      if (!response.ok) {
        const answer = await response.text();
        let reason = '';
        try {
          const body = JSON.parse(answer) as {
            error?: string;
            error_description?: string;
          };
          reason = [body.error, body.error_description]
            .filter(Boolean)
            .join(': ');
        } catch {
          reason = answer.slice(0, 200);
        }
        // A 4xx is Google saying no to this key, which retrying will not
        // change; a 5xx is Google having a bad minute.
        this.keyRefused = response.status < 500;
        const said = `${response.status}${reason ? ` ${reason}` : ''}`;
        this.problem = this.keyRefused
          ? `Google refused the service account key (${said}). A key ` +
            'deleted in the Google Cloud console is refused like this: ' +
            'generate a new one.'
          : `Google could not check the service account key just now ` +
            `(${said}). It is asked again with the next notification.`;
        this.logger.error(this.problem);
        return null;
      }

      const body = (await response.json()) as {
        access_token: string;
        expires_in: number;
      };
      this.accessToken = {
        value: body.access_token,
        expiresAt: now + body.expires_in,
      };
      this.keyRefused = false;
      this.problem = null;
      return body.access_token;
    } catch (error) {
      this.problem = `Could not reach Google to authorise: ${String(error)}`;
      this.logger.error(this.problem);
      return null;
    }
  }

  /** The signed JWT Google takes in exchange for an access token. */
  private signAssertion(credentials: ServiceAccount, now: number): string {
    // Required lazily so this file can be imported in a test that never sends.
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    const { createSign } = require('crypto') as typeof import('crypto');

    const header = { alg: 'RS256', typ: 'JWT' };
    const claims = {
      iss: credentials.client_email,
      scope: SCOPE,
      aud: TOKEN_URL,
      iat: now,
      exp: now + 3600,
    };

    const encode = (value: object): string =>
      Buffer.from(JSON.stringify(value)).toString('base64url');

    const unsigned = `${encode(header)}.${encode(claims)}`;
    const signature = createSign('RSA-SHA256')
      .update(unsigned)
      .sign(credentials.private_key, 'base64url');

    return `${unsigned}.${signature}`;
  }
}

/** What a test notification found. */
export interface PushTestResult {
  /** Whether this server has a key to send with at all. */
  configured: boolean;
  /** How many phones the reader has registered. */
  devices: number;
  /** How many of them Google accepted the test for. */
  delivered: number;
}
