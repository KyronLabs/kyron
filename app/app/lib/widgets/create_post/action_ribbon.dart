import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/composer_provider.dart';
import '../privacy_selector.dart';
import 'schedule_selector.dart';
import '../media_selector.dart';
import '../ai_assist_menu.dart';

class ActionRibbon extends ConsumerWidget {
  const ActionRibbon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: scheme.outline.withValues(alpha: .15), width: .5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(
            icon: Icons.add_photo_alternate_outlined,
            label: 'Add',
            onTap: () => MediaSelector.show(context),
          ),
          _buildIconButton(
            icon: _getPrivacyIcon(ref.watch(composerProvider).privacy),
            label: ref.watch(composerProvider).privacy,
            onTap: () => PrivacySelector.show(context),
            onLongPress: () => PrivacySelector.showDetailed(context),
          ),
          _buildIconButton(
            icon: ref.watch(composerProvider).scheduledAt == null 
                ? Icons.timer_outlined 
                : Icons.timer,
            label: ref.watch(composerProvider).scheduledAt == null ? 'Now' : 'Later',
            onTap: () => ScheduleSelector.show(context),
          ),
          _buildIconButton(
            icon: Icons.auto_awesome_outlined,
            label: 'Assist',
            onLongPress: () => AiAssistMenu.show(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPrivacyIcon(String privacy) {
    switch (privacy) {
      case 'Public': return Icons.public;
      case 'Followers': return Icons.people;
      case 'Mutuals': return Icons.people_alt;
      case 'E2EE': return Icons.lock;
      default: return Icons.public;
    }
  }
}
