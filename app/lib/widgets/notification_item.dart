// lib/widgets/notification_item.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/notification_model.dart';
import '../utils/notification_text.dart';
import 'gift_sheet.dart';
import 'verified_badge.dart';

/// One thing somebody did, as a row.
///
/// What this replaces slid open to a Mute button that showed a snackbar and a
/// Delete button that dropped the row until the next load. Neither could be
/// built: a notification here is the like or the follow itself, so there is
/// nothing to delete that would not also unlike the post.
class NotificationItem extends StatefulWidget {
  final NotificationModel notification;

  /// The row as a whole: the reply it is about, else the post, else the
  /// person.
  final VoidCallback onTap;

  /// The person's face and name: their profile.
  final VoidCallback? onActor;

  /// The picture at the end: the post.
  final VoidCallback? onPost;

  /// The words quoted under the action, when they are a reply's: that reply.
  final VoidCallback? onContent;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    this.onActor,
    this.onPost,
    this.onContent,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

/// Each part of a row opens its own page -- the face and the name the
/// person, the picture the post, a reply's words the reply -- and the rest
/// of the row what the row is about. One target for the whole row sent a
/// tap on somebody's face to a post.
class _NotificationItemState extends State<NotificationItem> {
  late final _name = TapGestureRecognizer();

  NotificationModel get notification => widget.notification;
  VoidCallback get onTap => widget.onTap;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  IconData get _badge => switch (notification.type) {
        NotificationType.like => Iconsax.heart_copy,
        NotificationType.comment => Iconsax.message_copy,
        NotificationType.follow => Iconsax.user_add_copy,
        NotificationType.repost => Iconsax.repeat_copy,
        NotificationType.mention => Iconsax.tag_user_copy,
        NotificationType.account => Iconsax.shield_tick_copy,
        NotificationType.report => Iconsax.flag_copy,
        NotificationType.gift => Iconsax.gift_copy,
      };

  Color _badgeColor(ColorScheme scheme) => switch (notification.type) {
        NotificationType.like => const Color(0xFFE0245E),
        NotificationType.repost => const Color(0xFF17BF63),
        NotificationType.gift => const Color(0xFFFFB800),
        _ => scheme.primary,
      };

  @override
  Widget build(BuildContext context) {
    if (notification.fromKyron) return _FromKyron(notification, onTap: onTap);
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final actor = notification.actor ?? const NotificationActor(id: '');
    final snippet = notification.content ?? notification.postSnippet;
    final gift =
        notification.type == NotificationType.gift ? notification.gift : null;

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
            GestureDetector(
              key: ValueKey('notification-actor-${notification.id}'),
              onTap: widget.onActor,
              child: Stack(
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
                    child: gift != null
                        ? _GiftBadge(type: gift.type)
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _badgeColor(scheme),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: scheme.surface, width: 2),
                            ),
                            child: Icon(_badge, size: 10, color: Colors.white),
                          ),
                  ),
                ],
              ),
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
                          recognizer: widget.onActor == null
                              ? null
                              : (_name..onTap = widget.onActor),
                        ),
                        if (actor.verified)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: VerifiedBadge(
                                size: VerifiedBadge.sizeFor(
                                  TypographyTokens.fontSize3,
                                ),
                              ),
                            ),
                          ),
                        TextSpan(
                          text:
                              ' ${notificationAction(l10n, notification.type, gift: notification.gift)}',
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (snippet != null && snippet.isNotEmpty) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    GestureDetector(
                      key: ValueKey('notification-content-${notification.id}'),
                      onTap: widget.onContent,
                      child: Text(
                        snippet,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
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
                fontSize: TypographyTokens.fontSize1,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            // At the very end, what it was about: the post's picture, with
            // the gift on its corner if it was given one -- or, on a post of
            // words alone, the gift by itself.
            if (notification.postImage != null) ...[
              const SizedBox(width: SpacingTokens.space12),
              GestureDetector(
                key: ValueKey('notification-post-${notification.id}'),
                onTap: widget.onPost,
                child: _PostPicture(
                  url: notification.postImage!,
                  gift: gift?.type,
                ),
              ),
            ] else if (gift != null) ...[
              const SizedBox(width: SpacingTokens.space8),
              GiftArt(type: gift.type, size: 32),
            ],
          ],
        ),
      ),
    );
  }
}

/// The post a row is about, by its picture: a small rounded square at the
/// end of the row, with the gift it was given sitting on its corner.
class _PostPicture extends StatelessWidget {
  final String url;
  final String? gift;

  const _PostPicture({required this.url, this.gift});

  /// The square's side, and how far the gift hangs off its corner.
  static const side = 44.0;
  static const overhang = 8.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final placeholder = ColoredBox(
      color: scheme.onSurface.withValues(alpha: 0.06),
      child: const SizedBox.expand(),
    );

    final picture = ClipRRect(
      borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      child: SizedBox.square(
        dimension: side,
        child: Image(
          // Decoded at the size it is drawn: a feed's worth of full-size
          // photographs for 44-point squares is how a list runs out of
          // memory.
          image: ResizeImage(
            NetworkImage(url),
            width: (side * dpr).round(),
            policy: ResizeImagePolicy.fit,
          ),
          fit: BoxFit.cover,
          // A square of the page's own tint while it loads or if it cannot,
          // so the row keeps its shape either way.
          frameBuilder: (context, child, frame, synchronous) =>
              frame == null && !synchronous ? placeholder : child,
          errorBuilder: (_, __, ___) => placeholder,
        ),
      ),
    );

    if (gift == null) return ExcludeSemantics(child: picture);
    return ExcludeSemantics(
      // The square alone takes the room, so every row's picture lines up
      // whether or not a gift hangs off it.
      child: SizedBox.square(
        dimension: side,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            picture,
            Positioned(
              right: -overhang,
              bottom: -overhang,
              child: GiftArt(type: gift!, size: 26),
            ),
          ],
        ),
      ),
    );
  }
}

/// A gift row's badge: the gift's own picture on the avatar, where the other
/// rows have an icon on a colour.
class _GiftBadge extends StatelessWidget {
  final String type;

  const _GiftBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: scheme.surface,
        shape: BoxShape.circle,
      ),
      child: GiftArt(type: type, size: 16),
    );
  }
}

/// A row from Kyron: a decision about this account, an appeal answered, or
/// what came of something it reported. No face, because nobody is named --
/// the team decides as Kyron -- and the words are the reader's language.
class _FromKyron extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _FromKyron(this.notification, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final text = moderationText(
      l10n,
      notification,
      locale: Localizations.maybeLocaleOf(context)?.toLanguageTag(),
    );
    final report = notification.type == NotificationType.report;

    return InkWell(
      key: ValueKey('notification-kyron-${notification.id}'),
      onTap: onTap,
      child: Container(
        color:
            notification.isRead ? null : scheme.primary.withValues(alpha: 0.06),
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: scheme.primary.withValues(alpha: 0.12),
              child: Icon(
                report ? Iconsax.flag_copy : Iconsax.shield_tick_copy,
                size: 20,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.headline,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (text.detail != null) ...[
                    const SizedBox(height: SpacingTokens.space4),
                    Text(
                      text.detail!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize2,
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
                fontSize: TypographyTokens.fontSize1,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
