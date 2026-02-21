import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/profile/profile_orbit.dart';
//import '../widgets/profile/profile_dock.dart';
import '../widgets/profile/profile_chips.dart';
import '../widgets/profile/profile_passport.dart';
import '../widgets/profile/profile_galaxy.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final bool isOwnProfile;

  const ProfilePage({
    super.key,
    required this.userId,
    this.isOwnProfile = true,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  int _selectedChipIndex = 0;

  // Mock data
  final Map<String, dynamic> _profileData = {
    'displayName': 'Alice Wonderland',
    'username': '@alice',
    'did': 'did:kyron:alice123',
    'bio': 'Digital artist & AR creator. Building the future of social interaction.',
    'avatarUrl': 'https://i.pravatar.cc/150?img=1',
    'coverUrl': 'https://picsum.photos/800/400',
    'kyronPoints': 42069,
    'followers': 1234,
    'following': 567,
    'posts': 89,
    'links': [
      {'platform': 'Instagram', 'url': 'https://instagram.com/alice', 'verified': true},
      {'platform': 'Twitter', 'url': 'https://twitter.com/alice', 'verified': true},
      {'platform': 'GitHub', 'url': 'https://github.com/alice', 'verified': false},
    ],
    'collections': [
      {'name': 'Travel Tokyo', 'count': 24, 'cover': 'https://picsum.photos/200/200?random=1'},
      {'name': 'Synthwave', 'count': 18, 'cover': 'https://picsum.photos/200/200?random=2'},
      {'name': 'AR Lenses', 'count': 12, 'cover': 'https://picsum.photos/200/200?random=3'},
    ],
    'badges': [
      {'name': 'Early Adopter', 'icon': '🚀', 'verified': true},
      {'name': 'AR Creator', 'icon': '🎭', 'verified': true},
      {'name': 'Top 1%', 'icon': '👑', 'verified': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    
    // Transparent status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Generate mock posts for galaxy
  List<Map<String, dynamic>> _generateMockPosts() {
    return List.generate(12, (index) => ({
      'imageUrl': 'https://picsum.photos/200/200?random=$index',
      'hasAR': index % 3 == 0,
    }));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppTheme.background : AppTheme.lightBackgroundStart;
    final surfaceColor = isDark ? AppTheme.surface : AppTheme.lightSurface;
    final textColor = isDark ? AppTheme.textPrimary : AppTheme.lightTextPrimary;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          top: false, // Allow content under status bar
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ProfileOrbit
              SliverToBoxAdapter(
                child: ProfileOrbit(
                  coverUrl: _profileData['coverUrl'],
                  avatarUrl: _profileData['avatarUrl'],
                  displayName: _profileData['displayName'],
                  did: _profileData['did'],
                  scrollOffset: _scrollOffset,
                ),
              ),
              
              // ProfileDock (Sticky Header)
              //SliverPersistentHeader(
              //  pinned: true,
              //  delegate: _DockDelegate(
               //   minHeight: 56,
               //   maxHeight: 56,
              //    child: Container(
               //     color: surfaceColor,
               //     child: ProfileDock(
               //       username: _profileData['username'],
               //       avatarUrl: _profileData['avatarUrl'],
               //       kyronPoints: _profileData['kyronPoints'],
               //       isOwnProfile: widget.isOwnProfile,
                //      onBack: () => Navigator.pop(context),
               //       onSettings: () {
               //         ScaffoldMessenger.of(context).showSnackBar(
               //           const SnackBar(content: Text('Settings tapped')),
               //         );
               //       },
               //       onFollow: () {
               //         ScaffoldMessenger.of(context).showSnackBar(
               //           const SnackBar(content: Text('Follow tapped')),
              //          );
               //       },
               //       onMessage: () {
               //         ScaffoldMessenger.of(context).showSnackBar(
               //           const SnackBar(content: Text('Message tapped')),
               //         );
              //        },
               //     ),
               //   ),
              //  ),
              //),
              
              // Content Area
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  // ProfileChips
                  ProfileChips(
                    chips: [
                      {'icon': '📸', 'label': 'Posts', 'count': _profileData['posts']},
                      {'icon': '🎭', 'label': 'AR Lenses', 'count': 12},
                      {'icon': '📁', 'label': 'Collections', 'count': _profileData['collections'].length},
                      {'icon': '🏆', 'label': 'Badges', 'count': _profileData['badges'].length},
                      {'icon': '📊', 'label': 'Stats', 'count': null},
                    ],
                    onChipSelected: (index) {
                      setState(() => _selectedChipIndex = index);
                    },
                  ),
                  const SizedBox(height: 16),
                  // ProfilePassport
                  ProfilePassport(
                    bio: _profileData['bio'],
                    links: _profileData['links'],
                    onShowMoreLinks: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Show more links tapped')),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // ProfileGalaxy
                  ProfileGalaxy(
                    posts: _generateMockPosts(),
                    onPostTap: (index) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Post $index tapped')),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sliver Delegate for Dock
class _DockDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _DockDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_DockDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}