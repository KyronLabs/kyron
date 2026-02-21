import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/post_model.dart';
import '../routes.dart';

class PostItem extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onRepost;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;
  final VoidCallback? onMore;
  final VoidCallback? onHide;

  const PostItem({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onRepost,
    this.onBookmark,
    this.onShare,
    this.onMore,
    this.onHide,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  late AnimationController _likeController;
  bool _showHeartBurst = false;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (widget.onLike != null) {
      widget.onLike!();
      setState(() => _showHeartBurst = true);
      _likeController.forward().then((_) {
        setState(() => _showHeartBurst = false);
        _likeController.reset();
      });
      HapticFeedback.lightImpact();
    }
  }

  void _handleLongPress() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _ActionSheet(post: widget.post),
    );
    HapticFeedback.mediumImpact();
  }

  void _handleSwipeRight() {
    if (widget.onBookmark != null) {
      widget.onBookmark!();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post bookmarked')),
      );
      HapticFeedback.lightImpact();
    }
  }

  void _handleSwipeLeft() {
    if (widget.onHide != null) {
      widget.onHide!();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post hidden')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Semantics(
      label: 'Post by ${widget.post.creatorHandle}, ${widget.post.displayTimestamp}, ${widget.post.likes} likes. Double-tap to like, swipe right to bookmark.',
      child: FocusTraversalGroup(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12), // 96px between cards
          child: Stack(
            children: [
              // Layer Z: Background Media
              if (widget.post.mediaType != PostMediaType.none)
                _buildMediaLayer(scheme),
              
              // Layer Y: Gradient Scrim (40% height)
              if (widget.post.mediaType != PostMediaType.none)
                _buildScrimLayer(scheme),
              
              // Layer X: Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Creator Strip
                  _buildCreatorStrip(scheme),
                  
                  // Caption (max 3 lines)
                  if (widget.post.caption.isNotEmpty)
                    _buildCaption(scheme),
                  
                  // Community Pill
                  if (widget.post.communityTag != null)
                    _buildCommunityPill(scheme),
                  
                  // Stats Row
                  _buildStatsRow(scheme),
                  
                  // Action Bar (48px icons)
                  _buildActionBar(scheme),
                ],
              ),
              
              // Layer W: Interactive Overlays
              _buildGestureOverlay(scheme),
              
              // Layer V: Accessibility
              _buildAccessibilityOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaLayer(ColorScheme scheme) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: widget.post.mediaUrl != null
            ? DecorationImage(
                image: NetworkImage(widget.post.mediaUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: widget.post.mediaType == PostMediaType.video
          ? const Center(child: Icon(Iconsax.play_circle, size: 48))
          : widget.post.mediaType == PostMediaType.arLens
              ? const Center(child: Text('AR Lens Preview'))
              : null,
    );
  }

  Widget _buildScrimLayer(ColorScheme scheme) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.black.withOpacity(1.0),
              Colors.black.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorStrip(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar (40px)
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile, arguments: widget.post.creatorDid),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.primary, width: 2),
                image: DecorationImage(
                  image: NetworkImage(widget.post.creatorAvatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Handle + Timestamp
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.post.creatorHandle,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro Rounded',
                      ),
                    ),
                    if (widget.post.isLive)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                Text(
                  widget.post.displayTimestamp,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          
          // Follow Pill (28px height) or Edit icon for self-post
          if (!widget.post.isSelfPost)
            _FollowPill(
              isFollowing: widget.post.isFollowingCreator,
              onTap: () {
                // TODO: Toggle follow
              },
            )
          else
            IconButton(
              icon: Icon(Iconsax.more, size: 20, color: scheme.onSurface),
              onPressed: widget.onMore,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
        ],
      ),
    );
  }

  Widget _buildCaption(ColorScheme scheme) {
    final maxLines = MediaQuery.of(context).textScaleFactor > 1.5 ? 2 : 3;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        widget.post.caption,
        style: const TextStyle(
          fontSize: 17,
          height: 1.41,
          fontFamily: 'SF Pro Rounded',
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCommunityPill(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/community', arguments: widget.post.communityTag),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [scheme.primary, scheme.secondary],
            ),
            border: Border.all(color: scheme.primary.withOpacity(0.3), width: 1),
          ),
          child: Text(
            widget.post.communityTag!,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _Stat(icon: Iconsax.heart, count: widget.post.likes, isActive: widget.post.isLiked),
          const SizedBox(width: 16),
          _Stat(icon: Iconsax.message, count: widget.post.comments),
          const SizedBox(width: 16),
          _Stat(icon: Iconsax.export_3, count: widget.post.reposts),
          const SizedBox(width: 16),
          _Stat(icon: Iconsax.eye, count: widget.post.reach),
        ],
      ),
    );
  }

  Widget _buildActionBar(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionButton(
            icon: Iconsax.heart,
            isActive: widget.post.isLiked,
            onTap: widget.onLike,
            semanticsLabel: 'Like',
          ),
          _ActionButton(
            icon: Iconsax.export_3,
            onTap: widget.onRepost,
            semanticsLabel: 'Repost',
          ),
          _ActionButton(
            icon: Iconsax.message,
            onTap: widget.onComment,
            semanticsLabel: 'Comment',
          ),
          _ActionButton(
            icon: Iconsax.bookmark,
            isActive: widget.post.isBookmarked,
            onTap: widget.onBookmark,
            semanticsLabel: 'Bookmark',
          ),
          _ActionButton(
            icon: Iconsax.share,
            onTap: widget.onShare,
            semanticsLabel: 'Share',
          ),
        ],
      ),
    );
  }

  Widget _buildGestureOverlay(ColorScheme scheme) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: _handleDoubleTap,
        onLongPress: _handleLongPress,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < 0) {
              _handleSwipeLeft();
            } else {
              _handleSwipeRight();
            }
          }
        },
        child: AnimatedBuilder(
          animation: _likeController,
          builder: (context, child) {
            return Stack(
              children: [
                if (_showHeartBurst)
                  Positioned.fill(
                    child: Center(
                      child: Transform.scale(
                        scale: 1.0 + (_likeController.value * 0.2),
                        child: Icon(
                          Iconsax.heart,
                          size: 80,
                          color: scheme.primary,
                        ),
                      ),
                    ),
                  ),
                child!,
              ],
            );
          },
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildAccessibilityOverlay() {
    return const SizedBox.shrink(); // Semantics handled at top level
  }
}

