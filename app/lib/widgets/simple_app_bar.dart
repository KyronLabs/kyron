// lib/widgets/simple_app_bar.dart
import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onAvatarTap;
  final VoidCallback? onSettingsTap;

  const SimpleAppBar({
    super.key,
    required this.title,
    required this.onAvatarTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Avatar button
            GestureDetector(
              onTap: onAvatarTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.primary.withValues(alpha: 0.15),
                  border: Border.all(
                    color: scheme.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  color: scheme.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
            // Settings button
            IconButton(
              onPressed: onSettingsTap ?? () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(
                Icons.settings_outlined,
                color: scheme.onSurface.withValues(alpha: 0.7),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}