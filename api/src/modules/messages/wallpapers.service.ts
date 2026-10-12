import { Injectable, Logger } from '@nestjs/common';
import { SupabaseService } from '../../infrastructure/supabase/supabase.service';

/** One wallpaper a conversation can be drawn on. */
export interface Wallpaper {
  /** The file's name, which is stable for as long as the file is there. */
  id: string;
  url: string;
}

/**
 * The wallpapers chats can choose from, read from storage.
 *
 * A folder in the media bucket rather than a list in code or a table: adding
 * a wallpaper is dropping an image into `wallpapers/`, with no release and no
 * migration, the way the default profile covers already work. Read through a
 * short cache, because every chat's settings page asks and the folder changes
 * on the scale of weeks.
 */
@Injectable()
export class WallpapersService {
  static readonly folder = 'wallpapers';

  /** How long a listing is trusted before storage is asked again. */
  static readonly ttlMs = 10 * 60 * 1000;

  /** What counts as a wallpaper: stills the app can draw. */
  private static readonly image = /\.(jpe?g|png|webp)$/i;

  private readonly logger = new Logger(WallpapersService.name);
  private cache?: { at: number; items: Wallpaper[] };

  constructor(private readonly storage: SupabaseService) {}

  /** In name order, so a curator can order them by naming them. */
  async list(now = Date.now()): Promise<Wallpaper[]> {
    if (this.cache && now - this.cache.at < WallpapersService.ttlMs) {
      return this.cache.items;
    }

    let files: { name: string }[];
    try {
      files = await this.storage.listFiles(WallpapersService.folder, {
        limit: 200,
      });
    } catch (error) {
      // A storage blip is not worth an error on a settings page: whatever
      // was last known, or none, and the built-in ones still work.
      this.logger.warn(`Could not list wallpapers: ${String(error)}`);
      return this.cache?.items ?? [];
    }

    const items: Wallpaper[] = [];
    for (const file of [...files].sort((a, b) =>
      a.name.localeCompare(b.name),
    )) {
      if (!WallpapersService.image.test(file.name)) continue;
      const url = this.storage.getPublicUrl(
        `${WallpapersService.folder}/${file.name}`,
      );
      if (url) items.push({ id: file.name, url });
    }

    this.cache = { at: now, items };
    return items;
  }
}
