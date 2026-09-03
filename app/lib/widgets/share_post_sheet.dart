// lib/widgets/share_post_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:share_plus/share_plus.dart';

import '../models/feed_post.dart';
import 'toast.dart';

/// Sharing one post.
///
/// A sheet rather than going straight to the system share dialogue, because
/// "share" means several different things: hand it to another app, copy the
/// address, or copy what it says. Going straight to the system sheet offers
/// only the first and buries the two people ask for most.
class SharePostSheet {
  static Future<void> show(BuildContext context, FeedPost post) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => _Sheet(post: post),
    );
  }

  /// The post's public address.
  static String linkTo(FeedPost post) => 'https://kyron.so/post/${post.id}';
}

class _Sheet extends StatelessWidget {
  final FeedPost post;

  const _Sheet({required this.post});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final link = SharePostSheet.linkTo(post);
    final text = post.content.trim();
    final author = post.author.displayName;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space20,
              0,
              SpacingTokens.space20,
              SpacingTokens.space8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Share this post',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          _Item(
            icon: Iconsax.export_1_copy,
            label: 'Share via…',
            subtitle: 'Hand it to another app',
            onTap: () async {
              Navigator.pop(context);
              // The link, not the text: the post may be edited or deleted, and
              // a copy of its words pasted elsewhere cannot follow either.
              await Share.share(link, subject: '$author on Kyron');
            },
          ),
          _Item(
            icon: Iconsax.link_copy,
            label: 'Copy link',
            onTap: () => _copy(context, link, 'Link copied'),
          ),
          if (text.isNotEmpty)
            _Item(
              icon: Iconsax.copy_copy,
              label: 'Copy text',
              onTap: () => _copy(context, text, 'Post text copied'),
            ),
          _Item(
            icon: Iconsax.message_2_copy,
            label: 'Share with a quote',
            subtitle: 'Post it with your own words above it',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/composer', arguments: post);
            },
          ),
          Divider(
            height: SpacingTokens.space16,
            thickness: 0.5,
            color: scheme.outline.withValues(alpha: 0.2),
          ),
          const SizedBox(height: SpacingTokens.space8),
        ],
      ),
    );
  }

  Future<void> _copy(
    BuildContext context,
    String value,
    String confirmation,
  ) async {
    // Captured before the pop: by the time there is something to report,
    // this sheet's own context is gone.
    final overlay = Toast.anchor(context);
    Navigator.pop(context);
    await Clipboard.setData(ClipboardData(text: value));
    Toast.showOn(
      overlay,
      confirmation,
      spot: ToastSpot.middle,
      icon: Iconsax.copy_copy,
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _Item({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, size: 20, color: scheme.onSurface),
      title: Text(label, style: const TextStyle(fontSize: 15)),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
      onTap: onTap,
      dense: true,
    );
  }
}
