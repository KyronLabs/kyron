import {
  BadRequestException,
  Controller,
  Get,
  Header,
  Param,
  ParseUUIDPipe,
} from '@nestjs/common';

import { PublicService } from './public.service';

/** A handle, a slug or an id: letters, digits, `_`, `.` and `-`, briefly. */
const NAME = /^[A-Za-z0-9_.-]{1,64}$/;

function name(value: string): string {
  if (!NAME.test(value)) throw new BadRequestException('Not a valid name.');
  return value;
}

/**
 * Read-only, signed-out views of posts, profiles and communities, for the
 * pages a shared link opens (kyron-links).
 *
 * No guard, on purpose: these are what a stranger with the link may see, and
 * PublicService decides that field by field. Every response may be cached
 * for a minute by anybody in between -- none depends on who asked.
 */
@Controller('public')
export class PublicController {
  constructor(private readonly svc: PublicService) {}

  @Get('posts/:id')
  @Header('Cache-Control', 'public, max-age=60')
  post(@Param('id', ParseUUIDPipe) id: string) {
    return this.svc.post(id);
  }

  @Get('comments/:id')
  @Header('Cache-Control', 'public, max-age=60')
  comment(@Param('id', ParseUUIDPipe) id: string) {
    return this.svc.comment(id);
  }

  @Get('profiles/:handle')
  @Header('Cache-Control', 'public, max-age=60')
  profile(@Param('handle') handle: string) {
    return this.svc.profile(name(handle.replace(/^@/, '')));
  }

  @Get('communities/:slug')
  @Header('Cache-Control', 'public, max-age=60')
  community(@Param('slug') slug: string) {
    return this.svc.community(name(slug));
  }
}
