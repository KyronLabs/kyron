// lib/screens/conversation_info_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/chat_wallpaper.dart';
import '../models/conversation.dart';
import '../providers/chat_wallpaper_provider.dart';
import '../providers/messages_provider.dart';
import '../providers/shared_media_provider.dart';
import '../repositories/messages_repository.dart' show SharedMedia;
import '../repositories/moderation_repository.dart' show ReportTarget;
import '../routes.dart';
import '../widgets/chat_wallpaper_view.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/media_viewer.dart';
import '../widgets/toast.dart';
import '../widgets/voice_post_player.dart';
import 'chat_wallpaper_screen.dart';
import 'report_screen.dart';

/// What the conversation's screen does after its info page closes.
enum ConversationInfoResult {
  /// The conversation is gone from the reader's list -- blocked or removed --
  /// so the thread behind this page should close too.
  closed,
}

/// Everything about one conversation that is not a message: who it is with,
/// what has been shared in it, how it looks, and what can be done about it.
///
/// A page rather than the sheet the header's menu used to open. The sheet
/// held four actions; this holds the person, their pictures and voice notes,
/// the wallpaper, and those same actions, which is more than a sheet can
/// carry without becoming a page that cannot scroll properly.
class ConversationInfoScreen extends ConsumerWidget {
  final String conversationId;

  /// Who it is with, for the header before the thread has said.
  final List<MessagePerson> people;

  const ConversationInfoScreen({
    super.key,
    required this.conversationId,
    this.people = const [],
  });

  /// Opens the page and answers with what it did to the conversation, if it
  /// did anything the thread has to follow.
  static Future<ConversationInfoResult?> open(
    BuildContext context, {
    required String conversationId,
    List<MessagePerson> people = const [],
  }) =>
      Navigator.of(context).push<ConversationInfoResult>(
        MaterialPageRoute(
          builder: (_) => ConversationInfoScreen(
            conversationId: conversationId,
            people: people,
          ),
        ),
      );

