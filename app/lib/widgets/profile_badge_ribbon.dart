import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ProfileBadgeRibbon extends StatelessWidget {
  final List<BadgeModel> badges;

  const ProfileBadgeRibbon({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: badges.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final badge = badges[index];
          return _BadgePill(badge: badge);
        },
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final BadgeModel badge;

  const _BadgePill({required this.badge});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Text(badge.emoji),
                  const SizedBox(width: 8),
                  Text(badge.label),
                ],
              ),
              content: Text(badge.description),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(badge.emoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                badge.label,
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}