// lib/screens/delete_account_screen.dart
import 'package:dio/dio.dart';
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
      try {
        await ref.read(accountRepositoryProvider).delete();
      } on DioException catch (error) {
        if (!_needsRecentSignIn(error)) rethrow;
        // The sign-in behind this session is too old to delete with: ask
        // the person to prove it is them, then try once more.
        if (!mounted) return;
        final confirmed = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          builder: (_) => const _ConfirmItsYouSheet(),
        );
        if (confirmed != true) {
          if (mounted) setState(() => _deleting = false);
          return;
        }
        await ref.read(accountRepositoryProvider).delete();
      }
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

bool _needsRecentSignIn(DioException error) {
  final data = error.response?.data;
  return error.response?.statusCode == 403 &&
      data is Map &&
      data['code'] == 'RECENT_SIGN_IN_REQUIRED';
}

/// Signs the person in again, in place, before the account is deleted.
///
/// A session lasts weeks; an unlocked phone should not be enough to erase
/// somebody. Password accounts type it again, Google accounts go back
/// through Google. Pops true once the sign-in is fresh.
class _ConfirmItsYouSheet extends ConsumerStatefulWidget {
  const _ConfirmItsYouSheet();

  @override
  ConsumerState<_ConfirmItsYouSheet> createState() =>
      _ConfirmItsYouSheetState();
}

class _ConfirmItsYouSheetState extends ConsumerState<_ConfirmItsYouSheet> {
  final _password = TextEditingController();
  bool _busy = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _go(Future<void> Function() confirm) async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await confirm();
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = l10n.ui('ui_confirm_its_you_failed',
            "That didn't work. Check it and try again.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final repo = ref.read(authRepositoryProvider);
    final withPassword = repo.hasPassword;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SpacingTokens.space20,
          SpacingTokens.space20,
          SpacingTokens.space20,
          SpacingTokens.space20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.ui('ui_confirm_its_you_title', "Confirm it's you"),
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              withPassword
                  ? l10n.ui('ui_confirm_its_you_password',
                      'Enter your password to delete your account.')
                  : l10n.ui('ui_confirm_its_you_google',
                      'Sign in with Google again to delete your account.'),
            ),
            const SizedBox(height: SpacingTokens.space20),
            if (withPassword) ...[
              TextField(
                key: const ValueKey('confirm-password'),
                controller: _password,
                obscureText: _obscure,
                autofocus: true,
                enabled: !_busy,
                onSubmitted: (_) =>
                    _go(() => repo.confirmPassword(_password.text)),
                decoration: InputDecoration(
                  labelText: l10n.ui('ui_password', 'Password'),
                  errorText: _error,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: SpacingTokens.space16),
            ] else if (_error != null) ...[
              Text(_error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
              const SizedBox(height: SpacingTokens.space16),
            ],
            SizedBox(
              height: 40,
              child: FilledButton(
                key: const ValueKey('confirm-its-you'),
                style: FilledButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                onPressed: () => _go(withPassword
                    ? () => repo.confirmPassword(_password.text)
                    : repo.confirmWithGoogle),
                child: _busy
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(withPassword
                        ? l10n.ui('ui_confirm_its_you_continue', 'Continue')
                        : l10n.ui(
                            'ui_continue_with_google', 'Continue with Google')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
