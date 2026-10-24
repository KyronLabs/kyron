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
import { MessagesService } from './messages.service';
import { WallpapersService } from './wallpapers.service';
import { KeySharesService } from './key-shares.service';
import {
  ListConversationsDto,
  ListMessagesDto,
  MessagingSettingsDto,
} from './dto/list-messages.dto';
import { SendMessageDto } from './dto/send-message.dto';
import { ReactDto } from './dto/react.dto';
import { OpenConversationDto } from './dto/open-conversation.dto';
import { RequestKeysDto, ShareKeysDto } from './dto/key-shares.dto';
import {
  AddMembersDto,
  CreateGroupDto,
  SetRoleDto,
  UpdateGroupDto,
} from './dto/groups.dto';
import { GroupsService } from './groups.service';
import { ViewOnceService } from './view-once.service';
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
    private readonly keyShares: KeySharesService,
    private readonly groups: GroupsService,
    private readonly viewOnce: ViewOnceService,
  ) {}

  /**
   * Starts a group, with the reader as its owner.
   *
   * Declared above ':id' so a fixed name is not swallowed by the parameter.
   */
  @Post('groups')
  createGroup(@Req() req: AuthRequest, @Body() dto: CreateGroupDto) {
    return this.groups.create(
      req.user.id,
      dto.title,
      dto.userIds,
      dto.joinRole,
    );
  }

  /** The reader's conversations, whichever moved last at the top. */
  @Get()
  list(@Req() req: AuthRequest, @Query() query: ListConversationsDto) {
    return this.svc.list(req.user.id, {
      limit: query.limit,
      cursor: query.cursor,
      unreadOnly: query.unreadOnly ?? false,
      filter: query.filter,
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

  /** Keeps a conversation at the top of the reader's list. Theirs alone. */
  @Put(':id/pinned')
  pin(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setPinned(req.user.id, id, true);
  }

  @Delete(':id/pinned')
  unpin(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.setPinned(req.user.id, id, false);
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
  /** The reader's messaging settings. Before ':id', which would take it. */
  @Get('settings')
  settings(@Req() req: AuthRequest) {
    return this.svc.settings(req.user.id);
  }

  @Put('settings')
  updateSettings(@Req() req: AuthRequest, @Body() dto: MessagingSettingsDto) {
    return this.svc.updateSettings(req.user.id, dto);
  }

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

  /**
   * Requests for message keys that the reader's devices may be able to
   * answer. See KeySharesService.
   */
  @Get('keys/requests')
  keyRequests(@Req() req: AuthRequest) {
    return this.keyShares.pending(req.user.id);
  }

  /** Answers them, with keys sealed for the devices that asked. */
  @Post('keys/shares')
  shareKeys(@Req() req: AuthRequest, @Body() dto: ShareKeysDto) {
    return this.keyShares.answer(req.user.id, dto.shares);
  }

  /** Asks for the keys of messages this device was not sealed for. */
  @Post(':id/keys/requests')
  requestKeys(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RequestKeysDto,
  ) {
    return this.keyShares.request(
      req.user.id,
      id,
      dto.deviceId,
      dto.messageIds,
    );
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
      dto.linkCard,
      dto.once,
    );
  }

  /** Renames a group, or changes what people added to it start as. */
  @Patch(':id/group')
  updateGroup(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateGroupDto,
  ) {
    return this.groups.update(req.user.id, id, dto);
  }

  @Get(':id/members')
  members(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.groups.members(req.user.id, id);
  }

  @Post(':id/members')
  addMembers(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: AddMembersDto,
  ) {
    return this.groups.add(req.user.id, id, dto.userIds);
  }

  /** Takes somebody out of a group; the reader's own id leaves it. */
  @Delete(':id/members/:userId')
  removeMember(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('userId', ParseUUIDPipe) userId: string,
  ) {
    return this.groups.remove(req.user.id, id, userId);
  }

  @Put(':id/members/:userId/role')
  setRole(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('userId', ParseUUIDPipe) userId: string,
    @Body() dto: SetRoleDto,
  ) {
    return this.groups.setRole(req.user.id, id, userId, dto.role);
  }

  /** A spectator asks to write. */
  @Put(':id/hand')
  raiseHand(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.groups.raiseHand(req.user.id, id);
  }

  @Delete(':id/hand')
  lowerHand(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.groups.lowerHand(req.user.id, id);
  }

  /** An admin says no to somebody's raised hand. */
  @Delete(':id/members/:userId/hand')
  dismissHand(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('userId', ParseUUIDPipe) userId: string,
  ) {
    return this.groups.lowerHand(req.user.id, id, userId);
  }

  /**
   * Opens a view-once message, once: records it and answers a link that
   * stops working in minutes. A second open is refused.
   */
  @Post(':id/items/:messageId/open')
  openOnce(
    @Req() req: AuthRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('messageId', ParseUUIDPipe) messageId: string,
  ) {
    return this.viewOnce.open(req.user.id, id, messageId);
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
  /** Back in the list, from Hidden. */
  @Put(':id/restore')
  unhide(@Req() req: AuthRequest, @Param('id', ParseUUIDPipe) id: string) {
    return this.svc.unhide(req.user.id, id);
  }

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
