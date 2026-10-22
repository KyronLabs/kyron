import '../l10n/app_localizations.dart';

// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/community_chat.dart';
import '../models/conversation.dart';
import '../providers/community_chats_provider.dart';
import '../utils/conversation_text.dart';
import '../widgets/community_avatar.dart';
import 'community_chat_screen.dart';
import '../widgets/list_controls.dart';
import '../widgets/online_dot.dart';
import '../widgets/group_avatar.dart';
import '../providers/current_user_provider.dart';
import '../providers/messages_provider.dart';
import '../routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/empty_state.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/toast.dart';
import 'thread_screen.dart';
import '../widgets/skeleton.dart';

/// Everything the reader is talking about with somebody, one row each.
///
/// What this replaces was twenty rows of "User 1 — Hey! How are you doing?",
/// with a green dot on the first five and bold text on the first three. It had
/// a Groups tab too, which nothing could ever have put anything in.
class MessagesScreen extends ConsumerStatefulWidget {
  final GlobalKey<AppDrawerState> drawerKey;
  final Function(double progress) onScrollProgress;

  const MessagesScreen({
    super.key,
    required this.drawerKey,
    required this.onScrollProgress,
  });

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  bool _hidden = false;

  /// Which conversations the list shows. All, Unread and Unanswered from
  /// the filter menu; Groups and Hidden from chips of their own, one at a
  /// time, over whatever the menu says.
  ConversationFilter _filter = ConversationFilter.all;
  ConversationFilter? _chip;

  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  ConversationFilter get _shown => _chip ?? _filter;

  void _toggle(ConversationFilter chip) =>
      setState(() => _chip = _chip == chip ? null : chip);

  bool _onScroll(UserScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    if (notification.direction == ScrollDirection.reverse && !_hidden) {
      _hidden = true;
      widget.onScrollProgress(1);
    } else if (notification.direction == ScrollDirection.forward && _hidden) {
      _hidden = false;
      widget.onScrollProgress(0);
    }
    return false;
  }

