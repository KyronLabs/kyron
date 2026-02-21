import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfilePassport extends StatelessWidget {
  final String bio;
  final List<Map<String, dynamic>> links;
  final VoidCallback onShowMoreLinks;

  const ProfilePassport({
    super.key,
    required this.bio,
    required this.links,
    required this.onShowMoreLinks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio
          Text(
            bio,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),
          
          // Links (max 5, >5 collapses)
          ...links.take(5).map((link) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    _getPlatformIcon(link['platform']),
                    color: Colors.white.withOpacity(0.7),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${link['platform']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  if (link['verified']) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.verified, color: AppTheme.accent, size: 14),
                  ],
                ],
              ),
            ),
          ),
          
          // "+X" collapse indicator
          if (links.length > 5)
            TextButton(
              onPressed: onShowMoreLinks,
              child: Text(
                '+${links.length - 5} more',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'twitter':
        return Icons.chat_bubble_outline;
      case 'github':
        return Icons.code_outlined;
      default:
        return Icons.link_outlined;
    }
  }
}
