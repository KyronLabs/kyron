import type { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { RecordingDelivery } from '../push/delivery.test-double';
import { MessagesService } from './messages.service';

/**
 * Messaging settings, now that there are two. A client from before the
 * second existed sends only the first, and must not switch the other off by
 * leaving it out.
 */
describe('MessagesService settings', () => {
  const ME = '00000000-0000-0000-0000-000000000001';

  const build = () => {
    const update = jest.fn(({ data }: { data: Record<string, boolean> }) =>
      Promise.resolve({
        readReceipts: data.readReceipts ?? true,
        showOnline: data.showOnline ?? true,
      }),
    );
    const prisma = {
      user: {
        update,
        findUnique: jest.fn(() =>
          Promise.resolve({
            readReceipts: true,
            showOnline: false,
          }),
        ),
      },
    } as unknown as PrismaService;
    return {
      update,
      svc: new MessagesService(prisma, new RecordingDelivery()),
    };
  };

  it('reads both', async () => {
    const { svc } = build();
    await expect(svc.settings(ME)).resolves.toEqual({
      readReceipts: true,
      showOnline: false,
    });
  });

  it('changes only what it was sent', async () => {
    const { svc, update } = build();

    await svc.updateSettings(ME, { readReceipts: false });
    expect(update.mock.calls[0][0].data).toEqual({ readReceipts: false });

    await svc.updateSettings(ME, { showOnline: false });
    expect(update.mock.calls[1][0].data).toEqual({ showOnline: false });
  });
});
