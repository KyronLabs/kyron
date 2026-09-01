import { Controller, Logger, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { MediaService } from './media.service';

/**
 * The slice of the Fastify multipart request this handler touches. Typed
 * locally because @fastify/multipart augments FastifyRequest, which the Nest
 * @Req() decorator does not surface here.
 */
interface MultipartFile {
  filename: string;
  mimetype: string;
  fields: Record<string, { value?: unknown } | undefined>;
  toBuffer(): Promise<Buffer>;
}

interface MultipartRequest {
  user: { id: string };
  file(): Promise<MultipartFile | undefined>;
}

@Controller('media')
@UseGuards(AuthGuard)
export class MediaController {
  private readonly logger = new Logger(MediaController.name);

  constructor(private readonly svc: MediaService) {}

  /**
   * Uploads one file and answers with the URL to attach.
   *
   * Separate from creating the post so a slow upload does not hold a half-typed
   * post hostage, and so a failed post does not lose the pictures with it.
   */
  @Post()
  async upload(@Req() req: MultipartRequest) {
    const file = await req.file();
    if (!file) return { error: 'No file uploaded' };

    // Dimensions are measured on the device, which has already decoded the
    // image to show a preview. Doing it again here would mean decoding
    // untrusted image data on the server for a number used only for layout.
    const width = numberField(file, 'width');
    const height = numberField(file, 'height');

    return this.svc.upload(req.user.id, await file.toBuffer(), file.mimetype, {
      width,
      height,
    });
  }
}

function numberField(file: MultipartFile, name: string): number | undefined {
  const raw = file.fields?.[name]?.value;
  const value = Number(raw);
  return Number.isFinite(value) && value > 0 ? Math.round(value) : undefined;
}
