import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Put,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';

import { AuthGuard } from '../../common/guards/auth.guard';
import type { AuthRequest } from '../../common/types/auth-request';
import { CommunityChatsService } from './community-chats.service';
import {
  CommunityChatReactionDto,
  CommunityChatVoteDto,
  CreateCommunityChatDto,
  EditCommunityChatMessageDto,
  ListCommunityChatMessagesDto,
  PinCommunityChatMessageDto,
  SearchCommunityChatDto,
  SendCommunityChatMessageDto,
  UpdateCommunityChatDto,
} from './dto/community-chat.dto';

/**
 * A community's chats, listed and opened under the community.
 *
 * Only these two sit under `/communities/:slug`; everything about one chat is
 * under `/community-chats/:id` below, by its id. Putting those under the slug
 * too would mean reserving words like "chats" as community names, and a
 * community that already has one would lose the route.
 */
@Controller('communities')
@UseGuards(AuthGuard)
export class CommunityChatListController {
  constructor(private readonly chats: CommunityChatsService) {}

  @Get(':slug/chats')
  list(@Req() req: AuthRequest, @Param('slug') slug: string) {
    return this.chats.list(req.user.id, slug);
  }

  @Post(':slug/chats')
  create(
    @Req() req: AuthRequest,
    @Param('slug') slug: string,
    @Body() dto: CreateCommunityChatDto,
  ) {
    return this.chats.create(req.user.id, slug, dto);
  }
}

/** One community chat, by id. */
@Controller('community-chats')
@UseGuards(AuthGuard)
export class CommunityChatsController {
  constructor(private readonly chats: CommunityChatsService) {}

  /** The reader's joined chats, across their communities. Above ':id'. */
  @Get('joined')
  joined(@Req() req: AuthRequest) {
    return this.chats.joined(req.user.id);
  }

  /** How many joined, unmuted chats have something new, for the Messages
   * badge. Above ':id', like 'joined'. */
  @Get('unread')
  unread(@Req() req: AuthRequest) {
    return this.chats.unreadChats(req.user.id);
  }

  @Get(':id')
  get(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.get(req.user.id, id);
  }

  @Patch(':id')
  update(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCommunityChatDto,
  ) {
    return this.chats.update(req.user.id, id, dto);
  }

  @Delete(':id')
  remove(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.remove(req.user.id, id);
  }

  @Put(':id/membership')
  join(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.join(req.user.id, id);
  }

  @Delete(':id/membership')
  leave(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.leave(req.user.id, id);
  }

  @Put(':id/read')
  markRead(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.markRead(req.user.id, id);
  }

  @Put(':id/mute')
  mute(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.setMuted(req.user.id, id, true);
  }

  @Delete(':id/mute')
  unmute(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.setMuted(req.user.id, id, false);
  }

  @Get(':id/search')
  search(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: SearchCommunityChatDto,
  ) {
    return this.chats.search(req.user.id, id, query.q);
  }

  @Put(':id/pin')
  pin(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PinCommunityChatMessageDto,
  ) {
    return this.chats.pin(req.user.id, id, dto.messageId);
  }

  @Delete(':id/pin')
  unpin(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.chats.pin(req.user.id, id, null);
  }

  @Get(':id/messages')
  messages(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Query() query: ListCommunityChatMessagesDto,
  ) {
    return this.chats.messages(req.user.id, id, query);
  }

  @Post(':id/messages')
  send(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: SendCommunityChatMessageDto,
  ) {
    return this.chats.send(req.user.id, id, dto);
  }

  @Patch(':id/messages/:messageId')
  edit(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
    @Body() dto: EditCommunityChatMessageDto,
  ) {
    return this.chats.edit(req.user.id, id, messageId, dto);
  }

  @Put(':id/messages/:messageId/vote')
  vote(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
    @Body() dto: CommunityChatVoteDto,
  ) {
    return this.chats.vote(req.user.id, id, messageId, dto.optionIds);
  }

  @Delete(':id/messages/:messageId/vote')
  unvote(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.chats.unvote(req.user.id, id, messageId);
  }

  @Put(':id/messages/:messageId/closed')
  closePoll(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.chats.closePoll(req.user.id, id, messageId);
  }

  @Delete(':id/messages/:messageId')
  deleteMessage(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.chats.deleteMessage(req.user.id, id, messageId);
  }

  @Put(':id/messages/:messageId/reaction')
  react(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
    @Body() dto: CommunityChatReactionDto,
  ) {
    return this.chats.react(req.user.id, id, messageId, dto.emoji);
  }

  @Delete(':id/messages/:messageId/reaction')
  unreact(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.chats.unreact(req.user.id, id, messageId);
  }
}
