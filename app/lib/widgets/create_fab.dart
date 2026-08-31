import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../routes.dart';
import 'long_press_sheet.dart';

/// The create button, and the menu of what you can create.
class CreateFab extends StatelessWidget {
  const CreateFab({super.key});

  /// Each entry's icon and the route it opens. Every one of these went
  /// nowhere but Text Post, so three of the four closed the sheet in silence.
  static const _options = <String, ({IconData icon, String route})>{
    'Text post': (icon: Iconsax.note_text_copy, route: Routes.composer),
    'AR Lens': (icon: Iconsax.camera_copy, route: Routes.createArLens),
    'Poll': (icon: Iconsax.chart_copy, route: Routes.createPoll),
    'Space (audio)': (icon: Iconsax.microphone_copy, route: Routes.createSpace),
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient aura
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  scheme.primary.withValues(alpha: 0.3),
                  scheme.secondary.withValues(alpha: 0.3),
                  (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: 'create',
            tooltip: 'Create',
            onPressed: () => _showMenu(context),
            backgroundColor: isDark ? Colors.white : Colors.black,
            elevation: 2,
            shape: const CircleBorder(),
            child: Icon(Iconsax.add_copy,
                size: 24, color: isDark ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _showMenu(BuildContext context) async {
    HapticFeedback.lightImpact();

    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => LongPressSheet(
        items: {
          for (final entry in _options.entries) entry.key: entry.value.icon,
        },
      ),
    );

    final route = _options[chosen]?.route;
    if (route == null || !context.mounted) return;
    await Navigator.pushNamed(context, route);
  }
}