  /// How many pictures the page shows before "See all".
  static const int previewCount = 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final thread = ref.watch(threadProvider(conversationId));
    final shared = ref.watch(sharedMediaProvider(conversationId));
    final wallpaper = ref.watch(chatWallpaperProvider(conversationId));
    final known = thread.people.isNotEmpty ? thread.people : people;
    final other = known.isEmpty ? null : known.first;

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.ui('ui_status_details', 'Details')),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
        children: [
          _Header(person: other),
          _QuickActions(
            muted: thread.muted,
            onProfile: other == null
                ? null
                : () => openProfile(
                      context,
                      username: other.username,
                      userId: other.id,
                    ),
            onMute: () => _setMuted(context, ref, !thread.muted),
            onWallpaper: () => ChatWallpaperScreen.open(
              context,
              conversationId: conversationId,
            ),
          ),
          _GroupHeader(l10n.ui('ui_dm_info_media', 'Media')),
          _MediaPreview(
            state: shared,
            onSeeAll: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) =>
                    SharedMediaScreen(conversationId: conversationId),
              ),
            ),
          ),
          if (shared.voice.isNotEmpty) ...[
            _GroupHeader(l10n.ui('ui_dm_info_voice_notes', 'Voice notes')),
            for (final note in shared.voice.take(3))
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space20,
                ),
                child: VoicePostPlayer(media: note.media),
              ),
          ],
          _GroupHeader(l10n.ui('ui_dm_info_chat', 'Chat')),
          _Row(
            icon: Iconsax.brush_2_copy,
            label: l10n.ui('ui_dm_info_wallpaper', 'Wallpaper'),
            subtitle: _wallpaperName(context, wallpaper),
            trailing: _Swatch(wallpaper: wallpaper),
            onTap: () => ChatWallpaperScreen.open(
              context,
              conversationId: conversationId,
            ),
          ),
          _Row(
            icon: thread.muted
                ? Iconsax.volume_slash_copy
                : Iconsax.notification_copy,
            label: l10n.ui('ui_dm_info_mute_row', 'Mute notifications'),
            subtitle: l10n.ui(
              'ui_dm_info_mute_detail',
              'Stop being notified about this conversation',
            ),
            trailing: Switch.adaptive(
              value: thread.muted,
              onChanged: (muted) => _setMuted(context, ref, muted),
            ),
            onTap: () => _setMuted(context, ref, !thread.muted),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: SpacingTokens.space8),
            child: Hairline(),
          ),
          if (other != null)
            _Row(
              icon: Iconsax.flag_copy,
              label: '${l10n.report} ${other.handle ?? other.displayName}',
              onTap: () => ReportScreen.open(
                context,
                target: ReportTarget.user,
                targetId: other.id,
                subject: other.handle ?? other.displayName,
              ),
            ),
          if (other != null)
            _Row(
              icon: Iconsax.slash_copy,
              label: '${l10n.block} ${other.handle ?? other.displayName}',
              subtitle: l10n.ui(
                'ui_dm_info_block_detail',
                'They can no longer message you',
              ),
              destructive: true,
              onTap: () => _block(context, ref),
            ),
          _Row(
            icon: Iconsax.trash_copy,
            label: l10n.literalremoveThisConversation,
            destructive: true,
            onTap: () => _remove(context, ref),
          ),
        ],
      ),
    );
  }

  static String _wallpaperName(BuildContext context, ChatWallpaper wallpaper) {
    final l10n = AppLocalizations.of(context);
    if (wallpaper.isNone) return l10n.ui('ui_dm_wallpaper_none', 'None');
    final builtIn = wallpaper.builtIn;
    if (builtIn != null) return builtInWallpaperName(l10n, builtIn);
    return l10n.ui('ui_dm_wallpaper_photo', 'Photo');
  }

  Future<void> _setMuted(
    BuildContext context,
    WidgetRef ref,
    bool muted,
  ) async {
    final l10n = AppLocalizations.of(context);
    final error =
        await ref.read(threadProvider(conversationId).notifier).setMuted(muted);
    if (!context.mounted) return;
    Toast.show(
      context,
      error ??
          (muted
              ? l10n.literalmutedYouWillNotBeNotified
              : l10n.ui('ui_dm_unmuted', 'Unmuted.')),
    );
  }

  Future<void> _block(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final sure = await _confirm(
      context,
      title: l10n.literalblockThisAccount,
      detail: 'They cannot message you, and this conversation leaves your '
          'list. You can undo it from Settings.',
      confirm: l10n.block,
    );
    if (!sure || !context.mounted) return;
    final error =
        await ref.read(threadProvider(conversationId).notifier).blockOther();
    if (!context.mounted) return;
    if (error != null) {
      Toast.show(context, error);
    } else {
      Navigator.pop(context, ConversationInfoResult.closed);
    }
  }

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final sure = await _confirm(
      context,
      title: l10n.removeConversation,
      detail: 'It disappears from your list. The other person keeps theirs, '
          'and it comes back if either of you writes again.',
      confirm: l10n.remove,
    );
    if (!sure || !context.mounted) return;
    try {
      await ref.read(messagesRepositoryProvider).hide(conversationId);
    } catch (_) {
      if (context.mounted) {
        Toast.show(
          context,
          l10n.ui('ui_dm_remove_failed', 'Could not remove it. Try again.'),
        );
      }
      return;
    }
    if (context.mounted) {
      Navigator.pop(context, ConversationInfoResult.closed);
    }
  }

  static Future<bool> _confirm(
    BuildContext context, {
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
}

/// The person, large: who this conversation is with.
class _Header extends StatelessWidget {
  final MessagePerson? person;

  const _Header({required this.person});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final person = this.person;
    final avatar = person?.avatarUrl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space16,
        SpacingTokens.space20,
        SpacingTokens.space8,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: scheme.primary.withValues(alpha: 0.15),
            foregroundImage: avatar == null ? null : NetworkImage(avatar),
            child: Icon(Iconsax.user_copy, size: 36, color: scheme.primary),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            person?.displayName ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize6,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (person?.handle != null)
            Padding(
              padding: const EdgeInsets.only(top: SpacingTokens.space2),
              child: Text(
                person!.handle!,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Profile, mute and wallpaper, as round buttons under the name: the three
/// things done most often from here, one tap each.
class _QuickActions extends StatelessWidget {
  final bool muted;
  final VoidCallback? onProfile;
  final VoidCallback onMute;
  final VoidCallback onWallpaper;

  const _QuickActions({
    required this.muted,
    required this.onProfile,
    required this.onMute,
    required this.onWallpaper,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _QuickAction(
            icon: Iconsax.user_copy,
            label: l10n.ui('ui_dm_info_profile', 'Profile'),
            onTap: onProfile,
          ),
          _QuickAction(
            icon: muted ? Iconsax.volume_high_copy : Iconsax.volume_slash_copy,
            label: muted ? l10n.ui('ui_dm_unmute', 'Unmute') : l10n.mute,
            onTap: onMute,
          ),
          _QuickAction(
            icon: Iconsax.brush_2_copy,
            label: l10n.ui('ui_dm_info_wallpaper', 'Wallpaper'),
            onTap: onWallpaper,
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: SizedBox(
          width: 88,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space8),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 22, color: scheme.onSurface),
                ),
                const SizedBox(height: SpacingTokens.space8),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The first few pictures shared here, with a way to the rest.
class _MediaPreview extends StatelessWidget {
  final SharedMediaState state;
  final VoidCallback onSeeAll;

  const _MediaPreview({required this.state, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final visual = state.visual;

    if (state.loading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(SpacingTokens.space24),
        child: Center(
          child: SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (visual.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space20,
          vertical: SpacingTokens.space8,
        ),
        child: Text(
          state.error ??
              l10n.ui(
                'ui_dm_info_no_media',
                'Photos and clips you share show up here.',
              ),
          style: TextStyle(
            fontSize: TypographyTokens.fontSize2,
            color: scheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
      );
    }

    final shown = visual.take(ConversationInfoScreen.previewCount).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MediaGrid(items: shown, all: visual),
          if (visual.length > shown.length || state.hasMore)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSeeAll,
                child: Text(l10n.ui('ui_dm_info_see_all', 'See all')),
              ),
            ),
        ],
      ),
    );
  }
}

/// Square thumbnails, three across, that open the viewer on everything.
class _MediaGrid extends StatelessWidget {
  final List<SharedMedia> items;

  /// What the viewer pages through: every picture loaded, not only the ones
  /// in this grid.
  final List<SharedMedia> all;

  const _MediaGrid({required this.items, required this.all});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => MediaThumb(
        item: items[index],
        onTap: () => MediaViewer.open(
          context,
          [for (final item in all) item.media],
          initialIndex: all.indexOf(items[index]),
        ),
      ),
    );
  }
}

/// One shared picture or clip, cropped square.
class MediaThumb extends StatelessWidget {
  final SharedMedia item;
  final VoidCallback onTap;

  const MediaThumb({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final media = item.media;
    final still = media.isVideo ? media.thumbnailUrl : media.url;
    // Decoded near the size it is drawn at: a grid of full-size photos is
    // a lot of memory for thumbnails.
    final width = (MediaQuery.sizeOf(context).width /
            3 *
            MediaQuery.devicePixelRatioOf(context))
        .round();

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RadiusTokens.radius4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: scheme.surfaceContainerHighest),
            if (still != null)
              Image(
                image: ResizeImage(NetworkImage(still), width: width),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            if (media.isVideo)
              const Center(
                child: Icon(Iconsax.play, size: 22, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final String title;

  const _GroupHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space20,
        SpacingTokens.space24,
        SpacingTokens.space20,
        SpacingTokens.space8,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// One setting or action: the settings screen's row, so the two pages read
/// as one app.
class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;

  const _Row({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = destructive ? scheme.error : scheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space20,
            vertical: SpacingTokens.space8,
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: ink.withValues(alpha: 0.85)),
              const SizedBox(width: SpacingTokens.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize3,
                        fontWeight: FontWeight.w500,
                        color: ink,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          color: scheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: SpacingTokens.space12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The current wallpaper, small, at the end of its row.
class _Swatch extends StatelessWidget {
  final ChatWallpaper wallpaper;

  const _Swatch({required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(RadiusTokens.radius8),
      child: SizedBox(
        width: 28,
        height: 40,
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusTokens.radius8),
            border: Border.fromBorderSide(
              postRule(Theme.of(context).colorScheme),
            ),
          ),
          child: ChatWallpaperView(wallpaper: wallpaper, decodeWidth: 96),
        ),
      ),
    );
  }
}

/// Everything shared in a conversation: pictures and clips in a grid, and
/// voice notes as players, newest first.
class SharedMediaScreen extends ConsumerWidget {
  final String conversationId;

  const SharedMediaScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(sharedMediaProvider(conversationId));
    final notifier = ref.read(sharedMediaProvider(conversationId).notifier);
    final visual = state.visual;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: KyronAppBar(
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_copy),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(l10n.ui('ui_dm_info_media', 'Media')),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.ui('ui_dm_media_tab', 'Photos and clips')),
              Tab(text: l10n.ui('ui_dm_info_voice_notes', 'Voice notes')),
            ],
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          // The next page as the end comes into view, not at the very end.
          onNotification: (scroll) {
            if (scroll.metrics.extentAfter < 600) notifier.loadMore();
            return false;
          },
          child: TabBarView(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: visual.length,
                itemBuilder: (context, index) => MediaThumb(
                  item: visual[index],
                  onTap: () => MediaViewer.open(
                    context,
                    [for (final item in visual) item.media],
                    initialIndex: index,
                  ),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(SpacingTokens.space16),
                children: [
                  for (final note in state.voice)
                    VoicePostPlayer(media: note.media),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
