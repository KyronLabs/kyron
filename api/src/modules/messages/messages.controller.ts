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
import { ListConversationsDto, ListMessagesDto } from './dto/list-messages.dto';
import { SendMessageDto } from './dto/send-message.dto';
import { OpenConversationDto } from './dto/open-conversation.dto';
import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';

@Controller('messages')
// Every route. There is no such thing as an anonymous read of somebody's
// direct messages.
@UseGuards(AuthGuard)
export class MessagesController {
  constructor(private readonly svc: MessagesService) {}

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
    return this.svc.send(req.user.id, id, dto.body);
  }

  @Put(':id/read')
  markRead(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.markRead(req.user.id, id);
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
