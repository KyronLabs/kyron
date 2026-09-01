import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../routes.dart';
import 'media_grid.dart';
import 'post_card.dart';
import 'post_text.dart';

/// The post a quote is quoting, drawn inside the quoting post.
///
/// Outlined rather than filled, and one level deep: a quote of a quote shows
/// only its own subject, so a long chain cannot build an unbounded stack of
/// nested cards on a phone screen.
class QuotedPostCard extends StatelessWidget {
  final QuotedPost post;

  const QuotedPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postDetail,
        arguments: post.id,
      ),
      borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(SpacingTokens.space12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PostAvatar(author: post.author, radius: 10),
                const SizedBox(width: SpacingTokens.space8),
                Flexible(
                  child: Text(
                    post.author.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (handle != null) ...[
                  const SizedBox(width: SpacingTokens.space4),
                  Flexible(
                    child: Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: SpacingTokens.space4),
                Text(
                  '· ${age(post.createdAt)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
            if (post.content.trim().isNotEmpty) ...[
              const SizedBox(height: SpacingTokens.space4),
              PostText(
                content: post.content,
                style: const TextStyle(fontSize: 14, height: 1.3),
                maxLines: 6,
              ),
            ],
            if (post.media.isNotEmpty) ...[
              const SizedBox(height: SpacingTokens.space8),
              MediaGrid(media: post.media, radius: RadiusTokens.radiusSm),
            ],
          ],
        ),
      ),
    );
  }
}