  /// The filter menu, under its chip: All, Unread and Unanswered, the one in
  /// force ticked. Two tabs used to do this job, and could only say two
  /// things.
  Future<void> _chooseFilter(BuildContext chip) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showListFilterMenu<ConversationFilter>(
      context: context,
      anchor: chip,
      title: l10n.ui('ui_dm_filter', 'Filter'),
      options: const [
        ConversationFilter.all,
        ConversationFilter.unread,
        ConversationFilter.unanswered,
      ],
      current: _filter,
      label: (filter) => _filterName(l10n, filter),
      keyOf: (filter) => ValueKey('filter-${filter.name}'),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _filter = picked;
      _chip = null;
    });
  }

  static String _filterName(AppLocalizations l10n, ConversationFilter f) =>
      switch (f) {
        ConversationFilter.all => l10n.ui('ui_dm_filter_all', 'All'),
        ConversationFilter.unread => l10n.ui('ui_dm_filter_unread', 'Unread'),
        ConversationFilter.unanswered =>
          l10n.ui('ui_dm_filter_unanswered', 'Unanswered'),
        ConversationFilter.groups => l10n.ui('ui_dm_groups', 'Groups'),
        ConversationFilter.hidden => l10n.ui('ui_dm_hidden', 'Hidden'),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final filtered = _filter != ConversationFilter.all && _chip == null;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: l10n.messages,
            onAvatarTap: () => widget.drawerKey.currentState?.toggleDrawer(),
            actions: [
              SimpleBarAction(
                key: const ValueKey('messages-new'),
                icon: Iconsax.message_add_copy,
                tooltip: l10n.ui('ui_dm_new', 'New message'),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.newMessage),
              ),
              SimpleBarAction(
                key: const ValueKey('messages-settings'),
                icon: Iconsax.setting_2_copy,
                tooltip: l10n.ui('ui_dm_settings_open', 'Message settings'),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.messagingSettings),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space16,
            SpacingTokens.space4,
            SpacingTokens.space16,
            SpacingTokens.space8,
          ),
          child: ListSearchField(
            fieldKey: const ValueKey('messages-search'),
            controller: _search,
            hint: l10n.ui('ui_share_search', 'Search'),
          ),
        ),
        ListChipRow(
          children: [
            Builder(
              builder: (chip) => ListChip(
                key: const ValueKey('messages-filter'),
                selected: filtered,
                onTap: () => _chooseFilter(chip),
                icon: Iconsax.filter_copy,
                label: filtered ? _filterName(l10n, _filter) : null,
                tooltip: l10n.ui('ui_dm_filter', 'Filter'),
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            // Groups, and the community chats joined: every conversation
            // with more than one other person in it, in one place.
            ListChip(
              key: const ValueKey('messages-groups'),
              selected: _chip == ConversationFilter.groups,
              onTap: () => _toggle(ConversationFilter.groups),
              label: l10n.ui('ui_dm_groups', 'Groups'),
            ),
            const SizedBox(width: SpacingTokens.space8),
            ListChip(
              key: const ValueKey('messages-hidden'),
              selected: _chip == ConversationFilter.hidden,
              onTap: () => _toggle(ConversationFilter.hidden),
              label: l10n.ui('ui_dm_hidden', 'Hidden'),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space8),
        Divider(
          height: 0.5,
          thickness: 0.5,
          color: scheme.outline.withValues(alpha: 0.15),
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onScroll,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: _ConversationList(
                key: ValueKey(_shown),
                filter: _shown,
                query: _search.text.trim(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConversationList extends ConsumerStatefulWidget {
  final ConversationFilter filter;
  final String query;

  const _ConversationList({
    super.key,
    required this.filter,
    required this.query,
  });

  @override
  ConsumerState<_ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends ConsumerState<_ConversationList> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final position = _scroll.position;
    if (position.pixels >= position.maxScrollExtent - 400) {
      ref.read(conversationListProvider(widget.filter).notifier).loadMore();
    }
  }

  Future<void> _open(Conversation conversation) async {
    final notifier = ref.read(conversationListProvider(widget.filter).notifier);
    notifier.markRead(conversation.id);
    await Navigator.pushNamed(
      context,
      Routes.thread,
      arguments: ThreadArgs(
        conversationId: conversation.id,
        people: conversation.people,
        group: conversation.group,
      ),
    );
    // Whatever was said while the thread was open belongs in every list.
    if (mounted) await refreshConversations(ref);
  }

  Future<void> _restore(Conversation conversation) async {
    final l10n = AppLocalizations.of(context);
    final error = await ref
        .read(conversationListProvider(widget.filter).notifier)
        .restore(conversation);
    if (!mounted) return;
    Toast.show(
      context,
      error ?? l10n.ui('ui_dm_restored', 'Back in your list.'),
      // Restored from Hidden, it is in the other list now, out of sight: the
      // way to it is here.
      action: error != null
          ? null
          : ToastAction(
              l10n.ui('ui_toast_open', 'Open'),
              () => _open(conversation),
            ),
    );
    await refreshConversations(ref);
  }

  Future<void> _openChat(CommunityChat chat) async {
    await CommunityChatScreen.open(context, chat);
    // Read while it was open, perhaps muted: the row and the badge say so.
    if (!mounted) return;
    ref.invalidate(joinedChatsProvider);
    ref.invalidate(unreadConversationsProvider);
  }

  /// When [entry] -- a conversation or a community chat -- was last spoken
  /// in, for the order they are listed in together.
  static DateTime _when(Object entry) => entry is Conversation
      ? entry.lastMessage?.createdAt ?? entry.lastMessageAt
      : (entry as CommunityChat).activeAt;

  bool _chatMatches(CommunityChat chat) {
    final query = widget.query.toLowerCase();
    if (query.isEmpty) return true;
    return chat.name.toLowerCase().contains(query) ||
        chat.communityName.toLowerCase().contains(query);
  }

  /// Whether [conversation] is one the search box is asking for.
  bool _matches(Conversation conversation) {
    final query = widget.query.toLowerCase();
    if (query.isEmpty) return true;
    return conversation.people.any(
      (p) =>
          p.displayName.toLowerCase().contains(query) ||
          (p.username ?? '').toLowerCase().contains(query),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(conversationListProvider(widget.filter));
    final notifier = ref.read(conversationListProvider(widget.filter).notifier);

    if (state.loadingFirstPage) {
      return SkeletonList.conversations();
    }

    final items = state.items.where(_matches).toList();
    final hidden = widget.filter == ConversationFilter.hidden;

    // The reader's community chats, in among their conversations by when
    // each was last spoken in -- under Groups too, since a community chat
    // is one. Not in Unanswered or Hidden, which mean nothing for a room.
    // Only as far back as the conversations loaded so far reach: further,
    // and a chat would sit above a conversation that belongs before it once
    // the next page arrives.
    final listsChats = widget.filter == ConversationFilter.all ||
        widget.filter == ConversationFilter.unread ||
        widget.filter == ConversationFilter.groups;
    final joined = listsChats
        ? ref.watch(joinedChatsProvider).asData?.value ??
            const <CommunityChat>[]
        : const <CommunityChat>[];
    final reach = state.cursor != null && state.items.isNotEmpty
        ? _when(state.items.last)
        : null;
    final chats = [
      for (final chat in joined)
        if ((widget.filter != ConversationFilter.unread || chat.unread > 0) &&
            _chatMatches(chat) &&
            (reach == null || !chat.activeAt.isBefore(reach)))
          chat,
    ];
    final entries = <Object>[...items, ...chats]
      ..sort((a, b) => _when(b).compareTo(_when(a)));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(joinedChatsProvider);
        await notifier.refresh();
      },
      child: entries.isEmpty
          ? (state.error != null
                  ? EmptyState.failed(
                      title: l10n.literalcouldNotLoadYourMessages,
                      detail: state.error,
                      onAction: notifier.refresh,
                    )
                  : widget.query.isNotEmpty
                      ? EmptyState(
                          art: EmptyArt.noMatch,
                          title: l10n.ui(
                            'ui_dm_search_none',
                            'No conversations match.',
                          ),
                        )
                      : switch (widget.filter) {
                          ConversationFilter.unread => EmptyState(
                              art: EmptyArt.caughtUp,
                              title: l10n.literalnothingUnread,
                              detail: l10n.messagesCaughtUp,
                            ),
                          ConversationFilter.unanswered => EmptyState(
                              art: EmptyArt.caughtUp,
                              title: l10n.ui(
                                'ui_dm_unanswered_none',
                                'Nothing waiting on you',
                              ),
                              detail: l10n.ui(
                                'ui_dm_unanswered_none_detail',
                                'Every conversation ends on your word.',
                              ),
                            ),
                          ConversationFilter.groups => EmptyState(
                              art: EmptyArt.people,
                              title: l10n.ui('ui_dm_groups_none', 'No groups'),
                              detail: l10n.ui(
                                'ui_dm_groups_none_detail',
                                'Groups you are in, and the community chats '
                                    'you join, are listed here.',
                              ),
                            ),
                          ConversationFilter.hidden => EmptyState(
                              art: EmptyArt.messages,
                              title: l10n.ui(
                                'ui_dm_hidden_none',
                                'Nothing hidden',
                              ),
                              detail: l10n.ui(
                                'ui_dm_hidden_none_detail',
                                'Conversations you remove from your list '
                                    'wait here, in case you want them back.',
                              ),
                            ),
                          ConversationFilter.all => EmptyState(
                              art: EmptyArt.messages,
                              title: l10n.literalnoMessagesYet,
                              detail: l10n.messagesNoMessages,
                            ),
                        })
              .scrollable
          : ListView.separated(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: entries.length + (state.loadingMore ? 1 : 0),
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 76,
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.15),
              ),
              itemBuilder: (context, index) {
                if (index >= entries.length) {
                  return const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final entry = entries[index];
                if (entry is CommunityChat) {
                  return _CommunityChatRow(
                    chat: entry,
                    onTap: () => _openChat(entry),
                  );
                }
                final conversation = entry as Conversation;
                return _ConversationRow(
                  conversation: conversation,
                  me: ref.watch(currentUserProvider).asData?.value.id,
                  hidden: hidden,
                  onTap: () => _open(conversation),
                  onRestore: () => _restore(conversation),
                  onHide: () async {
                    final error = await notifier.hide(conversation);
                    if (error != null && context.mounted) {
                      Toast.show(context, error);
                    }
                    if (context.mounted) await refreshConversations(ref);
                  },
                );
              },
            ),
    );
  }
}

class _ConversationRow extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;
  final VoidCallback onHide;
  final VoidCallback onRestore;

  /// In the Hidden list, where a swipe puts it back rather than removes it.
  final bool hidden;

  /// The reader, to tell their own last message from everybody else's.
  final String? me;

  const _ConversationRow({
    required this.conversation,
    required this.onTap,
    required this.onHide,
    required this.onRestore,
    this.hidden = false,
    this.me,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final unread = conversation.unread > 0;
    final other = conversation.other;
    final last = conversation.lastMessage;
    // By the reader's own id where it is known. Before, "not the other
    // person" -- which in a group is everybody.
    final mine = last != null &&
        last.event == null &&
        (me != null ? last.senderId == me : last.senderId != other?.id);
    final muted = scheme.onSurface.withValues(alpha: 0.55);

    // In a group, whose the last message was, before it.
    final speaker = conversation.isGroup && last != null && !mine
        ? conversation.people
            .where((p) => p.id == last.senderId)
            .firstOrNull
            ?.displayName
        : null;
    final line = last == null
        ? l10n.ui('ui_dm_preview_none', 'No messages yet')
        : mine
            ? '${l10n.ui('ui_dm_you_prefix', 'You:')} ${conversationPreview(l10n, last)}'
            : speaker != null && last.event == null
                ? '$speaker: ${conversationPreview(l10n, last)}'
                : conversationPreview(l10n, last);

    return Dismissible(
      key: ValueKey(conversation.id),
      direction:
          hidden ? DismissDirection.startToEnd : DismissDirection.endToStart,
      background: hidden
          ? ColoredBox(
              color: scheme.primary.withValues(alpha: 0.12),
              child: Padding(
                padding: const EdgeInsets.only(left: SpacingTokens.space24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.undo_copy, color: scheme.primary, size: 20),
                      const SizedBox(width: SpacingTokens.space8),
                      Text(
                        l10n.ui('ui_dm_restore', 'Put back'),
                        style: TextStyle(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ColoredBox(
              color: scheme.error.withValues(alpha: 0.12),
              child: Padding(
                padding: const EdgeInsets.only(right: SpacingTokens.space24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Iconsax.trash, color: scheme.error, size: 22),
                ),
              ),
            ),
      // Removed from this list only. The messages are the other side's history
      // too, and deleting them would be deciding that for both people. Put
      // back from Hidden without asking: nothing is lost either way.
      confirmDismiss: (_) async {
        if (hidden) return true;
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(l10n.removeConversation),
                content: Text(
                  l10n.ui(
                    'ui_dm_hide_detail',
                    'It moves to Hidden. The other person keeps theirs, and '
                        'it comes back if either of you writes again.',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(l10n.cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(l10n.remove),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => hidden ? onRestore() : onHide(),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space12,
          ),
          child: Row(
            children: [
              if (conversation.isGroup)
                GroupAvatar(people: conversation.people)
              else
                OnlineDot(
                  person: other,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: scheme.primary.withValues(alpha: 0.15),
                    foregroundImage: other?.avatarUrl == null
                        ? null
                        : NetworkImage(other!.avatarUrl!),
                    child: Icon(
                      Iconsax.user_copy,
                      size: 20,
                      color: scheme.primary,
                    ),
                  ),
                ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            // Empty once the other side deleted their account.
                            conversation.people.isEmpty && !conversation.isGroup
                                ? l10n.ui(
                                    'ui_dm_deleted_account', 'Deleted account')
                                : conversation.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize3,
                              fontWeight:
                                  unread ? FontWeight.w700 : FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: SpacingTokens.space8),
                        Text(
                          conversationTime(
                            l10n,
                            last?.createdAt ?? conversation.lastMessageAt,
                            locale: Localizations.maybeLocaleOf(context)
                                ?.toLanguageTag(),
                          ),
                          key: ValueKey('when-${conversation.id}'),
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            color: unread ? scheme.primary : muted,
                            fontWeight:
                                unread ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            line,
                            key: ValueKey('preview-${conversation.id}'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize2,
                              height: 1.3,
                              color: unread
                                  ? scheme.onSurface
                                  : scheme.onSurface.withValues(alpha: 0.6),
                              fontWeight:
                                  unread ? FontWeight.w600 : FontWeight.normal,
                              fontStyle: last?.unreadable == true
                                  ? FontStyle.italic
                                  : null,
                            ),
                          ),
                        ),
                        if (unread) ...[
                          const SizedBox(width: SpacingTokens.space8),
                          CountBadge(count: conversation.unread),
                        ] else if (mine) ...[
                          // Where the reader's own last message stands, in
                          // the place a count would be: read or not yet.
                          const SizedBox(width: SpacingTokens.space8),
                          _Status(seen: last.seen),
                        ],
                      ],
                    ),
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

/// One of the reader's community chats, as a row among their conversations:
/// the community's picture, the chat's name, and the community and the last
/// thing said under it.
class _CommunityChatRow extends StatelessWidget {
  final CommunityChat chat;
  final VoidCallback onTap;

  const _CommunityChatRow({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final unread = chat.unread > 0;
    final quiet = scheme.onSurface.withValues(alpha: 0.55);
    final last = chat.lastMessage;
    final said = last == null
        ? null
        : last.poll
            ? l10n
                .ui('ui_cchat_poll_preview', r'Poll: $question')
                .replaceAll(r'$question', last.body)
            : last.body.trim().isNotEmpty || last.media == null
                ? last.body
                : mediaPreview(l10n, [last.media!]);
    final line = said == null
        ? l10n.ui('ui_dm_preview_none', 'No messages yet')
        : last!.mine
            ? '${l10n.ui('ui_dm_you_prefix', 'You:')} $said'
            : last.senderName != null
                ? '${last.senderName}: $said'
                : said;

    return InkWell(
      key: ValueKey('inbox-chat-${chat.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            CommunityAvatar(
              avatarUrl: chat.communityAvatarUrl,
              initial: chat.communityName.isEmpty
                  ? '#'
                  : chat.communityName.characters.first.toUpperCase(),
              size: 48,
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // The name and its muted mark take what the time
                      // leaves, so the time sits at the edge like a
                      // conversation's does.
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                chat.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize3,
                                  fontWeight: unread
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                            if (chat.muted) ...[
                              const SizedBox(width: SpacingTokens.space4),
                              Icon(
                                Iconsax.volume_slash_copy,
                                key: ValueKey('inbox-chat-muted-${chat.id}'),
                                size: 14,
                                color: quiet,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: SpacingTokens.space8),
                      Text(
                        conversationTime(
                          l10n,
                          chat.activeAt,
                          locale: Localizations.maybeLocaleOf(context)
                              ?.toLanguageTag(),
                        ),
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          color: unread && !chat.muted ? scheme.primary : quiet,
                          fontWeight:
                              unread ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${chat.communityName} · $line',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            height: 1.3,
                            color: unread
                                ? scheme.onSurface
                                : scheme.onSurface.withValues(alpha: 0.6),
                            fontWeight:
                                unread ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (unread) ...[
                        const SizedBox(width: SpacingTokens.space8),
                        // Muted, the count is there to read, not to call.
                        Opacity(
                          opacity: chat.muted ? 0.45 : 1,
                          child: CountBadge(count: chat.unread),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Seen" or "Sent", for the reader's own last message. Seen in the accent,
/// so it can be told apart at a glance down the list.
class _Status extends StatelessWidget {
  final bool seen;

  const _Status({required this.seen});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          seen ? Iconsax.tick_circle : Iconsax.tick_circle_copy,
          size: 13,
          color:
              seen ? scheme.primary : scheme.onSurface.withValues(alpha: 0.45),
        ),
        const SizedBox(width: 3),
        Text(
          seen ? l10n.ui('ui_dm_seen', 'Seen') : l10n.ui('ui_dm_sent', 'Sent'),
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w500,
            color:
                seen ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
