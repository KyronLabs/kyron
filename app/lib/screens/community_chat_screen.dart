// lib/screens/community_chat_screen.dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart' show CommunityRole;
import '../models/community_chat.dart';
import '../models/post_media.dart';
import '../providers/community_chats_provider.dart';
import '../providers/current_user_provider.dart';
import '../repositories/moderation_repository.dart' show ReportTarget;
import '../utils/conversation_text.dart' show mediaPreview;
import '../utils/media_basket.dart' show MediaBasket, mediaKindOf;
import '../widgets/action_button.dart';
import '../widgets/action_sheet.dart';
import '../widgets/create_post/voice_recorder_sheet.dart';
import '../widgets/empty_state.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/media_grid.dart';
import '../widgets/quick_reaction_row.dart';
import '../widgets/toast.dart';
import '../widgets/verified_badge.dart';
import '../widgets/voice_post_player.dart';
import 'community_chat_search_screen.dart';
import 'community_chat_settings_screen.dart';
import 'community_poll_screen.dart';
import 'report_screen.dart';

/// One chat inside a community.
///
/// Not end-to-end encrypted, and it says so at the top of the conversation:
/// a room anybody in the community can join cannot be sealed for all of them.
/// Plain text in and out through [CommunityChatsRepository]; nothing here
/// touches the message vault.
class CommunityChatScreen extends ConsumerStatefulWidget {
  final String chatId;

  /// What the list already knew, so the header has a name before the first
  /// page lands.
  final CommunityChat? initial;

  const CommunityChatScreen({super.key, required this.chatId, this.initial});

  static Future<void> open(BuildContext context, CommunityChat chat) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) => CommunityChatScreen(chatId: chat.id, initial: chat),
        ),
      );

  @override
  ConsumerState<CommunityChatScreen> createState() =>
      _CommunityChatScreenState();
}

class _CommunityChatScreenState extends ConsumerState<CommunityChatScreen> {
  final _box = TextEditingController();
  final _scroll = ScrollController();
  final _focus = FocusNode();
  CommunityChatMessage? _replyingTo;

  /// The reader's own message whose words the composer is changing.
  CommunityChatMessage? _editing;

  /// A message just found by a search, lit for a moment where it was said.
  String? _highlight;
  final _highlightKey = GlobalKey();
  Timer? _unlight;

  bool _settled = false;

