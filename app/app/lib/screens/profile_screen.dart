// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/profile_model.dart';
import '../models/profile_tab.dart';
import '../widgets/profile_content_grid.dart';

class ProfileScreen extends StatefulWidget {
  final String did;
  final String? handle;
  final ProfileModel? profile;
  
  const ProfileScreen({
    super.key,
    required this.did,
    this.handle,
    this.profile,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileTab _activeTab = ProfileTab.posts;
  bool _isFollowing = false;
  late ProfileModel _profile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    if (widget.profile != null) {
      _profile = widget.profile!;
      _isFollowing = widget.profile!.isFollowing;
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _profile = _fetchProfileByDid(widget.did);
        _isFollowing = _profile.isFollowing;
        _isLoading = false;
      });
    });
  }

  ProfileModel _fetchProfileByDid(String did) {
    return ProfileModel(
      did: did,
      handle: widget.handle ?? '@user_${did.substring(did.length - 4)}',
      displayName: 'User ${did.substring(did.length - 4)}',
      avatarUrl: 'https://picsum.photos/300/300?random=${did.hashCode % 100}',
      coverUrl: 'https://picsum.photos/800/300?random=${did.hashCode % 100 + 1}',
      kyronPoints: 500 + (did.hashCode % 1000),
      bio: 'User with DID: ${did.substring(0, 16)}...',
      socials: [],
      badges: [
        BadgeModel(emoji: '👤', label: 'Member', description: 'Community Member'),
      ],
      postsCount: 25 + (did.hashCode % 50),
      repliesCount: 50 + (did.hashCode % 100),
      mediaCount: 10 + (did.hashCode % 20),
      likesCount: 100 + (did.hashCode % 200),
      isFollowing: false,
      isVerified: did.hashCode % 3 == 0,
      isOwnProfile: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Cover image with animated avatar
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.more_vert, color: Colors.white, size: 20),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Calculate shrink progress (0.0 = fully expanded, 1.0 = fully collapsed)
                final double top = constraints.biggest.height;
                final double collapsedHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
                final double expandedHeight = 200;
                final double shrinkOffset = expandedHeight - top;
                final double shrinkProgress = (shrinkOffset / (expandedHeight - collapsedHeight)).clamp(0.0, 1.0);

                // Avatar size animation: 100 -> 40
                final double avatarSize = 100 - (60 * shrinkProgress);
                
                // Avatar position animation
                final double leftPosition = 20 + (36 * shrinkProgress); // Move from 20 to 56 (next to back button)
                final double topPosition = expandedHeight - 50 - (shrinkOffset); // Start from bottom of cover

                return Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    // Cover image
                    _profile.coverUrl != null
                        ? Image.network(
                            _profile.coverUrl!,
                            fit: BoxFit.cover,
                            color: Colors.blue.withOpacity(0.1),
                            colorBlendMode: BlendMode.multiply,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultCover();
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildDefaultCover();
                            },
                          )
                        : _buildDefaultCover(),
                    
                    // Animated avatar
                    Positioned(
                      left: leftPosition,
                      top: topPosition,
                      child: Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(avatarSize / 2),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(avatarSize / 2),
                          child: Image.network(
                            _profile.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.blueGrey[100],
                                child: Icon(
                                  Iconsax.user,
                                  size: avatarSize * 0.5,
                                  color: Colors.blueGrey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Profile info section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username and handle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profile.handle,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    _profile.displayName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (_profile.isVerified)
                                    Icon(
                                      Iconsax.verify,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'DID: ${_profile.did.substring(0, 12)}...',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_profile.isOwnProfile)
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.setting_2, color: Colors.black),
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _buildProfileActions(),
                    const SizedBox(height: 24),

                    // Kyron Points
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[100]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Iconsax.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${_profile.kyronPoints} Kyron Points',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Badges
                    if (_profile.badges.isNotEmpty) ...[
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: _profile.badges
                            .map((badge) => _buildBadge(badge))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Bio
                    if (_profile.bio != null && _profile.bio!.isNotEmpty) ...[
                      Text(
                        _profile.bio!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Social links
                    if (_profile.socials.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _profile.socials
                            .map((social) => _buildLink(social))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // STICKY TABS - This is the key part!
          SliverPersistentHeader(
            pinned: true, // Makes it stick
            delegate: _StickyTabBarDelegate(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Stats tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatTab('Posts', _profile.postsCount, ProfileTab.posts),
                          _buildStatTab('Replies', _profile.repliesCount, ProfileTab.replies),
                          _buildStatTab('Media', _profile.mediaCount, ProfileTab.media),
                          _buildStatTab('Likes', _profile.likesCount, ProfileTab.likes),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tab indicator
                    Container(
                      height: 2,
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: _activeTab == ProfileTab.posts
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: _activeTab == ProfileTab.replies
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: _activeTab == ProfileTab.media
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: _activeTab == ProfileTab.likes
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content grid
          SliverFillRemaining(
            hasScrollBody: true,
            child: ProfileContentGrid(
              activeTab: _activeTab,
              profile: _profile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCover() {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      child: const Center(
        child: Icon(
          Iconsax.gallery,
          size: 50,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildProfileActions() {
    if (_profile.isOwnProfile) {
      return Row(
        children: [
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Share',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.setting_2, color: Colors.black, size: 16),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            height: 32,
            constraints: const BoxConstraints(minWidth: 90),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFollowing = !_isFollowing;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFollowing ? Colors.grey[200] : Colors.blue,
                foregroundColor: _isFollowing ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                _isFollowing ? 'Following' : 'Follow',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 32,
            constraints: const BoxConstraints(minWidth: 90),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Message',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.share, color: Colors.black, size: 16),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildBadge(BadgeModel badge) {
    return Tooltip(
      message: badge.description,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              badge.emoji,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 6),
            Text(
              badge.label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String text) {
    IconData icon;
    if (text.contains('@')) {
      icon = Iconsax.stop;
    } else if (text.contains('.')) {
      icon = Iconsax.link;
    } else {
      icon = Iconsax.sms;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTab(String label, int count, ProfileTab tab) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = tab;
        });
      },
      child: Column(
        children: [
          Text(
            _formatCount(count),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _activeTab == tab ? Colors.blue : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: _activeTab == tab ? Colors.blue : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

// Custom delegate for sticky tabs
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabBarDelegate({required this.child});

  @override
  double get minExtent => 70; // Height when stuck

  @override
  double get maxExtent => 70; // Height when not stuck

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}