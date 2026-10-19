import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/preferences_provider.dart';
import '../providers/push_provider.dart';
import '../services/app_preferences.dart';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import '../config/legal_links.dart';
import '../providers/feedback_provider.dart';
import '../routes.dart';
import '../services/app_browser.dart';
import '../repositories/feedback_repository.dart';
import '../utils/api_error_message.dart';
import '../services/app_info.dart';
import '../models/language.dart';
import '../widgets/hairline.dart';
import '../widgets/language_sheet.dart';
import '../widgets/action_button.dart';
import '../widgets/toast.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/empty_state.dart';

import '../l10n/app_localizations.dart';

/// Every screen in this file was `Center(child: Text(AppLocalizations.of(context).nameScreen))`.
///
/// Each is now either backed by something real -- Supabase for credentials,
/// stored preferences for the rest -- or says plainly that the feature does
/// not exist yet. A stub that looks like a working screen is worse than one
/// that admits what it is: it makes a missing feature look like a broken one.

class SettingsChangeEmailScreen extends ConsumerStatefulWidget {
  const SettingsChangeEmailScreen({super.key});

  @override
  ConsumerState<SettingsChangeEmailScreen> createState() =>
      _SettingsChangeEmailScreenState();
}

class _SettingsChangeEmailScreenState
    extends ConsumerState<SettingsChangeEmailScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _saving) return;
    setState(() => _saving = true);
    try {
      // Supabase mails a confirmation link to the new address; the change
      // does not take effect until it is followed, which is why the message
      // below says "sent" rather than "changed".
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(email: _controller.text.trim()),
      );
      if (!mounted) return;
      _tell('Check ${_controller.text.trim()} for a confirmation link.');
      Navigator.pop(context);
    } on AuthException catch (e) {
      if (mounted) _tell(e.message);
    } catch (_) {
      if (mounted) _tell('Could not change your email. Please try again.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _tell(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final current = Supabase.instance.client.auth.currentUser?.email;

    return SettingsScaffold(
      title: AppLocalizations.of(context).changeEmail,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (current != null) ...[
              Text(
                AppLocalizations.of(context).signedInAs,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: SpacingTokens.space4),
              Text(current, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: SpacingTokens.space24),
            ],
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).ui(
                      'ui_settings_subscreens_new_email_address_dab96e',
                      'New email address')),
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'Enter an email address.';
                if (!v.contains('@') || !v.contains('.')) {
                  return "That does not look like an email address.";
                }
                if (v == current) return 'That is already your email address.';
                return null;
              },
            ),
            const SizedBox(height: SpacingTokens.space24),
            FilledButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppLocalizations.of(context).sendConfirmation),
            ),
            const SizedBox(height: SpacingTokens.space12),
            Text(
              'Your address changes once you follow the link we send.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPasswordLoginScreen extends ConsumerStatefulWidget {
  const SettingsPasswordLoginScreen({super.key});

  @override
  ConsumerState<SettingsPasswordLoginScreen> createState() =>
      _SettingsPasswordLoginScreenState();
}

