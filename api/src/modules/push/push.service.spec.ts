import { generateKeyPairSync } from 'crypto';

import { PushService } from './push.service';

/**
 * The half of push that talks to Google.
 *
 * What these hold: a device is forgotten only when Google says the token is
 * dead -- never for a malformed message -- and the message is built to arrive
 * promptly on Android, on the channel it belongs to.
 */
function serviceWith(devices: string[]) {
  const deleted: string[] = [];
  const prisma = {
    deviceToken: {
      findMany: jest.fn(() =>
        Promise.resolve(devices.map((token) => ({ token }))),
      ),
      count: jest.fn(() => Promise.resolve(devices.length)),
      deleteMany: jest.fn((args: { where: { token: string } }) => {
        deleted.push(args.where.token);
        return Promise.resolve({ count: 1 });
      }),
    },
  };
  const service = new PushService(prisma as never);
  return { service, deleted };
}

function configure(service: PushService) {
  const { privateKey } = generateKeyPairSync('rsa', { modulusLength: 2048 });
  process.env.FCM_SERVICE_ACCOUNT_JSON = JSON.stringify({
    project_id: 'kyron-test',
    client_email: 'push@kyron-test.iam.gserviceaccount.com',
    private_key: privateKey.export({ type: 'pkcs8', format: 'pem' }),
  });
  service.onModuleInit();
  delete process.env.FCM_SERVICE_ACCOUNT_JSON;
}

/** Google's token endpoint, then each send answered with [answers] in turn. */
function mockGoogle(answers: Array<{ status: number; body?: string }>) {
  const sends: unknown[] = [];
  const queue = [...answers];
  jest
    .spyOn(global, 'fetch')
    .mockImplementation((url: string | URL | Request, init?: RequestInit) => {
      const address = url instanceof Request ? url.url : url.toString();
      if (address.includes('oauth2')) {
        return Promise.resolve(
          new Response(
            JSON.stringify({ access_token: 'at', expires_in: 3600 }),
            {
              status: 200,
            },
          ),
        );
      }
      sends.push(JSON.parse(init?.body as string));
      const answer = queue.shift() ?? { status: 200 };
      return Promise.resolve(
        new Response(answer.body ?? '{}', { status: answer.status }),
      );
    });
  return sends;
}

afterEach(() => jest.restoreAllMocks());

describe('a message to a phone', () => {
  it('is high priority on the Messages channel, one per conversation', () => {
    const payload = PushService.payload('t', {
      title: 'Ada',
      body: 'Sent you a message',
      data: { type: 'message', conversationId: 'c1' },
    }) as { android: { priority: string; notification: object } };

    expect(payload.android.priority).toBe('HIGH');
    expect(payload.android.notification).toEqual(
      expect.objectContaining({
        channel_id: 'messages',
        tag: 'conversation-c1',
      }),
    );
  });

  it('everything else goes on the Activity channel', () => {
    const payload = PushService.payload('t', {
      title: 'Kyron',
      body: 'Somebody liked your post.',
      data: { type: 'notification', kind: 'like' },
    }) as { android: { notification: { channel_id: string; tag?: string } } };

    expect(payload.android.notification.channel_id).toBe('activity');
    expect(payload.android.notification.tag).toBeUndefined();
  });
});

describe('when Google says no', () => {
  it('forgets a device whose token is gone', async () => {
    const { service, deleted } = serviceWith(['dead', 'unregistered']);
    configure(service);
    mockGoogle([
      { status: 404 },
      {
        status: 400,
        body: '{"error":{"details":[{"errorCode":"UNREGISTERED"}]}}',
      },
    ]);

    await service.sendTo('u1', { title: 'x', body: 'y' });

    expect(deleted.sort()).toEqual(['dead', 'unregistered']);
  });

  it('keeps every device when the message itself was wrong', async () => {
    // A 400 for a bad payload used to delete the token it was sent to, so
    // one malformed notification wiped every phone anybody had registered.
    const { service, deleted } = serviceWith(['a', 'b']);
    configure(service);
    mockGoogle([
      { status: 400, body: '{"error":{"status":"INVALID_ARGUMENT"}}' },
      { status: 400, body: '{"error":{"status":"INVALID_ARGUMENT"}}' },
    ]);

    await service.sendTo('u1', { title: 'x', body: 'y' });

    expect(deleted).toEqual([]);
  });
});

describe('a test notification', () => {
  it('says when this server has no key to send with', async () => {
    const { service } = serviceWith(['a']);
    service.onModuleInit();

    await expect(service.test('u1')).resolves.toEqual({
      configured: false,
      devices: 1,
      delivered: 0,
    });
  });

  it('says how many phones took it', async () => {
    const { service } = serviceWith(['a', 'b']);
    configure(service);
    const sends = mockGoogle([{ status: 200 }, { status: 500 }]);

    await expect(service.test('u1')).resolves.toEqual({
      configured: true,
      devices: 2,
      delivered: 1,
    });
    expect(sends).toHaveLength(2);
  });
});
