import '../l10n/app_localizations.dart';

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
import '../models/current_user.dart';
import '../models/post_media.dart' show MediaKind;
import '../utils/emoji_only.dart';
import '../widgets/gif_picker_sheet.dart';
import '../widgets/quote_stack.dart';
import '../widgets/swipe_to_reply.dart';

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

  Future<void> _attachGif() async {
    final path = await GifPickerSheet.show(context);
    if (path == null || !mounted) return;
    final message = await _media.attachFile(path, MediaKind.gif);
    if (message != null && mounted) Toast.show(context, message);
  }

  /// Everything that can go in a message besides words, behind one button,
  /// so the box itself has the room.
  Future<void> _openAttachments() async {
    final choice = await ActionSheet.show<String>(
      context,
      actions: [
        SheetAction(
          value: 'photo',
          label: AppLocalizations.of(context).literaladdAPhoto,
          icon: Iconsax.gallery_copy,
        ),
        SheetAction(
          value: 'video',
          label: AppLocalizations.of(context).literaladdAClip,
          icon: Iconsax.video_copy,
        ),
        SheetAction(
          value: 'gif',
          label: AppLocalizations.of(context).literaladdAGif,
          icon: Iconsax.emoji_happy_copy,
        ),
      ],
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case 'photo':
        await _attach(video: false);
      case 'video':
        await _attach(video: true);
      case 'gif':
        await _attachGif();
    }
  }

  /// Starts answering [message], with the keyboard up: whoever pulled a
  /// message across to answer it is about to type.
  void _startReply(DirectMessage message) {
    setState(() => _replyingTo = message);
    _focus.requestFocus();
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
            ? SheetAction(
                value: 'unmute',
                label: 'Unmute',
                icon: Iconsax.volume_high_copy,
                detail: 'Be notified about this conversation again',
              )
            : SheetAction(
                value: 'mute',
                label: AppLocalizations.of(context).mute,
                icon: Iconsax.volume_slash_copy,
                detail: 'Stop being notified about this conversation',
              ),
        SheetAction(
          value: 'report',
          label: AppLocalizations.of(context).report,
          icon: Iconsax.flag_copy,
        ),
        SheetAction(
          value: 'block',
          label: AppLocalizations.of(context).block,
          icon: Iconsax.slash_copy,
          detail: 'They can no longer message you',
          destructive: true,
        ),
        SheetAction(
          value: 'leave',
          label: AppLocalizations.of(context).literalremoveThisConversation,
          icon: Iconsax.trash_copy,
          destructive: true,
        ),
      ],
    );
    if (choice == null || !mounted) return;
    await _conversationAction(choice);
  }

  Future<void> _conversationAction(String action) async {
    final notifier = ref.read(
      threadProvider(widget.args.conversationId).notifier,
    );

    switch (action) {
      case 'mute':
        final error = await notifier.setMuted(true);
        if (!mounted) return;
        Toast.show(
          context,
          error ??
              AppLocalizations.of(context).literalmutedYouWillNotBeNotified,
        );
      case 'unmute':
        final error = await notifier.setMuted(false);
        if (!mounted) return;
        Toast.show(context, error ?? 'Unmuted.');
      case 'block':
        final sure = await _confirm(
          title: AppLocalizations.of(context).literalblockThisAccount,
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
          title: AppLocalizations.of(context).removeConversation,
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
              child: Text(AppLocalizations.of(context).cancel),
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

  /// Sends what is in the box -- or, given [quick], just that: the heart
  /// beside an empty box, the wave that opens a new conversation. A quick one
  /// leaves whatever is half-written, and any attachments, where they were.
  Future<void> _send({String? quick}) async {
    final me = ref.read(currentUserProvider).asData?.value.id;
    if (me == null) {
      Toast.show(context, AppLocalizations.of(context).literalyouAreSignedOut);
      return;
    }
    final text = quick ?? _box.text;
    final answering = _replyingTo;
    if (quick == null) _box.clear();
    setState(() => _replyingTo = null);
    unawaited(HapticFeedback.selectionClick());
    await ref.read(threadProvider(widget.args.conversationId).notifier).send(
          text,
          senderId: me,
          media: quick == null ? _media.ready : const [],
          replyToId: answering?.id,
        );
    if (quick == null) _media.clear();
    _toNewest(animate: true);
  }

  /// Whether [later] carries on the turn [earlier] started.
  static bool _sameRun(DirectMessage earlier, DirectMessage later) =>
      earlier.senderId == later.senderId &&
      later.createdAt.difference(earlier.createdAt).inMinutes < 2;

  /// Who wrote [message], as the quote labels it.
  String _authorOf(
    DirectMessage message,
    String? me,
    List<MessagePerson> people,
  ) {
    if (me != null && message.senderId == me) return 'You';
    for (final person in people) {
      if (person.id == message.senderId) return person.displayName;
    }
    return 'Them';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(threadProvider(widget.args.conversationId));
    final notifier = ref.read(
      threadProvider(widget.args.conversationId).notifier,
    );
    final self = ref.watch(currentUserProvider).asData?.value;
    final me = self?.id;

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
                  Positioned.fill(
                    child: _body(state, notifier, me, people, self),
                  ),
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
              onHeart: () => _send(quick: '❤️'),
              media: _media,
              onAttach: _attach,
              onAttachments: _openAttachments,
              onGif: _attachGif,
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

  Widget _body(
    ThreadState state,
    ThreadNotifier notifier,
    String? me,
    List<MessagePerson> people,
    CurrentUser? self,
  ) {
    if (state.loadingFirstPage) {
      return SkeletonList.messages();
    }
    if (state.messages.isEmpty) {
      if (state.error != null) {
        return EmptyState.failed(
          title:
              AppLocalizations.of(context).literalcouldNotLoadThisConversation,
          detail: state.error,
          onAction: notifier.refresh,
        ).scrollable;
      }
      return _ChatStarter(
        other: people.firstOrNull,
        self: self,
        onWave: () => _send(quick: '👋'),
      );
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
        final next = at + 1 < ordered.length ? ordered[at + 1] : null;
        return _Bubble(
          message: message,
          mine: mine,
          // A run: consecutive messages from the same person within a couple
          // of minutes read as one turn, so they sit close together and share
          // one avatar and one time, at the end of the run.
          grouped: previous != null && _sameRun(previous, message),
          endsGroup: next == null || !_sameRun(message, next),
          sender: mine
              ? null
              : people.where((p) => p.id == message.senderId).firstOrNull,
          onRetry: () => notifier.retry(message),
          onReply: () => _startReply(message),
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

  /// Whether this is the last message of a run from one person. That is where
  /// the run's avatar and its time go -- once, rather than a timestamp under
  /// every line somebody sent in the same breath.
  final bool endsGroup;

  /// Who sent it, for the avatar beside their runs. Null for your own.
  final MessagePerson? sender;

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
    required this.endsGroup,
    required this.onRetry,
    required this.onReply,
    this.sender,
    this.onRemove,
    this.answered,
    this.answeredAuthor,
  });

  /// The avatar's width plus the gap after it, which every bubble from the
  /// other person is indented by, avatar or not, so a run stays in a column.
  static const double _gutter = 28 + SpacingTokens.space8;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Just a few emoji, and nothing else, is drawn large and without a
    // bubble. Never for one that could not be opened: what it holds is not
    // known, so it cannot be known to be emoji.
    final jumbo = message.media.isEmpty && !message.unreadable
        ? jumboEmojiCount(message.body)
        : null;

    Widget content = jumbo != null
        ? _Jumbo(text: message.body.trim(), count: jumbo, faded: message.failed)
        : _box(context, scheme, overlapping: message.replyToId != null);

    if (message.replyToId != null) {
      content = Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space4,
              SpacingTokens.space4,
              SpacingTokens.space4,
              SpacingTokens.space4,
            ),
            child: Text(
              mine
                  ? AppLocalizations.of(context)
                      .ui('ui_dm_you_replied', 'You replied')
                  : AppLocalizations.of(context).dmReplied(
                      sender?.displayName ?? answeredAuthor ?? 'Them',
                    ),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
          // The answered message behind, muted; the answer over its lower
          // edge. One exchange, read as one.
          QuoteStack(
            alignEnd: mine,
            quote: _QuotedMessage(answered: answered),
            reply: content,
          ),
        ],
      );
    }

    final showStatus = endsGroup || message.failed || message.sending;

    return Padding(
      padding: EdgeInsets.only(top: grouped ? 2 : SpacingTokens.space8),
      child: Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                mine ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!mine) ...[
                SizedBox(
                  width: 28,
                  child: endsGroup ? _Avatar(person: sender, radius: 14) : null,
                ),
                const SizedBox(width: SpacingTokens.space8),
              ],
              Flexible(
                child: SwipeToReply(
                  // A message still on its way, or one that never arrived,
                  // has no id the server knows -- there is nothing to answer.
                  enabled: !message.sending && !message.failed,
                  onReply: onReply,
                  child: GestureDetector(
                    onLongPress: () => _openOptions(context),
                    child: content,
                  ),
                ),
              ),
            ],
          ),
          if (showStatus)
            Padding(
              padding: EdgeInsets.only(top: 2, left: mine ? 0 : _gutter),
              child: _Status(message: message, mine: mine, onRetry: onRetry),
            ),
        ],
      ),
    );
  }

  /// The bubble: colour, shape, and what is in it.
  ///
  /// [overlapping] when it rides over a quoted message. It then takes a rim in
  /// the page colour, so where the two meet reads as one shape in front of
  /// another rather than as two shapes run together.
  Widget _box(
    BuildContext context,
    ColorScheme scheme, {
    required bool overlapping,
  }) {
    final radius = Radius.circular(RadiusTokens.radiusLg);
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.72,
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
                // `surfaceContainer`, not the top of the ramp. A bubble is
                // the most repeated shape in the app -- a hundred down one
                // screen -- so it takes the quietest step that still gives it
                // an edge: 2.47 L* off the page, which is what the messaging
                // apps this was measured against use. `Highest` is for
                // something there is one of.
                : scheme.surfaceContainer,
        border:
            overlapping ? Border.all(color: scheme.surface, width: 2) : null,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
          // The corner nearest the sender is squared off, which is what makes
          // a run of bubbles read as one voice.
          bottomLeft: mine ? radius : const Radius.circular(4),
          bottomRight: mine ? const Radius.circular(4) : radius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // A recording is a player, not a picture, so it is split out the
          // same way a post's is.
          for (final voice in message.media.where((m) => m.isVoice))
            VoicePostPlayer(media: voice),
          if (message.media.any((m) => m.isVisual)) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
              child: MediaGrid(
                media: message.media.where((m) => m.isVisual).toList(),
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
        SheetAction(
          value: 'reply',
          label: AppLocalizations.of(context).reply,
          icon: Iconsax.undo_copy,
        ),
        if (copyable)
          SheetAction(
            value: 'copy',
            label: AppLocalizations.of(context).literalcopyText,
            icon: Iconsax.copy_copy,
          ),
        if (onRemove != null)
          SheetAction(
            value: 'delete',
            label: AppLocalizations.of(context).delete,
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
        title: Text(AppLocalizations.of(context).removeMessage),
        content: Text(AppLocalizations.of(context).itDisappearsForBoth),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).remove),
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
        label: Text(
          AppLocalizations.of(context).notSentTapRetry,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.sending ? 'Sending…' : age(message.createdAt),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: muted,
            ),
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

  /// Sends a heart on its own, from the button that stands where Send does
  /// while there is nothing to send.
  final VoidCallback onHeart;
  final MediaBasket media;
  final Future<void> Function({required bool video}) onAttach;

  /// Every kind of attachment, as a sheet.
  final VoidCallback onAttachments;
  final VoidCallback onGif;

  /// The message being answered, while one is.
  final DirectMessage? replyingTo;
  final String? replyingToAuthor;
  final VoidCallback onCancelReply;

  const _Composer({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
    required this.onHeart,
    required this.media,
    required this.onAttach,
    required this.onAttachments,
    required this.onGif,
    required this.onCancelReply,
    this.replyingTo,
    this.replyingToAuthor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final typing = controller.text.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space8,
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
              padding: const EdgeInsets.only(
                left: SpacingTokens.space8,
                bottom: SpacingTokens.space8,
              ),
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
                    tooltip: AppLocalizations.of(context).literaldoNotReply,
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
                tooltip: AppLocalizations.of(context)
                    .ui('ui_dm_attach', 'Add to message'),
                onPressed: media.hasRoom ? onAttachments : null,
                icon: const Icon(Iconsax.add, size: 22),
                style: IconButton.styleFrom(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: scheme.outline.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space4),
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
                    hintText: AppLocalizations.of(context).message,
                    isDense: true,
                    filled: true,
                    // No alpha: the ramp itself is quiet now, and an alpha
                    // over it was compensation for a step that was too big.
                    fillColor: scheme.surfaceContainer,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space16,
                      vertical: SpacingTokens.space12,
                    ),
                    // A photo and a GIF are a tap away inside the box while
                    // it is empty, and step aside once something is being
                    // written, which is when the room matters more.
                    suffixIcon: typing
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: AppLocalizations.of(context)
                                    .literaladdAPhoto,
                                onPressed: media.hasRoom
                                    ? () => onAttach(video: false)
                                    : null,
                                icon: const Icon(
                                  Iconsax.gallery_copy,
                                  size: 20,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              IconButton(
                                tooltip:
                                    AppLocalizations.of(context).literaladdAGif,
                                onPressed: media.hasRoom ? onGif : null,
                                icon: const Icon(
                                  Iconsax.emoji_happy_copy,
                                  size: 20,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                              const SizedBox(width: SpacingTokens.space4),
                            ],
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        RadiusTokens.radiusFull,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space4),
              // Send when there is something to send. Until then a heart,
              // which is the reply most messages actually get, in one tap.
              canSend
                  ? IconButton(
                      onPressed: onSend,
                      tooltip: 'Send',
                      icon: const Icon(Iconsax.send_1, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: scheme.primary,
                        foregroundColor: scheme.onPrimary,
                      ),
                    )
                  : IconButton(
                      onPressed: media.isUploading ? null : onHeart,
                      tooltip: AppLocalizations.of(context)
                          .ui('ui_dm_send_heart', 'Send a heart'),
                      icon: const Icon(Iconsax.heart, size: 22),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The message about to be answered, above the composer.
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

/// A message that is only a few emoji, drawn large and without a bubble.
class _Jumbo extends StatelessWidget {
  const _Jumbo({required this.text, required this.count, this.faded = false});

  final String text;
  final int count;

  /// One that failed to send stays readable, but plainly not delivered.
  final bool faded;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Opacity(
          opacity: faded ? 0.5 : 1,
          child: Text(
            text,
            style: TextStyle(fontSize: jumboEmojiSize(count), height: 1.15),
          ),
        ),
      );
}

/// The message a reply answers, behind the reply and muted, its lower edge
/// under the reply's bubble.
///
/// The text comes from the copy this phone decrypted, never from the server:
/// direct messages are sealed before they leave the device, so the only thing
/// that crosses the wire is the id of what is being answered.
class _QuotedMessage extends StatelessWidget {
  const _QuotedMessage({required this.answered});

  /// Null when the answered message is older than the pages loaded so far.
  final DirectMessage? answered;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final message = answered;

    // A quote that cannot be resolved is still drawn. A reply whose quote
    // silently vanished reads as a remark that does not follow.
    final text = message == null
        ? 'Message'
        : message.isEmpty || message.body.trim().isEmpty
            ? 'Attachment'
            : message.body.trim();

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.62,
      ),
      // Room at the bottom for the reply to ride over without covering the
      // words: QuoteStack overlaps by 14.
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space8 + 14,
      ),
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
      ),
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize2,
          height: 1.3,
          color: scheme.onSurface.withValues(alpha: 0.65),
          fontStyle: message == null ? FontStyle.italic : null,
        ),
      ),
    );
  }
}

