// lib/widgets/terms_gate.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../config/legal_links.dart';
import '../services/app_browser.dart';
import '../services/app_preferences.dart';

/// What somebody agrees to the first time they sign in.
///
/// Two links under a button is the usual way to do this, and it is the usual
/// way because it works for the company rather than the reader: nobody has
/// ever read a document they had to leave the screen to find. This asks once,
/// before the first sign-in, and says the three things that actually matter in
/// a sentence each -- with the documents themselves a tap away for anyone who
/// wants them.
///
/// Asked once, not every launch: [AppPreferences.readTermsAcceptedAt] records
/// when, so a returning reader goes straight through.
abstract final class TermsGate {
  /// Runs before [proceed], and only lets it happen if the terms are agreed.
  ///
  /// Answers true when the caller may carry on. A reader who closes the sheet
  /// has declined, and nothing happens -- which is the point of a gate rather
  /// than a notice.
  static Future<bool> require(
    BuildContext context, {
    required AppPreferences preferences,
  }) async {
    if (await preferences.readTermsAcceptedAt() != null) return true;
    if (!context.mounted) return false;

    final agreed = await _show(context);
    if (agreed != true) return false;

    await preferences.writeTermsAcceptedAt(DateTime.now());
    return true;
  }

  static Future<bool?> _show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      // Not dismissible by tapping away: closing it is a decision, and the
      // button that makes it is right there.
      builder: (context) => const _Sheet(),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    const side = EdgeInsets.symmetric(horizontal: SpacingTokens.space24);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        // The reading scrolls; the decision does not. A consent sheet whose
        // Agree button is below the fold is a sheet somebody can be stuck in,
        // and on a 600-pixel window this one's was.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: side,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Before you start',
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize6,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space8),
                  Text(
                    'The short version. The full documents are linked below '
                    'and are the ones that count.',
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      height: 1.45,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: side.copyWith(top: SpacingTokens.space20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _Point(
                      icon: Iconsax.profile_tick,
                      title: 'What you post is yours',
                      detail: 'Kyron does not claim ownership of anything you '
                          'write, record or upload. You can delete it, and '
                          'export your account.',
                    ),
                    const _Point(
                      icon: Iconsax.shield_tick,
                      title: 'What Kyron keeps',
                      detail:
                          'Your account, your posts, and what you tap on so '
                          'the feed can be ordered. Direct messages are '
                          'encrypted between devices and cannot be read on '
                          'the server.',
                    ),
                    const _Point(
                      icon: Iconsax.people,
                      title: 'How to behave',
                      detail: 'No harassment, no content involving minors, '
                          'nothing illegal. Accounts that do those things are '
                          'removed.',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _DocButton(
                            label: LegalLinks.termsTitle,
                            url: LegalLinks.terms,
                          ),
                        ),
                        const SizedBox(width: SpacingTokens.space12),
                        Expanded(
                          child: _DocButton(
                            label: LegalLinks.privacyTitle,
                            url: LegalLinks.privacy,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: side.copyWith(
                top: SpacingTokens.space16,
                bottom: SpacingTokens.space24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Agree and continue'),
                  ),
                  const SizedBox(height: SpacingTokens.space8),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Not now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Point extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _Point({
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            ),
            child: Icon(icon, size: 17, color: scheme.primary),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize3,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    height: 1.45,
                    color: scheme.onSurface.withValues(alpha: 0.65),
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

/// Opens one of the documents in Kyron's own browser, so reading it does not
/// mean losing the sheet.
class _DocButton extends StatelessWidget {
  final String label;
  final String url;

  const _DocButton({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => AppBrowser.open(context, url, title: label),
      icon: const Icon(Iconsax.document_text, size: 15),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: TypographyTokens.fontSize1),
      ),
    );
  }
}
