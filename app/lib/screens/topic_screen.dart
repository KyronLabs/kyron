// lib/screens/topic_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../widgets/post_list_view.dart';

/// What the people who follow a topic are posting.
///
/// Named by slug and titled by name, because the slug is the stable identity
/// and the name is the readable one -- and a screen opened from a deep link
/// may have only the slug.
class TopicArgs {
  final String slug;
  final String name;

  const TopicArgs({required this.slug, required this.name});
}

class TopicScreen extends StatelessWidget {
  final TopicArgs args;

  const TopicScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(args.name),
      ),
      body: SafeArea(
        child: PostListView(
          source: PostListSource.topic(args.slug),
          errorTitle: 'Could not load ${args.name}',
          emptyTitle: 'Nothing here yet',
          // Says what a topic feed actually is, because it is not obvious:
          // nothing links a post to a topic, so what a topic can show is what
          // the people who chose it are posting.
          emptyDetail:
              'Posts from the people who follow ${args.name} will show up here.',
          emptyIcon: Iconsax.category_copy,
          padding: const EdgeInsets.only(bottom: SpacingTokens.space40),
        ),
      ),
    );
  }
}
