import 'package:flutter/material.dart';
import '../models/profile_model.dart';

enum ProfileTab { posts, replies, media, likes }

class ProfileTabs extends SliverPersistentHeaderDelegate {
  final ProfileTab activeTab;
  final Function(ProfileTab) onTabChanged;
  final ProfileModel profile;

  ProfileTabs({
    required this.activeTab,
    required this.onTabChanged,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scheme = Theme.of(context).colorScheme;
    
    return Container(
      color: scheme.surface,
      child: Column(
        children: [
          // Tabs
          SizedBox(
            height: 48,
            child: Row(
              children: [
                _TabButton(
                  label: 'Posts',
                  count: profile.postsCount,
                  isActive: activeTab == ProfileTab.posts,
                  onTap: () => onTabChanged(ProfileTab.posts),
                ),
                _TabButton(
                  label: 'Replies',
                  count: profile.repliesCount,
                  isActive: activeTab == ProfileTab.replies,
                  onTap: () => onTabChanged(ProfileTab.replies),
                ),
                _TabButton(
                  label: 'Media',
                  count: profile.mediaCount,
                  isActive: activeTab == ProfileTab.media,
                  onTap: () => onTabChanged(ProfileTab.media),
                ),
                _TabButton(
                  label: 'Likes',
                  count: profile.likesCount,
                  isActive: activeTab == ProfileTab.likes,
                  onTap: () => onTabChanged(ProfileTab.likes),
                ),
              ],
            ),
          ),
          
          // Bottom border
          Divider(
            height: 1,
            thickness: 1,
            color: scheme.onSurface.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 49;

  @override
  double get minExtent => 49;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _TabButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.count,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedScale(
          scale: isActive ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? scheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive ? scheme.primary : scheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 4),
                if (count > 0)
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? scheme.primary : scheme.onSurface.withOpacity(0.4),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}