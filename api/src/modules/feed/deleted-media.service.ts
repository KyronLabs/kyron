import {
  Injectable,
  Logger,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';
import { storedPathFromUrl } from '../media/stored-path';

/**
 * Removes the pictures and clips of posts deleted more than [graceDays] ago.
 *
 * Deleting a post only marks its row, and the files stayed in the public
 * bucket at the same address until the whole account went: anybody holding
 * the link could still open a photo its author had deleted. They are kept
 * for the grace period, not removed at once, because a report about the post
 * or an appeal against its removal still needs to see what it showed.
 */
@Injectable()
export class DeletedMediaService implements OnModuleInit, OnModuleDestroy {
  static readonly graceDays = 30;
  static readonly sweepMs = 6 * 60 * 60_000;
  static readonly batch = 200;

  private readonly logger = new Logger(DeletedMediaService.name);
  private timer: NodeJS.Timeout | null = null;

  constructor(
    private readonly prisma: PrismaService,
    private readonly supabase: SupabaseService,
  ) {}

  onModuleInit(): void {
    if (process.env.NODE_ENV === 'test') return;
    this.timer = setInterval(
      () => void this.sweep().catch(() => undefined),
      DeletedMediaService.sweepMs,
    );
    this.timer.unref();
  }

  onModuleDestroy(): void {
    if (this.timer) clearInterval(this.timer);
    this.timer = null;
  }

  /**
   * One batch: files first, then the rows, so a failed removal leaves the
   * rows to be tried again next time. Answers how many rows it cleared.
   */
  async sweep(now = new Date()): Promise<number> {
    const before = new Date(
      now.getTime() - DeletedMediaService.graceDays * 86_400_000,
    );
    const rows = await this.prisma.media.findMany({
      where: { post: { deletedAt: { not: null, lt: before } } },
      select: { id: true, url: true, thumbnailUrl: true },
      take: DeletedMediaService.batch,
    });
    if (rows.length === 0) return 0;

    const urls = [
      ...new Set(rows.flatMap((r) => [r.url, r.thumbnailUrl]).filter(Boolean)),
    ] as string[];
    // A file another live row still shows -- a draft re-posted, a copy --
    // stays where it is.
    const shared = await this.prisma.media.findMany({
      where: {
        id: { notIn: rows.map((r) => r.id) },
        OR: [{ url: { in: urls } }, { thumbnailUrl: { in: urls } }],
      },
      select: { url: true, thumbnailUrl: true },
    });
    const keep = new Set(shared.flatMap((r) => [r.url, r.thumbnailUrl]));

    const bucket = this.supabase.getBucketName();
    const paths: string[] = [];
    for (const url of urls) {
      if (keep.has(url)) continue;
      const stored = storedPathFromUrl(url, bucket);
      if ('path' in stored) paths.push(stored.path);
    }

    try {
      await this.supabase.removeFiles(paths);
    } catch (error) {
      this.logger.warn(
        `Could not remove deleted posts' files: ${String(error)}`,
      );
      return 0;
    }
    const { count } = await this.prisma.media.deleteMany({
      where: { id: { in: rows.map((r) => r.id) } },
    });
    if (count) {
      this.logger.log(`Removed the files of ${count} deleted posts' media.`);
    }
    return count;
  }
}
