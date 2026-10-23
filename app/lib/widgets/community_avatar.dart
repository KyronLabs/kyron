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
///
/// Two targets, because it is two things: the community opens the community
/// and the author opens the author. It used to be one target that opened the
/// author, so the larger shape -- the place -- led to a person, and nothing on
/// a community post in the feed big enough to hit led to the community.
class StackedPostAvatar extends StatelessWidget {
  final PostCommunity community;
  final Widget author;

  /// The whole stack's footprint, which is what the row lays out against.
  final double size;

  final VoidCallback? onCommunityTap;
  final VoidCallback? onAuthorTap;

  const StackedPostAvatar({
    super.key,
    required this.community,
    required this.author,
    this.size = 40,
    this.onCommunityTap,
    this.onAuthorTap,
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
            child: Semantics(
              button: onCommunityTap != null,
              label: community.name,
              child: GestureDetector(
                key: const ValueKey('stacked-avatar-community'),
                behavior: HitTestBehavior.opaque,
                onTap: onCommunityTap,
                child: CommunityAvatar.of(
                  community,
                  size: size * _communityFraction,
                ),
              ),
            ),
          ),
          // Last, so it is on top: where the two overlap, the author is what
          // is drawn there and so what a tap there means.
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              key: const ValueKey('stacked-avatar-author'),
              behavior: HitTestBehavior.opaque,
              onTap: onAuthorTap,
              child: Container(
                padding: const EdgeInsets.all(_ring),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.surface,
                ),
                child: author,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
