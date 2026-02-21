import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileOrbit extends StatelessWidget {
  final String coverUrl;
  final String avatarUrl;
  final String displayName;
  final String did;
  final double scrollOffset;

  const ProfileOrbit({
    super.key,
    required this.coverUrl,
    required this.avatarUrl,
    required this.displayName,
    required this.did,
    required this.scrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          // Cover image
          Positioned.fill(
            child: Image.network(
              coverUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.red);
              },
            ),
          ),
          
          // Scrim gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
              ),
            ),
          ),
          
          // Avatar and name section
          Positioned(
            left: 16,
            bottom: 20,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(avatarUrl),
                  backgroundColor: AppTheme.surface,
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint('Avatar image error: $exception');
                  },
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        did,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}