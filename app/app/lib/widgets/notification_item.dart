import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../models/notification_model.dart';
import '../routes.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;
  final VoidCallback onMute;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
    required this.onMute,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Slidable(
      key: Key(notification.id),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) => onMute(),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Iconsax.volume_slash,
            label: 'Mute',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Iconsax.trash,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => onMarkAsRead(),
        child: Semantics(
          label: '${notification.actorHandle} ${notification.actionText}, ${notification.displayTimestamp}',
          child: Container(
            height: 72,
            color: notification.isRead 
                ? scheme.surface 
                : scheme.primaryContainer.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Unread dot
                if (!notification.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 16, right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scheme.primary,
                    ),
                  ),
                
                // Avatar (40px)
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.profile, arguments: notification.actorDid),
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: scheme.primary, width: 1),
                      image: DecorationImage(
                        image: NetworkImage(notification.actorAvatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: scheme.onSurface,
                            fontFamily: 'SF Pro Rounded',
                          ),
                          children: [
                            TextSpan(
                              text: notification.actorHandle,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(text: ' ${notification.actionText}'),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (notification.postSnippet != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            notification.postSnippet!,
                            style: TextStyle(
                              fontSize: 13,
                              color: scheme.onSurface.withOpacity(0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Timestamp
                Text(
                  notification.displayTimestamp,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}