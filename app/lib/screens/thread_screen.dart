import '../l10n/app_localizations.dart';

// lib/screens/thread_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/conversation.dart';
import '../providers/current_user_provider.dart';
import '../providers/messages_provider.dart';
import '../routes.dart';
import '../widgets/action_sheet.dart';
import '../widgets/chat_wallpaper_view.dart';
import '../providers/chat_wallpaper_provider.dart';
import 'conversation_info_screen.dart';
import '../widgets/empty_state.dart';
import '../widgets/jump_to_end.dart';
import '../widgets/online_dot.dart';
import '../widgets/toast.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../providers/composer_provider.dart' show ComposerState;
import '../providers/preferences_provider.dart';
import '../utils/media_basket.dart';
import '../widgets/media_tray.dart';
import '../widgets/media_grid.dart';
import '../widgets/create_post/voice_recorder_sheet.dart';
import '../widgets/voice_post_player.dart';
import '../widgets/skeleton.dart';
import '../widgets/kyron_app_bar.dart';
import '../models/current_user.dart';
import '../models/post_media.dart' show MediaKind, PostMedia;
import '../utils/emoji_only.dart';
import '../widgets/gif_picker_sheet.dart';
import '../widgets/overlap_stack.dart';
import '../widgets/swipe_to_reply.dart';
import '../widgets/message_focus.dart';
import '../models/message_link_card.dart';
import '../services/link_card_reader.dart';
import '../widgets/create_post/url_preview.dart' show firstLinkIn;
import '../widgets/hairline.dart';
import '../widgets/link_preview_card.dart' show LinkCard;

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

