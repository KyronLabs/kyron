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
    if (!this.credentials) return;

    const devices = await this.prisma.deviceToken.findMany({
      where: { userId },
      select: { token: true },
    });
    if (devices.length === 0) return;

    const accessToken = await this.authorize();
    if (!accessToken) return;

    await Promise.all(
      devices.map((device) => this.deliver(device.token, message, accessToken)),
    );
  }

  private async deliver(
    token: string,
    message: PushMessage,
    accessToken: string,
  ): Promise<void> {
    const projectId = this.credentials?.project_id;
    if (!projectId) return;

    try {
      const response = await fetch(FCM_SEND(projectId), {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          message: {
            token,
            notification: { title: message.title, body: message.body },
            data: message.data ?? {},
          },
        }),
      });

      if (response.ok) return;

      // 404 means the token is gone; 400 UNREGISTERED means the same thing in
      // a different dress. Either way it will never work again, so it goes
      // rather than being retried on every future notification.
      if (response.status === 404 || response.status === 400) {
        await this.prisma.deviceToken.deleteMany({ where: { token } });
        return;
      }

      this.logger.warn(
        `Push rejected with ${response.status}: ${await response.text()}`,
      );
    } catch (error) {
      this.logger.warn(`Push could not be delivered: ${String(error)}`);
    }
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

/** The fields this service needs from a Firebase service account key. */
interface ServiceAccount {
  project_id: string;
  client_email: string;
  private_key: string;
}
