// lib/screens/post_collection_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../widgets/post_list_view.dart';
import '../widgets/empty_state.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/saved_comments_list.dart';
import '../widgets/section_tabs.dart';
import '../l10n/app_localizations.dart';

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
  final EmptyArt emptyArt;

  /// What to say when the list itself will not load.
  final String errorTitle;

  const PostCollectionScreen({
    super.key,
    required this.source,
    required this.title,
    required this.emptyTitle,
    required this.emptyDetail,
    required this.emptyArt,
    required this.errorTitle,
  });

  const PostCollectionScreen.saved({super.key})
      : source = PostListSource.saved,
        title = 'Saved posts',
        emptyTitle = 'Nothing saved yet',
        emptyDetail =
            'Tap the archive icon on any post to keep it here. Only you can '
                'see what you save.',
        emptyArt = EmptyArt.saved,
        errorTitle = 'Could not load your saved posts';

  const PostCollectionScreen.liked({super.key})
      : source = PostListSource.liked,
        title = 'Liked posts',
        emptyTitle = 'No likes yet',
        emptyDetail = 'Posts you like show up here, most recent first.',
        emptyArt = EmptyArt.likes,
        errorTitle = 'Could not load your liked posts';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localizedTitle = source == PostListSource.saved
        ? l10n.ui('ui_saved_posts', 'Saved posts')
        : l10n.ui('ui_liked_posts', 'Liked posts');
    final localizedEmptyTitle = source == PostListSource.saved
        ? l10n.ui('ui_nothing_saved_yet', 'Nothing saved yet')
        : l10n.ui('ui_no_likes_yet', 'No likes yet');
    final localizedEmptyDetail = source == PostListSource.saved
        ? l10n.ui(
            'ui_saved_posts_detail',
            'Tap the archive icon on any post to keep it here. Only you can see what you save.',
          )
        : l10n.ui(
            'ui_liked_posts_detail',
            'Posts you like show up here, most recent first.',
          );
    final localizedError = source == PostListSource.saved
        ? l10n.ui(
            'ui_could_not_load_saved_posts', 'Could not load your saved posts')
        : l10n.ui(
            'ui_could_not_load_liked_posts', 'Could not load your liked posts');
    final posts = PostListView(
      source: source,
      errorTitle: localizedError,
      emptyTitle: localizedEmptyTitle,
      emptyDetail: localizedEmptyDetail,
      emptyArt: emptyArt,
      padding: const EdgeInsets.only(
        top: SpacingTokens.space8,
        bottom: SpacingTokens.space40,
      ),
    );
    if (source == PostListSource.saved) {
      return _SavedTabs(
        title: l10n.ui('ui_saved', 'Saved'),
        posts: posts,
      );
    }
    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(localizedTitle),
      ),
      body: SafeArea(child: posts),
    );
  }
}

/// Saved, in two: the posts kept, and the comments kept. A comment saved
/// from under somebody's post has to be findable again, and a list of
/// posts is not where anyone would look for it.
class _SavedTabs extends StatefulWidget {
  final String title;
  final Widget posts;

  const _SavedTabs({required this.title, required this.posts});

  @override
  State<_SavedTabs> createState() => _SavedTabsState();
}

class _SavedTabsState extends State<_SavedTabs>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(widget.title),
        bottom: SectionTabs(
          controller: _tabs,
          labels: [
            l10n.ui('ui_saved_tab_posts', 'Posts'),
            l10n.ui('ui_saved_tab_comments', 'Comments'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabs,
          children: [widget.posts, const SavedCommentsList()],
        ),
      ),
    );
  }
}
