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
      {'name': 'Early Adopter', 'icon': '\ud83d\ude80', 'verified': true},
      {'name': 'AR Creator', 'icon': '\ud83c\udfad', 'verified': true},
      {'name': 'Top 1%', 'icon': '\ud83d\udc51', 'verified': false},
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
    final backgroundColor = isDark ? AppTheme.darkBackground : AppTheme.lightBackgroundStart;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 80,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (_profileData['coverUrl'] != null)
                      Image.network(
                        _profileData['coverUrl']!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface);
                        },
                        errorBuilder: (context, error, stackTrace) => Container(color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            backgroundColor,
                            backgroundColor.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(_profileData['avatarUrl']!),
                              backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _profileData['displayName']!,
                                  style: TextStyle(
                                    color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _profileData['username']!,
                                  style: TextStyle(
                                    color: (isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary).withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileOrbit(
                coverUrl: _profileData['coverUrl']!,
                avatarUrl: _profileData['avatarUrl']!,
                displayName: _profileData['displayName']!,
                did: _profileData['did']!,
                scrollOffset: _scrollOffset,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: ProfileChips(
                  chips: _profileData['collections'],
                  onChipSelected: (index) {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: ProfilePassport(
                  bio: _profileData['bio']!,
                  links: _profileData['links'],
                  onShowMoreLinks: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileGalaxy(
                posts: _generateMockPosts(),
                onPostTap: (index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
