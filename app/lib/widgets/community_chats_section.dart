// lib/widgets/community_chats_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart';
import '../models/community_chat.dart';
import '../providers/community_chats_provider.dart';
import '../screens/community_chat_screen.dart';
import '../screens/community_chat_settings_screen.dart';
import '../utils/api_error_message.dart';
import 'list_controls.dart' show CountBadge;

/// A community's chats, on its page, above its posts.
///
/// Only asked for when the reader is in the community: the server refuses
/// anybody else, and a section that loads only to say "no" is worse than one
/// that says why up front.
class CommunityChatsSection extends ConsumerWidget {
  final Community community;

  const CommunityChatsSection({super.key, required this.community});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final moderator = community.role?.canModerate ?? false;

    final heading = Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space12,
        SpacingTokens.space8,
        SpacingTokens.space4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.ui('ui_cchat_heading', 'Chats'),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          if (moderator)
            TextButton.icon(
              key: const ValueKey('cchat-new'),
              onPressed: () async {
                final made = await CommunityChatSettingsScreen.create(
                  context,
                  community.slug,
                );
                if (made != null && context.mounted) {
                  await CommunityChatScreen.open(context, made);
                }
              },
              icon: const Icon(Iconsax.add_copy, size: 16),
              label: Text(l10n.ui('ui_cchat_new', 'New chat')),
            ),
        ],
      ),
    );

    if (!community.joined) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading,
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space16,
              0,
              SpacingTokens.space16,
              SpacingTokens.space12,
            ),
            child: Text(
              l10n.ui(
                'ui_cchat_join_community',
                "Join the community to see and take part in its chats.",
              ),
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
            ),
          ),
        ],
      );
    }

    final chats = ref.watch(communityChatsProvider(community.slug));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heading,
        ...chats.when(
          loading: () => [
            const Padding(
              padding: EdgeInsets.all(SpacingTokens.space12),
              child: Center(
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ],
          error: (error, _) => [
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Text(describeApiError(error, sessionIsLive: true)),
            ),
          ],
          data: (items) => items.isEmpty
              ? [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SpacingTokens.space16,
                      0,
                      SpacingTokens.space16,
                      SpacingTokens.space12,
                    ),
                    child: Text(
                      moderator
                          ? l10n.ui(
                              'ui_cchat_none_mod',
                              'No chats yet. Open one for the community.',
                            )
                          : l10n.ui('ui_cchat_none', 'No chats yet.'),
                      style: TextStyle(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ]
              : [
                  for (final chat in items)
                    _ChatRow(
                      chat: chat,
                      onTap: () async {
                        await CommunityChatScreen.open(context, chat);
                        // Unread counts and joins changed while it was open.
                        ref.invalidate(communityChatsProvider(community.slug));
                      },
                    ),
                ],
        ),
      ],
    );
  }
}

class _ChatRow extends StatelessWidget {
  final CommunityChat chat;
  final VoidCallback onTap;

  const _ChatRow({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final joined = l10n
        .ui('ui_cchat_joined', r'$count joined')
        .replaceAll(r'$count', '${chat.joinedCount}');
    return ListTile(
      key: ValueKey('cchat-row-${chat.id}'),
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: scheme.primary.withValues(alpha: 0.12),
        child: Icon(
          chat.announcements
              ? Iconsax.volume_high_copy
              : Iconsax.messages_2_copy,
          size: 20,
          color: scheme.primary,
        ),
      ),
      title: Text(
        chat.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: chat.unread > 0 ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.description == null ? joined : '$joined · ${chat.description}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      // In a Row of its own: the badge is a Container that fills whatever
      // width it is given, and a tile's trailing slot gives it the tile's.
      trailing: chat.unread > 0
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [CountBadge(count: chat.unread)],
            )
          : null,
    );
  }
}
