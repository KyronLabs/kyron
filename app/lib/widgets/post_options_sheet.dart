import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../providers/current_user_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/moderation_provider.dart';
import '../repositories/moderation_repository.dart';
import '../routes.dart';
import '../screens/report_screen.dart';
import '../screens/translation_sheet.dart';
import '../services/app_log.dart';
import 'interaction_settings_sheet.dart';

/// The menu behind a post's overflow button.
///
/// Everything here does something. A menu of options that quietly do nothing
/// is worse than a shorter menu, so an entry only appears once the thing it
/// claims to do is wired up.
class PostOptionsSheet {
  const PostOptionsSheet._();

  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required FeedPost post,
    required PostListSource source,
  }) {
    HapticFeedback.lightImpact();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _Options(post: post, source: source),
    );
  }
}

class _Options extends ConsumerStatefulWidget {
  final FeedPost post;
  final PostListSource source;

  const _Options({required this.post, required this.source});

  @override
  ConsumerState<_Options> createState() => _OptionsState();
}

class _OptionsState extends ConsumerState<_Options> {
  bool _busy = false;

  FeedPost get _post => widget.post;

  ModerationRepository get _moderation =>
      ref.read(moderationRepositoryProvider);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final me = ref.watch(currentUserProvider).asData?.value;
    final mine = me != null && me.id == _post.author.id;
    final author = _post.author.displayName;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Item(
              icon: Iconsax.language_square_copy,
              label: 'Translate post',
              onTap: () => _replace(
                () => TranslationSheet.show(context, _post.content),
              ),
            ),
            _Item(
              icon: Iconsax.copy_copy,
              label: 'Copy post text',
              onTap: () => _run(() async {
                await Clipboard.setData(ClipboardData(text: _post.content));
              }, 'Post text copied'),
            ),
            _Item(
              icon: Iconsax.link_copy,
              label: 'Copy link to post',
              onTap: () => _run(() async {
                await Clipboard.setData(
                  ClipboardData(text: 'https://kyron.so/post/${_post.id}'),
                );
              }, 'Link copied'),
            ),

            _divider(scheme),

            // Feed control. These change what you are shown, and each takes
            // effect on the server rather than only in this session.
            _Item(
              icon: Iconsax.like_1_copy,
              label: 'Show more posts like this',
              onTap: () => _run(
                () => _moderation.setInterest(_post.id, more: true),
                'Noted. This helps shape what you are shown.',
              ),
            ),
            _Item(
              icon: Iconsax.dislike_copy,
              label: 'Not interested in this',
              subtitle: 'Hides it, and tells us to show fewer like it',
              onTap: () => _run(
                () => _moderation.setInterest(_post.id, more: false),
                'Hidden. We will show you fewer like it.',
                removesPost: true,
              ),
            ),
            _Item(
              icon: Iconsax.eye_slash_copy,
              label: 'Hide this post',
              onTap: () => _run(
                () => _moderation.setHidden(_post.id, true),
                'Post hidden',
                removesPost: true,
              ),
            ),
            _Item(
              icon: Iconsax.notification_bing_copy,
              label: 'Mute this thread',
              subtitle: 'Stop seeing this post and replies to it',
              onTap: () => _run(
                () => _moderation.setThreadMuted(_post.id, true),
                'Thread muted',
                removesPost: true,
              ),
            ),
            _Item(
              icon: Iconsax.text_block_copy,
              label: 'Mute words or tags',
              onTap: () => _replace(
                () => Navigator.pushNamed(context, '/settings/muted-words'),
              ),
            ),

            // Your own post. These were missing entirely, so the only menu a
            // post's author saw was the feed-control half -- no way to see how
            // it was doing, and no way to delete it.
            if (mine) ...[
              _divider(scheme),
              _Item(
                icon: Iconsax.chart_2_copy,
                label: 'Post analytics',
                subtitle: 'Viewers, likes, saves and comments',
                onTap: () => _replace(
                  () => Navigator.pushNamed(
                    context,
                    Routes.postAnalytics,
                    arguments: _post.id,
                  ),
                ),
              ),
              _Item(
                icon: Iconsax.global_copy,
                label: 'Who can reply',
                subtitle: _post.replyPolicy.label,
                onTap: _changeReplyPolicy,
              ),
              _Item(
                icon: Iconsax.trash_copy,
                label: 'Delete post',
                destructive: true,
                onTap: _confirmDelete,
              ),
            ],