/// Somebody's picture, or a placeholder in the same circle.
class _Avatar extends StatelessWidget {
  const _Avatar({required this.person, required this.radius, this.url});

  final MessagePerson? person;
  final double radius;

  /// Used when there is no [person] -- the reader's own picture.
  final String? url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final src = person?.avatarUrl ?? url;
    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primary.withValues(alpha: .15),
      foregroundImage: src == null ? null : NetworkImage(src),
      child: Icon(Iconsax.user_copy, size: radius, color: scheme.primary),
    );
  }
}

/// What a conversation looks like before anybody has said anything.
///
/// It used to be the app's generic empty state -- an illustration and "Say
/// something" -- which is what an empty search looks like too. A new
/// conversation is two particular people, so it shows them, and offers the
/// easiest possible first message: a wave, one tap, sent as itself.
class _ChatStarter extends StatelessWidget {
  const _ChatStarter({
    required this.other,
    required this.self,
    required this.onWave,
  });

  final MessagePerson? other;
  final CurrentUser? self;
  final VoidCallback onWave;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(SpacingTokens.space24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Narrower than the two avatars side by side, so they
                  // overlap: two people, one conversation.
                  SizedBox(
                    width: 128,
                    height: 92,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: _Avatar(person: other, radius: 38),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: scheme.surface,
                            ),
                            child: _Avatar(
                              person: null,
                              url: self?.avatarUrl,
                              radius: 35,
                            ),
                          ),
                        ),
                        // The wave, mid-air between the two of them.
                        Positioned(
                          right: 38,
                          top: -10,
                          child: Container(
                            padding: const EdgeInsets.all(SpacingTokens.space8),
                            decoration: BoxDecoration(
                              color: scheme.surfaceContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '👋',
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  Text(
                    other?.displayName ?? l10n.ui('ui_dm_new', 'New message'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: TypographyTokens.fontSize4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (other?.handle != null)
                    Text(
                      other!.handle!,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize2,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  const SizedBox(height: SpacingTokens.space8),
                  Text(
                    l10n.ui(
                      'ui_dm_starter',
                      'Nothing said yet. A wave is a good start.',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  // A small pill, not a full-width call to action: it is a
                  // wave, and the box below is right there for anything more.
                  OutlinedButton(
                    onPressed: onWave,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpacingTokens.space20,
                      ),
                    ),
                    child: Text(l10n.ui('ui_dm_wave', '👋  Wave')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
