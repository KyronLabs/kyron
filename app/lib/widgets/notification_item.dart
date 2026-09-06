// lib/widgets/notification_item.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/notification_model.dart';

/// One thing somebody did, as a row.
///
/// What this replaces slid open to a Mute button that showed a snackbar and a
/// Delete button that dropped the row until the next load. Neither could be
/// built: a notification here is the like or the follow itself, so there is
/// nothing to delete that would not also unlike the post.
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  /// Opens the post, or the profile when there is no post.
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData get _badge => switch (notification.type) {
        NotificationType.like => Iconsax.heart_copy,
        NotificationType.comment => Iconsax.message_copy,
        NotificationType.follow => Iconsax.user_add_copy,
        NotificationType.repost => Iconsax.repeat_copy,
      };

  Color _badgeColor(ColorScheme scheme) => switch (notification.type) {
        NotificationType.like => const Color(0xFFE0245E),
        NotificationType.repost => const Color(0xFF17BF63),
        _ => scheme.primary,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final actor = notification.actor;
    final snippet = notification.content ?? notification.postSnippet;

    return InkWell(
      onTap: onTap,
      child: Container(
        // Unread rows are tinted rather than dotted: the whole row reads at a
        // glance, where a dot has to be looked for.
        color:
            notification.isRead ? null : scheme.primary.withValues(alpha: 0.06),
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: scheme.primary.withValues(alpha: 0.15),
                  foregroundImage: actor.avatarUrl == null
                      ? null
                      : NetworkImage(actor.avatarUrl!),
                  child: Icon(
                    Iconsax.user_copy,
                    size: 18,
                    color: scheme.primary,
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _badgeColor(scheme),
                      shape: BoxShape.circle,
                      border: Border.all(color: scheme.surface, width: 2),
                    ),
                    child: Icon(_badge, size: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: SpacingTokens.space12),
            // Expanded, because a Row gives a non-flex child unbounded width
            // and the ellipsis would never engage on a long name.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: actor.label,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: ' ${notification.actionText}'),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: scheme.onSurface),
                  ),
                  if (snippet != null && snippet.isNotEmpty) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    Text(
                      snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            Text(
              notification.displayTimestamp,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