class _ThreadScreenState extends ConsumerState<ThreadScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _box = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final FocusNode _focus = FocusNode();
  bool _canSend = false;

  /// Each message's row, by id, so a quote can bring the message it quotes
  /// into view. Rows are built lazily, so this is how one off screen is
  /// found once the list has been moved near it.
  final Map<String, GlobalKey> _rows = {};

  /// The message a quote was just followed to, while it is being pointed
  /// out.
  String? _pulsing;

  /// Set while the list is being moved to a quoted message, so reaching the
  /// top on the way does not start loading older pages under it.
  bool _jumping = false;
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  /// The link whose card is being made for the message being written, once
  /// the typing has paused on it.
  String? _link;

  /// A link whose card the writer took off. It stays off for that link.
  String? _droppedLink;
  Timer? _linkPause;

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
    _pulse.dispose();
    _linkPause?.cancel();
    super.dispose();
  }

  // As many as a post: the server holds a message to the same number.
  late final MediaBasket _media = MediaBasket(
    ref.read(feedRepositoryProvider),
    limit: ComposerState.maxMedia,
  )..addListener(_onMedia);

  void _onMedia() => setState(_recalculate);

  /// Whether the list has been put at its newest message once.
  bool _settled = false;

  void _onTyping() {
    setState(_recalculate);
    _watchLink();
    // Throttled by the notifier, so this can be called on every keystroke.
    // Not at all for somebody who turned "typing" off in messaging settings.
    if (_box.text.trim().isNotEmpty &&
        ref.read(preferencesProvider).typingShown) {
      unawaited(
        ref
            .read(threadProvider(widget.args.conversationId).notifier)
            .sendTyping(),
      );
    }
  }

  /// Follows the first link in the box, settling on it only once typing
  /// pauses, so "https://ex", "https://exa" and so on are not each read.
  void _watchLink() {
    // No card at all for somebody who turned link previews off: the page is
    // never read, so the site never hears from this phone.
    final link = ref.read(preferencesProvider).linkPreviews
        ? firstLinkIn(_box.text)
        : null;
    if (link == _link) {
      _linkPause?.cancel();
      return;
    }
    _linkPause?.cancel();
    if (link == null) {
      setState(() => _link = null);
      return;
    }
    _linkPause = Timer(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _link = link);
    });
  }

  /// The card for the link in the message about to go, made or on its way.
  ///
  /// Read from the words at the moment Send is pressed rather than from what
  /// the pause in typing settled on: a link pasted and sent at once never
  /// waited out the pause, and went without a card. Null when there is no
  /// link, or the writer took its card off.
  Future<MessageLinkCard?>? get _cardToSend {
    if (!ref.read(preferencesProvider).linkPreviews) return null;
    final link = firstLinkIn(_box.text);
    if (link == null || link == _droppedLink) return null;
    return ref.read(messageLinkCardProvider(link).future);
  }

  /// Whether the list is at, or near, its newest message -- the only time
  /// something arriving at the bottom should pull the view down to it. A
  /// reader scrolled up into last week is not dragged back for "is typing".
  bool get _nearNewest =>
      !_scroll.hasClients ||
      _scroll.position.maxScrollExtent - _scroll.position.pixels < 120;

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

  Future<void> _capture() async {
    final message = await _media.capture();
    if (message != null && mounted) Toast.show(context, message);
  }

  Future<void> _attachGif() async {
    final path = await GifPickerSheet.show(context);
    if (path == null || !mounted) return;
    final message = await _media.attachFile(path, MediaKind.gif);
    if (message != null && mounted) Toast.show(context, message);
  }

  /// Records a voice note and sends it as its own message, answering
  /// whatever was being answered.
  Future<void> _recordVoice() async {
    final me = ref.read(currentUserProvider).asData?.value.id;
    if (me == null) {
      Toast.show(context, AppLocalizations.of(context).literalyouAreSignedOut);
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    final recording = await VoiceRecorderSheet.show(context, forMessage: true);
    if (recording == null || !mounted) return;

    final answering = _replyingTo;
    setState(() => _replyingTo = null);
    unawaited(HapticFeedback.selectionClick());
    final feed = ref.read(feedRepositoryProvider);
    unawaited(
      ref.read(threadProvider(widget.args.conversationId).notifier).sendVoice(
            recording,
            senderId: me,
            upload: feed.uploadMedia,
            replyToId: answering?.id,
          ),
    );
    _toNewest(animate: true);
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
          value: 'camera',
          label: AppLocalizations.of(context)
              .ui('ui_dm_take_photo', 'Take a photo'),
          icon: Iconsax.camera_copy,
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
      case 'camera':
        await _capture();
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

  /// The conversation's info page: the person, what has been shared, the
  /// wallpaper, and mute, report, block and remove. Blocking or removing
  /// takes the conversation out of the list, so this screen goes with it.
  Future<void> _openInfo(List<MessagePerson> people) async {
    final result = await ConversationInfoScreen.open(
      context,
      conversationId: widget.args.conversationId,
      people: people,
    );
    if (result == ConversationInfoResult.closed && mounted) {
      Navigator.pop(context);
    }
  }

  void _onScroll() {
    if (!_scroll.hasClients || _jumping) return;
    // Older messages are above, so the top edge is what asks for more.
    if (_scroll.position.pixels <= 300) {
      // Nothing older to fetch, or a fetch already going: nothing will be
      // added above, so there is nothing to make room for. Without this the
      // "make room" below ran on every scroll near the top and moved the
      // view by however much the list's own estimate of its length changed.
      final state = ref.read(threadProvider(widget.args.conversationId));
      if (state.cursor == null || state.loadingMore) return;
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

  /// Follows a quote to the message it quotes: pages back until that message
  /// is loaded, scrolls it into view, and points it out.
  Future<void> _openAnswered(String id) async {
    final provider = threadProvider(widget.args.conversationId);
    final notifier = ref.read(provider.notifier);

    // Older than anything loaded: page back until it is, or there is nothing
    // older. Bounded, so a quote of something long deleted cannot page
    // through a whole history.
    for (var pages = 0; pages < 20; pages++) {
      final state = ref.read(provider);
      if (state.messages.any((m) => m.id == id) || state.cursor == null) break;
      await notifier.loadMore();
      if (!mounted) return;
    }

    if (!ref.read(provider).messages.any((m) => m.id == id)) {
      if (mounted) {
        Toast.show(
          context,
          AppLocalizations.of(context)
              .ui('ui_dm_quote_gone', 'That message is no longer here.'),
        );
      }
      return;
    }

    // Let the list take in whatever was just loaded before measuring it.
    await WidgetsBinding.instance.endOfFrame;
    _jumping = true;
    final arrived = await _bringIntoView(id);
    _jumping = false;
    if (!arrived || !mounted) return;

    unawaited(HapticFeedback.selectionClick());
    setState(() => _pulsing = id);
    await _pulse.forward(from: 0);
    if (mounted && _pulsing == id) setState(() => _pulsing = null);
  }

  /// Scrolls until the row for [id] is built, then settles it a little above
  /// the middle of the screen. Answers whether it got there.
  Future<bool> _bringIntoView(String id) async {
    for (var step = 0; step < 80; step++) {
      if (!mounted || !_scroll.hasClients) return false;
      final row = _rows[id]?.currentContext;
      if (row != null && row.mounted) {
        await Scrollable.ensureVisible(
          row,
          alignment: 0.4,
          duration: MotionTokens.normal,
          curve: Curves.easeInOutCubic,
        );
        return true;
      }

      // Off screen, so not built. Which way to go is told by which rows are
      // built: all after it means it is above, all before means below.
      final messages =
          ref.read(threadProvider(widget.args.conversationId)).messages;
      final index = messages.indexWhere((m) => m.id == id);
      if (index < 0) return false;
      final built = <int>[
        for (var i = 0; i < messages.length; i++)
          if (_rows[messages[i].id]?.currentContext != null) i,
      ];
      final position = _scroll.position;
      final page = position.viewportDimension * 0.85;
      final double to;
      if (built.isEmpty) {
        to = messages.length < 2
            ? position.pixels
            : position.maxScrollExtent * index / (messages.length - 1);
      } else if (index < built.first) {
        to = position.pixels - page;
      } else {
        to = position.pixels + page;
      }
      _scroll.jumpTo(
        to.clamp(position.minScrollExtent, position.maxScrollExtent),
      );
      await WidgetsBinding.instance.endOfFrame;
    }
    return false;
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

  /// Sends what is in the box -- or, given [quick], just that: the wave that
  /// opens a new conversation. A quick one leaves whatever is half-written,
  /// and any attachments, where they were.
  Future<void> _send({String? quick}) async {
    final me = ref.read(currentUserProvider).asData?.value.id;
    if (me == null) {
      Toast.show(context, AppLocalizations.of(context).literalyouAreSignedOut);
      return;
    }
    final text = quick ?? _box.text;
    final answering = _replyingTo;
    final card = quick == null ? _cardToSend : null;
    if (quick == null) _box.clear();
    setState(() {
      _replyingTo = null;
      _link = null;
      _droppedLink = null;
    });
    unawaited(HapticFeedback.selectionClick());
    await ref.read(threadProvider(widget.args.conversationId).notifier).send(
          text,
          senderId: me,
          media: quick == null ? _media.ready : const [],
          replyToId: answering?.id,
          linkCardLater: card,
        );
    if (quick == null) _media.clear();
    _toNewest(animate: true);
  }

  /// How long a pause has to be before the thread says what time it is
  /// again. The time is a centred line between turns, the way Threads,
  /// Instagram and iMessage draw it, rather than a stamp under every run.
  static const _pause = Duration(minutes: 15);

  /// Whether the time goes above [message], given the one before it: at the
  /// start, after a pause, and whenever the day changes.
  static bool _timeAbove(DirectMessage? previous, DirectMessage message) {
    if (previous == null) return true;
    final a = previous.createdAt;
    final b = message.createdAt;
    return b.difference(a) >= _pause ||
        a.year != b.year ||
        a.month != b.month ||
        a.day != b.day;
  }

  /// Whether [later] carries on [earlier]'s turn with nothing drawn between
  /// them: the same person, no pause long enough for a time, and not where
  /// "New messages" goes.
  static bool _continues(
    DirectMessage earlier,
    DirectMessage later,
    String? firstUnread,
  ) =>
      earlier.senderId == later.senderId &&
      !_timeAbove(earlier, later) &&
      later.id != firstUnread;

  /// Whether [message] is drawn as a bubble whose corners can join its
  /// neighbours'. A few emoji alone are drawn large and bare, and pictures
  /// are a block of their own: neither has a sender's corner to tuck.
  static bool _inBubble(DirectMessage message) =>
      _Bubble.jumboCountOf(message) == null &&
      !message.media.any((m) => m.isVisual);

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

    // The dots appear at the foot of the list; bring them into view if the
    // reader was already reading the newest messages.
    ref.listen(
      threadProvider(widget.args.conversationId).select((s) => s.typing),
      (previous, next) {
        if (next != null && previous == null && _nearNewest) {
          _toNewest(animate: true);
        }
      },
    );

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
              OnlineDot(
                person: other,
                size: 11,
                child: CircleAvatar(
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
                    // Online in place of the handle while they are: the
                    // one thing about them worth knowing at that moment.
                    if (isOnline(ref, other))
                      Text(
                        AppLocalizations.of(context)
                            .ui('ui_dm_online', 'Online'),
                        key: const ValueKey('thread-online'),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      )
                    else if (other?.handle != null)
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
            tooltip:
                AppLocalizations.of(context).ui('ui_status_details', 'Details'),
            icon: const Icon(Iconsax.more_copy, size: 20),
            onPressed: () => _openInfo(people),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Behind the messages, never behind the box they are
                  // written in: the composer keeps the page's own colour.
                  Positioned.fill(
                    child: ChatWallpaperView(
                      wallpaper: ref.watch(
                        chatWallpaperProvider(widget.args.conversationId),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: _WallpaperScope(
                      onWallpaper: !ref
                          .watch(
                            chatWallpaperProvider(widget.args.conversationId),
                          )
                          .isNone,
                      child: _body(state, notifier, me, people, self),
                    ),
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
              media: _media,
              onAttach: _attach,
              onAttachments: _openAttachments,
              onGif: _attachGif,
              onVoice: _recordVoice,
              replyingTo: _replyingTo,
              replyingToAuthor: switch (_replyingTo) {
                final answering? => _authorOf(answering, me, state.people),
                _ => null,
              },
              onCancelReply: () => setState(() => _replyingTo = null),
              link: _link == _droppedLink ? null : _link,
              onDropLink: () => setState(() => _droppedLink = _link),
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

    final firstUnread = me == null ? null : state.firstUnreadFor(me);
    final typer = state.typing == null
        ? null
        : people.where((p) => p.id == state.typing).firstOrNull;

    // Where encryption starts: the first sealed message. The notice goes
    // there, once -- the point a conversation from before encryption, or
    // with somebody whose app had no key, changed over -- and a message after
    // it that went as written is the exception worth marking. Everything
    // before it is plain, and saying so on each one would be noise.
    final sealedFrom = ordered.indexWhere((m) => m.encrypted);
    final lead = state.loadingMore ? 1 : 0;

    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space12,
      ),
      // The spinner for older messages goes at the top, which is where they
      // are; "is typing" goes at the bottom, where the next message will.
      itemCount: lead + ordered.length + (state.typing != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (state.loadingMore && index == 0) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final at = index - lead;
        if (at == ordered.length) {
          return _TypingBubble(person: typer);
        }
        final message = ordered[at];
        final mine = me != null && message.senderId == me;
        final previous = at > 0 ? ordered[at - 1] : null;
        final next = at + 1 < ordered.length ? ordered[at + 1] : null;

        final timeAbove = _timeAbove(previous, message);
        final dividerAbove = message.id == firstUnread;
        // A turn: one person's messages with nothing drawn between them. They
        // stack tight, share one avatar at the bottom, and their corners on
        // the sender's side tuck in where they meet -- so one message is a
        // pill, two are a pair, and a run reads as a single column.
        final continues =
            previous != null && _continues(previous, message, firstUnread);
        final continuesBelow =
            next != null && _continues(message, next, firstUnread);
        // A reply starts its own shape: the quote above it is in the way.
        final joinsAbove = previous != null &&
            continues &&
            message.replyToId == null &&
            _inBubble(previous) &&
            _inBubble(message);
        final joinsBelow = next != null &&
            continuesBelow &&
            next.replyToId == null &&
            _inBubble(message) &&
            _inBubble(next);

        final bubble = _Bubble(
          message: message,
          mine: mine,
          me: me,
          joinsAbove: joinsAbove,
          joinsBelow: joinsBelow,
          showAvatar: !continuesBelow,
          topGap: timeAbove || dividerAbove
              ? 0
              : continues
                  ? (message.replyToId == null ? 2 : SpacingTokens.space8)
                  : SpacingTokens.space12,
          // Only a message with words: those are what is sealed. Pictures
          // alone have nothing to seal -- attachments are stored in the clear,
          // which docs/E2EE.md says -- and marking every photo as a lapse
          // was a lock beside each one.
          unsealed: sealedFrom >= 0 &&
              at > sealedFrom &&
              message.body.trim().isNotEmpty &&
              !message.encrypted &&
              !message.sending &&
              !message.failed,
          onToggleHeart: me == null
              ? null
              : () => _afterReaction(
                    notifier.toggleHeart(message, me: me),
                  ),
          onReact: me == null
              ? null
              : (emoji) => _afterReaction(
                    notifier.react(message, emoji, me: me),
                  ),
          onRemoveReaction: me == null
              ? null
              : () => _afterReaction(notifier.unreact(message, me: me)),
          sender: mine
              ? null
              : people.where((p) => p.id == message.senderId).firstOrNull,
          onReply: () => _startReply(message),
          // Resolved here rather than sent by the server: it holds ciphertext
          // and could not quote it. This list is decrypted.
          answered: state.answered(message),
          onOpenAnswered: switch (message.replyToId) {
            final id? => () => _openAnswered(id),
            _ => null,
          },
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

        return Column(
          key: _rows.putIfAbsent(message.id, GlobalKey.new),
          crossAxisAlignment:
              mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (at == sealedFrom) const _EncryptionNotice(),
            if (timeAbove) _TimeHeader(at: message.createdAt),
            // Above the first message the reader had not seen when they
            // opened the thread -- where they left off, marked.
            if (dividerAbove) const _NewMessagesDivider(),
            if (message.id == _pulsing)
              _Pulse(
                key: ValueKey('pulsing-${message.id}'),
                animation: _pulse,
                alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                child: bubble,
              )
            else
              bubble,
            // Whether it went, said once: under your newest message, the way
            // a chat says "Seen", rather than a line under every run. One
            // that failed says so wherever it is, with a way to try again.
            if (message.failed)
              Padding(
                padding: EdgeInsets.only(left: mine ? 0 : _Bubble.gutter),
                child: _NotSent(onRetry: () => notifier.retry(message)),
              )
            else if (mine && next == null)
              _Receipt(message: message),
          ],
        );
      },
    );
  }

  /// Says so if a reaction did not stick. The notifier has already put the
  /// bubble back the way it was.
  Future<void> _afterReaction(Future<String?> attempt) async {
    unawaited(HapticFeedback.lightImpact());
    final error = await attempt;
    if (error != null && mounted) Toast.show(context, error);
  }
}

class _Bubble extends StatelessWidget {
  final DirectMessage message;
  final bool mine;

  /// Whether it carries on from the message above, or into the one below,
  /// without a break. The corners where they meet tuck in on the sender's
  /// side, so a run of messages reads as one column rather than a stack of
  /// separate pills.
  final bool joinsAbove;
  final bool joinsBelow;

  /// Whether this is the last of a turn from the other person, which is where
  /// their avatar goes -- once per turn, not beside every line.
  final bool showAvatar;

  /// The space above it: almost none inside a turn, more between turns.
  final double topGap;

  /// Sent as written, in a conversation where messages are otherwise sealed.
  /// Marked, so nobody assumes it was private.
  final bool unsealed;

  /// Who sent it, for the avatar beside their turns. Null for your own.
  final MessagePerson? sender;

  /// The reader's id, to tell their own reaction from the other person's.
  final String? me;

  /// A double tap: a heart, or the heart taken back.
  final VoidCallback? onToggleHeart;

  /// One of the quick reactions, from the long-press sheet.
  final void Function(String emoji)? onReact;

  /// Takes the reader's reaction off, from a tap on it.
  final VoidCallback? onRemoveReaction;

  final VoidCallback? onRemove;
  final VoidCallback onReply;

  /// The message this one answers, already decrypted, or null when it answers
  /// nothing -- or when the answer is older than the pages loaded so far.
  final DirectMessage? answered;

  /// Who wrote [answered], in words.
  final String? answeredAuthor;

  /// Takes the reader to the message this one answers.
  final VoidCallback? onOpenAnswered;

  const _Bubble({
    required this.message,
    required this.mine,
    required this.joinsAbove,
    required this.joinsBelow,
    required this.showAvatar,
    required this.topGap,
    required this.onReply,
    this.unsealed = false,
    this.sender,
    this.me,
    this.onToggleHeart,
    this.onReact,
    this.onRemoveReaction,
    this.onRemove,
    this.answered,
    this.answeredAuthor,
    this.onOpenAnswered,
  });

  /// The avatar's width plus the gap after it, which every bubble from the
  /// other person is indented by, avatar or not, so a turn stays in a column.
  static const double gutter = 28 + SpacingTokens.space8;

  /// The corner of a bubble, and of where two in a turn meet.
  static const _round = Radius.circular(RadiusTokens.radius20);
  static const _tucked = Radius.circular(RadiusTokens.radius4);

  /// How many emoji to draw large, or null to draw a bubble.
  ///
  /// Never for one that could not be opened: what it holds is not known, so
  /// it cannot be known to be emoji.
  static int? jumboCountOf(DirectMessage message) =>
      message.media.isEmpty && !message.unreadable
          ? jumboEmojiCount(message.body)
          : null;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final jumbo = jumboCountOf(message);
    Widget content = jumbo != null
        ? _Jumbo(text: message.body.trim(), count: jumbo, faded: message.failed)
        : _box(context, scheme, overlapping: message.replyToId != null);

    // Reactions sit on the bubble's lower corner -- the side it hangs from --
    // overlapping its edge, as one small pill.
    if (message.reactions.isNotEmpty) {
      content = OverlapStack(
        alignEnd: mine,
        overlap: 8,
        back: content,
        front: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space8,
          ),
          child: _ReactionPill(
            reactions: message.reactions,
            me: me,
            onRemove: onRemoveReaction,
          ),
        ),
      );
    }

    // The message's own gestures go on the message, and not on the quote
    // above it: inside the double-tap's reach, a tap on the quote had to wait
    // out the double-tap window before it went anywhere.
    final lifted = content;
    content = Builder(
      builder: (inner) => GestureDetector(
        // From where the message is, so it can be lifted out of the page in
        // place rather than described in a sheet that covers it.
        onLongPress: () => _openOptions(context, inner, lifted),
        // A heart on a double tap. Not on a message the server does not
        // have yet: there is nothing for it to attach to.
        onDoubleTap: _canReact ? onToggleHeart : null,
        child: ValueListenableBuilder<String?>(
          valueListenable: _focused,
          // Hidden while it is lifted: the copy above the blur is the
          // message, and the original showing through under it is a ghost.
          builder: (_, focused, child) => Opacity(
            opacity: focused == message.id ? 0 : 1,
            child: child,
          ),
          child: lifted,
        ),
      ),
    );

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
            child: _ChromeLabel(
              child: Text(
                mine
                    ? AppLocalizations.of(context)
                        .ui('ui_dm_you_replied', 'You replied')
                    : AppLocalizations.of(context).dmReplied(
                        sender?.displayName ??
                            answeredAuthor ??
                            AppLocalizations.of(context)
                                .ui('ui_dm_someone', 'Someone'),
                      ),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
          ),
          // The answered message behind, muted; the answer over its lower
          // edge. One exchange, read as one.
          OverlapStack(
            alignEnd: mine,
            // A tap on the quote goes to what it quotes. The quote is a
            // piece of the conversation above; it should lead there.
            back: Semantics(
              button: onOpenAnswered != null,
              label: AppLocalizations.of(context)
                  .ui('ui_dm_quote_open', 'Go to the message'),
              child: GestureDetector(
                key: ValueKey('quote-${message.id}'),
                behavior: HitTestBehavior.opaque,
                onTap: onOpenAnswered,
                child: _QuotedMessage(answered: answered),
              ),
            ),
            front: content,
          ),
        ],
      );
    }

    // Beside the bubble, on the side away from the sender, rather than in
    // it: it is about the message, not part of what was said.
    final marker = !unsealed
        ? null
        : Padding(
            padding: const EdgeInsets.only(
              left: SpacingTokens.space4,
              right: SpacingTokens.space4,
              bottom: SpacingTokens.space12,
            ),
            child: Semantics(
              label: AppLocalizations.of(context)
                  .ui('ui_dm_not_encrypted', 'Not end-to-end encrypted'),
              child: Icon(
                Iconsax.unlock_copy,
                size: 13,
                color: scheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          );

    return Padding(
      padding: EdgeInsets.only(top: topGap),
      child: Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine) ...[
            SizedBox(
              width: 28,
              child: showAvatar ? _Avatar(person: sender, radius: 14) : null,
            ),
            const SizedBox(width: SpacingTokens.space8),
          ],
          if (mine && marker != null) marker,
          Flexible(
            child: SwipeToReply(
              // A message still on its way, or one that never arrived, has no
              // id the server knows -- there is nothing to answer.
              enabled: !message.sending && !message.failed,
              onReply: onReply,
              child: content,
            ),
          ),
          if (!mine && marker != null) marker,
        ],
      ),
    );
  }

  /// What the message holds: its pictures, then its words in a bubble.
  ///
  /// The pictures are their own rounded block, not something inside the
  /// bubble. They used to sit in it with a few points of padding, which drew
  /// a frame of the bubble's colour round every photo -- a thick blue one on
  /// your own -- and a grid that did not fill the bubble left more of it on
  /// one side than the other.
  ///
  /// [overlapping] when it rides over a quoted message. The top of it then
  /// takes a rim in the page colour, so where the two meet reads as one shape
  /// in front of another rather than as two shapes run together.
  Widget _box(
    BuildContext context,
    ColorScheme scheme, {
    required bool overlapping,
  }) {
    final visual = message.media.where((m) => m.isVisual).toList();
    final hasWords = message.unreadable ||
        message.body.trim().isNotEmpty ||
        message.media.any((m) => m.isVoice);

    final pictures = visual.isEmpty
        ? null
        : _pictures(context, scheme, visual, overlapping: overlapping);
    final words = hasWords
        ? _bubble(
            context,
            scheme,
            overlapping: overlapping && pictures == null,
          )
        : null;

    if (pictures != null && words != null) {
      return Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [pictures, const SizedBox(height: 2), words],
      );
    }
    return pictures ?? words ?? const SizedBox.shrink();
  }

  /// A message's pictures: at most three tiles, with the rest counted on the
  /// third, at a fixed share of the screen so one photo and four line up.
  Widget _pictures(
    BuildContext context,
    ColorScheme scheme,
    List<PostMedia> visual, {
    required bool overlapping,
  }) {
    Widget grid = SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.66,
      child: MediaGrid(media: visual, radius: RadiusTokens.radius16),
    );
    if (message.failed) grid = Opacity(opacity: 0.5, child: grid);
    if (!overlapping) return grid;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.radius16 + 2),
      ),
      child: grid,
    );
  }

  /// The bubble: colour, shape, and the words -- or a recording, which is a
  /// player rather than a picture and so stays in it.
  Widget _bubble(
    BuildContext context,
    ColorScheme scheme, {
    required bool overlapping,
  }) {
    final above = joinsAbove ? _tucked : _round;
    final below = joinsBelow ? _tucked : _round;
    final hasText = message.unreadable || message.body.trim().isNotEmpty;
    final ink = message.failed
        ? scheme.onSurface
        : mine
            ? scheme.onPrimary
            : scheme.onSurface;
    final card = hasText && !message.unreadable ? message.linkCard : null;
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      constraints: BoxConstraints(maxWidth: width * 0.75),
      // A card sets the bubble's width -- the share of the screen a message's
      // pictures take -- rather than the words under it, which would squeeze
      // its picture to the width of "look".
      width: card == null ? null : width * 0.66,
      // At this padding one line of body text makes a bubble exactly as tall
      // as its corners are round, which is what draws it as a pill. A voice
      // note alone is held tighter: its play button is already a full
      // target, and the text bubble's padding round that made it half as
      // tall again as a line of text. A card runs to the bubble's edges:
      // inset, it was framed in the bubble's colour, the thick blue frame
      // the pictures were taken out of the bubble to be rid of.
      padding: card != null
          ? EdgeInsets.zero
          : !hasText && message.media.any((m) => m.isVoice)
              ? const EdgeInsets.fromLTRB(4, 4, 14, 4)
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      clipBehavior: card != null ? Clip.antiAlias : Clip.none,
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
        // The page's colour round a reply that rides over its quote, so the
        // two read as stacked. Not on a wallpaper: there the page's colour
        // is not what is behind it, and the ring showed as a white circle.
        border: overlapping && !_WallpaperScope.of(context)
            ? Border.all(color: scheme.surface, width: 2)
            : null,
        // Round all round, except where it meets the message above or below
        // from the same person: there, on the sender's side, the corners
        // tuck in.
        borderRadius: BorderRadius.only(
          topLeft: mine ? _round : above,
          bottomLeft: mine ? _round : below,
          topRight: mine ? above : _round,
          bottomRight: mine ? below : _round,
        ),
      ),
      child: Column(
        // A card spans the bubble, whatever the length of its title.
        crossAxisAlignment: card != null
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Unframed: the bubble is the frame. In the sender's own bubble,
          // which is filled with the accent, it is drawn in the bubble's ink
          // -- in the accent it would be a waveform the colour of its page.
          for (final voice in message.media.where((m) => m.isVoice)) ...[
            VoicePostPlayer(
              media: voice,
              framed: false,
              ink: mine && !message.failed ? scheme.onPrimary : null,
            ),
            if (hasText) const SizedBox(height: SpacingTokens.space8),
          ],
          // The link's card first, the words that carried it under it: the
          // order a reader meets them in every messenger.
          if (card != null)
            LinkCard(
              key: ValueKey('link-card-${message.id}'),
              preview: card.asPreview,
              image: card.image == null ? null : MemoryImage(card.image!),
              ink: ink,
              // A shade of whatever the bubble is, rather than a hairline
              // inside an edge that is already there.
              fill: mine && !message.failed
                  ? Colors.black.withValues(alpha: 0.14)
                  : scheme.onSurface.withValues(alpha: 0.05),
              // The bubble's own corners clip it.
              radius: 0,
              placeholder: false,
            ),
          if (hasText)
            Padding(
              padding: card == null
                  ? EdgeInsets.zero
                  : const EdgeInsets.fromLTRB(14, 8, 14, 10),
              child: Text(
                // Said, not shown as ciphertext, and set apart from anything
                // somebody actually wrote: in italics, a step quieter.
                message.unreadable
                    ? AppLocalizations.of(context).ui(
                        'ui_dm_unreadable',
                        'This message cannot be read on this device.',
                      )
                    : message.body,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  height: 1.3,
                  fontStyle: message.unreadable ? FontStyle.italic : null,
                  color: message.unreadable ? ink.withValues(alpha: 0.7) : ink,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool get _canReact => !message.sending && !message.failed;

  /// Reply, copy, and -- on your own -- delete.
  ///
  /// This used to be long-press-to-delete and nothing else, which meant a long
  /// press on somebody else's message did nothing at all.
  Future<void> _openOptions(
    BuildContext context,
    BuildContext at,
    Widget lifted,
  ) async {
    final copyable = message.body.trim().isNotEmpty && !message.unreadable;
    final box = at.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final rect = box.localToGlobal(Offset.zero) & box.size;

    unawaited(HapticFeedback.mediumImpact());
    final mineReaction = me == null ? null : message.reactionOf(me!);
    _focused.value = message.id;
    final chosen = await MessageFocus.show(
      context,
      rect: rect,
      alignEnd: mine,
      // Drawn again with the page's own text style and wallpaper setting, so
      // the copy is the message exactly. The overlay has no Material of its
      // own: without one the copy's words took the framework's fallback
      // style, set differently enough to overflow the space they had.
      message: Material(
        type: MaterialType.transparency,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          child: _WallpaperScope(
            onWallpaper: _WallpaperScope.of(context),
            child: lifted,
          ),
        ),
      ),
      // The quick reactions above, everything else below: reacting is the
      // thing most often done to a message somebody else sent.
      reactions: !_canReact || onReact == null
          ? null
          : (choose) => _ReactionRow(
                selected: mineReaction,
                onPick: (emoji) => choose('react:$emoji'),
              ),
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
    _focused.value = null;
    if (chosen == null || !context.mounted) return;

    switch (chosen) {
      // The one already chosen, chosen again, takes it back.
      case final String pick when pick.startsWith('react:'):
        final emoji = pick.substring('react:'.length);
        if (emoji == mineReaction) {
          onRemoveReaction?.call();
        } else {
          onReact?.call(emoji);
        }
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

/// Under your newest message: whether it is on its way, arrived, or has been
/// read. Said once, the way a chat says "Seen", rather than under every run.
class _Receipt extends StatelessWidget {
  const _Receipt({required this.message});

  final DirectMessage message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        top: SpacingTokens.space4,
        right: SpacingTokens.space4,
      ),
      child: _ChromeLabel(
        child: Text(
          message.sending
              ? l10n.ui('ui_dm_sending', 'Sending…')
              : message.seen
                  ? l10n.ui('ui_dm_seen', 'Seen')
                  : l10n.ui('ui_dm_sent', 'Sent'),
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w500,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

/// Under a message that did not go, wherever it is, with a way to send it
/// again.
class _NotSent extends StatelessWidget {
  const _NotSent({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
        style: const TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// The box a message is written in.
///
/// Built the way the reply box under a post is: a hairline above, the field
/// itself as tall as one line of text, and Send at the end, dimmed until
/// there is something to send. It used to be a filled field a full control
/// high with a heart beside it, inside a bar of its own -- most of the bottom
/// of the screen for a box that usually holds a few words -- and it picked up
/// the theme's focus outline, a blue ring that belongs to forms.
class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool canSend;
  final VoidCallback onSend;
  final MediaBasket media;
  final Future<void> Function({required bool video}) onAttach;

  /// Every kind of attachment, as a sheet.
  final VoidCallback onAttachments;
  final VoidCallback onGif;

  /// Records a voice note and sends it.
  final VoidCallback onVoice;

  /// The message being answered, while one is.
  final DirectMessage? replyingTo;
  final String? replyingToAuthor;
  final VoidCallback onCancelReply;

  /// The link whose card will go with the message, while there is one.
  final String? link;
  final VoidCallback onDropLink;

  /// The longest message, in what is typed. The server holds the same line;
  /// stopping here is better than a message that is refused once sent.
  static const maxLength = 4000;

  const _Composer({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
    required this.media,
    required this.onAttach,
    required this.onAttachments,
    required this.onGif,
    required this.onVoice,
    required this.onCancelReply,
    required this.onDropLink,
    this.replyingTo,
    this.replyingToAuthor,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final typing = controller.text.trim().isNotEmpty;
    final keyboardUp = MediaQuery.viewInsetsOf(context).bottom > 0;

    // A small, tight button: the field is one line of text tall, and a
    // standard 48-point button beside it would set the height of the bar.
    Widget button({
      required IconData icon,
      required String tooltip,
      required VoidCallback? onPressed,
      double size = 22,
      Color? color,
      Key? key,
    }) =>
        IconButton(
          key: key,
          onPressed: onPressed,
          tooltip: tooltip,
          icon: Icon(icon, size: size),
          color: color,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          // Without this the button reserves a 48-point target around its
          // own box, and two of them side by side sat that far apart: the
          // gap between the picture and the clip buttons.
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          constraints: const BoxConstraints.tightFor(width: 36, height: 40),
        );

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          top: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      // Room on every side, the same as the thread's own margin: at eight
      // points the + and the microphone sat on the screen's edge and the box
      // ran almost the full width between them.
      padding: EdgeInsets.only(
        left: SpacingTokens.space12,
        right: SpacingTokens.space12,
        top: SpacingTokens.space12,
        bottom: keyboardUp ? SpacingTokens.space12 : SpacingTokens.space16,
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
                    tooltip: l10n.literaldoNotReply,
                    icon: const Icon(Iconsax.close_circle_copy, size: 18),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          if (link != null)
            _LinkDraft(
              key: ValueKey('link-draft-$link'),
              url: link!,
              onDrop: onDropLink,
            ),
          if (media.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: MediaTray(
                media: media.items,
                height: 84,
                onRemove: media.remove,
                onRetry: media.retry,
                // No ALT here: a description is for strangers reading a
                // post, and a message has one reader, who was there.
              ),
            ),
          Row(
            // The buttons stay on the last line as the field grows.
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              button(
                icon: Iconsax.add_circle_copy,
                tooltip: l10n.ui('ui_dm_attach', 'Add to message'),
                onPressed: media.hasRoom ? onAttachments : null,
                size: 24,
              ),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 40),
                  padding: EdgeInsets.only(
                    left: SpacingTokens.space16,
                    right:
                        typing ? SpacingTokens.space16 : SpacingTokens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(RadiusTokens.radius20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focus,
                          // Grows with what is being written, up to a point:
                          // a long message should not be typed through a
                          // one-line slot, nor push the thread off screen.
                          minLines: 1,
                          maxLines: 5,
                          maxLength: maxLength,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            height: 1.3,
                          ),
                          decoration: InputDecoration(
                            hintText: l10n.message,
                            counterText: '',
                            isDense: true,
                            // The pill around it is the shape. Every border
                            // is named because the theme's focused border is
                            // an accent outline, and naming only `border`
                            // leaves that one in place.
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            // No floor: the theme's minimum height is what
                            // made an empty box taller than the line in it.
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                      // A photo and a GIF a tap away while the box is empty;
                      // they step aside once something is being written,
                      // which is when the room matters more.
                      if (!typing) ...[
                        button(
                          icon: Iconsax.gallery_copy,
                          tooltip: l10n.literaladdAPhoto,
                          onPressed: media.hasRoom
                              ? () => onAttach(video: false)
                              : null,
                          size: 20,
                        ),
                        button(
                          icon: Iconsax.emoji_happy_copy,
                          tooltip: l10n.literaladdAGif,
                          onPressed: media.hasRoom ? onGif : null,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              // Send while there is something to send; the microphone while
              // there is not. The same place, so a voice note is one tap from
              // an empty box, the way every messenger puts it.
              if (typing || media.isNotEmpty)
                button(
                  icon: Iconsax.send_1,
                  tooltip: l10n.send,
                  onPressed: canSend ? onSend : null,
                  color: scheme.primary,
                )
              else
                button(
                  key: const ValueKey('composer-voice'),
                  icon: Iconsax.microphone_2,
                  tooltip: l10n.ui('ui_dm_voice', 'Record a voice note'),
                  onPressed: onVoice,
                  color: scheme.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The card that will go with the message, above the box while it is
/// written: what the reader will see, and a way to send without it.
///
/// Nothing at all while the page is being read and when it has no card. A
/// placeholder there would jump the box up and back for every link with
/// nothing to show, and a message sent before the card is ready simply goes
/// without one.
class _LinkDraft extends ConsumerWidget {
  final String url;
  final VoidCallback onDrop;

  const _LinkDraft({super.key, required this.url, required this.onDrop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reading = ref.watch(messageLinkCardProvider(url));
    final scheme = Theme.of(context).colorScheme;
    // While the page is read: a quiet line saying a preview is coming, so a
    // link that will carry one does not look like one that will not.
    if (reading.isLoading) {
      return Padding(
        key: const ValueKey('link-draft-loading'),
        padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: scheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            Expanded(
              child: Text(
                Uri.tryParse(url)?.host ?? url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
          ],
        ),
      );
    }
    final card = reading.asData?.value;
    if (card == null) return const SizedBox.shrink();
    final image = card.image;

    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.fromBorderSide(postRule(scheme)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            if (image != null)
              SizedBox(
                width: 56,
                height: 56,
                child: Image.memory(image, fit: BoxFit.cover),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.asPreview.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    if (card.title != null)
                      Text(
                        card.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            IconButton(
              key: const ValueKey('link-draft-drop'),
              onPressed: onDrop,
              tooltip: AppLocalizations.of(context)
                  .ui('ui_dm_link_card_remove', 'Send without the preview'),
              icon: Icon(
                Iconsax.close_circle_copy,
                size: 18,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
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
    final l10n = AppLocalizations.of(context);
    final text = message == null
        ? l10n.ui('ui_dm_quote_message', 'Message')
        : message.unreadable
            ? l10n.ui(
                'ui_dm_unreadable',
                'This message cannot be read on this device.',
              )
            : message.isEmpty
                ? l10n.ui('ui_dm_quote_attachment', 'Attachment')
                : message.body.trim();
    final aside = message == null || message.unreadable;

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
              fontStyle: aside ? FontStyle.italic : null,
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
    final l10n = AppLocalizations.of(context);
    final text = message == null
        ? l10n.ui('ui_dm_quote_message', 'Message')
        : message.unreadable
            ? l10n.ui(
                'ui_dm_unreadable',
                'This message cannot be read on this device.',
              )
            : message.isEmpty || message.body.trim().isEmpty
                ? message.media.any((m) => m.isVoice)
                    ? l10n.ui('ui_dm_quote_voice', 'Voice note')
                    : l10n.ui('ui_dm_quote_attachment', 'Attachment')
                : message.body.trim();
    final aside = message == null || message.unreadable;

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.62,
      ),
      // Room at the bottom for the reply to ride over without covering the
      // words: OverlapStack overlaps by 14.
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space8 + 14,
      ),
      decoration: BoxDecoration(
        // A tint of the text colour on the plain page; something solid on a
        // wallpaper, where a tint lets the picture through the words.
        color: _WallpaperScope.of(context)
            ? scheme.surfaceContainerHighest.withValues(alpha: 0.94)
            : scheme.onSurface.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      ),
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize2,
          height: 1.3,
          color: scheme.onSurface.withValues(alpha: 0.65),
          fontStyle: aside ? FontStyle.italic : null,
        ),
      ),
    );
  }
}

/// Whether the thread is drawn on a wallpaper. Read by the things that sit
/// loose on the page -- the time, "New messages", the receipts -- which are
/// legible on a plain page and not on a picture.
class _WallpaperScope extends InheritedWidget {
  const _WallpaperScope({required this.onWallpaper, required super.child});

  final bool onWallpaper;

  static bool of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_WallpaperScope>()
          ?.onWallpaper ??
      false;

  @override
  bool updateShouldNotify(_WallpaperScope old) =>
      old.onWallpaper != onWallpaper;
}

/// A small label set on a pill of the page's colour when the thread has a
/// wallpaper, and left bare when it does not. Muted text straight on a photo
/// is muted text nobody can read.
class _ChromeLabel extends StatelessWidget {
  const _ChromeLabel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!_WallpaperScope.of(context)) return child;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: child,
    );
  }
}

/// A message being pointed out, after a quote was followed to it.
///
/// It swells a little and settles, with a tint behind it that fades, so the
/// eye lands on it wherever the scroll left it. Drawn around the bubble
/// without taking any room, so nothing on the screen moves but the bubble.
class _Pulse extends StatelessWidget {
  const _Pulse({
    super.key,
    required this.animation,
    required this.alignment,
    required this.child,
  });

  final Animation<double> animation;
  final Alignment alignment;
  final Widget child;

  /// Up quickly, back slowly: a nudge rather than a bounce.
  static final Animatable<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.06)
          .chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.06, end: 1.0)
          .chain(CurveTween(curve: Curves.easeInOutCubic)),
      weight: 70,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final t = animation.value;
        final tint = scheme.primary.withValues(
          alpha: 0.16 * (1 - Curves.easeIn.transform(t)),
        );
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -SpacingTokens.space8,
              right: -SpacingTokens.space8,
              top: -SpacingTokens.space4,
              bottom: -SpacingTokens.space4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(RadiusTokens.radius20),
                ),
              ),
            ),
            Transform.scale(
              scale: _scale.transform(t),
              alignment: alignment,
              child: child,
            ),
          ],
        );
      },
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

/// The reactions most messages get, a tap away above a message's actions.
const List<String> _quickReactions = ['❤️', '😂', '😮', '😢', '😡', '👍'];

class _ReactionRow extends StatelessWidget {
  const _ReactionRow({required this.selected, required this.onPick});

  /// The reader's current reaction, drawn picked so choosing it again reads
  /// as taking it back.
  final String? selected;
  final void Function(String emoji) onPick;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // As wide as the six of them and no wider: a pill over the message, not
    // a toolbar across the screen.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final emoji in _quickReactions)
            InkResponse(
              onTap: () => onPick(emoji),
              radius: 26,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: emoji == selected
                      ? scheme.primary.withValues(alpha: 0.15)
                      : null,
                ),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: TypographyTokens.fontSize6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The message lifted out of the page by a long press, while it is. One at a
/// time, so one notifier for the screen.
final ValueNotifier<String?> _focused = ValueNotifier<String?>(null);

/// The pill on a bubble's corner saying who reacted with what.
///
/// Each emoji once, with a count beside it when both people chose the same
/// one. A tap takes the reader's own reaction back; the other person's is
/// theirs to take back.
class _ReactionPill extends StatelessWidget {
  const _ReactionPill({
    required this.reactions,
    required this.me,
    required this.onRemove,
  });

  final List<MessageReaction> reactions;
  final String? me;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final counts = <String, int>{};
    for (final reaction in reactions) {
      counts[reaction.emoji] = (counts[reaction.emoji] ?? 0) + 1;
    }
    final label = [
      for (final entry in counts.entries)
        entry.value > 1 ? '${entry.key} ${entry.value}' : entry.key,
    ].join(' ');
    final mine = me != null && reactions.any((r) => r.userId == me);

    // Pops in rather than appearing, so a double tap visibly did something.
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.6, end: 1),
      duration: MotionTokens.fast,
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Semantics(
        button: mine,
        label: mine
            ? AppLocalizations.of(context)
                .ui('ui_dm_reaction_remove', 'Remove your reaction')
            : null,
        child: GestureDetector(
          onTap: mine ? onRemove : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                color: scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "Ada is typing": three dots in a bubble, at the foot of the thread.
class _TypingBubble extends StatefulWidget {
  const _TypingBubble({required this.person});

  final MessagePerson? person;

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _wave = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Still dots, not moving ones, for somebody who has asked the phone for
    // less motion.
    if (MediaQuery.of(context).disableAnimations) {
      _wave.stop();
    } else if (!_wave.isAnimating) {
      _wave.repeat();
    }
  }

  @override
  void dispose() {
    _wave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final name = widget.person?.displayName ??
        AppLocalizations.of(context).ui('ui_dm_someone', 'Someone');

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 28,
            child: _Avatar(person: widget.person, radius: 14),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Semantics(
            liveRegion: true,
            label: AppLocalizations.of(context).dmTyping(name),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space12,
                vertical: SpacingTokens.space12,
              ),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(RadiusTokens.radius20),
              ),
              child: AnimatedBuilder(
                animation: _wave,
                builder: (context, _) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < 3; i++) ...[
                      if (i > 0) const SizedBox(width: SpacingTokens.space4),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scheme.onSurface.withValues(
                            alpha: _alphaFor(i),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Each dot brightens in turn, a third of a cycle after the one before.
  double _alphaFor(int dot) {
    final phase = (_wave.value - dot / 3) % 1.0;
    final lift = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
    return 0.25 + 0.45 * lift;
  }
}

/// "New messages", across the thread above the first one the reader had not
/// seen when they opened it.
class _NewMessagesDivider extends StatelessWidget {
  const _NewMessagesDivider();

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(
          alpha: 0.5,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      child: Row(
        children: [
          Expanded(child: Divider(color: muted.withValues(alpha: 0.25))),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space12,
            ),
            child: _ChromeLabel(
              child: Text(
                AppLocalizations.of(context)
                    .ui('ui_dm_new_messages', 'New messages'),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  color: muted,
                ),
              ),
            ),
          ),
          Expanded(child: Divider(color: muted.withValues(alpha: 0.25))),
        ],
      ),
    );
  }
}

/// When a turn started, as a line across the thread: the time today, the
/// weekday and time this week, the date further back.
///
/// In the reader's own language and clock, from the platform's date data.
/// A locale with none falls back to English rather than throwing.
String _stamp(BuildContext context, DateTime at) {
  final now = DateTime.now();
  // Whole days between the two calendar dates. In UTC, so a day that is 23
  // hours long because the clocks went forward still counts as a day.
  final daysAgo = DateTime.utc(now.year, now.month, now.day)
      .difference(DateTime.utc(at.year, at.month, at.day))
      .inDays;

  DateFormat format(String? locale) {
    if (daysAgo == 0) return DateFormat.jm(locale);
    if (daysAgo > 0 && daysAgo < 7) return DateFormat.E(locale).add_jm();
    if (at.year == now.year) return DateFormat.MMMd(locale).add_jm();
    return DateFormat.yMMMd(locale).add_jm();
  }

  try {
    return format(Localizations.maybeLocaleOf(context)?.toLanguageTag())
        .format(at);
  } catch (_) {
    return format('en_US').format(at);
  }
}

/// The time, centred, above the first message after a pause.
class _TimeHeader extends StatelessWidget {
  const _TimeHeader({required this.at});

  final DateTime at;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: SpacingTokens.space20,
          bottom: SpacingTokens.space8,
        ),
        child: Center(
          child: _ChromeLabel(
            child: Text(
              _stamp(context, at),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                fontWeight: FontWeight.w500,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      );
}

/// Above the first sealed message in a conversation, once: from here on,
/// messages are end-to-end encrypted.
///
/// This replaced a lock under every run of messages. It said the same thing
/// a hundred times down a screen; what is worth saying per message is the
/// exception -- one sent as written after this point -- and that is marked
/// where it is.
class _EncryptionNotice extends StatelessWidget {
  const _EncryptionNotice();

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(
          alpha: 0.5,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space24,
        vertical: SpacingTokens.space16,
      ),
      child: Center(
        child: _ChromeLabel(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.lock_copy, size: 13, color: muted),
              const SizedBox(width: SpacingTokens.space4),
              Flexible(
                child: Text(
                  AppLocalizations.of(context).ui(
                    'ui_dm_e2ee_notice',
                    'Messages are end-to-end encrypted',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    color: muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