class _SettingsPasswordLoginScreenState
    extends ConsumerState<SettingsPasswordLoginScreen> {
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _obscure = true;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _saving) return;
    setState(() => _saving = true);
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: _password.text),
      );
      if (!mounted) return;
      _tell('Password updated.');
      Navigator.pop(context);
    } on AuthException catch (e) {
      if (mounted) _tell(e.message);
    } catch (_) {
      if (mounted) _tell('Could not update your password. Please try again.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _tell(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: AppLocalizations.of(context).literalpasswordLogin,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).ui(
                    'ui_settings_subscreens_new_password_88c1bf',
                    'New password'),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (value) {
                final v = value ?? '';
                // Supabase enforces its own minimum server-side; checking here
                // too means the failure arrives before a round trip.
                if (v.length < 8) {
                  return 'Use at least 8 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: SpacingTokens.space16),
            TextFormField(
              controller: _confirm,
              obscureText: _obscure,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).ui(
                      'ui_settings_subscreens_confirm_password_41d040',
                      'Confirm password')),
              validator: (value) =>
                  value == _password.text ? null : 'These do not match.',
            ),
            const SizedBox(height: SpacingTokens.space24),
            FilledButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppLocalizations.of(context).updatePassword),
            ),
            const SizedBox(height: SpacingTokens.space12),
            Text(
              'You stay signed in on this device. Other devices are signed out.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsFontSizeScreen extends ConsumerWidget {
  const SettingsFontSizeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);

    return SettingsScaffold(
      title: AppLocalizations.of(context).literalfontSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The sample is scaled directly so the effect is visible before
          // committing to it, rather than only after leaving the screen.
          Container(
            padding: const EdgeInsets.all(SpacingTokens.space16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: .4),
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            ),
            child: MediaQuery.withClampedTextScaling(
              minScaleFactor: prefs.textScale,
              maxScaleFactor: prefs.textScale,
              child: Text(
                'Kyron is a place to say something worth reading.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          for (var i = 0; i < AppPreferences.textScales.length; i++)
            RadioListTile<double>(
              value: AppPreferences.textScales[i],
              groupValue: prefs.textScale,
              onChanged: (value) => value == null
                  ? null
                  : ref.read(preferencesProvider.notifier).setTextScale(value),
              title: Text(AppPreferences.textScaleLabels[i]),
              contentPadding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}

class SettingsLanguageScreen extends ConsumerWidget {
  const SettingsLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);

    return SettingsScaffold(
      title: AppLocalizations.of(context).languages,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LanguageSection(
            title: AppLocalizations.of(context).literalappLanguage,
            detail: AppLocalizations.of(context).selectAppLanguage,
            value: prefs.language.nativeName,
            onTap: () async {
              final chosen = await LanguageSheet.pickOne(
                context,
                title: AppLocalizations.of(context).literalappLanguage,
                current: prefs.language,
              );
              if (chosen != null) await notifier.setLanguage(chosen);
            },
          ),
          // What this setting does today, said plainly. Flutter ships its own
          // translations for the parts of the interface it draws -- the back
          // button's tooltip, the text-selection menu, date pickers -- and
          // right-to-left languages lay the whole app out the other way round.
          // Kyron's own words are not translated yet. Saying so is the
          // difference between a setting that under-delivers and one that
          // lies.
          _Note(
            'Kyron\'s own words are still being translated, so most screens '
            'stay in English for now. What this changes today: the parts of '
            'the interface Flutter draws itself, dates and numbers, and the '
            'direction the app lays out in for right-to-left languages.',
          ),
          const SizedBox(height: SpacingTokens.space24),
          const Hairline(),
          const SizedBox(height: SpacingTokens.space24),
          _LanguageSection(
            title: AppLocalizations.of(context).literalprimaryLanguage,
            detail: AppLocalizations.of(context).selectPrimaryLanguage,
            value: prefs.primaryLanguage.nativeName,
            onTap: () async {
              final chosen = await LanguageSheet.pickOne(
                context,
                title: AppLocalizations.of(context).literalprimaryLanguage,
                current: prefs.primaryLanguage,
              );
              if (chosen != null) await notifier.setPrimaryLanguage(chosen);
            },
          ),
          // Kept rather than hidden, and labelled rather than left to imply.
          // There is no translation in Kyron yet -- no service, no endpoint,
          // nothing on a post that says what it is written in. A row that
          // offers to translate into Kiswahili and then does not is worse
          // than one that says it cannot yet.
          _Note(AppLocalizations.of(context).translationNotBuiltYet),
          const SizedBox(height: SpacingTokens.space24),
          const Hairline(),
          const SizedBox(height: SpacingTokens.space24),
          _SectionHeader(
            title: AppLocalizations.of(context).literalcontentLanguages,
            detail: AppLocalizations.of(context).selectContentLanguages,
          ),
          const SizedBox(height: SpacingTokens.space12),
          for (final language in prefs.contentLanguages)
            _ContentLanguageRow(
              language: language,
              onRemove: () => notifier.setContentLanguages([
                for (final l in prefs.contentLanguages)
                  if (l != language) l,
              ]),
            ),
          _AddLanguagesRow(
            onTap: () async {
              final chosen = await LanguageSheet.pickMany(
                context,
                title: AppLocalizations.of(context).literalcontentLanguages,
                current: prefs.contentLanguages,
              );
              if (chosen != null) await notifier.setContentLanguages(chosen);
            },
          ),
          _Note(AppLocalizations.of(context).contentLanguagesNotFilteringYet),
        ],
      ),
    );
  }
}