            if (!mine) ...[
              _divider(scheme),
              _Item(
                icon: Iconsax.volume_slash_copy,
                label: 'Mute $author',
                subtitle:
                    'You will stop seeing their posts. They are not told.',
                onTap: () => _run(
                  () => _moderation.setUserMuted(_post.author.id, true),
                  'You will not see posts from $author',
                  removesPost: true,
                ),
              ),
              _Item(
                icon: Iconsax.profile_delete_copy,
                label: 'Block $author',
                subtitle:
                    'Neither of you will see the other, or be able to follow.',
                destructive: true,
                onTap: _confirmBlock,
              ),
              _Item(
                icon: Iconsax.flag_copy,
                label: 'Report post',
                destructive: true,
                onTap: () => _replace(
                  () => ReportScreen.open(
                    context,
                    target: ReportTarget.post,
                    targetId: _post.id,
                    subject: 'this post',
                  ),
                ),
              ),
              _Item(
                icon: Iconsax.user_remove_copy,
                label: 'Report $author',
                destructive: true,
                onTap: () => _replace(
                  () => ReportScreen.open(
                    context,
                    target: ReportTarget.user,
                    targetId: _post.author.id,
                    subject: author,
                  ),
                ),
              ),
            ],

            const SizedBox(height: SpacingTokens.space16),
          ],
        ),
      ),
    );
  }

  Widget _divider(ColorScheme scheme) => Divider(
        height: SpacingTokens.space16,
        thickness: 0.5,
        color: scheme.outline.withValues(alpha: 0.2),
      );

  /// Closes the sheet, then opens something else. Done in this order so the
  /// sheet is not still animating shut underneath the next screen.
  Future<void> _replace(Future<void> Function() open) async {
    Navigator.pop(context);
    await open();
  }

  /// Runs an action, closes the sheet, and says what happened.
  ///
  /// [removesPost] drops it from the list straight away: an action whose whole
  /// point is "stop showing me this" that leaves it on screen has not visibly
  /// done anything.
  Future<void> _run(
    Future<void> Function() action,
    String done, {
    bool removesPost = false,
  }) async {
    if (_busy) return;
    setState(() => _busy = true);

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await action();
      if (removesPost) {
        ref.read(postListProvider(widget.source).notifier).remove(_post.id);
      }
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } catch (e) {
      AppLog.instance.error('moderation', 'Action failed: $e');
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('That did not go through. Try again.')),
      );
    }
  }

  /// Changing the reply setting after the fact. The composer offers it before
  /// posting; a post that turns out to need it later had no way to get it.
  Future<void> _changeReplyPolicy() async {
    final chosen =
        await InteractionSettingsSheet.show(context, _post.replyPolicy);
    if (chosen == null || !mounted) return;

    await _run(
      () => ref.read(feedRepositoryProvider).setReplyPolicy(_post.id, chosen),
      'Replies: ${chosen.label.toLowerCase()}',
    );
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this post?'),
        content: const Text(
          'It is removed from your profile and from everyone else\'s feed. '
          'Replies to it go with it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    await _run(
      () => ref.read(feedRepositoryProvider).delete(_post.id),
      'Post deleted',
      removesPost: true,
    );
  }

  Future<void> _confirmBlock() async {
    final author = _post.author.displayName;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Block $author?'),
        content: const Text(
          'Neither of you will see the other on Kyron, and any follow between '
          'you is removed. They are not told.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    await _run(
      () => _moderation.setBlocked(_post.author.id, true),
      '$author blocked',
      removesPost: true,
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool destructive;
  final VoidCallback onTap;

  const _Item({
    required this.icon,
    required this.label,
    this.subtitle,
    this.destructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = destructive ? scheme.error : scheme.onSurface;

    return ListTile(
      leading: Icon(icon, size: 20, color: color),
      title: Text(label, style: TextStyle(color: color, fontSize: 15)),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: const TextStyle(fontSize: 12)),
      dense: true,
      onTap: onTap,
    );
  }
}
