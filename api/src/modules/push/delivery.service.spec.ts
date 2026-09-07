import { RealtimeService, type Sendable } from '../realtime/realtime.service';
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

  it('uses the socket and stays off the phone when the app is open', async () => {
    const socket = new FakeSocket();
    realtime.register('me', socket);

    delivery.tell('me', event, alert);
    await Promise.resolve();

    expect(socket.sent).toHaveLength(1);
    // A phone that buzzes for something already on screen is the thing this
    // check exists to prevent.
    expect(push.sent).toEqual([]);
  });

  it('pushes when nobody is connected', async () => {
    delivery.tell('me', event, alert);
    await Promise.resolve();

    expect(push.sent).toEqual([{ userId: 'me', message: alert }]);
  });

  it('decides per person, not per event', async () => {
    // Two people in one conversation are rarely in the same place.
    const socket = new FakeSocket();
    realtime.register('here', socket);

    delivery.tellMany(['here', 'away'], event, alert);
    await Promise.resolve();

    expect(socket.sent).toHaveLength(1);
    expect(push.sent.map((s) => s.userId)).toEqual(['away']);
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
});
