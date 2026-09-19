import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';
import '../l10n/app_localizations.dart';

/// Who can reply to the post being written.
///
/// The server enforces whatever is chosen here. A setting the server ignores
/// is decoration, and one that quietly lets everyone reply anyway is worse
/// than not offering it.
class InteractionSettingsSheet {
  const InteractionSettingsSheet._();

  static Future<ReplyPolicy?> show(BuildContext context, ReplyPolicy current) {
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
                    AppLocalizations.of(sheetContext)
                        .ui('reply_who_can_reply', 'Who can reply?'),
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  Text(
                    AppLocalizations.of(sheetContext).ui(
                      'reply_anyone_can_see',
                      'Anyone can still see, repost and quote this post.',
                    ),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
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
                title: Text(_label(sheetContext, policy)),
                subtitle: Text(
                  _detail(sheetContext, policy),
                  style: const TextStyle(fontSize: TypographyTokens.fontSize1),
                ),
              ),
            const SizedBox(height: SpacingTokens.space8),
          ],
        ),
      ),
    );
  }

  static String _label(BuildContext context, ReplyPolicy policy) =>
      switch (policy) {
        ReplyPolicy.everyone => AppLocalizations.of(
            context,
          ).ui('reply_anyone', 'Anyone can interact'),
        ReplyPolicy.followers => AppLocalizations.of(
            context,
          ).ui('reply_followers', 'People who follow you'),
        ReplyPolicy.mentioned => AppLocalizations.of(
            context,
          ).ui('reply_mentioned', 'People you mention'),
        ReplyPolicy.nobody => AppLocalizations.of(
            context,
          ).ui('reply_nobody', 'Nobody can reply'),
      };
  static String _detail(BuildContext context, ReplyPolicy policy) =>
      switch (policy) {
        ReplyPolicy.everyone => AppLocalizations.of(
            context,
          ).ui(
              'reply_anyone_detail', 'Anyone on Kyron can reply to this post.'),
        ReplyPolicy.followers => AppLocalizations.of(context).ui(
            'reply_followers_detail',
            'Only people who follow you can reply to this post.',
          ),
        ReplyPolicy.mentioned => AppLocalizations.of(context).ui(
            'reply_mentioned_detail',
            'Only the people you @mention in this post can reply.',
          ),
        ReplyPolicy.nobody => AppLocalizations.of(context).ui(
            'reply_nobody_detail',
            'Replies are turned off. You can still reply.',
          ),
      };
  static IconData _iconFor(ReplyPolicy policy) => switch (policy) {
        ReplyPolicy.everyone => Iconsax.global_copy,
        ReplyPolicy.followers => Iconsax.profile_2user_copy,
        ReplyPolicy.mentioned => Iconsax.tag_user_copy,
        ReplyPolicy.nobody => Iconsax.lock_copy,
      };
}
