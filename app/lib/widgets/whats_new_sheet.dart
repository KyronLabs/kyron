// lib/widgets/whats_new_sheet.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../services/home_prompts.dart';
import 'action_button.dart';
import 'app_sheet.dart';
import 'hairline.dart';

/// What changed in the update just opened: each version's headlines and the
/// sentence after each, newest first.
///
/// Shown once per update, by [HomePrompts]. During a test that ships most
/// days, it is how testers see that what they said was heard.
abstract final class WhatsNewSheet {
  static Future<void> show(
    BuildContext context,
    List<WhatsNewVersion> versions,
  ) =>
      showAppSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _Sheet(versions: versions),
      );
}

class _Sheet extends StatelessWidget {
  final List<WhatsNewVersion> versions;

  const _Sheet({required this.versions});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final many = versions.length > 1;

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space20,
                SpacingTokens.space8,
                SpacingTokens.space20,
                SpacingTokens.space12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.ui('ui_whats_new', "What's new"),
                    style: const TextStyle(
                      fontSize: TypographyTokens.fontSize5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space2),
                  Text(
                    l10n
                        .ui('ui_whats_new_version', r'Kyron $version')
                        .replaceAll(r'$version', versions.first.version),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      color: scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
            const RuleLine(),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space20,
                  SpacingTokens.space16,
                  SpacingTokens.space20,
                  SpacingTokens.space8,
                ),
                children: [
                  for (final (i, version) in versions.indexed) ...[
                    if (many) ...[
                      if (i > 0) const SizedBox(height: SpacingTokens.space8),
                      Text(
                        version.version,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space12),
                    ],
                    for (final item in version.items) _Item(item: item),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingTokens.space20,
                SpacingTokens.space8,
                SpacingTokens.space20,
                SpacingTokens.space16,
              ),
              child: ActionButton(
                key: const ValueKey('whats-new-done'),
                label: l10n.ui('ui_got_it', 'Got it'),
                expand: true,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final ({String title, String detail}) item;

  const _Item({required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child:
                Icon(Iconsax.magic_star_copy, size: 18, color: scheme.primary),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: TypographyTokens.fontSize3,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                if (item.detail.isNotEmpty) ...[
                  const SizedBox(height: SpacingTokens.space2),
                  Text(
                    item.detail,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      height: 1.35,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
