import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../providers/feed_provider.dart';
import '../routes.dart';

/// One post, wherever it appears.
///
/// The feed, a profile and the saved and liked lists all render posts, and all
/// four used to draw their own card -- so a like button existed on one of them
/// and did nothing on the rest. This is the only card.
class PostCard extends ConsumerWidget {
  final FeedPost post;

  /// Which list this card belongs to; its like and save taps go there.
  final PostListSource source;

  const PostCard({super.key, required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space8,
      ),
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _openAuthor(context),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: scheme.primary.withValues(alpha: 0.2),
                  foregroundImage: post.author.avatarUrl == null
                      ? null
                      : NetworkImage(post.author.avatarUrl!),
                  child: Icon(Iconsax.user, color: scheme.primary, size: 20),
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      // Only when the account actually has a handle. The old
                      // feed printed "@user" for everyone.
                      if (handle != null)
                        Text(
                          handle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  _age(post.createdAt),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            post.content,
            style: const TextStyle(fontSize: 15, height: 1.4),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Row(
            children: [
              _action(
                context,
                ref,
                icon: post.liked ? Iconsax.heart_circle : Iconsax.heart,
                // Zero shows nothing rather than "0": a post with no likes
                // reads better bare than with a count nobody wants to see.
                label: post.likes > 0 ? '${post.likes}' : null,
                active: post.liked,
                activeColor: scheme.error,
                tooltip: post.liked ? 'Unlike' : 'Like',
                onTap: () => _run(
                  context,
                  ref
                      .read(postListProvider(source).notifier)
                      .toggleLike(post.id),
                ),
              ),
              const SizedBox(width: SpacingTokens.space20),
              _action(
                context,
                ref,
                icon: post.saved ? Iconsax.archive_tick : Iconsax.archive_add,
                active: post.saved,
                activeColor: scheme.primary,
                tooltip: post.saved ? 'Remove from saved' : 'Save',
                onTap: () => _run(
                  context,
                  ref
                      .read(postListProvider(source).notifier)
                      .toggleSave(post.id),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openAuthor(BuildContext context) {
    final username = post.author.username;
    // No handle means no public profile to open; a tap that navigates nowhere
    // is better than one that opens an empty screen.
    if (username == null || username.isEmpty) return;
    Navigator.pushNamed(context, Routes.profile, arguments: username);
  }

  /// Shows whatever the mutation reports, and nothing when it succeeds.
  static Future<void> _run(
    BuildContext context,
    Future<String?> action,
  ) async {
    final message = await action;
    if (message == null || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _action(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    String? label,
    required bool active,
    required Color activeColor,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final color =
        active ? activeColor : scheme.onSurface.withValues(alpha: 0.6);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space4,
            vertical: SpacingTokens.space4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              if (label != null) ...[
                const SizedBox(width: SpacingTokens.space4),
                Text(label, style: TextStyle(fontSize: 13, color: color)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Compact relative age. Deliberately coarse: a feed does not need seconds,
  /// and a rebuild per second to keep them honest is not worth it.
  static String _age(DateTime at) {
    final d = DateTime.now().difference(at);
    if (d.inMinutes < 1) return 'now';
    if (d.inHours < 1) return '${d.inMinutes}m';
    if (d.inDays < 1) return '${d.inHours}h';
    if (d.inDays < 7) return '${d.inDays}d';
    return '${(d.inDays / 7).floor()}w';
  }
}
