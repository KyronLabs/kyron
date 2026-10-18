// lib/widgets/share_into_kyron_sheet.dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/message_link_card.dart';
import '../models/post_media.dart';
import '../models/profile_summary.dart';
import '../providers/feed_provider.dart' show feedRepositoryProvider;
import '../providers/keys_provider.dart';
import '../providers/messages_provider.dart';
import '../providers/people_search_provider.dart';
import '../providers/preferences_provider.dart';
import '../routes.dart';
import '../services/link_card_reader.dart';
import '../services/share_inbox.dart';
import '../screens/thread_screen.dart' show ThreadArgs;
import 'create_post/url_preview.dart' show firstLinkIn;
import 'hairline.dart';
import 'toast.dart';

/// What another app shared, and where in Kyron it can go: a new post, or one
/// or more conversations at once, with a line of one's own beside it.
///
/// Laid out the way the share sheets people already know are: what is being
/// shared at the top, a search, then a grid -- a new post first, then the
/// people most recently talked to -- that ticks as it is tapped, and a
/// message box and Send once anybody is ticked.
class ShareIntoKyronSheet extends ConsumerStatefulWidget {
  final SharedContent content;

  const ShareIntoKyronSheet({super.key, required this.content});

  static Future<void> show(BuildContext context, SharedContent content) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        builder: (_) =>
            SafeArea(top: false, child: ShareIntoKyronSheet(content: content)),
      );

  @override
  ConsumerState<ShareIntoKyronSheet> createState() =>
      _ShareIntoKyronSheetState();
}

/// Somebody a share can go to: a conversation already held, or a person
/// found by searching, whose conversation is opened when it is sent.
class _Target {
  final String key;
  final String name;
  final String? avatarUrl;
  final String? conversationId;
  final String? userId;

  const _Target({
    required this.key,
    required this.name,
    this.avatarUrl,
    this.conversationId,
    this.userId,
  });

  factory _Target.conversation(Conversation c) => _Target(
        key: 'c:${c.id}',
        name: c.title,
        avatarUrl: c.other?.avatarUrl,
        conversationId: c.id,
      );

  factory _Target.person(ProfileSummary p) => _Target(
        key: 'u:${p.id}',
        name: p.name?.trim().isNotEmpty == true
            ? p.name!.trim()
            : '@${p.username ?? ''}',
        avatarUrl: p.avatarUrl,
        userId: p.id,
      );
}

class _ShareIntoKyronSheetState extends ConsumerState<ShareIntoKyronSheet> {
  final _search = TextEditingController();
  final _note = TextEditingController();

  /// Ticked, in the order they were ticked, by key.
  final Map<String, _Target> _chosen = {};
  bool _sending = false;

  String get _query => _search.text.trim();

