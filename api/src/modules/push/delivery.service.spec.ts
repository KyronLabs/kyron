import { RealtimeService, type Sendable } from '../realtime/realtime.service';
import type { Activity, ActivityPushService } from './activity-push.service';
import { DeliveryService } from './delivery.service';
import type { PushMessage, PushService } from './push.service';

class FakeSocket implements Sendable {
  readonly sent: string[] = [];
  send(data: string): void {
    this.sent.push(data);
  }
}

/** Records what would have gone to a phone. */
class FakePush {
  readonly sent: { userId: string; message: PushMessage }[] = [];
  sendTo(userId: string, message: PushMessage): Promise<void> {
    this.sent.push({ userId, message });
    return Promise.resolve();
  }
}

describe('DeliveryService', () => {
  let realtime: RealtimeService;
  let push: FakePush;
  let delivery: DeliveryService;

  beforeEach(() => {
    realtime = new RealtimeService();
    push = new FakePush();
    delivery = new DeliveryService(realtime, push as unknown as PushService);
  });

  const event = {
    type: 'notification.new',
    kind: 'like',
    actorId: 'a',
  } as const;
  const alert: PushMessage = { title: 'Kyron', body: 'Somebody liked it.' };

  it('pushes even with a socket open, which a backgrounded app keeps', async () => {
    // This used to skip the push for anybody connected, and a phone with the
    // screen off and the socket still alive heard about nothing. The phone,
    // not this server, knows whether the app is in front: it hands a push to
    // an app on screen instead of showing it.
    const socket = new FakeSocket();
    realtime.register('me', socket);

    delivery.tell('me', event, alert);
    await Promise.resolve();

    expect(socket.sent).toHaveLength(1);
    expect(push.sent).toEqual([{ userId: 'me', message: alert }]);
  });

  it('pushes when nobody is connected', async () => {
    delivery.tell('me', event, alert);
    await Promise.resolve();

    expect(push.sent).toEqual([{ userId: 'me', message: alert }]);
  });

  it('tells everyone by both routes, connected or not', async () => {
    const socket = new FakeSocket();
    realtime.register('here', socket);

    delivery.tellMany(['here', 'away'], event, alert);
    await Promise.resolve();

    expect(socket.sent).toHaveLength(1);
    expect(push.sent.map((s) => s.userId)).toEqual(['here', 'away']);
  });

  it('sends no push when the caller offered none', async () => {
    delivery.tell('me', event);
    await Promise.resolve();

    expect(push.sent).toEqual([]);
  });

  it('does not push the same person twice for one event', async () => {
    delivery.tellMany(['me', 'me'], event, alert);
    await Promise.resolve();

    expect(push.sent).toHaveLength(1);
  });

  describe('activity', () => {
    const like: Activity = { kind: 'like', actorId: 'a', postId: 'p1' };
    const settle = () => new Promise((resolve) => setImmediate(resolve));

    it('tells the socket at once and pushes the words worked out after', async () => {
      const words = {
        message: jest.fn(() =>
          Promise.resolve({ title: 'Ada', body: 'Liked your post' }),
        ),
      };
      delivery = new DeliveryService(
        realtime,
        push as unknown as PushService,
        words as unknown as ActivityPushService,
      );
      const socket = new FakeSocket();
      realtime.register('me', socket);

      delivery.tellActivity('me', event, like);
      // Before any of the push's work has run.
      expect(socket.sent).toHaveLength(1);
      await settle();

      expect(words.message).toHaveBeenCalledWith('me', like);
      expect(push.sent).toEqual([
        { userId: 'me', message: { title: 'Ada', body: 'Liked your post' } },
      ]);
    });

    it('pushes nothing when there are no words for it', async () => {
      delivery = new DeliveryService(
        realtime,
        push as unknown as PushService,
        {
          message: () => Promise.resolve(null),
        } as unknown as ActivityPushService,
      );

      delivery.tellActivity('me', event, like);
      await settle();

      expect(push.sent).toEqual([]);
    });

    it('survives the words failing', async () => {
      delivery = new DeliveryService(
        realtime,
        push as unknown as PushService,
        {
          message: () => Promise.reject(new Error('db down')),
        } as unknown as ActivityPushService,
      );

      delivery.tellActivity('me', event, like);
      await settle();

      expect(push.sent).toEqual([]);
    });
  });
});
