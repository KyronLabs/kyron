import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../providers/feed_provider.dart';
import '../routes.dart';
import '../utils/format_count.dart';
import 'media_grid.dart';
import 'post_options_sheet.dart';
import 'post_text.dart';
import 'quoted_post_card.dart';
import 'repost_sheet.dart';

/// One post, wherever it appears.
///
/// The feed, a profile and the saved and liked lists all render posts, and all
/// four used to draw their own card -- so a like button existed on one of them
/// and did nothing on the rest. This is the only card.
///
/// Separated by a hairline rather than boxed: a rounded outline around every
/// post turns a feed into a stack of tiles, and the border was competing with
/// the card's own fill for the same edge.
class PostCard extends ConsumerWidget {
  final FeedPost post;

  /// Which list this card belongs to; its like and save taps go there.
  final PostListSource source;

  const PostCard({super.key, required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        // The whole post opens the post, not its author. Tapping a post to
        // land on somebody's profile is not what anyone means by it.
        onTap: () => Navigator.pushNamed(
          context,
          Routes.postDetail,
          arguments: post.id,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => openAuthor(context, post.author),
                child: PostAvatar(author: post.author),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () => openAuthor(context, post.author),
                            child: Text(
                              post.author.displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        // Only when the account actually has a handle. The old
                        // feed printed "@user" for everyone.
                        if (handle != null) ...[
                          const SizedBox(width: SpacingTokens.space4),
                          Flexible(
                            child: Text(
                              handle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: scheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(width: SpacingTokens.space4),
                        Text(
                          '· ${age(post.createdAt)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                        const Spacer(),
                        // Far right of the header, where an overflow menu is
                        // looked for.
                        _OverflowButton(post: post, source: source),
                      ],
                    ),
                    if (post.content.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: SpacingTokens.space2,
                          bottom: SpacingTokens.space4,
                        ),
                        child: PostText(content: post.content),
                      ),
                    if (post.media.isNotEmpty) ...[
                      const SizedBox(height: SpacingTokens.space8),
                      MediaGrid(media: post.media),
                    ],
                    if (post.quotedPost != null) ...[
                      const SizedBox(height: SpacingTokens.space8),
                      QuotedPostCard(post: post.quotedPost!),
                    ],
                    const SizedBox(height: SpacingTokens.space8),
                    _Actions(post: post, source: source),
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

/// The author's picture beside a post. Small: at radius 20 it was competing
/// with the post itself for the eye.
class PostAvatar extends StatelessWidget {
  final FeedAuthor author;
  final double radius;

  const PostAvatar({super.key, required this.author, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: radius,
      backgroundColor: scheme.primary.withValues(alpha: 0.15),
      foregroundImage:
          author.avatarUrl == null ? null : NetworkImage(author.avatarUrl!),
      child: Icon(Iconsax.user_copy, color: scheme.primary, size: radius),
    );
  }
}

class _Actions extends ConsumerWidget {
  final FeedPost post;
  final PostListSource source;

  const _Actions({required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final notifier = ref.read(postListProvider(source).notifier);

    return Row(
      children: [
        _Action(
          // Outline until you act on it, filled once you have -- so the state
          // reads at a glance instead of only by colour.
          icon: Iconsax.message_text_copy,
          label: post.comments > 0 ? formatCount(post.comments) : null,
          tooltip: 'Comments',
          onTap: () => Navigator.pushNamed(
            context,
            Routes.postDetail,
            arguments: post.id,
          ),
        ),
        const SizedBox(width: SpacingTokens.space20),
        _Action(
          icon:
              post.reposted ? Iconsax.repeat_circle_copy : Iconsax.repeat_copy,
          label: post.reposts > 0 ? formatCount(post.reposts) : null,
          active: post.reposted,
          activeColor: scheme.tertiary,
          tooltip: 'Repost',
          onTap: () => RepostSheet.show(
            context,
            ref,
            post: post,
            source: source,
          ),
        ),
        const SizedBox(width: SpacingTokens.space20),
        _Action(
          icon: post.liked ? Iconsax.heart : Iconsax.heart_copy,
          label: post.likes > 0 ? formatCount(post.likes) : null,
          active: post.liked,
          activeColor: scheme.error,
          tooltip: post.liked ? 'Unlike' : 'Like',
          onTap: () => report(context, notifier.toggleLike(post.id)),
        ),
        const SizedBox(width: SpacingTokens.space20),
        _Action(
          icon: post.saved ? Iconsax.archive_tick : Iconsax.archive_add_copy,
          active: post.saved,
          activeColor: scheme.primary,
          tooltip: post.saved ? 'Remove from saved' : 'Save',
          onTap: () => report(context, notifier.toggleSave(post.id)),
        ),
      ],
    );
  }
}

class _OverflowButton extends ConsumerWidget {
  final FeedPost post;
  final PostListSource source;

  const _OverflowButton({required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () =>
          PostOptionsSheet.show(context, ref, post: post, source: source),
      borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space4),
        child: Icon(
          Iconsax.more_copy,
          size: 16,
          color: scheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool active;
  final Color? activeColor;
  final String tooltip;
  final VoidCallback onTap;

  const _Action({
    required this.icon,
    this.label,
    this.active = false,
    this.activeColor,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active
        ? (activeColor ?? scheme.primary)
        : scheme.onSurface.withValues(alpha: 0.55);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: color),
              if (label != null) ...[
                const SizedBox(width: SpacingTokens.space4),
                Text(label!, style: TextStyle(fontSize: 12, color: color)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens an author's profile, if they have a handle to open one by.
void openAuthor(BuildContext context, FeedAuthor author) {
  final username = author.username;
  // No handle means no public profile; a tap that navigates nowhere is better
  // than one that opens an empty screen.
  if (username == null || username.isEmpty) return;
  Navigator.pushNamed(context, Routes.profile, arguments: username);
}

/// Shows whatever a mutation reports, and nothing when it succeeds.
Future<void> report(BuildContext context, Future<String?> action) async {
  final message = await action;
  if (message == null || !context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

/// Compact relative age. Deliberately coarse: a feed does not need seconds,
/// and a rebuild per second to keep them honest is not worth it.
String age(DateTime at) {
  final d = DateTime.now().difference(at);
  if (d.inMinutes < 1) return 'now';
  if (d.inHours < 1) return '${d.inMinutes}m';
  if (d.inDays < 1) return '${d.inHours}h';
  if (d.inDays < 7) return '${d.inDays}d';
  return '${(d.inDays / 7).floor()}w';
}
