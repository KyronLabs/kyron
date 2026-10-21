// lib/widgets/community_avatar.dart
import 'package:flutter/material.dart';

import '../models/feed_post.dart';
import 'squircle.dart';

/// A community's picture, or the first letter of its name.
///
/// Always a squircle, everywhere one appears. A community used to be drawn
/// three different ways -- a rounded square on the list, a circle on its own
/// page, nothing at all in the feed -- so the same place looked like a
/// different kind of thing depending on which screen you met it on.
class CommunityAvatar extends StatelessWidget {
  final String? avatarUrl;

  /// Shown when there is no picture. The community's first letter.
  final String initial;

  final double size;

  const CommunityAvatar({
    super.key,
    required this.avatarUrl,
    required this.initial,
    this.size = 40,
  });

  /// From a post's community.
  CommunityAvatar.of(PostCommunity community, {super.key, this.size = 40})
      : avatarUrl = community.avatarUrl,
        initial = community.initial;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final url = avatarUrl?.trim();

    return Squircle(
      size: size,
      child: ColoredBox(
        color: scheme.primary.withValues(alpha: 0.15),
        child: url == null || url.isEmpty
            ? Center(
                child: Text(
                  initial,
                  style: TextStyle(
                    // Proportional, so the letter fills the same amount of a
                    // 24-pixel tile as of a 96-pixel one.
                    fontSize: size * 0.42,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              )
            : Image.network(
                url,
                fit: BoxFit.cover,
                // The tinted ground shows through rather than a broken-image
                // glyph, which tells the reader nothing they can act on.
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
      ),
    );
  }
}
