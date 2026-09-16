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

/// A post's author, stacked on the community it was posted in.
///
/// The community is the larger shape because it is the place; the author sits
/// in front of it, in the round, because a person is not a place. The ring
/// around the author is the page's own colour, so the two read as stacked
/// rather than overlapping.
class StackedPostAvatar extends StatelessWidget {
  final PostCommunity community;
  final Widget author;

  /// The whole stack's footprint, which is what the row lays out against.
  final double size;

  const StackedPostAvatar({
    super.key,
    required this.community,
    required this.author,
    this.size = 40,
  });

  /// How much of the box the community's own tile takes, leaving the rest for
  /// the author to overhang into.
  static const double _communityFraction = 0.78;

  /// The ring between the two.
  static const double _ring = 2;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CommunityAvatar.of(
              community,
              size: size * _communityFraction,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(_ring),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.surface,
              ),
              child: author,
            ),
          ),
        ],
      ),
    );
  }
}
