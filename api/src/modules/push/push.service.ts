import { Injectable, Logger, OnModuleInit } from '@nestjs/common';

import { PrismaService } from '../../infrastructure/prisma/prisma.service';

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
 * from the Firebase console, as one line of JSON. Without it this class does
 * nothing -- and says so once at boot and once per attempt at debug level,
 * rather than reporting success it did not have. A silent no-op here is worse
 * than no push at all: it looks like delivery works right up until somebody
 * checks why nobody is opening the app.
 */
@Injectable()
export class PushService implements OnModuleInit {
  private readonly logger = new Logger(PushService.name);

  private credentials: ServiceAccount | null = null;
  private accessToken: { value: string; expiresAt: number } | null = null;

  constructor(private readonly prisma: PrismaService) {}

  onModuleInit(): void {
    const raw = process.env.FCM_SERVICE_ACCOUNT_JSON?.trim();
    if (!raw) {
      this.logger.warn(
        'FCM_SERVICE_ACCOUNT_JSON is not set, so no push notification will ' +
          'be delivered. Everything else works; people are simply never told ' +
          'about anything while the app is closed.',
      );
      return;
    }

    try {
      const parsed = JSON.parse(raw) as Partial<ServiceAccount>;
      if (!parsed.project_id || !parsed.client_email || !parsed.private_key) {
        throw new Error('missing project_id, client_email or private_key');
      }
      this.credentials = parsed as ServiceAccount;
      this.logger.log(
        `Push notifications are on, for Firebase project ${parsed.project_id}.`,
      );
    } catch (error) {
      // Loudly, and without throwing: a malformed key should not stop the API
      // from serving everything that has nothing to do with push.
      this.logger.error(
        `FCM_SERVICE_ACCOUNT_JSON is set but could not be read (${String(
          error,
        )}). No push notification will be delivered.`,
      );
    }
  }

  get isConfigured(): boolean {
    return this.credentials !== null;
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
    if (!this.credentials) {
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

      if (response.ok) return 'sent';

      const detail = await response.text();
      if (PushService.tokenIsGone(response.status, detail)) {
        await this.prisma.deviceToken.deleteMany({ where: { token } });
        return 'gone';
      }

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
    return {
      token,
      notification: { title: message.title, body: message.body },
      data,
      android: {
        priority: 'HIGH',
        notification: {
          channel_id: isMessage ? 'messages' : 'activity',
          sound: 'default',
          ...(isMessage && data.conversationId
            ? { tag: `conversation-${data.conversationId}` }
            : {}),
        },
      },
      apns: { payload: { aps: { sound: 'default' } } },
    };
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

    try {
      const assertion = this.signAssertion(credentials, now);
      const response = await fetch(TOKEN_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion,
        }),
      });

      if (!response.ok) {
        this.logger.error(
          `Could not authorise with Google (${response.status}). Push is off ` +
            'until this is fixed.',
        );
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
      return body.access_token;
    } catch (error) {
      this.logger.error(`Could not authorise with Google: ${String(error)}`);
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
      .sign(credentials.private_key.replace(/\\n/g, '\n'), 'base64url');

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

/** The fields this service needs from a Firebase service account key. */
interface ServiceAccount {
  project_id: string;
  client_email: string;
  private_key: string;
}
