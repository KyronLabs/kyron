import { Test } from '@nestjs/testing';
import { FeedController } from './feed.controller';
import { FeedService } from './feed.service';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { CreatePostDto } from './dto/create-post.dto';

/**
 * The controller names every field it forwards rather than spreading the body,
 * so that nothing the client sends can reach the service unless it is meant
 * to. The cost of that is a field going missing in silence, which is exactly
 * what happened to the poll: validated on the way in, dropped here, and the
 * post written without it. These pin the forwarding down.
 */
describe('FeedController.create', () => {
  const createPost = jest.fn();

  const request = { user: { id: 'viewer-1' } } as AuthRequest;

  const controller = async () => {
    const module = await Test.createTestingModule({
      controllers: [FeedController],
      providers: [{ provide: FeedService, useValue: { createPost } }],
    })
      .overrideGuard(AuthGuard)
      .useValue({ canActivate: () => true })
      .compile();

    return module.get(FeedController);
  };

  beforeEach(() => createPost.mockReset().mockResolvedValue({ id: 'p1' }));

  const dto = (over: Partial<CreatePostDto> = {}): CreatePostDto =>
    ({ content: 'hello', ...over }) as CreatePostDto;

  it('forwards the poll', async () => {
    await (
      await controller()
    ).create(
      request,
      dto({
        content: 'Which one?',
        poll: { options: ['Yes', 'No'], durationMinutes: 60 },
      }),
    );

    expect(createPost).toHaveBeenCalledWith(
      'viewer-1',
      expect.objectContaining({
        poll: { options: ['Yes', 'No'], durationMinutes: 60 },
      }),
    );
  });

  it('forwards the attachments, the quote and the reply setting', async () => {
    await (
      await controller()
    ).create(
      request,
      dto({
        media: [{ url: 'https://example.test/a.jpg' }],
        quotedPostId: '11111111-1111-4111-8111-111111111111',
        replyPolicy: 'FOLLOWERS' as CreatePostDto['replyPolicy'],
      }),
    );

    expect(createPost).toHaveBeenCalledWith('viewer-1', {
      content: 'hello',
      media: [{ url: 'https://example.test/a.jpg' }],
      quotedPostId: '11111111-1111-4111-8111-111111111111',
      replyPolicy: 'FOLLOWERS',
      poll: undefined,
    });
  });

  it('takes the author from the token, never from the body', async () => {
    // The route used to accept an authorId, so any caller could post as
    // anyone by naming them in a field nobody sees.
    await (
      await controller()
    ).create(request, {
      ...dto(),
      authorId: 'somebody-else',
    } as CreatePostDto & { authorId: string });

    const [authorId, input] = createPost.mock.calls[0] as [
      string,
      Record<string, unknown>,
    ];
    expect(authorId).toBe('viewer-1');
    expect(input).not.toHaveProperty('authorId');
  });
});
