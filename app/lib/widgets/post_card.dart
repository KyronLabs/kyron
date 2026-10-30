import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/country.dart';
import '../models/feed_post.dart';
import '../providers/current_user_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/follow_provider.dart';
import '../routes.dart';
import 'community_avatar.dart';
import 'country_sheet.dart';
import 'gift_sheet.dart';
import 'link_preview_card.dart';
import 'media_grid.dart';
import 'poll_card.dart';
import 'post_actions_row.dart';
import 'voice_post_player.dart';
import 'post_options_sheet.dart';
import 'post_text.dart';
import 'quoted_post_card.dart';
import 'repost_sheet.dart';
import 'share_post_sheet.dart';
import 'toast.dart';
import 'hairline.dart';
import 'verified_badge.dart';

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
  /// The most of the name line an author's name may take before it is cut.
  /// Enough for nearly any name; what is left is for the handle or the
  /// community and the time.
  static const double _nameShare = 0.62;

  final FeedPost post;

  /// Which list this card belongs to; its like and save taps go there.
  final PostListSource source;

  /// A hashtag to pick out in the body, without its leading #. Set by the
  /// screen showing one tag's posts.
  final String? highlightTag;

  const PostCard({
    super.key,
    required this.post,
    required this.source,
    this.highlightTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final handle = post.author.handle;
    // Which community, unless this is that community's own page, where
    // saying so on every post is the same words fifty times -- and where the
    // post is drawn as any other post is.
    final community =
        post.community != null && !source.isCommunity(post.community!.slug)
            ? post.community
            : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: postRule(scheme)),
      ),
      child: InkWell(
        // The whole post opens the post, not its author. Tapping a post to
        // land on somebody's profile is not what anyone means by it.
        onTap: () =>
            Navigator.pushNamed(context, Routes.postDetail, arguments: post.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // From a community, everywhere but the community's own page:
              // the author in front of the community's picture, so a post
              // from a place reads as from that place at a glance. Two
              // targets, as it is two things.
              //
              // The follow button rides on the plain picture only. On a
              // community post there are two faces, and a "+" on either
              // reads as joining the community.
              community == null
                  // Keyed by the post: its state is "followed from here",
                  // which must not carry over to the next post a recycled
                  // row is given.
                  ? _AvatarWithFollow(key: ValueKey(post.id), post: post)
                  : StackedPostAvatar(
                      community: community,
                      author: PostAvatar(author: post.author, radius: 11),
                      onCommunityTap: () => openCommunity(context, community),
                      onAuthorTap: () => openAuthor(context, post.author),
                    ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Which community, when it came from one. A post from a
                    // place you joined arriving in the home feed with nothing
                    // to say so reads as somebody posting to everybody.
                    if (community != null)
                      PostCommunityLine(community: community),
                    // The name takes what it needs, up to most of the line;
                    // the handle or the community has the rest. Three flex
                    // children here -- name, handle, and a Spacer -- each got
                    // a third of the free width, so "Yunnieee" was cut to
                    // "Yunni…" with half the line empty after it.
                    LayoutBuilder(
                      builder: (context, line) => Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: line.maxWidth * _nameShare,
                            ),
                            child: GestureDetector(
                              onTap: () => openAuthor(context, post.author),
                              child: NameWithBadge(
                                name: post.author.displayName,
                                verified: post.author.verified,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: TypographyTokens.fontSize3,
                                ),
                              ),
                            ),
                          ),
                          // Only when the account actually has a handle. The
                          // old feed printed "@user" for everyone.
                          if (handle != null) ...[
                            const SizedBox(width: SpacingTokens.space4),
                            Flexible(
                              child: Text(
                                handle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize2,
                                  color:
                                      scheme.onSurface.withValues(alpha: 0.55),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(width: SpacingTokens.space4),
                          Text(
                            '· ${age(post.createdAt)}',
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize2,
                              color: scheme.onSurface.withValues(alpha: 0.45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (post.content.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: SpacingTokens.space2,
                          bottom: SpacingTokens.space4,
                        ),
                        child: PostText(
                          content: post.content,
                          highlightTag: highlightTag,
                        ),
                      ),
                    // Voice is a player, not a picture, so it does not go
                    // through the grid -- a grid tile has no room for a
                    // waveform and no way to play anything.
                    for (final voice in post.media.where((m) => m.isVoice))
                      VoicePostPlayer(media: voice),
                    if (post.media.any((m) => m.isVisual)) ...[
                      const SizedBox(height: SpacingTokens.space8),
                      MediaGrid(
                        media: post.media.where((m) => m.isVisual).toList(),
                      ),
                    ],
                    if (post.poll != null)
                      PollCard(
                        postId: post.id,
                        poll: post.poll!,
                        onVoted: (updated) => ref
                            .read(postListProvider(source).notifier)
                            .replace(updated),
                      ),
                    // Only when there is nothing else competing for the
                    // space: a post with its own pictures does not also need a
                    // thumbnail of the page it links to.
                    if (post.media.isEmpty &&
                        post.quotedPost == null &&
                        post.firstLink != null)
                      LinkPreviewCard(url: post.firstLink!),
                    if (post.quotedPost != null) ...[
                      const SizedBox(height: SpacingTokens.space8),
                      QuotedPostCard(post: post.quotedPost!),
                    ],
                    // Where the author is, from the list on their profile:
                    // under the post, so it is there for whoever wants it
                    // and out of the way of the name and the words.
                    if (Countries.isCode(post.author.country))
                      Padding(
                        padding: const EdgeInsets.only(
                          top: SpacingTokens.space8,
                        ),
                        child: CountryLabel(
                          post.author.country!,
                          key: ValueKey('post-country-${post.id}'),
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            color: scheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    const SizedBox(height: SpacingTokens.space8),
                    _Actions(post: post, source: source),
                  ],
                ),
              ),
              // A sibling of the avatar, not a child of the header row. Inside
              // it the button sat after the timestamp behind a Spacer, so a
              // long display name squeezed the Spacer to nothing and the menu
              // drifted inwards -- its position depended on the author's name.
              _OverflowButton(post: post, source: source),
            ],
          ),
        ),
      ),
    );
  }
}

