import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { MessagesService } from './messages.service';
import { WallpapersService } from './wallpapers.service';
import { ListConversationsDto, ListMessagesDto } from './dto/list-messages.dto';
import { SendMessageDto } from './dto/send-message.dto';
import { ReactDto } from './dto/react.dto';
import { OpenConversationDto } from './dto/open-conversation.dto';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

@Controller('messages')
// Every route. There is no such thing as an anonymous read of somebody's
// direct messages.
@UseGuards(AuthGuard)
export class MessagesController {
  constructor(
    private readonly svc: MessagesService,
    private readonly wallpapers: WallpapersService,
  ) {}

  /** The reader's conversations, whichever moved last at the top. */
  @Get()
  list(@Req() req: AuthRequest, @Query() query: ListConversationsDto) {
    return this.svc.list(req.user.id, {
      limit: query.limit,
      cursor: query.cursor,
      unreadOnly: query.unreadOnly ?? false,
    });
  }

  /**
   * How many conversations hold something unread.
   *
   * Declared above ':id' so a fixed name is not swallowed by the parameter.
   */
  @Get('unread')
  unread(@Req() req: AuthRequest) {
    return this.svc.unreadCount(req.user.id);
  }

  /** Opens the conversation with one person, or finds the existing one. */
  @Post()
  open(@Req() req: AuthRequest, @Body() dto: OpenConversationDto) {
    return this.svc.openWith(req.user.id, dto.userId);
  }

  /** Silences a conversation for the reader. Their own setting, not the
   * other side's. */
  @Put(':id/mute')
  mute(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setMuted(req.user.id, id, true);
  }

  @Delete(':id/mute')
  unmute(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setMuted(req.user.id, id, false);
  }

  /**
   * Blocks the other person and takes the thread out of the reader's list.
   *
   * One call rather than two: blocking somebody you are talking to and
   * leaving their thread sitting in your list is not a state anybody wants.
   */
  @Put(':id/block')
  block(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.blockOther(req.user.id, id);
  }

  /**
   * The wallpapers a chat can be drawn on. Declared above `:id`, which would
   * otherwise take "wallpapers" for a conversation id and refuse it.
   */
  @Get('wallpapers')
  listWallpapers() {
    return this.wallpapers.list();
  }

  /**
   * Every photo, clip, GIF and voice note in a conversation, newest first,
   * for its info page. Paged by message.
   */
  @Get(':id/media')
  media(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: ListMessagesDto,
  ) {
    return this.svc.sharedMedia(req.user.id, id, {
      limit: query.limit,
      cursor: query.cursor,
    });
  }

  @Get(':id')
  messages(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: ListMessagesDto,
  ) {
    return this.svc.messages(req.user.id, id, {
      limit: query.limit,
      cursor: query.cursor,
    });
  }

  @Post(':id')
  send(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: SendMessageDto,
  ) {
    return this.svc.send(
      req.user.id,
      id,
      dto.body ?? '',
      dto.media ?? [],
      dto.replyToId,
    );
  }

  @Put(':id/read')
  markRead(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.markRead(req.user.id, id);
  }

  /** "I'm writing" -- told to the other side over the socket, never pushed. */
  @Post(':id/typing')
  typing(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.typing(req.user.id, id);
  }

  /** Reacts to a message, replacing the reader's previous reaction to it. */
  @Put(':id/items/:messageId/reaction')
  react(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
    @Body() dto: ReactDto,
  ) {
    return this.svc.react(req.user.id, id, messageId, dto.emoji);
  }

  @Delete(':id/items/:messageId/reaction')
  unreact(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.svc.unreact(req.user.id, id, messageId);
  }

  /** One message's reactions, for a client told they changed. */
  @Get(':id/items/:messageId/reactions')
  reactions(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.svc.reactionsFor(req.user.id, id, messageId);
  }

  /** Takes the conversation out of the reader's list, not out of existence. */
  @Delete(':id')
  hide(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.hide(req.user.id, id);
  }

  @Delete('items/:messageId')
  remove(
    @Req() req: AuthRequest,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.svc.remove(req.user.id, messageId);
  }
}
