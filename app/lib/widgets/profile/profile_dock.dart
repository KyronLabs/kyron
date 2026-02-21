import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileDock extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final int kyronPoints;
  final bool isOwnProfile;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onFollow;
  final VoidCallback onMessage;

  const ProfileDock({
    super.key,
    required this.username,
    required this.avatarUrl,
    required this.kyronPoints,
    required this.isOwnProfile,
    required this.onBack,
    required this.onSettings,
    required this.onFollow,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppTheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              onPressed: onBack,
            ),
            const SizedBox(width: 8),
            
            // Avatar with proper error handling
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(avatarUrl),
              backgroundColor: AppTheme.surface,
              onBackgroundImageError: (exception, stackTrace) {
                // This is a void function - just log the error
                debugPrint('Avatar image error: $exception');
              },
              child: const Icon(Icons.person, color: Colors.white), // Fallback child
            ),
            const SizedBox(width: 12),
            
            // Username
            Expanded(
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            // Action buttons
            if (isOwnProfile)
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: onSettings,
              )
            else
              Row(
                children: [
                  TextButton(
                    onPressed: onFollow,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Follow'),
                  ),
                  TextButton(
                    onPressed: onMessage,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Message'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}