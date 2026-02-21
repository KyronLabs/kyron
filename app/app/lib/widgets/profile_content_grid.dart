// lib/widgets/profile_content_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/profile_model.dart';
import '../models/profile_tab.dart';

class ProfileContentGrid extends StatelessWidget {
  final ProfileTab activeTab;
  final ProfileModel profile;

  const ProfileContentGrid({
    super.key,
    required this.activeTab,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case ProfileTab.posts:
        return _PostsGrid(count: profile.postsCount);
      case ProfileTab.replies:
        return _RepliesList(count: profile.repliesCount);
      case ProfileTab.media:
        return _MediaGrid(count: profile.mediaCount);
      case ProfileTab.likes:
        return _LikesGrid(count: profile.likesCount);
    }
  }
}

class _PostsGrid extends StatelessWidget {
  final int count;

  const _PostsGrid({required this.count});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(), // FIXED: Disable independent scrolling
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(4),
          height: (index % 5 + 1) * 80,
          decoration: BoxDecoration(
            color: Colors.primaries[index % Colors.primaries.length],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Post ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RepliesList extends StatelessWidget {
  final int count;

  const _RepliesList({required this.count});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(), // FIXED: Disable independent scrolling
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Iconsax.message, size: 20, color: Colors.white),
            ),
            title: Text('Reply to @user${index % 5}'),
            subtitle: const Text('Lorem ipsum dolor sit amet...'),
            trailing: Text('${index + 1}h ago'),
          ),
        );
      },
    );
  }
}

class _MediaGrid extends StatelessWidget {
  final int count;

  const _MediaGrid({required this.count});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(), // FIXED: Disable independent scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.primaries[index % Colors.primaries.length],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://picsum.photos/200/200?random=$index',
              ),
            ),
          ),
          child: const Center(
            child: Icon(Iconsax.gallery, size: 32, color: Colors.white),
          ),
        );
      },
    );
  }
}

class _LikesGrid extends StatelessWidget {
  final int count;

  const _LikesGrid({required this.count});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(), // FIXED: Disable independent scrolling
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(4),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.primaries[index % Colors.primaries.length]
                .withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.heart, size: 32, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  'Liked ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}