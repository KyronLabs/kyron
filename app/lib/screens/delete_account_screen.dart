// lib/screens/delete_account_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../providers/account_provider.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';

/// Deleting the account, from Settings.
///
/// Two deliberate steps: this page says exactly what goes, and the button on
/// it asks once more. Not a typed word to confirm with -- that is a word in
/// English, in an app read in sixty-nine languages.
class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() =>
      _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  bool _deleting = false;

  Future<void> _confirm() async {
    // Ignored rather than disabled while it runs: a disabled filled button
    // draws as a pale smudge, and the spinner is what should show.
    if (_deleting) return;
    final l10n = AppLocalizations.of(context);
    final sure = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.ui(
                    'ui_delete_account_confirm_title', 'Delete your account?'),
                style: const TextStyle(
                  fontSize: TypographyTokens.fontSize6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: SpacingTokens.space8),
              Text(
                l10n.ui('ui_delete_account_confirm_detail',
                    "You won't be able to get any of it back."),
              ),
              const SizedBox(height: SpacingTokens.space24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: ElevatedButton(
                      key: const ValueKey('delete-account-final'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(l10n.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (sure == true) await _delete();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final overlay = Toast.anchor(context);
    final navigator = Navigator.of(context);
    setState(() => _deleting = true);
    try {
      await ref.read(accountRepositoryProvider).delete();
    } catch (error) {
      if (!mounted) return;
      setState(() => _deleting = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
      return;
    }

    // Gone on the server, so nothing here can be allowed to fail any more.
    await ref.read(authNotifierProvider.notifier).accountDeleted();
    // Back to the root, which sees nobody signed in and shows the welcome.
    navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    Toast.showOn(
      overlay,
      l10n.ui('ui_delete_account_done', 'Your account has been deleted.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    Widget point(IconData icon, String text) => Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon,
                  size: 20, color: scheme.onSurface.withValues(alpha: .7)),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(child: Text(text)),
            ],
          ),
        );

    return SettingsScaffold(
      title: l10n.ui('ui_delete_account', 'Delete account'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.ui(
              'ui_delete_account_intro',
              "This permanently deletes your Kyron account. It can't be undone.",
            ),
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: SpacingTokens.space20),
          point(
            Iconsax.document_text_copy,
            l10n.ui('ui_delete_account_posts',
                'Your profile, posts, replies, likes and reposts'),
          ),
          point(
            Iconsax.message_copy,
            l10n.ui(
              'ui_delete_account_messages',
              'Your messages, including the ones you sent to other people, '
                  'and the photos and voice notes in them',
            ),
          ),
          point(
            Iconsax.people_copy,
            l10n.ui('ui_delete_account_people',
                'Your followers, the people you follow, and your settings'),
          ),
          point(
            Iconsax.home_hashtag_copy,
            l10n.ui(
              'ui_delete_account_communities',
              'Communities you started go to their longest-serving moderator '
                  'or member. One with nobody else in it is closed.',
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          SizedBox(
            height: KyronTheme.buttonHeight,
            child: ElevatedButton(
              key: const ValueKey('delete-account-confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: _confirm,
              child: _deleting
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.ui('ui_delete_account', 'Delete account')),
            ),
          ),
        ],
      ),
    );
  }
}