/// Which community a post came from, above the author's name.
///
/// Tappable, and it opens the community rather than the post -- a name that
/// looks like a link and is not one is worse than plain text. The target is
/// the whole line, not just the letters: at this size the words alone are a
/// sliver a thumb misses, and the miss lands on the post behind it.
class PostCommunityLine extends StatelessWidget {
  final PostCommunity community;

  const PostCommunityLine({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ink = scheme.primary.withValues(alpha: 0.9);

    return Semantics(
      button: true,
      label: community.name,
      excludeSemantics: true,
      child: GestureDetector(
        key: ValueKey('post-community-${community.slug}'),
        behavior: HitTestBehavior.opaque,
        onTap: () => openCommunity(context, community),
        child: Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space2),
          child: Row(
            children: [
              Icon(Iconsax.people_copy, size: 12, color: ink),
              const SizedBox(width: SpacingTokens.space4),
              Flexible(
                child: Text(
                  community.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    fontWeight: FontWeight.w600,
                    color: ink,
                  ),
                ),
              ),
              // Says it goes somewhere, which a coloured name alone does not.
              Icon(Iconsax.arrow_right_3_copy, size: 12, color: ink),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens the community a post was posted in.
void openCommunity(BuildContext context, PostCommunity community) {
  Navigator.pushNamed(context, Routes.community, arguments: community.slug);
}

/// The author's picture beside a post. Small: at radius 20 it was competing
/// with the post itself for the eye.
class PostAvatar extends StatelessWidget {
  final FeedAuthor author;
  final double radius;

  /// The size beside a post, which the follow button is placed against.
  static const double defaultRadius = 16;

  const PostAvatar({
    super.key,
    required this.author,
    this.radius = defaultRadius,
  });

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

/// The author's picture, with a follow button on it while you do not follow
/// them.
///
/// The picture opens their profile; the button follows them without leaving
/// the feed. Once followed it turns to a tick for a moment and then goes:
/// a button that stayed would be offering to do what is already done, and
/// unfollowing belongs on the profile, where it is deliberate.
class _AvatarWithFollow extends ConsumerStatefulWidget {
  const _AvatarWithFollow({super.key, required this.post});

  final FeedPost post;

  /// The button: a disc this wide, ring included, centred on the picture's
  /// edge at its lower right -- on the circle, not on the corner of the box
  /// around it, which leaves it floating off the face.
  static const double badge = 16;
  static const double ring = 1.5;

  /// Reach around the disc, for a thumb.
  static const double reach = 6;

  @override
  ConsumerState<_AvatarWithFollow> createState() => _AvatarWithFollowState();
}

class _AvatarWithFollowState extends ConsumerState<_AvatarWithFollow> {
  /// Followed from this card, so the tick shows before the button goes.
  bool _justFollowed = false;
  bool _gone = false;

  Future<void> _follow() async {
    final author = widget.post.author;
    unawaited(HapticFeedback.selectionClick());
    setState(() => _justFollowed = true);
    final error =
        await ref.read(followOverridesProvider.notifier).follow(author.id);
    if (!mounted) return;
    if (error != null) {
      setState(() => _justFollowed = false);
      Toast.show(context, error);
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) setState(() => _gone = true);
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final scheme = Theme.of(context).colorScheme;
    final me = ref.watch(currentUserProvider.select((s) => s.value?.id));
    final following = ref.watch(
          followOverridesProvider.select((m) => m[post.author.id]),
        ) ??
        post.followingAuthor;
    // Not on your own posts, and not while who you are is still loading:
    // a "+" on your own face, even for a moment, is offering to follow
    // yourself.
    final offer = me != null && me != post.author.id && !following;
    final showing = (offer || _justFollowed) && !_gone;

    const size = _AvatarWithFollow.badge;
    const reach = _AvatarWithFollow.reach;
    // Where the edge of the picture crosses its 45-degree line.
    const radius = PostAvatar.defaultRadius;
    const edge = radius + radius * 0.7071;
    const at = edge - size / 2 - reach;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => openAuthor(context, post.author),
          child: PostAvatar(author: post.author),
        ),
        if (showing)
          Positioned(
            left: at,
            top: at,
            child: Semantics(
              button: true,
              label: AppLocalizations.of(context)
                  .ui('follow_author', 'Follow {name}')
                  .replaceAll('{name}', post.author.displayName),
              excludeSemantics: true,
              child: GestureDetector(
                key: ValueKey('post-follow-${post.id}'),
                // Reach around a sixteen-pixel disc: the disc is what is
                // drawn, not what a thumb has to hit.
                behavior: HitTestBehavior.opaque,
                onTap: _justFollowed ? null : _follow,
                child: Padding(
                  padding: const EdgeInsets.all(reach),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: scheme.onSurface,
                      shape: BoxShape.circle,
                      // A ring of the page behind it, so it sits on the face
                      // rather than in it.
                      border: Border.all(
                        color: scheme.surface,
                        width: _AvatarWithFollow.ring,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: CustomPaint(
                        key: ValueKey(
                          _justFollowed ? 'follow-done' : 'follow-plus',
                        ),
                        painter: _FollowGlyph(
                          done: _justFollowed,
                          color: scheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A plus, or once followed a tick, drawn as two or three strokes.
///
/// Drawn rather than taken from the icon font: Iconsax's add is a filled
/// circle with the plus cut out of it, so at this size, on a disc, it read
/// as a white blob in a black ring -- and its strokes are too thin to hold
/// up at seven pixels anyway.
class _FollowGlyph extends CustomPainter {
  const _FollowGlyph({required this.done, required this.color});

  final bool done;
  final Color color;

  /// Half the plus's arm, and the stroke, in pixels.
  static const double arm = 3.5;
  static const double stroke = 1.6;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final pen = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    if (done) {
      canvas.drawPath(
        Path()
          ..moveTo(c.dx - 3, c.dy + 0.2)
          ..lineTo(c.dx - 0.9, c.dy + 2.2)
          ..lineTo(c.dx + 3, c.dy - 2),
        pen,
      );
    } else {
      canvas
        ..drawLine(c.translate(-arm, 0), c.translate(arm, 0), pen)
        ..drawLine(c.translate(0, -arm), c.translate(0, arm), pen);
    }
  }

  @override
  bool shouldRepaint(_FollowGlyph old) =>
      old.done != done || old.color != color;
}

class _Actions extends ConsumerWidget {
  final FeedPost post;
  final PostListSource source;

  const _Actions({required this.post, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(postListProvider(source).notifier);
    final me = ref.watch(currentUserProvider).asData?.value;
    // Holding the heart on your own post only likes it: the server refuses a
    // gift to yourself, so there is no sheet to open.
    final mine = me != null && me.id == post.author.id;

    return PostActionsRow(
      post: post,
      onReply: () =>
          Navigator.pushNamed(context, Routes.postDetail, arguments: post.id),
      onRepost: () => RepostSheet.show(
        context,
        post: post,
        onRepost: () => notifier.toggleRepost(post.id),
      ),
      onLike: () => report(context, notifier.toggleLike(post.id)),
      onSave: () => report(context, notifier.toggleSave(post.id)),
      onShare: () => SharePostSheet.show(context, post),
      onGift: mine
          ? null
          : () => GiftSheet.open(
                context,
                post,
                onSent: (gifts) => notifier.giftsChanged(post.id, gifts),
              ),
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

    return SizedBox(
      width: 28,
      height: 28,
      child: InkWell(
        onTap: () =>
            PostOptionsSheet.show(context, ref, post: post, source: source),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        child: Icon(
          Iconsax.more_copy,
          size: 16,
          color: scheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

/// Opens an author's profile.
///
/// By handle when they have one, by account id otherwise -- an account that
/// never set a handle still has a profile, and used to be unreachable.
void openAuthor(BuildContext context, FeedAuthor author) {
  openProfile(context, username: author.username, userId: author.id);
}

/// Shows whatever a mutation reports, and nothing when it succeeds.
Future<void> report(BuildContext context, Future<String?> action) async {
  final message = await action;
  if (message == null || !context.mounted) return;
  Toast.show(context, message);
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
