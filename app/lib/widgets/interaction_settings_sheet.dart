import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';

/// Who can reply to the post being written.
///
/// The server enforces whatever is chosen here. A setting the server ignores
/// is decoration, and one that quietly lets everyone reply anyway is worse
/// than not offering it.
class InteractionSettingsSheet {
  const InteractionSettingsSheet._();

  static Future<ReplyPolicy?> show(
    BuildContext context,
    ReplyPolicy current,
  ) {
    return showModalBottomSheet<ReplyPolicy>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space20,
                0,
                SpacingTokens.space20,
                SpacingTokens.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who can reply?',
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  Text(
                    'Anyone can still see, repost and quote this post.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(sheetContext)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: .7),
                    ),
                  ),
                ],
              ),
            ),
            for (final policy in ReplyPolicy.values)
              RadioListTile<ReplyPolicy>(
                value: policy,
                groupValue: current,
                onChanged: (chosen) => Navigator.pop(sheetContext, chosen),
                secondary: Icon(_iconFor(policy), size: 20),
                title: Text(policy.label),
                subtitle: Text(
                  policy.detail,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            const SizedBox(height: SpacingTokens.space8),
          ],
        ),
      ),
    );
  }

  static IconData _iconFor(ReplyPolicy policy) => switch (policy) {
        ReplyPolicy.everyone => Iconsax.global_copy,
        ReplyPolicy.followers => Iconsax.profile_2user_copy,
        ReplyPolicy.mentioned => Iconsax.tag_user_copy,
        ReplyPolicy.nobody => Iconsax.lock_copy,
      };
}