  String? get _link {
    final text = widget.content.text;
    if (text == null || !ref.read(preferencesProvider).linkPreviews) {
      return null;
    }
    return firstLinkIn(text);
  }

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
    // Started now, so the card for a shared link is usually ready by the time
    // anybody has picked who to send it to.
    final link = _link;
    if (link != null) unawaited(ref.read(messageLinkCardProvider(link).future));
  }

  @override
  void dispose() {
    _search.dispose();
    _note.dispose();
    super.dispose();
  }

  void _toggle(_Target target) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_chosen.remove(target.key) == null) _chosen[target.key] = target;
    });
  }

  /// Hands the share to the post composer instead.
  void _post() {
    final navigator = Navigator.of(context);
    navigator.pop();
    navigator.pushNamed(Routes.composer, arguments: widget.content);
  }

  /// Sends the share to everybody ticked: once each, with the line written
  /// beside it as a message of its own after it.
  Future<void> _send() async {
    if (_sending || _chosen.isEmpty) return;
    setState(() => _sending = true);
    final l10n = AppLocalizations.of(context);
    // Captured now: the sheet is gone by the time there is anything to say.
    final overlay = Toast.anchor(context);
    final navigator = Navigator.of(context);

    final repo = ref.read(messagesRepositoryProvider);
    final sender = MessageSender(repo, ref.read(messageVaultProvider));
    final text = widget.content.text ?? '';
    final note = _note.text.trim();

    var failed = 0;
    final sentTo = <String>[];
    try {
      // Pictures go up once, however many people they are going to.
      final pictures = <PendingMedia>[];
      for (final path in widget.content.files) {
        pictures.add(
          await ref.read(feedRepositoryProvider).uploadMedia(
                PendingMedia(path: path, kind: MediaKind.image),
              ),
        );
      }

      // The card, if it is ready or nearly. A share is not held up for a
      // slow page: it goes without one.
      MessageLinkCard? card;
      final link = _link;
      if (link != null) {
        try {
          card = await ref
              .read(messageLinkCardProvider(link).future)
              .timeout(const Duration(seconds: 3));
        } catch (_) {
          card = null;
        }
      }

      for (final target in _chosen.values) {
        try {
          final id =
              target.conversationId ?? await repo.openWith(target.userId!);
          await sender.send(id, text, media: pictures, linkCard: card);
          if (note.isNotEmpty) await sender.send(id, note);
          sentTo.add(id);
        } catch (_) {
          failed++;
        }
      }
    } catch (_) {
      failed = _chosen.length;
    }

    if (!mounted) return;
    if (failed == _chosen.length) {
      setState(() => _sending = false);
      Toast.show(
        context,
        l10n.ui('ui_share_failed', 'That could not be sent. Try again.'),
      );
      return;
    }
    unawaited(refreshConversations(ref));
    navigator.pop();
    // To one person, the conversation it went into is one tap away. To
    // several, there is no one place to open.
    final only = sentTo.length == 1 && failed == 0 ? sentTo.single : null;
    Toast.showOn(
      overlay,
      failed == 0
          ? l10n.ui('ui_share_sent', 'Sent')
          : l10n.ui('ui_share_some_failed', 'Sent, but not to everybody.'),
      action: only == null
          ? null
          : ToastAction(
              l10n.ui('ui_toast_open', 'Open'),
              () => navigator.pushNamed(
                Routes.thread,
                arguments: ThreadArgs(conversationId: only),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final query = _query.toLowerCase();

    final conversations =
        ref.watch(conversationListProvider(ConversationFilter.all));
    final held = [
      for (final c in conversations.items)
        if (c.other != null &&
            (query.isEmpty ||
                c.title.toLowerCase().contains(query) ||
                (c.other!.username ?? '').toLowerCase().contains(query)))
          _Target.conversation(c),
    ];
    final talkedTo = {
      for (final c in conversations.items)
        if (c.other != null) c.other!.id,
    };
    final found = query.length < 2
        ? const <_Target>[]
        : [
            for (final p
                in ref.watch(peopleSearchProvider(_query)).asData?.value ??
                    const <ProfileSummary>[])
              if (!talkedTo.contains(p.id)) _Target.person(p),
          ];
    final targets = [...held, ...found];
    // Ticked people stay on the grid while a search hides them, so what is
    // about to be sent to is always on screen.
    for (final chosen in _chosen.values) {
      if (!targets.any((t) => t.key == chosen.key)) targets.insert(0, chosen);
    }

    return AnimatedPadding(
      duration: MotionTokens.fast,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space16,
                0,
                SpacingTokens.space16,
                SpacingTokens.space12,
              ),
              child: _Shared(content: widget.content),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space16,
              ),
              child: _SearchBox(
                controller: _search,
                hint: l10n.ui('ui_share_search', 'Search'),
              ),
            ),
            const SizedBox(height: SpacingTokens.space8),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space12,
                  SpacingTokens.space8,
                  SpacingTokens.space12,
                  SpacingTokens.space16,
                ),
                // As tall as a circle and its name, so the rows sit as close
                // as the columns do.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: SpacingTokens.space12,
                  mainAxisExtent: _Tile.radius * 2 + 28,
                ),
                itemCount: targets.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _Tile(
                      key: const ValueKey('share-post'),
                      label: l10n.ui('ui_share_post', 'Post'),
                      onTap: _sending ? null : _post,
                      picture: CircleAvatar(
                        radius: _Tile.radius,
                        backgroundColor: scheme.surfaceContainerHighest,
                        child: Icon(
                          Iconsax.edit_2_copy,
                          size: 24,
                          color: scheme.onSurface,
                        ),
                      ),
                    );
                  }
                  final target = targets[index - 1];
                  return _Tile(
                    key: ValueKey('share-${target.key}'),
                    label: target.name,
                    chosen: _chosen.containsKey(target.key),
                    onTap: _sending ? null : () => _toggle(target),
                    picture: CircleAvatar(
                      radius: _Tile.radius,
                      backgroundColor: scheme.primary.withValues(alpha: .15),
                      foregroundImage: target.avatarUrl == null
                          ? null
                          : NetworkImage(target.avatarUrl!),
                      child: Icon(
                        Iconsax.user_copy,
                        size: 24,
                        color: scheme.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimatedSize(
              duration: MotionTokens.fast,
              curve: Curves.easeOut,
              alignment: Alignment.bottomCenter,
              child: _chosen.isEmpty
                  ? const SizedBox(width: double.infinity)
                  : _SendBar(
                      note: _note,
                      sending: _sending,
                      onSend: _send,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// What is being shared, small, so it is clear what Send will send.
class _Shared extends StatelessWidget {
  final SharedContent content;

  const _Shared({required this.content});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = content.text;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(SpacingTokens.space8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.fromBorderSide(postRule(scheme)),
      ),
      child: Row(
        children: [
          for (final path in content.files.take(3))
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(RadiusTokens.radius8),
                child: Image.file(
                  File(path),
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  cacheWidth: 132,
                  errorBuilder: (_, __, ___) => Container(
                    width: 44,
                    height: 44,
                    color: scheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ),
          if (text != null)
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  height: 1.3,
                  color: scheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            )
          else if (content.files.length > 3)
            Text(
              '+${content.files.length - 3}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _SearchBox({required this.controller, required this.hint});

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
              key: const ValueKey('share-search'),
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

/// One place a share can go: a picture in a circle, a name under it, and a
/// tick on the circle once it is chosen.
class _Tile extends StatelessWidget {
  final String label;
  final Widget picture;
  final bool chosen;
  final VoidCallback? onTap;

  const _Tile({
    super.key,
    required this.label,
    required this.picture,
    required this.onTap,
    this.chosen = false,
  });

  static const double radius = 30;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: chosen,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                picture,
                if (chosen)
                  Positioned(
                    right: -2,
                    bottom: -2,
                    // The filled tick, on a ring of the page's colour so
                    // it reads against any picture.
                    child: Container(
                      key: const ValueKey('share-tick'),
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.tick_circle,
                        size: 22,
                        color: scheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: SpacingTokens.space4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                fontWeight: chosen ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A line to send with it, and Send: there once somebody is chosen.
class _SendBar extends StatelessWidget {
  final TextEditingController note;
  final bool sending;
  final VoidCallback onSend;

  const _SendBar({
    required this.note,
    required this.sending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: postRule(scheme)),
      ),
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space12,
        SpacingTokens.space16,
        SpacingTokens.space16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const ValueKey('share-note'),
            controller: note,
            enabled: !sending,
            minLines: 1,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(fontSize: TypographyTokens.fontSize3),
            decoration: InputDecoration(
              hintText: l10n.ui('ui_share_note', 'Write a message…'),
              isDense: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(height: SpacingTokens.space12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: FilledButton(
              key: const ValueKey('share-send'),
              onPressed: sending ? null : onSend,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusTokens.radius12),
                ),
              ),
              child: sending
                  ? SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: scheme.onPrimary,
                      ),
                    )
                  : Text(
                      l10n.ui('ui_share_send', 'Send'),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