/// A titled section whose value opens a sheet.
class _LanguageSection extends StatelessWidget {
  const _LanguageSection({
    required this.title,
    required this.detail,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String detail;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(title: title, detail: detail),
        const SizedBox(height: SpacingTokens.space12),
        Material(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space16,
                vertical: SpacingTokens.space16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize3,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  // Points both ways: this opens a list of alternatives
                  // rather than going somewhere.
                  Icon(
                    Iconsax.arrow_3,
                    size: 18,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  _SectionHeader({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize4,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: SpacingTokens.space4),
        Text(
          detail,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize2,
            color: scheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

/// One chosen content language, with the way back out.
class _ContentLanguageRow extends StatelessWidget {
  const _ContentLanguageRow({required this.language, required this.onRemove});

  final Language language;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        ),
        child: Row(
          children: [
            Icon(Iconsax.tick_square, size: 20, color: scheme.primary),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Text(
                language.nativeName,
                textDirection: language.rtl ? TextDirection.rtl : null,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  color: scheme.onSurface,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Iconsax.close_circle_copy, size: 18),
              tooltip: AppLocalizations.of(context)
                  .literalremoveLanguageEnglishname(language),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddLanguagesRow extends StatelessWidget {
  const _AddLanguagesRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space16,
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.add,
                size: 20,
                color: scheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Text(
                AppLocalizations.of(context).addMoreLanguages,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsNotificationsScreen extends ConsumerWidget {
  const SettingsNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesProvider);
    final notifier = ref.read(preferencesProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return SettingsScaffold(
      title: l10n.notifications,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            key: const ValueKey('push-switch'),
            value: prefs.pushEnabled,
            // Registers this phone, or takes it off the list. The switch
            // used to save a preference that nothing read: off, and the
            // notifications kept coming.
            onChanged: (on) async {
              await notifier.setPushEnabled(on);
              final registrar = ref.read(pushRegistrarProvider);
              await (on ? registrar.start() : registrar.stop());
            },
            title: Text(l10n.pushNotifications),
            subtitle: Text(l10n.repliesFollowsMentions),
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: prefs.emailEnabled,
            onChanged: notifier.setEmailEnabled,
            title: Text(l10n.emailNotifications),
            subtitle: Text(l10n.securityAlerts),
            contentPadding: EdgeInsets.zero,
          ),
          if (prefs.pushEnabled) ...[
            const SizedBox(height: SpacingTokens.space8),
            const _PushTest(),
          ],
        ],
      ),
    );
  }
}

/// Sends a notification to this account, and says plainly which part is not
/// working if one does not come.
///
/// Push fails in three places, all silently: the server's key, this phone's
/// registration, and Google accepting the pair. "I never get notifications"
/// needs to know which.
class _PushTest extends ConsumerStatefulWidget {
  const _PushTest();

  @override
  ConsumerState<_PushTest> createState() => _PushTestState();
}

class _PushTestState extends ConsumerState<_PushTest> {
  bool _sending = false;

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _sending = true);
    String said;
    try {
      // Registered first, so a phone that never got as far as the server
      // gets there now rather than failing the test for it.
      await ref.read(pushRegistrarProvider).start();
      final result = await ref.read(devicesRepositoryProvider).test();
      said = !result.configured
          ? l10n.ui(
              'ui_push_test_off',
              "Kyron's server is not set up to send notifications yet, so "
                  'none can arrive. This is on our side, not your phone.',
            )
          : result.devices == 0
              ? l10n.ui(
                  'ui_push_test_no_device',
                  'This phone is not registered for notifications. Check '
                      "that notifications are allowed for Kyron in your phone's "
                      'settings, then try again.',
                )
              : result.delivered == 0
                  ? l10n.ui(
                      'ui_push_test_rejected',
                      'The notification could not be delivered to this '
                          'phone. Try again in a minute.',
                    )
                  : l10n.ui(
                      'ui_push_test_sent',
                      'Sent. It should arrive in a few seconds.',
                    );
    } catch (error) {
      said = describeApiError(error, sessionIsLive: true);
    }
    if (!mounted) return;
    setState(() => _sending = false);
    Toast.show(context, said, stay: const Duration(seconds: 6));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      key: const ValueKey('push-test'),
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Iconsax.notification_bing_copy),
      title: Text(l10n.ui('ui_push_test', 'Send a test notification')),
      trailing: _sending
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : null,
      onTap: _sending ? null : _send,
    );
  }
}

/// How to reach the Kyron team.
///
/// This said to "open an issue" and linked nowhere, and there is no issue
/// tracker anybody using the app could be expected to find. Now each way in
/// is one that arrives: the private inbox in the app for questions and
/// problems, the log for crashes, and, for what should not wait on the app,
/// the two addresses the published privacy policy names.
class SettingsContactSupportScreen extends StatelessWidget {
  const SettingsContactSupportScreen({super.key});

  /// Opens a mail to [address], or copies it when no mail app will.
  ///
  /// Plenty of phones have no mail app set up, and an address that nothing
  /// happens on reads as a broken button.
  static Future<void> _write(BuildContext context, String address) async {
    final opened = await AppBrowser.leave(Uri(scheme: 'mailto', path: address));
    if (opened || !context.mounted) return;
    await Clipboard.setData(ClipboardData(text: address));
    if (context.mounted) {
      Toast.show(context, 'No mail app opened. $address is copied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);

    Widget row({
      required IconData icon,
      required String title,
      required String detail,
      required VoidCallback onTap,
      bool leaves = false,
    }) =>
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, size: 20),
          title: Text(title),
          subtitle: Text(detail, style: TextStyle(color: faint)),
          trailing: Icon(
            leaves ? Iconsax.export_3_copy : Iconsax.arrow_right_3_copy,
            size: leaves ? 16 : 18,
          ),
          onTap: onTap,
        );

    Widget group(String title) => Padding(
          padding: const EdgeInsets.only(
            top: SpacingTokens.space16,
            bottom: SpacingTokens.space4,
          ),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: faint,
            ),
          ),
        );

    return SettingsScaffold(
      title: l10n.contactSupport,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Write to the Kyron team from here. It reaches us privately, with '
            'your account, and we answer at the email address on it.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          group('In the app'),
          row(
            icon: Iconsax.message_question_copy,
            title: 'Ask a question',
            detail: 'About your account, or how something works',
            onTap: () => Navigator.pushNamed(
              context,
              Routes.settingsFeedback,
              arguments: FeedbackKind.question,
            ),
          ),
          row(
            icon: Iconsax.danger_copy,
            title: 'Report a problem',
            detail: 'Something is broken or not doing what it should',
            onTap: () => Navigator.pushNamed(
              context,
              Routes.settingsFeedback,
              arguments: FeedbackKind.bug,
            ),
          ),
          row(
            icon: Iconsax.warning_2_copy,
            title: l10n.sendErrorReport,
            detail: 'If Kyron crashed: sends the app\'s log with it',
            onTap: () => Navigator.pushNamed(context, Routes.aboutErrorReport),
          ),
          row(
            icon: Iconsax.status_up_copy,
            title: l10n.serviceStatus,
            detail: 'Whether Kyron is down for everybody, or just you',
            onTap: () => Navigator.pushNamed(context, Routes.aboutStatus),
          ),
          const SizedBox(height: SpacingTokens.space8),
          const Hairline(),
          group('By email'),
          row(
            icon: Iconsax.shield_cross_copy,
            title: 'Safety and abuse',
            detail: SupportLinks.abuse,
            leaves: true,
            onTap: () => _write(context, SupportLinks.abuse),
          ),
          row(
            icon: Iconsax.lock_copy,
            title: 'Privacy and your data',
            detail: SupportLinks.privacy,
            leaves: true,
            onTap: () => _write(context, SupportLinks.privacy),
          ),
          const SizedBox(height: SpacingTokens.space12),
          const _Note(
            'To report a post or an account, use the menu on it: that tells '
            'us exactly which one you mean.',
          ),
        ],
      ),
    );
  }
}

