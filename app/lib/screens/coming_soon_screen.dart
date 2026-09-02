// lib/screens/coming_soon_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../routes.dart';

/// A post type that is announced but not built.
///
/// AR lenses, polls and audio spaces are all on the create menu, and none of
/// them exists: tapping them used to close the sheet and do nothing at all,
/// which reads as a broken button rather than an unfinished feature. This says
/// which it is, and offers the one composer that does work.
class ComingSoonScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String detail;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.detail,
  });

  const ComingSoonScreen.arLens({super.key})
      : title = 'AR Lens',
        icon = Iconsax.camera_copy,
        detail =
            'Recording and publishing AR lenses is still being built. Nothing '
                'you capture would be saved yet, so the camera stays closed.';

  const ComingSoonScreen.poll({super.key})
      : title = 'Poll',
        icon = Iconsax.chart_copy,
        detail =
            'Polls need somewhere to keep the options and count the votes. '
                'That is not in place yet, so a poll posted today would lose '
                'every answer.';

  const ComingSoonScreen.live({super.key})
      : title = 'Go live',
        icon = Iconsax.video_copy,
        detail = 'Going live needs a media server Kyron does not run yet. '
            'Starting a broadcast now would put you in a room nobody could '
            'join. Recording a voice post works today.';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
                  ),
                  child: Icon(icon, size: 34, color: scheme.primary),
                ),
                const SizedBox(height: SpacingTokens.space20),
                Text(
                  '$title is not ready yet',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: SpacingTokens.space8),
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: .7),
                      ),
                ),
                const SizedBox(height: SpacingTokens.space24),
                FilledButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    Routes.composer,
                  ),
                  icon: const Icon(Iconsax.note_text_copy, size: 18),
                  label: const Text('Write a text post instead'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
