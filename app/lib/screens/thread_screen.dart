// lib/screens/thread_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/conversation.dart';
import '../providers/current_user_provider.dart';
import '../providers/messages_provider.dart';
import '../routes.dart';
import '../widgets/action_sheet.dart';
import '../widgets/empty_state.dart';
import '../widgets/jump_to_end.dart';
import '../widgets/post_card.dart' show age;
import '../widgets/toast.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../repositories/moderation_repository.dart' show ReportTarget;
import '../utils/media_basket.dart';
import '../widgets/media_tray.dart';
import 'report_screen.dart';
import '../widgets/media_grid.dart';
import '../widgets/voice_post_player.dart';
import '../widgets/skeleton.dart';
import '../widgets/kyron_app_bar.dart';

/// Which conversation, and who is in it.
///
/// The people are carried so the header has a name before the first page
/// lands. The thread answers with them too, which is what a screen opened from
/// a deep link uses.
class ThreadArgs {
  final String conversationId;
  final List<MessagePerson> people;

  const ThreadArgs({required this.conversationId, this.people = const []});
}

class ThreadScreen extends ConsumerStatefulWidget {
  final ThreadArgs args;

  const ThreadScreen({super.key, required this.args});

  @override
  ConsumerState<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends ConsumerState<ThreadScreen> {
  final TextEditingController _box = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final FocusNode _focus = FocusNode();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _box.addListener(_onTyping);
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _box.removeListener(_onTyping);
    _media.removeListener(_onMedia);
    _media.dispose();
    _box.dispose();
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  late final MediaBasket _media = MediaBasket(ref.read(feedRepositoryProvider))
    ..addListener(_onMedia);

  void _onMedia() => setState(_recalculate);

  /// Whether the list has been put at its newest message once.
  bool _settled = false;

  void _onTyping() => setState(_recalculate);

  void _recalculate() {
    // A picture with no words is a message; an empty box is not. Never while
    // an upload is in flight, or the server is sent a file it does not have.
    _canSend = (_box.text.trim().isNotEmpty || _media.ready.isNotEmpty) &&
        !_media.isUploading;
  }

  Future<void> _attach({required bool video}) async {
    final message = await _media.attach(video: video);
    if (message != null && mounted) Toast.show(context, message);
  }

  /// Mute, block, or leave. What a conversation offers besides reading it.
  /// The conversation's actions, as a sheet.
  ///
  /// Mute and Unmute are one entry, not two: the reader is in one of those
  /// states and a menu offering both cannot say which.
  Future<void> _openMenu(bool muted, MessagePerson? other) async {
    final choice = await ActionSheet.show<String>(
      context,
      title: other?.displayName.toUpperCase(),
      actions: [
        muted
            ? const SheetAction(
                value: 'unmute',
                label: 'Unmute',
                icon: Iconsax.volume_high_copy,
                detail: 'Be notified about this conversation again',
              )
            : const SheetAction(
                value: 'mute',
                label: 'Mute',
                icon: Iconsax.volume_slash_copy,
                detail: 'Stop being notified about this conversation',
              ),
        const SheetAction(
          value: 'report',
          label: 'Report',
          icon: Iconsax.flag_copy,
        ),
        const SheetAction(
          value: 'block',
          label: 'Block',
          icon: Iconsax.slash_copy,
          detail: 'They can no longer message you',
          destructive: true,
        ),
        const SheetAction(
          value: 'leave',
          label: 'Remove this conversation',
          icon: Iconsax.trash_copy,
          destructive: true,
        ),
      ],
    );
    if (choice == null || !mounted) return;
    await _conversationAction(choice);
  }

  Future<void> _conversationAction(String action) async {
    final notifier =
        ref.read(threadProvider(widget.args.conversationId).notifier);

    switch (action) {
      case 'mute':
        final error = await notifier.setMuted(true);
        if (!mounted) return;
        Toast.show(context, error ?? 'Muted. You will not be notified.');
      case 'unmute':
        final error = await notifier.setMuted(false);
        if (!mounted) return;
        Toast.show(context, error ?? 'Unmuted.');
      case 'block':
        final sure = await _confirm(
          title: 'Block this account?',
          detail: 'They cannot message you, and this conversation leaves your '
              'list. You can undo it from Settings.',
          confirm: 'Block',
        );
        if (!sure || !mounted) return;
        final error = await notifier.blockOther();
        if (!mounted) return;
        if (error != null) {
          Toast.show(context, error);
        } else {
          Navigator.pop(context);
        }
      case 'report':
        final other = ref
            .read(threadProvider(widget.args.conversationId))
            .people
            .firstOrNull;
        if (other == null || !mounted) return;
        await ReportScreen.open(
          context,
          target: ReportTarget.user,
          targetId: other.id,
          subject: other.handle ?? other.displayName,
        );
      case 'leave':
        final sure = await _confirm(
          title: 'Remove this conversation?',
          detail: 'It disappears from your list. The other person keeps '
              'theirs, and it comes back if either of you writes again.',
          confirm: 'Remove',
        );
        if (!sure || !mounted) return;
        await ref
            .read(messagesRepositoryProvider)
            .hide(widget.args.conversationId);
        if (mounted) Navigator.pop(context);
    }
  }

  Future<bool> _confirm({
    required String title,
    required String detail,
    required String confirm,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(detail),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirm),
            ),
          ],
        ),
      ) ??
      false;

  void _onScroll() {
    if (!_scroll.hasClients) return;
    // Older messages are above, so the top edge is what asks for more.
    if (_scroll.position.pixels <= 300) {
      final before = _scroll.position.maxScrollExtent;
      ref.read(threadProvider(widget.args.conversationId).notifier).loadMore();
      // Prepending grows the list above the reader. Without putting the
      // offset back by however much was added, the view jumps to whatever
      // now occupies the pixels they were looking at.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_scroll.hasClients) return;
        final added = _scroll.position.maxScrollExtent - before;
        if (added > 0) _scroll.jumpTo(_scroll.position.pixels + added);
      });
    }
  }

  /// Puts the newest message back on screen.
  ///
  /// The list runs oldest to newest, so that is the far end. Called after
  /// sending, after the first page lands, and whenever the keyboard changes
  /// the space the list has.
  void _toNewest({bool animate = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final end = _scroll.position.maxScrollExtent;
      if (animate) {
        _scroll.animateTo(
          end,
          duration: MotionTokens.fast,
          curve: Curves.easeOut,
        );
      } else {
        _scroll.jumpTo(end);
      }
    });
  }

  /// The message being answered, while one is. Cleared when it is sent, so a
  /// reply does not silently attach itself to the message after it.
  DirectMessage? _replyingTo;

  Future<void> _send() async {
    final me = ref.read(currentUserProvider).asData?.value.id;
    if (me == null) {
      Toast.show(context, 'You are signed out.');
      return;
    }
    final text = _box.text;
    final answering = _replyingTo;
    _box.clear();
    setState(() => _replyingTo = null);
    unawaited(HapticFeedback.selectionClick());
    await ref.read(threadProvider(widget.args.conversationId).notifier).send(
          text,
          senderId: me,
          media: _media.ready,
          replyToId: answering?.id,
        );
    _media.clear();
    _toNewest(animate: true);
  }

  /// Who wrote [message], as the quote labels it.
  String _authorOf(
      DirectMessage message, String? me, List<MessagePerson> people) {
    if (me != null && message.senderId == me) return 'You';
    for (final person in people) {
      if (person.id == message.senderId) return person.displayName;
    }
    return 'Them';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threadProvider(widget.args.conversationId));
    final notifier =
        ref.read(threadProvider(widget.args.conversationId).notifier);
    final me = ref.watch(currentUserProvider).asData?.value.id;

    // The list is the truth once it has landed; the arguments are what the
    // header shows before that.
    final people = state.people.isNotEmpty ? state.people : widget.args.people;
    final other = people.isEmpty ? null : people.first;

    return Scaffold(
      appBar: KyronAppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: InkWell(
          onTap: other == null
              ? null
              : () => openProfile(
                    context,
                    username: other.username,
                    userId: other.id,
                  ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: .15),
                foregroundImage: other?.avatarUrl == null
                    ? null
                    : NetworkImage(other!.avatarUrl!),
                child: Icon(
                  Iconsax.user_copy,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      other?.displayName ?? 'Conversation',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: TypographyTokens.fontSize4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (other?.handle != null)
                      Text(
                        other!.handle!,
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
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'More',
            icon: const Icon(Iconsax.more_copy, size: 20),
            onPressed: () => _openMenu(state.muted, other),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: _body(state, notifier, me)),
                  // Above the composer, clear of the last bubble. A chat is
                  // read from the bottom, so this brings the reader back to
                  // the newest thing said.
                  Positioned(
                    right: SpacingTokens.space12,
                    bottom: SpacingTokens.space12,
                    child: JumpToEnd(
                      controller: _scroll,
                      direction: JumpDirection.bottom,
                    ),
                  ),
                ],
              ),
            ),
            _Composer(
              controller: _box,
              focus: _focus,
              canSend: _canSend,
              onSend: _send,
              media: _media,
              onAttach: _attach,
              replyingTo: _replyingTo,
              replyingToAuthor: switch (_replyingTo) {
                final answering? => _authorOf(answering, me, state.people),
                _ => null,
              },
              onCancelReply: () => setState(() => _replyingTo = null),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(ThreadState state, ThreadNotifier notifier, String? me) {
    if (state.loadingFirstPage) {
      return SkeletonList.messages();
    }
    if (state.messages.isEmpty) {
      return (state.error != null
              ? EmptyState.failed(
                  title: 'Could not load this conversation',
                  detail: state.error,
                  onAction: notifier.refresh,
                )
              : const EmptyState(
                  art: EmptyArt.messages,
                  title: 'Say something',
                  detail: 'This is the beginning of the conversation.',
                ))
          .scrollable;
    }

    // Oldest first, which is reading order.
    //
    // This was a reversed list, for a good reason -- the newest stays put when
    // the keyboard opens -- but a reversed list lays its content out from the
    // bottom, so a conversation with three messages in it sat against the
    // composer under most of a screen of nothing. It runs the normal way now
    // and is pinned to the end by hand, which does the same job and starts at
    // the top when there is not enough to fill the screen.
    // Already oldest first: the provider reverses what the server sends and
    // prepends older pages. Reversing again here put the newest message at the
    // top, which is not what a chat does.
    final ordered = state.messages;

    // The first page arrives after the first build, and a chat opens at its
    // newest message rather than its oldest.
    if (!_settled && ordered.isNotEmpty) {
      _settled = true;
      _toNewest();
    }

    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space12,
        vertical: SpacingTokens.space12,
      ),
      // The spinner for older messages goes at the top now, which is where
      // they are.
      itemCount: ordered.length + (state.loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (state.loadingMore && index == 0) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final at = state.loadingMore ? index - 1 : index;
        final message = ordered[at];
        final mine = me != null && message.senderId == me;
        final previous = at > 0 ? ordered[at - 1] : null;
        return _Bubble(
          message: message,
          mine: mine,
          // Grouped: consecutive messages from the same person on the same
          // minute do not each need their own timestamp.
          grouped: previous != null &&
              previous.senderId == message.senderId &&
              message.createdAt.difference(previous.createdAt).inMinutes < 2,
          onRetry: () => notifier.retry(message),
          onReply: () => setState(() => _replyingTo = message),
          // Resolved here rather than sent by the server: it holds ciphertext
          // and could not quote it. This list is decrypted.
          answered: state.answered(message),
          answeredAuthor: switch (state.answered(message)) {
            final answered? => _authorOf(answered, me, state.people),
            _ => null,
          },
          onRemove: !mine
              ? null
              : () async {
                  final error = await notifier.remove(message);
                  if (error != null && context.mounted) {
                    Toast.show(context, error);
                  }
                },
        );
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  final DirectMessage message;
  final bool mine;
  final bool grouped;
  final VoidCallback onRetry;
  final VoidCallback? onRemove;
  final VoidCallback onReply;

  /// The message this one answers, already decrypted, or null when it answers
  /// nothing -- or when the answer is older than the pages loaded so far.
  final DirectMessage? answered;

  /// Who wrote [answered], in words.
  final String? answeredAuthor;

  const _Bubble({
    required this.message,
    required this.mine,
    required this.grouped,
    required this.onRetry,
    required this.onReply,
    this.onRemove,
    this.answered,
    this.answeredAuthor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = Radius.circular(RadiusTokens.radiusLg);

    return Padding(
      padding: EdgeInsets.only(top: grouped ? 2 : SpacingTokens.space8),
      child: Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: GestureDetector(
              onLongPress: () => _openOptions(context),
              child: Column(
                crossAxisAlignment:
                    mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.76,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space12,
                      vertical: SpacingTokens.space8,
                    ),
                    decoration: BoxDecoration(
                      color: message.failed
                          ? scheme.error.withValues(alpha: 0.12)
                          : mine
                              ? scheme.primary
                              // `surfaceContainer`, not the top of the
                              // ramp. A bubble is the most repeated shape in
                              // the app -- a hundred down one screen -- so
                              // it takes the quietest step that still gives
                              // it an edge: 2.47 L* off the page, which is
                              // what the messaging apps this was measured
                              // against use. `Highest` is for something
                              // there is one of.
                              : scheme.surfaceContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        // The corner nearest the sender is squared off, which
                        // is what makes a run of bubbles read as one voice.
                        bottomLeft: mine ? radius : const Radius.circular(4),
                        bottomRight: mine ? const Radius.circular(4) : radius,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (message.replyToId != null)
                          _Quote(
                            answered: answered,
                            author: answeredAuthor,
                            onTint: mine ? scheme.onPrimary : scheme.onSurface,
                          ),
                        // A recording is a player, not a picture, so it is
                        // split out the same way a post's is.
                        for (final voice
                            in message.media.where((m) => m.isVoice))
                          VoicePostPlayer(media: voice),
                        if (message.media.any((m) => m.isVisual)) ...[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(RadiusTokens.radiusSm),
                            child: MediaGrid(
                              media: message.media
                                  .where((m) => m.isVisual)
                                  .toList(),
                              radius: RadiusTokens.radiusSm,
                            ),
                          ),
                          if (message.body.trim().isNotEmpty)
                            const SizedBox(height: SpacingTokens.space8),
                        ],
                        if (message.body.trim().isNotEmpty)
                          Text(
                            message.body,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize3,
                              height: 1.35,
                              color: message.failed
                                  ? scheme.onSurface
                                  : mine
                                      ? scheme.onPrimary
                                      : scheme.onSurface,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  _Status(message: message, mine: mine, onRetry: onRetry),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reply, copy, and -- on your own -- delete.
  ///
  /// This used to be long-press-to-delete and nothing else, which meant a long
  /// press on somebody else's message did nothing at all.
  Future<void> _openOptions(BuildContext context) async {
    final copyable = message.body.trim().isNotEmpty && !message.unreadable;

    final chosen = await ActionSheet.show<String>(
      context,
      actions: [
        const SheetAction(
          value: 'reply',
          label: 'Reply',
          icon: Iconsax.undo_copy,
        ),
        if (copyable)
          const SheetAction(
            value: 'copy',
            label: 'Copy text',
            icon: Iconsax.copy_copy,
          ),
        if (onRemove != null)
          const SheetAction(
            value: 'delete',
            label: 'Delete',
            icon: Iconsax.trash_copy,
            destructive: true,
          ),
      ],
    );
    if (chosen == null || !context.mounted) return;

    switch (chosen) {
      case 'reply':
        onReply();
      case 'copy':
        await Clipboard.setData(ClipboardData(text: message.body));
        if (context.mounted) Toast.show(context, 'Copied');
      case 'delete':
        await _confirmRemove(context);
    }
  }

  Future<void> _confirmRemove(BuildContext context) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove this message?'),
        content: const Text('It disappears for both of you.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (yes == true) onRemove?.call();
  }
}

/// The line under a bubble: when, whether it went, whether it was read.
class _Status extends StatelessWidget {
  final DirectMessage message;
  final bool mine;
  final VoidCallback onRetry;

  const _Status({
    required this.message,
    required this.mine,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.5);

    if (message.failed) {
      return TextButton.icon(
        onPressed: onRetry,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: scheme.error,
        ),
        icon: const Icon(Iconsax.refresh, size: 13),
        label: const Text('Not sent. Tap to try again',
            style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                fontWeight: FontWeight.w600)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.sending ? 'Sending…' : age(message.createdAt),
            style:
                TextStyle(fontSize: TypographyTokens.fontSize1, color: muted),
          ),
          // Shown rather than assumed. A conversation is encrypted only when
          // both sides have published a key, and the reader is entitled to
          // know which kind of message this actually was.
          if (message.encrypted) ...[
            const SizedBox(width: 4),
            Icon(
              message.unreadable ? Iconsax.lock_1_copy : Iconsax.lock_copy,
              size: 11,
              color: muted,
            ),
          ],
          if (mine && !message.sending) ...[
            const SizedBox(width: 3),
            Icon(
              message.seen ? Iconsax.tick_circle : Iconsax.tick_circle_copy,
              size: 12,
              color: message.seen ? scheme.primary : muted,
            ),
          ],
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool canSend;
  final VoidCallback onSend;
  final MediaBasket media;
  final Future<void> Function({required bool video}) onAttach;

  /// The message being answered, while one is.
  final DirectMessage? replyingTo;
  final String? replyingToAuthor;
  final VoidCallback onCancelReply;

  const _Composer({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
    required this.media,
    required this.onAttach,
    required this.onCancelReply,
    this.replyingTo,
    this.replyingToAuthor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space8,
        SpacingTokens.space8,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(color: scheme.outline.withValues(alpha: 0.15)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // What is being answered, above the box, with a way out. Without
          // this there is nothing on screen saying the next thing typed will
          // be a reply rather than a remark.
          if (replyingTo != null)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: Row(
                children: [
                  Expanded(
                    child: _Quote(
                      answered: replyingTo,
                      author: replyingToAuthor,
                      onTint: scheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: onCancelReply,
                    tooltip: 'Do not reply',
                    icon: const Icon(Iconsax.close_circle_copy, size: 18),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          if (media.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: MediaTray(
                media: media.items,
                height: 84,
                onRemove: media.remove,
                onRetry: media.retry,
                onDescribe: (item) => media.describe(item.path, item.alt ?? ''),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Add a photo',
                onPressed: media.hasRoom ? () => onAttach(video: false) : null,
                icon: const Icon(Iconsax.gallery_copy, size: 20),
              ),
              IconButton(
                tooltip: 'Add a clip',
                onPressed: media.hasRoom ? () => onAttach(video: true) : null,
                icon: const Icon(Iconsax.video_copy, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focus,
                  // Grows with what is being written, up to a point: a long
                  // message should not be typed through a one-line slot.
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    isDense: true,
                    filled: true,
                    // No alpha: the ramp itself is quiet now, and an alpha
                    // over it was compensation for a step that was too big.
                    fillColor: scheme.surfaceContainer,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space16,
                      vertical: SpacingTokens.space12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(RadiusTokens.radiusFull),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space4),
              IconButton(
                onPressed: canSend ? onSend : null,
                tooltip: 'Send',
                icon: const Icon(Iconsax.send_1, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: canSend
                      ? scheme.primary
                      : scheme.onSurface.withValues(alpha: 0.08),
                  foregroundColor: canSend
                      ? scheme.onPrimary
                      : scheme.onSurface.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The message a reply answers, drawn inside the reply's own bubble.
///
/// The text comes from the copy this phone decrypted, never from the server:
/// direct messages are sealed before they leave the device, so the only thing
/// that crosses the wire is the id of what is being answered.
class _Quote extends StatelessWidget {
  const _Quote({
    required this.answered,
    required this.author,
    required this.onTint,
  });

  /// Null when the answered message is older than the pages loaded so far.
  final DirectMessage? answered;
  final String? author;

  /// The bubble's own foreground, so the quote reads as part of it rather
  /// than as a card sitting on top.
  final Color onTint;

  @override
  Widget build(BuildContext context) {
    final message = answered;

    // A quote that cannot be resolved is still drawn. A reply whose quote
    // silently vanished reads as a remark that does not follow.
    final text = message == null
        ? 'Message'
        : message.isEmpty
            ? 'Attachment'
            : message.body.trim();

    return Container(
      margin: const EdgeInsets.only(bottom: SpacingTokens.space4),
      padding: const EdgeInsets.only(left: SpacingTokens.space8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: onTint.withValues(alpha: 0.5), width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (author != null)
            Text(
              author!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                fontWeight: FontWeight.w600,
                color: onTint.withValues(alpha: 0.85),
              ),
            ),
          Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              height: 1.3,
              color: onTint.withValues(alpha: 0.7),
              fontStyle: message == null ? FontStyle.italic : null,
            ),
          ),
        ],
      ),
    );
  }
}