/// Reporting a bug or asking for something, from inside the app.
///
/// What is written goes to the Kyron team and nobody else, with the account
/// that sent it so somebody can follow up. It used to be filed as an issue on
/// the public repository, and in practice was not filed at all: the token
/// that needed was never set, so this screen said "Feedback cannot be sent
/// right now" to everybody.
///
/// It still asks the server first, so nobody writes three paragraphs into a
/// box that cannot send them -- which now only happens when the server cannot
/// be reached at all.
class SettingsFeedbackScreen extends ConsumerStatefulWidget {
  const SettingsFeedbackScreen({super.key, this.kind = FeedbackKind.bug});

  /// Which kind the form starts on. Contact support opens it on a question.
  final FeedbackKind kind;

  @override
  ConsumerState<SettingsFeedbackScreen> createState() =>
      _SettingsFeedbackScreenState();
}

class _SettingsFeedbackScreenState
    extends ConsumerState<SettingsFeedbackScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  late FeedbackKind _kind = widget.kind;
  bool _sending = false;
  String? _error;

  /// Null while the question is still out.
  bool? _available;

  /// Which build this is, for the issue. Null if it could not be read.
  ///
  /// Fetched while the form is being filled in rather than when Send is
  /// pressed: it is a platform call, it is context rather than the report,
  /// and nobody's three paragraphs should be waiting behind it.
  String? _version;

  @override
  void initState() {
    super.initState();
    _askIfItCanBeSent();
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _askIfItCanBeSent() async {
    unawaited(_readVersion());
    if (_available != null) setState(() => _available = null);
    try {
      final can = await ref.read(feedbackRepositoryProvider).isAvailable();
      if (mounted) setState(() => _available = can);
    } catch (_) {
      // Treated as "not now" rather than as an error: the difference to
      // somebody standing here is nothing, and a red screen over a status
      // check reads as though their report failed.
      if (mounted) setState(() => _available = false);
    }
  }

  /// Best effort, and never in the way.
  ///
  /// A report filed without a version number is worth less to whoever reads
  /// it; a report not filed at all because the version could not be read is
  /// worth nothing to anybody.
  Future<void> _readVersion() async {
    try {
      final info = await AppInfo.load();
      if (mounted) _version = info.display;
    } on Object {
      // Left null. The issue still says which platform it came from.
    }
  }

  bool get _canSend =>
      !_sending &&
      _title.text.trim().length >= 3 &&
      _body.text.trim().length >= 10;

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });

    try {
      final filed = await ref.read(feedbackRepositoryProvider).send(
            kind: _kind,
            title: _title.text.trim(),
            body: _body.text.trim(),
            appVersion: _version,
            platform: defaultTargetPlatform.name,
          );
      if (!mounted) return;
      setState(() => _sending = false);
      Toast.show(
        context,
        filed.number > 0
            ? 'Sent -- thank you. It is report #${filed.number}.'
            : 'Sent -- thank you.',
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(error);
      });
    }
  }

  /// Said about a question, the form's words are about a bug: "what
  /// happened", "what you expected". So the long field's label and hint
  /// follow the kind chosen.
  ({String label, String hint, String title}) _words(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (_kind) {
      FeedbackKind.idea => (
          label: 'What would help',
          hint: 'What you would like, and what it would let you do.',
          title: 'Let me pin a post to my profile',
        ),
      FeedbackKind.question => (
          label: 'Your question',
          hint: 'What you are trying to do, and where you are stuck.',
          title: 'How do I mute a word?',
        ),
      _ => (
          label: l10n.ui(
              'ui_settings_subscreens_what_happened_977dd8', 'What happened'),
          hint: '${l10n.literalwhatYouDidWhatYouExpectedWhatHappened}instead.',
          title: l10n.theComposerNoPostButton,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = widget.kind == FeedbackKind.question
        ? AppLocalizations.of(context).contactSupport
        : AppLocalizations.of(context).literalsendFeedback;
    final words = _words(context);

    if (_available == null) {
      return SettingsScaffold(
        title: title,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_available == false) {
      return SettingsScaffold(
        title: title,
        child: EmptyState(
          art: EmptyArt.messages,
          title:
              AppLocalizations.of(context).literalfeedbackCannotBeSentRightNow,
          detail: 'Kyron could not be reached. Check your connection and try '
              'again -- nothing has been written yet, so nothing is lost.',
          action: AppLocalizations.of(context).ui('ui_try_again', 'Try again'),
          onAction: _askIfItCanBeSent,
        ),
      );
    }

    return SettingsScaffold(
      title: title,
      // A Column, not a ListView: SettingsScaffold already puts its child in a
      // scroll view, and a second one inside it is a vertical viewport given
      // unbounded height -- which does not lay out at all.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drawn rather than hidden behind a menu: there are only three.
          Row(
            children: [
              for (final kind in FeedbackKind.offered) ...[
                Expanded(
                  child: ActionButton(
                    label: kind.label,
                    compact: true,
                    kind: _kind == kind
                        ? ActionButtonKind.primary
                        : ActionButtonKind.outlined,
                    onPressed: () => setState(() => _kind = kind),
                  ),
                ),
                if (kind != FeedbackKind.offered.last)
                  const SizedBox(width: SpacingTokens.space8),
              ],
            ],
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _title,
            maxLength: 120,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).ui(
                  'ui_settings_subscreens_in_one_line_06bdaf', 'In one line'),
              hintText: words.title,
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          TextField(
            controller: _body,
            maxLines: 8,
            maxLength: 4000,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: words.label,
              alignLabelWithHint: true,
              hintText: words.hint,
            ),
          ),
          const _Note(
            'Only the Kyron team reads this. It is sent with your account, so '
            'we can answer by email, and with which version of the app you '
            'are running. Deleting your account deletes it too.',
          ),
          if (_error != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            Text(
              _error!,
              style: TextStyle(
                color: scheme.error,
                fontSize: TypographyTokens.fontSize2,
              ),
            ),
          ],
          const SizedBox(height: SpacingTokens.space16),
          ActionButton(
            label: AppLocalizations.of(context).send,
            expand: true,
            busy: _sending,
            onPressed: _canSend ? _send : null,
          ),
        ],
      ),
    );
  }
}

/// A quiet note under a group of controls.
class _Note extends StatelessWidget {
  final String text;

  const _Note(this.text);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.info_circle_copy,
            size: 18,
            color: scheme.onSurface.withValues(alpha: .6),
          ),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

/// For a screen whose feature does not exist on the server yet.
