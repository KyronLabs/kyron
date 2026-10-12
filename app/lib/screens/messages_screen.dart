import '../l10n/app_localizations.dart';

// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/conversation.dart';
import '../utils/conversation_text.dart';
import '../widgets/hairline.dart';
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
  /// the filter menu; Hidden from its own chip.
  ConversationFilter _filter = ConversationFilter.all;
  bool _showingHidden = false;

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

  ConversationFilter get _shown =>
      _showingHidden ? ConversationFilter.hidden : _filter;

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
    final box = chip.findRenderObject() as RenderBox?;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (box == null || overlay == null) return;
    final topLeft = box.localToGlobal(
      Offset(0, box.size.height + SpacingTokens.space4),
      ancestor: overlay,
    );
    final scheme = Theme.of(context).colorScheme;

    final picked = await showMenu<ConversationFilter>(
      context: context,
      position: RelativeRect.fromLTRB(
        topLeft.dx,
        topLeft.dy,
        overlay.size.width - topLeft.dx,
        0,
      ),
      color: scheme.surfaceContainerLow,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusTokens.radius16),
      ),
      constraints: const BoxConstraints(minWidth: 220),
      items: [
        PopupMenuItem<ConversationFilter>(
          enabled: false,
          height: 32,
          child: Text(
            l10n.ui('ui_dm_filter', 'Filter'),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ),
        for (final filter in const [
          ConversationFilter.all,
          ConversationFilter.unread,
          ConversationFilter.unanswered,
        ])
          PopupMenuItem<ConversationFilter>(
            key: ValueKey('filter-${filter.name}'),
            value: filter,
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: filter == _filter
                      ? Icon(Iconsax.tick_circle_copy,
                          size: 18, color: scheme.onSurface)
                      : null,
                ),
                Text(
                  _filterName(l10n, filter),
                  style: const TextStyle(fontSize: TypographyTokens.fontSize3),
                ),
              ],
            ),
          ),
      ],
    );
    if (picked == null || !mounted) return;
    setState(() {
      _filter = picked;
      _showingHidden = false;
    });
  }

  static String _filterName(AppLocalizations l10n, ConversationFilter f) =>
      switch (f) {
        ConversationFilter.all => l10n.ui('ui_dm_filter_all', 'All'),
        ConversationFilter.unread => l10n.ui('ui_dm_filter_unread', 'Unread'),
        ConversationFilter.unanswered =>
          l10n.ui('ui_dm_filter_unanswered', 'Unanswered'),
        ConversationFilter.hidden => l10n.ui('ui_dm_hidden', 'Hidden'),
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final filtered = _filter != ConversationFilter.all && !_showingHidden;

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
          child: _SearchField(
            controller: _search,
            hint: l10n.ui('ui_share_search', 'Search'),
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            children: [
              Builder(
                builder: (chip) => _Chip(
                  key: const ValueKey('messages-filter'),
                  selected: filtered,
                  onTap: () => _chooseFilter(chip),
                  icon: Iconsax.filter_copy,
                  label: filtered ? _filterName(l10n, _filter) : null,
                  tooltip: l10n.ui('ui_dm_filter', 'Filter'),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              _Chip(
                key: const ValueKey('messages-hidden'),
                selected: _showingHidden,
                onTap: () => setState(() => _showingHidden = !_showingHidden),
                label: l10n.ui('ui_dm_hidden', 'Hidden'),
              ),
            ],
          ),
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

/// The search box over the list. It narrows the conversations already
/// loaded, by name or handle; finding somebody new is New message's job.
class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _SearchField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal_1_copy,
            size: 18,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: TextField(
              key: const ValueKey('messages-search'),
              controller: controller,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: TypographyTokens.fontSize3),
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A rounded chip, outlined with the hairline, filled when it is in force.
class _Chip extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final String? label;
  final String? tooltip;

  const _Chip({
    super.key,
    required this.selected,
    required this.onTap,
    this.icon,
    this.label,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = scheme.onSurface;
    Widget chip = Material(
      color: selected ? scheme.surfaceContainerHighest : Colors.transparent,
      shape: StadiumBorder(side: postRule(scheme)),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: label == null ? SpacingTokens.space16 : 14,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, size: 18, color: ink),
              if (icon != null && label != null)
                const SizedBox(width: SpacingTokens.space4),
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: ink,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    if (tooltip != null) chip = Tooltip(message: tooltip!, child: chip);
    return Semantics(selected: selected, button: true, child: chip);
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
    );
    await refreshConversations(ref);
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

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: items.isEmpty
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
              itemCount: items.length + (state.loadingMore ? 1 : 0),
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
                if (index >= items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final conversation = items[index];
                return _ConversationRow(
                  conversation: conversation,
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

  const _ConversationRow({
    required this.conversation,
    required this.onTap,
    required this.onHide,
    required this.onRestore,
    this.hidden = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final unread = conversation.unread > 0;
    final other = conversation.other;
    final last = conversation.lastMessage;
    final mine = last != null && last.senderId != other?.id;
    final muted = scheme.onSurface.withValues(alpha: 0.55);

    final line = last == null
        ? l10n.ui('ui_dm_preview_none', 'No messages yet')
        : mine
            ? '${l10n.ui('ui_dm_you_prefix', 'You:')} ${conversationPreview(l10n, last)}'
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
              CircleAvatar(
                radius: 24,
                backgroundColor: scheme.primary.withValues(alpha: 0.15),
                foregroundImage: other?.avatarUrl == null
                    ? null
                    : NetworkImage(other!.avatarUrl!),
                child: Icon(Iconsax.user_copy, size: 20, color: scheme.primary),
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
                            conversation.title,
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
                          _UnreadBadge(count: conversation.unread),
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

class _UnreadBadge extends StatelessWidget {
  final int count;

  const _UnreadBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w700,
          color: scheme.onPrimary,
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
