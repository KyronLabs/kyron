import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

/// Translating a post.
///
/// Kyron does not run a translation service, and pretending otherwise -- a
/// button that returns the same text, or one that silently sends the post to
/// a third party -- would be worse than saying so. This offers the post's text
/// and hands it to a translator the reader chooses, which is the honest
/// version until there is a service behind it.
class TranslationSheet {
  const TranslationSheet._();

  static Future<void> show(BuildContext context, String content) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _Sheet(content: content),
    );
  }
}

class _Sheet extends StatelessWidget {
  final String content;

  const _Sheet({required this.content});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space20,
          0,
          SpacingTokens.space20,
          SpacingTokens.space20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Translate', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              'Kyron does not translate posts itself yet. Open this text in a '
              'translator, or copy it and use whichever you prefer.',
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface.withValues(alpha: .7),
              ),
            ),
            const SizedBox(height: SpacingTokens.space16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SpacingTokens.space12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              ),
              child: Text(
                content,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: SpacingTokens.space16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: content));
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post text copied')),
                      );
                    },
                    icon: const Icon(Iconsax.copy_copy, size: 18),
                    label: const Text('Copy'),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      final uri = Uri.https(
                        'translate.google.com',
                        '/',
                        {
                          'sl': 'auto',
                          'tl': 'en',
                          'text': content,
                          'op': 'translate'
                        },
                      );
                      // Externally, so it is clear the text is leaving Kyron.
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                      if (context.mounted) Navigator.pop(context);
                    },
                    icon: const Icon(Iconsax.language_square_copy, size: 18),
                    label: const Text('Translate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
