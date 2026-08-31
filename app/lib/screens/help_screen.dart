// lib/screens/help_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../config/legal_links.dart';
import '../routes.dart';

/// Where to go when something is wrong or unclear.
///
/// The drawer's "Help & Support" pushed /help, which no route answered, so it
/// opened the splash screen. This gathers the places that already exist --
/// support, feedback, the diagnostics under About -- in one list.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Help & Support'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _group(context, 'Get help'),
            ListTile(
              leading: const Icon(Iconsax.book, size: 20),
              title: const Text('Help Centre'),
              subtitle: const Text('Guides and answers to common questions'),
              trailing: const Icon(Iconsax.export_3, size: 16),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.webview,
                arguments: const {
                  'url': 'https://help.kyron.so',
                  'title': 'Help Centre',
                },
              ),
            ),
            ListTile(
              leading: const Icon(Iconsax.call, size: 20),
              title: const Text('Contact support'),
              subtitle: const Text('Reach a person'),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsContactSupport),
            ),
            ListTile(
              leading: const Icon(Iconsax.message_edit, size: 20),
              title: const Text('Send feedback'),
              subtitle: const Text('Tell us what is missing or broken'),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsFeedback),
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withValues(alpha: 0.1),
            ),
            _group(context, 'Something is broken'),
            ListTile(
              leading: const Icon(Iconsax.status_up, size: 20),
              title: const Text('Service status'),
              subtitle: const Text('Check whether Kyron is reachable'),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () => Navigator.pushNamed(context, Routes.aboutStatus),
            ),
            ListTile(
              leading: const Icon(Iconsax.warning_2, size: 20),
              title: const Text('Send error report'),
              subtitle: const Text('Share the app log with support'),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.aboutErrorReport),
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withValues(alpha: 0.1),
            ),
            _group(context, 'Policies'),
            ListTile(
              leading: const Icon(Iconsax.document_text, size: 20),
              title: const Text(LegalLinks.termsTitle),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () => Navigator.pushNamed(context, Routes.terms),
            ),
            ListTile(
              leading: const Icon(Iconsax.shield_tick, size: 20),
              title: const Text(LegalLinks.privacyTitle),
              trailing: const Icon(Iconsax.arrow_right_3, size: 18),
              onTap: () => Navigator.pushNamed(context, Routes.privacy),
            ),
            const SizedBox(height: SpacingTokens.space40),
          ],
        ),
      ),
    );
  }

  Widget _group(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(
          left: SpacingTokens.space20,
          top: SpacingTokens.space24,
          bottom: SpacingTokens.space8,
        ),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .5),
          ),
        ),
      );
}