// Helper widgets moved to top level
class _ActionSheet extends StatelessWidget {
  final PostModel post;

  const _ActionSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Iconsax.heart),
            title: const Text('Like'),
            onTap: () => Navigator.pop(context, 'like'),
          ),
          ListTile(
            leading: const Icon(Iconsax.message),
            title: const Text('Comment'),
            onTap: () => Navigator.pop(context, 'comment'),
          ),
          ListTile(
            leading: const Icon(Iconsax.export_3),
            title: const Text('Repost'),
            onTap: () => Navigator.pop(context, 'repost'),
          ),
          ListTile(
            leading: const Icon(Iconsax.bookmark),
            title: const Text('Bookmark'),
            onTap: () => Navigator.pop(context, 'bookmark'),
          ),
          ListTile(
            leading: const Icon(Iconsax.volume_slash),
            title: const Text('Mute'),
            onTap: () => Navigator.pop(context, 'mute'),
          ),
          ListTile(
            leading: const Icon(Iconsax.trash),
            title: const Text('Hide Post'),
            onTap: () => Navigator.pop(context, 'hide'),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final int count;
  final bool isActive;

  const _Stat({
    required this.icon,
    required this.count,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: isActive ? scheme.primary : scheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          _formatCount(count),
          style: TextStyle(
            fontSize: 12,
            color: scheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;
  final String semanticsLabel;

  const _ActionButton({
    required this.icon,
    this.isActive = false,
    this.onTap,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: IconButton(
        icon: Icon(icon, size: 24),
        color: isActive 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        splashRadius: 24,
      ),
    );
  }
}

class _FollowPill extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const _FollowPill({
    required this.isFollowing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isFollowing ? scheme.surface : scheme.primary,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isFollowing ? scheme.onSurface.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          isFollowing ? 'Following' : 'Follow',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isFollowing ? scheme.onSurface : scheme.onPrimary,
          ),
        ),
      ),
    );
  }
}