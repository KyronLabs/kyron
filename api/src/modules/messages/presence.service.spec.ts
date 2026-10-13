import { RealtimeGateway } from '../realtime/realtime.gateway';
import type { RealtimeEvent, Sendable } from '../realtime/realtime.service';
import { RealtimeService } from '../realtime/realtime.service';
import { PresenceService } from './presence.service';

/**
 * Who is online, and who may be told: only the people an account talks to,
 * only while both show their own, never across a block, and never a dot that
 * blinks for a phone changing networks.
 */
describe('PresenceService', () => {
  const socket = (): Sendable & { sent: RealtimeEvent[] } => {
    const sent: RealtimeEvent[] = [];
    return {
      sent,
      send: (data: string) => sent.push(JSON.parse(data) as RealtimeEvent),
    };
  };

  let realtime: RealtimeService;
  let showOnline: Record<string, boolean>;
  let findMany: jest.Mock;
  let presence: PresenceService;

  /** What Ada's conversation partner has been told about her. */
  const toldAboutAda = (s: { sent: RealtimeEvent[] }) =>
    s.sent.filter((e) => e.type === 'presence' && e.userId === 'ada');

  beforeEach(() => {
    jest.useFakeTimers();
    realtime = new RealtimeService();
    showOnline = { ada: true, bo: true };
    // Ada and Bo have a conversation; each is the other's audience.
    findMany = jest.fn(({ where }: { where: { userId: { not: string } } }) =>
      Promise.resolve(
        where.userId.not === 'ada' ? [{ userId: 'bo' }] : [{ userId: 'ada' }],
      ),
    );
    const prisma = {
      user: {
        findUnique: jest.fn(({ where }: { where: { id: string } }) =>
          Promise.resolve({ showOnline: showOnline[where.id] ?? true }),
        ),
      },
      conversationMember: { findMany },
    };
    presence = new PresenceService(realtime, prisma as never);
  });

  afterEach(() => {
    presence.onModuleDestroy();
    jest.useRealTimers();
  });

  /** Lets the announcement's queries resolve. */
  const settle = async () => {
    for (let i = 0; i < 5; i++) await Promise.resolve();
  };

  it('tells the people Ada talks to when she opens the app', async () => {
    const bo = socket();
    realtime.register('bo', bo);
    realtime.register('ada', socket());
    await settle();

    expect(toldAboutAda(bo)).toEqual([
      { type: 'presence', userId: 'ada', online: true },
    ]);
    // Asked only about people she shares a conversation with, who show
    // their own, across no block either way.
    const where = (
      findMany.mock.calls as [{ where: { userId: { not: string } } }][]
    ).find(([args]) => args.where.userId.not === 'ada')?.[0].where;
    expect(where).toEqual({
      userId: { not: 'ada' },
      conversation: { members: { some: { userId: 'ada' } } },
      user: {
        showOnline: true,
        blocking: { none: { blockedId: 'ada' } },
        blockedBy: { none: { blockerId: 'ada' } },
      },
    });
  });

  it('counts an app in the background as not here', async () => {
    const bo = socket();
    const phone = socket();
    realtime.register('bo', bo);
    realtime.register('ada', phone);
    await settle();
    expect(realtime.isOnline('ada')).toBe(true);

    realtime.setAway('ada', phone, true);
    expect(realtime.isOnline('ada')).toBe(false);
    // Still connected: the socket is open, the reader is not looking.
    expect(realtime.isConnected('ada')).toBe(true);
  });

  it('waits out a network change before saying she left', async () => {
    const bo = socket();
    const first = socket();
    realtime.register('bo', bo);
    realtime.register('ada', first);
    await settle();

    // Signal drops, and a new socket is up a few seconds later.
    realtime.unregister('ada', first);
    jest.advanceTimersByTime(4_000);
    realtime.register('ada', socket());
    jest.advanceTimersByTime(PresenceService.graceMs);
    await settle();

    expect(toldAboutAda(bo)).toEqual([
      { type: 'presence', userId: 'ada', online: true },
    ]);
  });

  it('says she left once she has been gone past the grace', async () => {
    const bo = socket();
    const phone = socket();
    realtime.register('bo', bo);
    realtime.register('ada', phone);
    await settle();

    realtime.setAway('ada', phone, true);
    jest.advanceTimersByTime(PresenceService.graceMs + 10);
    await settle();

    expect(toldAboutAda(bo).at(-1)).toEqual({
      type: 'presence',
      userId: 'ada',
      online: false,
    });
  });

  it('says nothing about somebody who does not show it', async () => {
    showOnline.ada = false;
    const bo = socket();
    realtime.register('bo', bo);
    realtime.register('ada', socket());
    await settle();

    expect(toldAboutAda(bo)).toEqual([]);
  });

  it('turning it off takes the dot away at once', async () => {
    const bo = socket();
    realtime.register('bo', bo);
    realtime.register('ada', socket());
    await settle();

    const ada = socket();
    realtime.register('ada', ada);
    await settle();
    await presence.settingChanged('ada', false);

    expect(toldAboutAda(bo).at(-1)).toEqual({
      type: 'presence',
      userId: 'ada',
      online: false,
    });
    // And she sees nobody now, without waiting for her app to reconnect.
    expect(ada.sent.at(-1)).toEqual({ type: 'presence.snapshot', online: [] });
  });

  it('hands a socket that connects who is online now', async () => {
    // Whatever changed while it was gone was not sent to it.
    realtime.register('ada', socket());
    await settle();
    const bo = socket();
    realtime.register('bo', bo);
    await settle();

    expect(bo.sent.find((e) => e.type === 'presence.snapshot')).toEqual({
      type: 'presence.snapshot',
      online: ['ada'],
    });
  });

  it('hands somebody who hides their own nobody', async () => {
    realtime.register('ada', socket());
    showOnline.bo = false;
    const bo = socket();
    realtime.register('bo', bo);
    await settle();

    expect(bo.sent.find((e) => e.type === 'presence.snapshot')).toEqual({
      type: 'presence.snapshot',
      online: [],
    });
  });

  describe('who a reader may see as online', () => {
    it('only while both show it, and only the person is here', () => {
      realtime.register('ada', socket());

      expect(presence.visible(true, { id: 'ada', showOnline: true })).toBe(
        true,
      );
      // The reader hides theirs: they see nobody's.
      expect(presence.visible(false, { id: 'ada', showOnline: true })).toBe(
        false,
      );
      // Ada hides hers.
      expect(presence.visible(true, { id: 'ada', showOnline: false })).toBe(
        false,
      );
      // Nobody there.
      expect(presence.visible(true, { id: 'cy', showOnline: true })).toBe(
        false,
      );
    });
  });
});

describe('the presence frame', () => {
  it('reads the two states the app sends, and nothing else', () => {
    expect(
      RealtimeGateway.presenceFrame('{"type":"presence","state":"away"}'),
    ).toBe(true);
    expect(
      RealtimeGateway.presenceFrame(
        Buffer.from('{"type":"presence","state":"here"}'),
      ),
    ).toBe(false);
    expect(RealtimeGateway.presenceFrame('{"type":"presence"}')).toBeNull();
    expect(RealtimeGateway.presenceFrame('{"type":"message.new"}')).toBeNull();
    expect(RealtimeGateway.presenceFrame('not json')).toBeNull();
    expect(RealtimeGateway.presenceFrame(42)).toBeNull();
    // Nobody gets to make the server parse something large.
    expect(
      RealtimeGateway.presenceFrame(
        `{"type":"presence","state":"away","pad":"${'x'.repeat(500)}"}`,
      ),
    ).toBeNull();
  });
});
