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
import '../widgets/empty_state.dart';
import '../widgets/post_card.dart' show age;
import '../widgets/toast.dart';

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
    _box.dispose();
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onTyping() {
    final can = _box.text.trim().isNotEmpty;
    if (can != _canSend) setState(() => _canSend = can);
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    // Reversed list: the far end is further back in time, not further down.
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 300) {
      ref.read(threadProvider(widget.args.conversationId).notifier).loadMore();
    }
  }

  Future<void> _send() async {
    final me = ref.read(currentUserProvider).asData?.value.id;
    if (me == null) {
      Toast.show(context, 'You are signed out.');
      return;
    }
    final text = _box.text;
    _box.clear();
    unawaited(HapticFeedback.selectionClick());
    await ref
        .read(threadProvider(widget.args.conversationId).notifier)
        .send(text, senderId: me);
    // Back to the newest, which in a reversed list is offset zero.
    if (_scroll.hasClients) {
      await _scroll.animateTo(
        0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    }
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
      appBar: AppBar(
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (other?.handle != null)
                      Text(
                        other!.handle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _body(state, notifier, me)),
            _Composer(
              controller: _box,
              focus: _focus,
              canSend: _canSend,
              onSend: _send,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(ThreadState state, ThreadNotifier notifier, String? me) {
    if (state.loadingFirstPage) {
      return const Center(child: CircularProgressIndicator());
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

    // Reversed, so the newest is at the bottom and stays there when the
    // keyboard opens -- rather than the list keeping its scroll offset and the
    // last message sliding out of sight.
    final ordered = state.messages.reversed.toList();

    return ListView.builder(
      controller: _scroll,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space12,
        vertical: SpacingTokens.space12,
      ),
      itemCount: ordered.length + (state.loadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= ordered.length) {
          return const Padding(
            padding: EdgeInsets.all(SpacingTokens.space16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final message = ordered[index];
        final mine = me != null && message.senderId == me;
        // The previous one in reading order is the next one in this list.
        final previous = index + 1 < ordered.length ? ordered[index + 1] : null;
        return _Bubble(
          message: message,
          mine: mine,
          // Grouped: consecutive messages from the same person on the same
          // minute do not each need their own timestamp.
          grouped: previous != null &&
              previous.senderId == message.senderId &&
              message.createdAt.difference(previous.createdAt).inMinutes < 2,
          onRetry: () => notifier.retry(message),
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

  const _Bubble({
    required this.message,
    required this.mine,
    required this.grouped,
    required this.onRetry,
    this.onRemove,
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
              onLongPress:
                  onRemove == null ? null : () => _confirmRemove(context),
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
                              : scheme.surfaceContainerHighest
                                  .withValues(alpha: 0.55),
                      borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        // The corner nearest the sender is squared off, which
                        // is what makes a run of bubbles read as one voice.
                        bottomLeft: mine ? radius : const Radius.circular(4),
                        bottomRight: mine ? const Radius.circular(4) : radius,
                      ),
                    ),
                    child: Text(
                      message.body,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.35,
                        color: message.failed
                            ? scheme.onSurface
                            : mine
                                ? scheme.onPrimary
                                : scheme.onSurface,
                      ),
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
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.sending ? 'Sending…' : age(message.createdAt),
            style: TextStyle(fontSize: 11, color: muted),
          ),
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

  const _Composer({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                fillColor:
                    scheme.surfaceContainerHighest.withValues(alpha: 0.45),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                  vertical: SpacingTokens.space12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
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
    );
  }
}
