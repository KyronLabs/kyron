import { EventEmitter } from 'node:events';

import { RealtimeGateway } from './realtime.gateway';

describe('RealtimeGateway auth frame', () => {
  it('reads the token from an auth frame', () => {
    expect(RealtimeGateway.authFrame('{"type":"auth","token":" abc "}')).toBe(
      'abc',
    );
    expect(
      RealtimeGateway.authFrame(Buffer.from('{"type":"auth","token":"t"}')),
    ).toBe('t');
  });

  it('ignores anything else', () => {
    expect(
      RealtimeGateway.authFrame('{"type":"presence","state":"away"}'),
    ).toBe(null);
    expect(RealtimeGateway.authFrame('{"type":"auth","token":7}')).toBe(null);
    expect(RealtimeGateway.authFrame('not json')).toBe(null);
    expect(RealtimeGateway.authFrame('x'.repeat(9000))).toBe(null);
  });

  it('takes the first frame', async () => {
    const socket = new EventEmitter();
    const token = RealtimeGateway.firstFrameToken(socket as never, 1000);
    socket.emit('message', '{"type":"auth","token":"first"}');
    socket.emit('message', '{"type":"auth","token":"second"}');
    await expect(token).resolves.toBe('first');
  });

  it('gives up on a socket that says nothing', async () => {
    jest.useFakeTimers();
    const socket = new EventEmitter();
    const token = RealtimeGateway.firstFrameToken(socket as never, 5000);
    jest.advanceTimersByTime(5000);
    await expect(token).resolves.toBe(null);
    expect(socket.listenerCount('message')).toBe(0);
    jest.useRealTimers();
  });
});
