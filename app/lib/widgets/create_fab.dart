import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../routes.dart';
import 'long_press_sheet.dart';

/// The create button, and the menu of what you can create.
///
/// The same disc is used for "post in this community", through [CreateFab.of]:
/// a black circle with a gradient aura behind it, which is what the button on
/// the bottom bar is. Before that, a community's compose button was a plain
/// Material `FloatingActionButton` in the bottom-right corner -- a different
/// shape, a different colour and a different place from the create button one
/// screen back, for the same job.
class CreateFab extends StatelessWidget {
  const CreateFab({super.key})
      : icon = Iconsax.add_copy,
        tooltip = 'Create',
        onPressed = null,
        heroTag = 'create';

  /// The same disc doing something other than opening the create menu.
  const CreateFab.of({
    super.key,
    required this.icon,
    required this.tooltip,
    required VoidCallback this.onPressed,
    this.heroTag,
  });

  final IconData icon;
  final String tooltip;

  /// Null opens the menu of what you can create.
  final VoidCallback? onPressed;

  final Object? heroTag;

  /// Each entry's icon and the route it opens.
  ///
  /// Poll is gone: a poll is written in the text composer, under the question
  /// it belongs to, so a second door into the same screen was one entry doing
  /// nothing the first did not.
  ///
  /// "Space" was one word covering two different things. Recording your voice
  /// and broadcasting live are not the same feature, and the second needs a
  /// media server this does not run -- so they are two entries, and the one
  /// that is not built says so when you open it.
  static const _options = <String, ({IconData icon, String route})>{
    'Text post': (icon: Iconsax.note_text_copy, route: Routes.composer),
    'Voice post': (
      icon: Iconsax.microphone_copy,
      route: Routes.createVoicePost,
    ),
    'AR Lens': (icon: Iconsax.camera_copy, route: Routes.createArLens),
    'Go live': (icon: Iconsax.video_copy, route: Routes.goLive),
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
            heroTag: heroTag,
            tooltip: tooltip,
            onPressed: onPressed ?? () => chooseWhatToPost(context),
            backgroundColor: isDark ? Colors.white : Colors.black,
            elevation: 2,
            shape: const CircleBorder(),
            child: Icon(icon,
                size: 24, color: isDark ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  /// The menu of what you can create.
  ///
  /// Static and public because the round button on a phone's bottom bar
  /// and the wide one down the side of a window are two ways into one
  /// menu. It was private, so the rail's button would have needed its own
  /// copy of the four options -- and a fifth added to one of them.
  static Future<void> chooseWhatToPost(BuildContext context) async {
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
