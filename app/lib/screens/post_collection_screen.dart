// lib/screens/post_collection_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../widgets/post_list_view.dart';

/// Your saved posts, or your liked posts.
///
/// One screen: they differ only in which endpoint they read and what to say
/// when there is nothing in them. The drawer offered "Saved Posts" and pointed
/// at a route that did not exist, so it opened the splash screen.
class PostCollectionScreen extends StatelessWidget {
  final PostListSource source;
  final String title;
  final String emptyTitle;
  final String emptyDetail;
  final IconData emptyIcon;

  /// What to say when the list itself will not load.
  final String errorTitle;

  const PostCollectionScreen({
    super.key,
    required this.source,
    required this.title,
    required this.emptyTitle,
    required this.emptyDetail,
    required this.emptyIcon,
    required this.errorTitle,
  });

  const PostCollectionScreen.saved({super.key})
      : source = PostListSource.saved,
        title = 'Saved posts',
        emptyTitle = 'Nothing saved yet',
        emptyDetail =
            'Tap the archive icon on any post to keep it here. Only you can '
                'see what you save.',
        emptyIcon = Iconsax.archive_add_copy,
        errorTitle = 'Could not load your saved posts';

  const PostCollectionScreen.liked({super.key})
      : source = PostListSource.liked,
        title = 'Liked posts',
        emptyTitle = 'No likes yet',
        emptyDetail = 'Posts you like show up here, most recent first.',
        emptyIcon = Iconsax.heart_copy,
        errorTitle = 'Could not load your liked posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: PostListView(
          source: source,
          errorTitle: errorTitle,
          emptyTitle: emptyTitle,
          emptyDetail: emptyDetail,
          emptyIcon: emptyIcon,
          padding: const EdgeInsets.only(
            top: SpacingTokens.space8,
            bottom: SpacingTokens.space40,
          ),
        ),
      ),
    );
  }
}
