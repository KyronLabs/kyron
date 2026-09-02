// lib/screens/hashtag_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../widgets/post_list_view.dart';

/// Every post carrying one hashtag.
class HashtagScreen extends StatelessWidget {
  final String tag;

  const HashtagScreen({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final normalised = tag.replaceFirst('#', '').toLowerCase();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text('#$normalised'),
      ),
      body: SafeArea(
        child: PostListView(
          source: PostListSource.hashtag(normalised),
          // The tag you came here for, highlighted in the body of every post
          // -- a post carrying five tags otherwise makes you read all five to
          // find the one you searched for.
          highlightTag: normalised,
          errorTitle: 'Could not load #$normalised',
          emptyTitle: 'Nothing tagged #$normalised yet',
          emptyDetail: 'Posts using this tag will show up here.',
          emptyIcon: Iconsax.hashtag_copy,
          padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
        ),
      ),
    );
  }
}
