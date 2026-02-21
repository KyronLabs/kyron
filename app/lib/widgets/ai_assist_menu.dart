import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class AiAssistMenu {
  static Future<void> show(BuildContext context) async {
    HapticFeedback.lightImpact();
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => const _AiAssistPlaceholder(),
    );
  }
}

class _AiAssistPlaceholder extends StatelessWidget {
  const _AiAssistPlaceholder();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surface : AppTheme.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Handle bar
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: scheme.outline.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Icon
          Icon(
            Icons.construction_outlined,
            size: 48,
            color: scheme.primary,
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            'AI Assist',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Message
          Text(
            'Smart writing tools are under development.\n'
            'Tone rewrites, shorten, emoji-fy, and translate\n'
            'coming soon!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.withValues(alpha: .7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // OK button
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}