  /// While the reader has not joined, nothing is pushed to them as it
  /// happens -- the server tells only people who joined -- so the open
  /// screen asks now and then instead.
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _box.addListener(() => setState(() {}));
    _scroll.addListener(_onScroll);
    _poll = Timer.periodic(const Duration(seconds: 20), (_) {
      final state = ref.read(communityChatProvider(widget.chatId));
      if (state.chat?.joined == false) {
        ref.read(communityChatProvider(widget.chatId).notifier).pullNewest();
      }
    });
  }

  @override
  void dispose() {
    _unlight?.cancel();
    _poll?.cancel();
    _box.dispose();
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  CommunityChatNotifier get _notifier =>
      ref.read(communityChatProvider(widget.chatId).notifier);

  void _onScroll() {
    if (_scroll.hasClients && _scroll.position.pixels <= 300) {
      _notifier.loadMore();
    }
  }

  void _toNewest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  ChatPerson? get _me {
    final user = ref.read(currentUserProvider).asData?.value;
    if (user == null) return null;
    return ChatPerson(id: user.id, name: user.name, username: user.username);
  }

  Future<void> _send() async {
    final me = _me;
    if (me == null) return;
    final text = _box.text;
    final editing = _editing;
    if (editing != null) {
      _box.clear();
      setState(() => _editing = null);
      await _after(_notifier.edit(editing, text));
      return;
    }
    final answering = _replyingTo;
    _box.clear();
    setState(() => _replyingTo = null);
    unawaited(HapticFeedback.selectionClick());
    final error = await _notifier.send(text, me: me, replyingTo: answering);
    _toNewest();
    if (error != null && mounted) Toast.show(context, error);
  }

  /// Sends what was picked or recorded, with whatever is in the box as the
  /// words under it.
  Future<void> _sendMedia(List<PendingMedia> media) async {
    final me = _me;
    if (me == null || media.isEmpty) return;
    final caption = _box.text;
    final answering = _replyingTo;
    _box.clear();
    setState(() => _replyingTo = null);
    unawaited(HapticFeedback.selectionClick());
    final sending = _notifier.sendMedia(
      media,
      me: me,
      caption: caption,
      replyingTo: answering,
    );
    _toNewest();
    final error = await sending;
    if (error != null && mounted) Toast.show(context, error);
  }

  /// Photos and clips, a photo from the camera, or a poll.
  Future<void> _attach(CommunityChat chat) async {
    final l10n = AppLocalizations.of(context);
    final choice = await ActionSheet.show<String>(
      context,
      actions: [
        SheetAction(
          value: 'gallery',
          label: l10n.ui('ui_cchat_attach_gallery', 'Photos and videos'),
          icon: Iconsax.gallery_copy,
        ),
        SheetAction(
          value: 'camera',
          label: l10n.ui('ui_dm_take_photo', 'Take a photo'),
          icon: Iconsax.camera_copy,
        ),
        SheetAction(
          value: 'poll',
          label: l10n.ui('ui_cchat_poll_new', 'New poll'),
          icon: Iconsax.chart_2_copy,
        ),
      ],
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case 'poll':
        final poll = await CommunityPollScreen.open(context);
        final me = _me;
        if (poll == null || me == null || !mounted) return;
        _toNewest();
        await _after(
          _notifier.sendPoll(
            poll.question,
            poll.options,
            me: me,
            multiple: poll.multiple,
          ),
        );
      case 'camera':
        final XFile? shot;
        try {
          shot = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 2048,
            maxHeight: 2048,
            imageQuality: 85,
          );
        } catch (_) {
          return;
        }
        if (shot == null || !mounted) return;
        await _sendMedia(
            [PendingMedia(path: shot.path, kind: MediaKind.image)]);
      case 'gallery':
        final List<XFile> picked;
        try {
          picked = await ImagePicker().pickMultipleMedia(limit: _maxMedia);
        } catch (_) {
          return;
        }
        if (picked.isEmpty || !mounted) return;
        final media = <PendingMedia>[];
        var tooBig = false;
        for (final file in picked.take(_maxMedia)) {
          if (await file.length() > MediaBasket.maxAttachmentBytes) {
            tooBig = true;
            continue;
          }
          media.add(PendingMedia(path: file.path, kind: mediaKindOf(file)));
        }
        if (!mounted) return;
        if (tooBig) {
          Toast.show(
            context,
            l10n.ui(
              'ui_cchat_too_big',
              'Something you picked is over 25 MB and was left out.',
            ),
          );
        }
        await _sendMedia(media);
    }
  }

  /// The most a message carries. The server holds the same line.
  static const _maxMedia = 4;

  /// A voice note, sent as its own message.
  Future<void> _recordVoice() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final recording = await VoiceRecorderSheet.show(context, forMessage: true);
    if (recording == null || !mounted) return;
    await _sendMedia([recording]);
  }

  Future<void> _search(CommunityChat chat) async {
    final found = await CommunityChatSearchScreen.open(context, chat.id);
    if (found == null || !mounted) return;
    await _jumpTo(found);
  }

  /// Shows a message where it was said: reads back until it is held, then
  /// brings it into view and lights it for a moment.
  Future<void> _jumpTo(String messageId) async {
    final l10n = AppLocalizations.of(context);
    final held = await _notifier.loadUntil(messageId);
    if (!mounted) return;
    if (!held) {
      Toast.show(
        context,
        l10n.ui('ui_cchat_too_far', 'That message is too far back to show.'),
      );
      return;
    }
    setState(() => _highlight = messageId);
    // Built only once it is near the screen: move towards it until it is.
    for (var i = 0; i < 8 && mounted; i++) {
      await WidgetsBinding.instance.endOfFrame;
      final there = _highlightKey.currentContext;
      if (there != null) {
        if (!there.mounted) break;
        await Scrollable.ensureVisible(
          there,
          alignment: 0.3,
          duration: const Duration(milliseconds: 250),
        );
        break;
      }
      if (!_scroll.hasClients) break;
      final messages = ref.read(communityChatProvider(widget.chatId)).messages;
      final at = messages.indexWhere((m) => m.id == messageId);
      if (at < 0) break;
      _scroll.jumpTo(
        _scroll.position.maxScrollExtent * (at + 1) / (messages.length + 1),
      );
    }
    _unlight?.cancel();
    _unlight = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _highlight = null);
    });
  }

  Future<void> _after(Future<String?> attempt) async {
    final error = await attempt;
    if (error != null && mounted) Toast.show(context, error);
  }

  Future<void> _options(
      CommunityChat chat, CommunityChatMessage message) async {
    if (message.sending) return;
    final l10n = AppLocalizations.of(context);
    final me = _me?.id;
    final mine = message.sender.id == me;
    unawaited(HapticFeedback.mediumImpact());
    final pinned = chat.pinned?.id == message.id;

    final choice = await ActionSheet.show<String>(
      context,
      header: message.failed
          ? null
          : (sheet) => QuickReactionRow(
                selected: message.mine,
                onPick: (emoji) => Navigator.pop(sheet, 'react:$emoji'),
              ),
      actions: [
        if (message.failed)
          SheetAction(
            value: 'retry',
            label: l10n.notSentTapRetry,
            icon: Iconsax.refresh_copy,
          ),
        if (chat.canWrite && !message.failed)
          SheetAction(
            value: 'reply',
            label: l10n.reply,
            icon: Iconsax.undo_copy,
          ),
        if (message.body.trim().isNotEmpty)
          SheetAction(
            value: 'copy',
            label: l10n.literalcopyText,
            icon: Iconsax.copy_copy,
          ),
        if (mine && message.editableAt(DateTime.now()))
          SheetAction(
            value: 'edit',
            label: l10n.ui('ui_cchat_edit_message', 'Edit'),
            icon: Iconsax.edit_2_copy,
          ),
        if (message.poll != null &&
            !message.poll!.closed &&
            !message.sending &&
            !message.failed &&
            (mine || chat.canModerate))
          SheetAction(
            value: 'close-poll',
            label: l10n.ui('ui_cchat_poll_close', 'Close poll'),
            icon: Iconsax.lock_1_copy,
          ),
        if (chat.canModerate && !message.failed)
          SheetAction(
            value: 'pin',
            label: pinned
                ? l10n.ui('ui_cchat_unpin', 'Unpin')
                : l10n.ui('ui_cchat_pin', 'Pin to the top'),
            icon: Iconsax.attach_square_copy,
          ),
        if (!mine && !message.failed)
          SheetAction(
            value: 'report',
            label: l10n.report,
            icon: Iconsax.flag_copy,
          ),
        if (mine || _canTakeDown(chat, message))
          SheetAction(
            value: 'delete',
            label: l10n.delete,
            icon: Iconsax.trash_copy,
            destructive: true,
          ),
      ],
    );
    if (choice == null || !mounted) return;

    switch (choice) {
      case final String pick when pick.startsWith('react:'):
        await _after(
          _notifier.toggleReaction(message, pick.substring('react:'.length)),
        );
      case 'retry':
        final who = _me;
        if (who != null) await _after(_notifier.retry(message, me: who));
      case 'reply':
        setState(() => _replyingTo = message);
        _focus.requestFocus();
      case 'copy':
        await Clipboard.setData(ClipboardData(text: message.body));
        if (mounted) Toast.show(context, l10n.ui('ui_cchat_copied', 'Copied'));
      case 'edit':
        setState(() {
          _replyingTo = null;
          _editing = message;
        });
        _box.text = message.body;
        _box.selection = TextSelection.collapsed(offset: _box.text.length);
        _focus.requestFocus();
      case 'close-poll':
        await _after(_notifier.closePoll(message));
      case 'pin':
        await _after(_notifier.pin(pinned ? null : message));
      case 'report':
        await ReportScreen.open(
          context,
          target: ReportTarget.communityMessage,
          targetId: message.id,
          subject: message.sender.username == null
              ? message.sender.displayName
              : '@${message.sender.username}',
        );
      case 'delete':
        final sure = await _confirmDelete(mine);
        if (sure) await _after(_notifier.delete(message));
    }
  }

  /// The owner over anybody's message; a moderator over a member's, or a
  /// message by somebody who has left. The server holds the same line; this
  /// only leaves out an entry it would refuse.
  static bool _canTakeDown(CommunityChat chat, CommunityChatMessage message) =>
      switch (chat.myRole) {
        CommunityRole.owner => true,
        CommunityRole.moderator => message.sender.role == null ||
            message.sender.role == CommunityRole.member,
        CommunityRole.member => false,
      };

  Future<bool> _confirmDelete(bool mine) async {
    final l10n = AppLocalizations.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (dialog) => AlertDialog(
            title: Text(l10n.removeMessage),
            content: Text(
              mine
                  ? l10n.ui(
                      'ui_cchat_delete_own',
                      'It is taken down for everyone in the chat.',
                    )
                  : l10n.ui(
                      'ui_cchat_delete_other',
                      'It is taken down for everyone. Kyron keeps a copy '
                          'for review.',
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialog, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialog, true),
                child: Text(l10n.remove),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(communityChatProvider(widget.chatId));
    final chat = state.chat ?? widget.initial;
    final me = ref.watch(currentUserProvider).asData?.value.id;

    ref.listen(
      communityChatProvider(widget.chatId).select((s) => s.messages.length),
      (before, after) {
        if (!_settled && after > 0) {
          _settled = true;
          _toNewest();
        }
      },
    );

    return Scaffold(
      appBar: KyronAppBar(
        titleSpacing: 0,
        title: chat == null
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (chat.announcements) ...[
                        const Icon(Iconsax.volume_high_copy, size: 16),
                        const SizedBox(width: SpacingTokens.space4),
                      ],
                      Flexible(
                        child: Text(
                          chat.name,
                          key: const ValueKey('cchat-title'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${chat.communityName} · '
                    '${l10n.ui('ui_cchat_joined', r'$count joined').replaceAll(r'$count', '${chat.joinedCount}')}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize1,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
        actions: [
          if (chat != null && !state.shut)
            IconButton(
              key: const ValueKey('cchat-more'),
              tooltip: l10n.ui('ui_status_details', 'Details'),
              icon: const Icon(Iconsax.more_copy, size: 20),
              onPressed: () => _menu(chat),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (chat?.pinned != null && !state.shut)
              _PinnedBanner(message: chat!.pinned!),
            Expanded(child: _body(state, chat, me)),
            if (chat != null && !state.shut) _footer(chat),
          ],
        ),
      ),
    );
  }

  Widget _body(CommunityChatState state, CommunityChat? chat, String? me) {
    final l10n = AppLocalizations.of(context);
    if (state.shut) {
      return EmptyState.failed(
        title: l10n.ui('ui_cchat_shut', 'You cannot see this chat any more.'),
        detail: state.error,
        onAction: _notifier.refresh,
      ).scrollable;
    }
    if (state.loading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null && state.messages.isEmpty) {
      return EmptyState.failed(
        title: l10n.ui('ui_cchat_failed', 'Could not open this chat.'),
        detail: state.error,
        onAction: _notifier.refresh,
      ).scrollable;
    }
    final messages = state.messages;
    final lead = state.loadingMore ? 1 : 0;
    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space12,
      ),
      // The notice first, always: it is about every message below it.
      itemCount: 1 + lead + messages.length,
      itemBuilder: (context, index) {
        if (index == 0) return const _NotEncryptedNotice();
        if (state.loadingMore && index == 1) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final at = index - 1 - lead;
        final message = messages[at];
        final previous = at > 0 ? messages[at - 1] : null;
        final newTurn = previous == null ||
            previous.sender.id != message.sender.id ||
            message.createdAt.difference(previous.createdAt) >
                const Duration(minutes: 15);
        return _MessageTile(
          key: message.id == _highlight
              ? _highlightKey
              : ValueKey('cchat-${message.id}'),
          message: message,
          mine: message.sender.id == me,
          lit: message.id == _highlight,
          onVote: (chosen) => _after(_notifier.vote(message, chosen)),
          newTurn: newTurn,
          onOptions: chat == null ? null : () => _options(chat, message),
          onReact: (emoji) => _after(_notifier.toggleReaction(message, emoji)),
          onRetry: () {
            final who = _me;
            if (who != null) _after(_notifier.retry(message, me: who));
          },
        );
      },
    );
  }

  Widget _footer(CommunityChat chat) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final bar = BoxDecoration(
      color: scheme.surface,
      border: Border(
        top: BorderSide(
          color: scheme.outline.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
    );

    if (!chat.joined) {
      return Container(
        key: const ValueKey('cchat-spectator'),
        decoration: bar,
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space12,
          SpacingTokens.space12,
          SpacingTokens.space16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                l10n.ui(
                  'ui_cchat_spectator',
                  'You can read and react as a spectator. Join to write.',
                ),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  color: scheme.onSurface.withValues(alpha: 0.65),
                ),
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            ActionButton(
              key: const ValueKey('cchat-join'),
              label: l10n.ui('ui_cchat_join', 'Join chat'),
              icon: Iconsax.add_copy,
              onPressed: () => _after(_notifier.join()),
            ),
          ],
        ),
      );
    }

    if (!chat.canWrite) {
      return Container(
        key: const ValueKey('cchat-readonly'),
        decoration: bar,
        width: double.infinity,
        padding: const EdgeInsets.all(SpacingTokens.space16),
        child: Text(
          l10n.ui(
            'ui_cchat_moderators_only',
            'Only the owner and moderators can write here.',
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
      );
    }

    final canSend = _box.text.trim().isNotEmpty;
    final editing = _editing;
    return Container(
      decoration: bar,
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (editing != null)
            Row(
              key: const ValueKey('cchat-editing'),
              children: [
                Icon(Iconsax.edit_2_copy, size: 16, color: scheme.primary),
                const SizedBox(width: SpacingTokens.space8),
                Expanded(
                  child: Text(
                    l10n.ui('ui_cchat_editing', 'Editing your message'),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      fontWeight: FontWeight.w600,
                      color: scheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  key: const ValueKey('cchat-editing-cancel'),
                  tooltip: l10n.cancel,
                  icon: const Icon(Iconsax.close_circle_copy, size: 18),
                  onPressed: () {
                    _box.clear();
                    setState(() => _editing = null);
                  },
                ),
              ],
            ),
          if (_replyingTo != null)
            Row(
              children: [
                Expanded(
                  child: _Quote(
                    reply: ChatReply(
                      id: _replyingTo!.id,
                      senderName: _replyingTo!.sender.displayName,
                      body: _replyingTo!.body,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.literaldoNotReply,
                  icon: const Icon(Iconsax.close_circle_copy, size: 18),
                  onPressed: () => setState(() => _replyingTo = null),
                ),
              ],
            ),
          if (chat.slowModeSeconds > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space4),
              child: Text(
                l10n
                    .ui('ui_cchat_slow_mode',
                        r'Slow mode: one message every $seconds seconds')
                    .replaceAll(r'$seconds', '${chat.slowModeSeconds}'),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (editing == null)
                IconButton(
                  key: const ValueKey('cchat-attach'),
                  tooltip: l10n.ui('ui_cchat_attach', 'Add a photo or a poll'),
                  icon: const Icon(Iconsax.add_circle_copy),
                  onPressed: () => _attach(chat),
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space16,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(RadiusTokens.radius20),
                  ),
                  child: TextField(
                    key: const ValueKey('cchat-box'),
                    controller: _box,
                    focusNode: _focus,
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 2000,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: l10n.message,
                      counterText: '',
                      isDense: true,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              // Nothing written: the microphone, as in a conversation. A
              // voice note goes on its own, so not while editing.
              if (!canSend && editing == null)
                IconButton(
                  key: const ValueKey('cchat-voice'),
                  tooltip: l10n.ui('ui_cchat_voice', 'Record a voice note'),
                  onPressed: _recordVoice,
                  icon: const Icon(Iconsax.microphone_2_copy),
                  color: scheme.primary,
                )
              else
                IconButton(
                  key: const ValueKey('cchat-send'),
                  tooltip: editing == null ? l10n.send : l10n.save,
                  onPressed: canSend ? _send : null,
                  icon: Icon(
                    editing == null ? Iconsax.send_1 : Iconsax.tick_circle,
                  ),
                  color: scheme.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _menu(CommunityChat chat) async {
    final l10n = AppLocalizations.of(context);
    final choice = await ActionSheet.show<String>(
      context,
      title: chat.name,
      actions: [
        SheetAction(
          value: 'search',
          label: l10n.ui('ui_cchat_search', 'Search this chat'),
          icon: Iconsax.search_normal_1_copy,
        ),
        if (chat.joined)
          SheetAction(
            value: chat.muted ? 'unmute' : 'mute',
            label: chat.muted
                ? l10n.ui('ui_cchat_unmute', 'Unmute')
                : l10n.ui('ui_cchat_mute', 'Mute'),
            icon: chat.muted
                ? Iconsax.volume_high_copy
                : Iconsax.volume_slash_copy,
            detail: chat.muted
                ? null
                : l10n.ui(
                    'ui_cchat_mute_detail',
                    'No notifications from it, and it is left out of the '
                        'Messages count.',
                  ),
          ),
        if (chat.canModerate)
          SheetAction(
            value: 'edit',
            label: l10n.ui('ui_cchat_edit', 'Edit chat'),
            icon: Iconsax.setting_2_copy,
          ),
        if (chat.joined)
          SheetAction(
            value: 'leave',
            label: l10n.ui('ui_cchat_leave', 'Leave chat'),
            icon: Iconsax.logout_copy,
            detail: l10n.ui(
              'ui_cchat_leave_detail',
              'You can still read it while you are in the community.',
            ),
          ),
        if (chat.canModerate)
          SheetAction(
            value: 'close',
            label: l10n.ui('ui_cchat_close', 'Close chat'),
            icon: Iconsax.trash_copy,
            destructive: true,
          ),
      ],
      header: chat.description == null
          ? null
          : (_) => Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space20,
                  0,
                  SpacingTokens.space20,
                  SpacingTokens.space12,
                ),
                child: Text(chat.description!),
              ),
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case 'search':
        await _search(chat);
      case 'mute' || 'unmute':
        await _after(_notifier.setMuted(choice == 'mute'));
      case 'edit':
        final changed = await CommunityChatSettingsScreen.edit(context, chat);
        if (changed && mounted) await _notifier.refreshChat();
      case 'leave':
        await _after(_notifier.leave());
      case 'close':
        final sure = await showDialog<bool>(
              context: context,
              builder: (dialog) => AlertDialog(
                title: Text(
                  l10n.ui('ui_cchat_close_title', 'Close this chat?'),
                ),
                content: Text(
                  l10n.ui(
                    'ui_cchat_close_detail',
                    'Nobody will be able to read or write in it. This cannot '
                        'be undone.',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialog, false),
                    child: Text(l10n.cancel),
                  ),
                  TextButton(
                    key: const ValueKey('cchat-close-confirm'),
                    onPressed: () => Navigator.pop(dialog, true),
                    child: Text(l10n.ui('ui_cchat_close', 'Close chat')),
                  ),
                ],
              ),
            ) ??
            false;
        if (!sure || !mounted) return;
        try {
          await ref.read(communityChatsRepositoryProvider).close(chat.id);
          ref.invalidate(communityChatsProvider(chat.communitySlug));
          if (mounted) Navigator.pop(context);
        } catch (_) {
          if (mounted) {
            Toast.show(
              context,
              l10n.ui('ui_cchat_failed', 'Could not open this chat.'),
            );
          }
        }
    }
  }
}

/// Once, at the top of every community chat: what it is not.
class _NotEncryptedNotice extends StatelessWidget {
  const _NotEncryptedNotice();

  @override
  Widget build(BuildContext context) {
    final muted =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);
    return Padding(
      key: const ValueKey('cchat-not-encrypted'),
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space24,
        vertical: SpacingTokens.space12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.unlock_copy, size: 14, color: muted),
          const SizedBox(width: SpacingTokens.space8),
          Flexible(
            child: Text(
              AppLocalizations.of(context).ui(
                'ui_cchat_not_encrypted',
                'Community chats are not end-to-end encrypted. The '
                    "community's moderators and Kyron can read them.",
              ),
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: TypographyTokens.fontSize1, color: muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinnedBanner extends StatelessWidget {
  final CommunityChatMessage message;

  const _PinnedBanner({required this.message});

  /// Its words, or what it carried when it has none.
  String _pinnedLine(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (message.poll != null) {
      return l10n
          .ui('ui_cchat_poll_preview', r'Poll: $question')
          .replaceAll(r'$question', message.body);
    }
    if (message.body.trim().isNotEmpty || message.media.isEmpty) {
      return message.body;
    }
    return mediaPreview(l10n, [for (final m in message.media) m.kind]);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey('cchat-pinned'),
      width: double.infinity,
      color: scheme.primary.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space8,
      ),
      child: Row(
        children: [
          Icon(Iconsax.attach_square_copy, size: 16, color: scheme.primary),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              '${message.sender.displayName}: ${_pinnedLine(context)}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: TypographyTokens.fontSize2),
            ),
          ),
        ],
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  final ChatReply reply;

  const _Quote({required this.reply});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: scheme.primary, width: 2)),
        color: scheme.onSurface.withValues(alpha: 0.04),
      ),
      child: Text(
        reply.unavailable
            ? l10n.ui('ui_dm_quote_gone', 'That message is no longer here.')
            : '${reply.senderName ?? l10n.ui('ui_dm_someone', 'Someone')}: '
                '${reply.body}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontStyle: reply.unavailable ? FontStyle.italic : null,
          color: scheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  final CommunityChatMessage message;
  final bool mine;

  /// The first of a run by one person: their name and avatar go here.
  final bool newTurn;

  /// Just found by a search: lit for a moment.
  final bool lit;
  final VoidCallback? onOptions;
  final void Function(String emoji) onReact;
  final void Function(List<String> optionIds) onVote;
  final VoidCallback onRetry;

  const _MessageTile({
    super.key,
    required this.message,
    required this.mine,
    required this.newTurn,
    required this.onOptions,
    required this.onReact,
    required this.onVote,
    required this.onRetry,
    this.lit = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final sender = message.sender;
    final role = sender.role;
    final tag = role == CommunityRole.owner
        ? l10n.ui('ui_community_role_owner', 'Owner')
        : role == CommunityRole.moderator
            ? l10n.ui('ui_community_role_moderator', 'Moderator')
            : null;

    final faded = message.failed || message.sending;
    final visual = message.media.where((m) => !m.isVoice).toList();
    final voice = message.media.where((m) => m.isVoice).toList();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: lit ? scheme.primary.withValues(alpha: 0.08) : Colors.transparent,
      padding: EdgeInsets.only(top: newTurn ? SpacingTokens.space12 : 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: newTurn
                ? CircleAvatar(
                    radius: 16,
                    backgroundColor: scheme.primary.withValues(alpha: 0.15),
                    foregroundImage: sender.avatarUrl == null
                        ? null
                        : NetworkImage(sender.avatarUrl!),
                    child: Icon(
                      Iconsax.user_copy,
                      size: 14,
                      color: scheme.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: onOptions,
              onTap: message.failed ? onRetry : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (newTurn)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Flexible(
                            child: NameWithBadge(
                              name: mine
                                  ? l10n.ui('ui_cchat_you', 'You')
                                  : sender.displayName,
                              verified: sender.verified,
                              style: const TextStyle(
                                fontSize: TypographyTokens.fontSize2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (tag != null) ...[
                            const SizedBox(width: SpacingTokens.space4),
                            Text(
                              tag,
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize1,
                                fontWeight: FontWeight.w600,
                                color: scheme.primary,
                              ),
                            ),
                          ],
                          const SizedBox(width: SpacingTokens.space8),
                          Text(
                            DateFormat.jm(
                              Localizations.maybeLocaleOf(context)
                                  ?.toLanguageTag(),
                            ).format(message.createdAt),
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize1,
                              color: scheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (message.replyTo != null) _Quote(reply: message.replyTo!),
                  if (message.poll != null)
                    _PollCard(
                      question: message.body,
                      poll: message.poll!,
                      // The asker sees how it is going from the start; anybody
                      // else once they have answered, or it has closed.
                      showResults: mine || message.poll!.answered,
                      enabled: !faded,
                      onVote: onVote,
                    )
                  else ...[
                    if (message.pendingMedia.isNotEmpty)
                      _PendingMedia(media: message.pendingMedia)
                    else ...[
                      for (final note in voice)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: SpacingTokens.space4),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: VoicePostPlayer(media: note),
                          ),
                        ),
                      if (visual.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: SpacingTokens.space4),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: MediaGrid(media: visual),
                          ),
                        ),
                    ],
                    if (message.body.isNotEmpty)
                      Text.rich(
                        TextSpan(
                          text: message.body,
                          children: [
                            if (message.edited)
                              TextSpan(
                                text:
                                    '  ${l10n.ui('ui_cchat_edited', 'edited')}',
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize1,
                                  color:
                                      scheme.onSurface.withValues(alpha: 0.45),
                                ),
                              ),
                          ],
                        ),
                        key: ValueKey('cchat-body-${message.id}'),
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize3,
                          height: 1.35,
                          color: faded
                              ? scheme.onSurface.withValues(alpha: 0.5)
                              : scheme.onSurface,
                        ),
                      ),
                  ],
                  if (message.failed)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        l10n.notSentTapRetry,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight: FontWeight.w600,
                          color: scheme.error,
                        ),
                      ),
                    ),
                  if (message.reactions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: SpacingTokens.space4),
                      child: Wrap(
                        spacing: SpacingTokens.space4,
                        runSpacing: SpacingTokens.space4,
                        children: [
                          for (final r in message.reactions)
                            _ReactionPill(
                              emoji: r.emoji,
                              count: r.count,
                              mine: r.emoji == message.mine,
                              onTap: () => onReact(r.emoji),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReactionPill extends StatelessWidget {
  final String emoji;
  final int count;
  final bool mine;
  final VoidCallback onTap;

  const _ReactionPill({
    required this.emoji,
    required this.count,
    required this.mine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: mine
              ? scheme.primary.withValues(alpha: 0.15)
              : scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(RadiusTokens.radius20),
          border: mine ? Border.all(color: scheme.primary) : null,
        ),
        child: Text(
          '$emoji $count',
          style: const TextStyle(fontSize: TypographyTokens.fontSize2),
        ),
      ),
    );
  }
}

/// What is on its way, from the phone's own files, while it uploads.
class _PendingMedia extends StatelessWidget {
  final List<PendingMedia> media;

  const _PendingMedia({required this.media});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space4),
      child: Wrap(
        spacing: SpacingTokens.space4,
        runSpacing: SpacingTokens.space4,
        children: [
          for (final item in media)
            ClipRRect(
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              child: SizedBox.square(
                dimension: media.length == 1 ? 160 : 96,
                child: item.kind == MediaKind.image ||
                        item.kind == MediaKind.gif
                    ? Opacity(
                        opacity: 0.6,
                        child: Image.file(
                          File(item.path),
                          fit: BoxFit.cover,
                          cacheWidth: 320,
                          errorBuilder: (_, __, ___) =>
                              ColoredBox(color: scheme.surfaceContainerHighest),
                        ),
                      )
                    : ColoredBox(
                        color: scheme.surfaceContainerHighest,
                        child: Icon(
                          item.kind == MediaKind.voice
                              ? Iconsax.microphone_2_copy
                              : Iconsax.video_copy,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A poll in a chat: its question, each answer, and -- once the reader has
/// answered, or it is theirs, or it has closed -- how many chose each, as a
/// bar. Counts only: nobody's choice is shown to anybody.
class _PollCard extends StatelessWidget {
  final String question;
  final ChatPoll poll;
  final bool showResults;
  final bool enabled;
  final void Function(List<String> optionIds) onVote;

  const _PollCard({
    required this.question,
    required this.poll,
    required this.showResults,
    required this.enabled,
    required this.onVote,
  });

  void _tap(String optionId) {
    final mine = poll.mine;
    if (!poll.multiple) {
      // The same answer again takes it back.
      onVote(mine.contains(optionId) ? const [] : [optionId]);
      return;
    }
    onVote(
      mine.contains(optionId)
          ? [
              for (final id in mine)
                if (id != optionId) id
            ]
          : [...mine, optionId],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final results = showResults || poll.closed;
    final open = enabled && !poll.closed && poll.id.isNotEmpty;
    return Container(
      key: const ValueKey('cchat-poll'),
      constraints: const BoxConstraints(maxWidth: 340),
      margin: const EdgeInsets.only(bottom: SpacingTokens.space4),
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize3,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            poll.closed
                ? l10n.ui('ui_cchat_poll_closed', 'Closed')
                : poll.multiple
                    ? l10n.ui('ui_cchat_poll_several', 'Choose one or more')
                    : l10n.ui('ui_cchat_poll_one', 'Choose one'),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          for (final option in poll.options)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space4),
              child: _PollOption(
                key: ValueKey('cchat-poll-option-${option.id}'),
                text: option.text,
                share: poll.voters == 0 ? 0 : option.votes / poll.voters,
                chosen: poll.mine.contains(option.id),
                results: results,
                multiple: poll.multiple,
                onTap: open ? () => _tap(option.id) : null,
              ),
            ),
          const SizedBox(height: 2),
          Text(
            l10n
                .ui('ui_cchat_poll_voters', r'$count answered')
                .replaceAll(r'$count', '${poll.voters}'),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _PollOption extends StatelessWidget {
  final String text;

  /// Of the people who answered, how many chose this: 0 to 1.
  final double share;
  final bool chosen;
  final bool results;
  final bool multiple;
  final VoidCallback? onTap;

  const _PollOption({
    super.key,
    required this.text,
    required this.share,
    required this.chosen,
    required this.results,
    required this.multiple,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(RadiusTokens.radius12);
    return Semantics(
      button: onTap != null,
      selected: chosen,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: scheme.onSurface.withValues(alpha: 0.04),
                ),
              ),
              if (results)
                Positioned.fill(
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: share.clamp(0, 1),
                    child: ColoredBox(
                      color: chosen
                          ? scheme.primary.withValues(alpha: 0.22)
                          : scheme.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Row(
                  children: [
                    _Mark(chosen: chosen, multiple: multiple),
                    const SizedBox(width: SpacingTokens.space8),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          fontWeight:
                              chosen ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (results) ...[
                      const SizedBox(width: SpacingTokens.space8),
                      Text(
                        '${(share * 100).round()}%',
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chosen or not, on a poll's answer: a filled tick, or an empty ring -- a
/// rounded square where several may be chosen, as a checkbox is.
class _Mark extends StatelessWidget {
  final bool chosen;
  final bool multiple;

  const _Mark({required this.chosen, required this.multiple});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (chosen) {
      return Icon(Iconsax.tick_circle, size: 18, color: scheme.primary);
    }
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: multiple ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: multiple ? BorderRadius.circular(4) : null,
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
    );
  }
}
