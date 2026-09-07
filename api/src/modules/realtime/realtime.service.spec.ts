import { RealtimeService, type Sendable } from './realtime.service';

/** A socket that records, and can be told to fail the way a dead one does. */
class FakeSocket implements Sendable {
  readonly sent: string[] = [];
  broken = false;

  send(data: string): void {
    if (this.broken) throw new Error('socket closed');
    this.sent.push(data);
  }
}

describe('RealtimeService', () => {
  let realtime: RealtimeService;

  beforeEach(() => {
    realtime = new RealtimeService();
  });

  const event = {
    type: 'notification.new',
    kind: 'like',
    actorId: 'them',
  } as const;

  it('reaches every device one reader has open', () => {
    const phone = new FakeSocket();
    const laptop = new FakeSocket();
    realtime.register('me', phone);
    realtime.register('me', laptop);

    realtime.emitTo('me', event);

    expect(phone.sent).toEqual([JSON.stringify(event)]);
    expect(laptop.sent).toEqual([JSON.stringify(event)]);
  });

  it('says nothing to a reader who is not connected', () => {
    const phone = new FakeSocket();
    realtime.register('me', phone);

    realtime.emitTo('somebody-else', event);

    expect(phone.sent).toEqual([]);
  });

  it('sends once to a reader named twice', () => {
    // Everyone in a conversation is emitted to at once, and a caller building
    // that list has no reason to have de-duplicated it.
    const phone = new FakeSocket();
    realtime.register('me', phone);

    realtime.emitToMany(['me', 'me'], event);

    expect(phone.sent).toHaveLength(1);
  });

  it('drops a socket that throws rather than trying it again', () => {
    const dead = new FakeSocket();
    dead.broken = true;
    const live = new FakeSocket();
    realtime.register('me', dead);
    realtime.register('me', live);

    realtime.emitTo('me', event);
    dead.broken = false;
    realtime.emitTo('me', event);

    // A socket that has gone without saying so would otherwise be written to
    // for the life of the process.
    expect(dead.sent).toEqual([]);
    expect(live.sent).toHaveLength(2);
  });

  it('forgets a reader once their last device disconnects', () => {
    const phone = new FakeSocket();
    const laptop = new FakeSocket();
    realtime.register('me', phone);
    realtime.register('me', laptop);

    realtime.unregister('me', phone);
    expect(realtime.isConnected('me')).toBe(true);

    realtime.unregister('me', laptop);
    expect(realtime.isConnected('me')).toBe(false);
    expect(realtime.connectedReaders).toBe(0);
  });

  it('survives unregistering something that was never registered', () => {
    expect(() => realtime.unregister('nobody', new FakeSocket())).not.toThrow();
  });
});
