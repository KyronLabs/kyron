import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../routes.dart';

/// The choice behind the repost button: pass it on as-is, or say something.
class RepostSheet {
  const RepostSheet._();

  /// [onRepost] does the reposting and answers with a message to show, or
  /// null when it worked.
  ///
  /// Passed in rather than looked up here, because the post lives somewhere
  /// different on each screen that shows this sheet: in a list on the feed,
  /// and on its own on the post's screen. Reposting through the feed's copy
  /// from the post's own screen left the button on that screen unchanged.
  static Future<void> show(
    BuildContext context, {
    required FeedPost post,
    required Future<String?> Function() onRepost,
  }) {
    HapticFeedback.lightImpact();
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                post.reposted
                    ? Iconsax.repeat_circle_copy
                    : Iconsax.repeat_copy,
                size: 20,
              ),
              title: Text(post.reposted ? 'Undo repost' : 'Repost'),
              subtitle: Text(
                post.reposted
                    ? 'Remove it from your profile'
                    : 'Share this with your followers as it is',
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () async {
                Navigator.pop(sheetContext);
                final message = await onRepost();
                if (message != null && context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.edit_2_copy, size: 20),
              title: const Text('Quote'),
              subtitle: const Text(
                'Add your own words above it',
                style: TextStyle(fontSize: 12),
              ),
              onTap: () {
                Navigator.pop(sheetContext);
                // The composer takes the post being quoted, so the quote is
                // written and sent as one post rather than a repost plus a
                // reply that happen to sit near each other.
                Navigator.pushNamed(context, Routes.composer, arguments: post);
              },
            ),
            const SizedBox(height: SpacingTokens.space8),
          ],
        ),
      ),
    );
  }
}
