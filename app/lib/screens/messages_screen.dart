// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/conversation.dart';
import '../providers/messages_provider.dart';
import '../routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/empty_state.dart';
import '../widgets/post_card.dart' show age;
import '../widgets/section_tabs.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/toast.dart';
import 'thread_screen.dart';

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

class _MessagesScreenState extends ConsumerState<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);
  bool _hidden = false;

  @override
  void initState() {
    super.initState();
    _tabs.addListener(_onTabChanged);
  }

  /// Reloads both lists whenever the tab changes.
  ///
  /// They are separate notifiers that each fetch once, so whichever tab was
  /// opened second held newer data than the first. That is what made a
  /// conversation show under Unread and not under All.
  void _onTabChanged() {
    if (_tabs.indexIsChanging) return;
    refreshConversations(ref);
  }

  @override
  void dispose() {
    _tabs.removeListener(_onTabChanged);
    _tabs.dispose();
    super.dispose();
  }

  bool _onScroll(UserScrollNotification notification) {
    // By axis, not depth: the tab strip is a scroll view too, and its sideways
    // swipe is not what hides a bottom bar.
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SimpleAppBar(
            title: 'Messages',
            onAvatarTap: () => widget.drawerKey.currentState?.toggleDrawer(),
          ),
        ),
        SectionTabs(
          controller: _tabs,
          // No Groups tab. There are no group conversations, so it was a tab
          // nothing could ever have put anything in.
          labels: const ['All', 'Unread'],
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: _onScroll,
            child: TabBarView(
              controller: _tabs,
              children: const [
                _ConversationList(unreadOnly: false),
                _ConversationList(unreadOnly: true),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ConversationList extends ConsumerStatefulWidget {
  final bool unreadOnly;

  const _ConversationList({required this.unreadOnly});

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
      ref.read(conversationListProvider(widget.unreadOnly).notifier).loadMore();
    }
  }

  Future<void> _open(Conversation conversation) async {
    final notifier =
        ref.read(conversationListProvider(widget.unreadOnly).notifier);
    notifier.markRead(conversation.id);
    await Navigator.pushNamed(
      context,
      Routes.thread,
      arguments: ThreadArgs(
        conversationId: conversation.id,
        people: conversation.people,
      ),
    );
    // Whatever was said while the thread was open belongs in both lists:
    // reading it empties Unread, and it moves to the top of All.
    if (mounted) await refreshConversations(ref);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationListProvider(widget.unreadOnly));
    final notifier =
        ref.read(conversationListProvider(widget.unreadOnly).notifier);

    if (state.loadingFirstPage) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: notifier.refresh,
      child: state.items.isEmpty
          ? (state.error != null
                  ? EmptyState.failed(
                      title: 'Could not load your messages',
                      detail: state.error,
                      onAction: notifier.refresh,
                    )
                  : widget.unreadOnly
                      ? const EmptyState(
                          art: EmptyArt.caughtUp,
                          title: 'Nothing unread',
                          detail: 'Every conversation is caught up.',
                        )
                      : const EmptyState(
                          art: EmptyArt.messages,
                          title: 'No messages yet',
                          detail: 'Open somebody\'s profile and tap Message to '
                              'start a conversation.',
                        ))
              .scrollable
          : ListView.separated(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.items.length + (state.loadingMore ? 1 : 0),
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
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(SpacingTokens.space16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final conversation = state.items[index];
                return _ConversationRow(
                  conversation: conversation,
                  onTap: () => _open(conversation),
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

  const _ConversationRow({
    required this.conversation,
    required this.onTap,
    required this.onHide,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final unread = conversation.unread > 0;
    final other = conversation.other;
    final last = conversation.lastMessage;

    return Dismissible(
      key: ValueKey(conversation.id),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
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
      // too, and deleting them would be deciding that for both people.
      confirmDismiss: (_) async =>
          await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Remove this conversation?'),
              content: const Text(
                'It disappears from your list. The other person keeps theirs, '
                'and it comes back if either of you writes again.',
              ),
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
          ) ??
          false,
      onDismissed: (_) => onHide(),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: 15,
                              fontWeight:
                                  unread ? FontWeight.w700 : FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: SpacingTokens.space8),
                        Text(
                          age(conversation.lastMessageAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: unread
                                ? scheme.primary
                                : scheme.onSurface.withValues(alpha: 0.5),
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
                            last == null
                                ? 'No messages yet'
                                : '${last.senderId == other?.id ? '' : 'You: '}'
                                    '${last.body}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
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
                          Container(
                            constraints: const BoxConstraints(minWidth: 20),
                            height: 20,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(
                                RadiusTokens.radiusFull,
                              ),
                            ),
                            child: Text(
                              conversation.unread > 99
                                  ? '99+'
                                  : '${conversation.unread}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: scheme.onPrimary,
                              ),
                            ),
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
      ),
    );
  }
}
