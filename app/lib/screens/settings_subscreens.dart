import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_language.dart';
import '../providers/preferences_provider.dart';
import '../services/app_preferences.dart';
import '../widgets/settings_scaffold.dart';

/// Every screen in this file was `Center(child: Text('<name> Screen'))`.
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
      title: 'Change Email',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (current != null) ...[
              Text('Signed in as',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: SpacingTokens.space4),
              Text(current, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: SpacingTokens.space24),
            ],
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'New email address',
              ),
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
                  : const Text('Send confirmation'),
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
      title: 'Password & Login',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'New password',
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Iconsax.eye_slash : Iconsax.eye),
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
              decoration: const InputDecoration(labelText: 'Confirm password'),
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
                  : const Text('Update password'),
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
      title: 'Font Size',
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
    final selected = ref.watch(preferencesProvider).language;

    return SettingsScaffold(
      title: 'Language',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final language in AppLanguage.values)
            RadioListTile<AppLanguage>(
              value: language,
              groupValue: selected,
              onChanged: (value) => value == null
                  ? null
                  : ref.read(preferencesProvider.notifier).setLanguage(value),
              title: Text(language.nativeName),
              subtitle: language.nativeName == language.englishName
                  ? null
                  : Text(language.englishName),
              contentPadding: EdgeInsets.zero,
            ),
          const SizedBox(height: SpacingTokens.space16),
          Text(
            'Your choice is remembered on this device and used on the sign-in '
            'screen too. Translations are still being written, so most of '
            'Kyron stays in English for now.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
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

    return SettingsScaffold(
      title: 'Notifications',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            value: prefs.pushEnabled,
            onChanged: notifier.setPushEnabled,
            title: const Text('Push notifications'),
            subtitle: const Text('Replies, follows and mentions'),
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: prefs.emailEnabled,
            onChanged: notifier.setEmailEnabled,
            title: const Text('Email notifications'),
            subtitle: const Text('Security alerts and account changes'),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: SpacingTokens.space16),
          // Said plainly rather than implied. These switches record a
          // preference; nothing sends anything yet, and a switch that looks
          // live but is not is how people end up believing they turned
          // something off.
          const _Note(
            'Kyron does not send notifications yet. These choices are saved '
            'and will apply as soon as it does.',
          ),
        ],
      ),
    );
  }
}

class SettingsBlockedUsersScreen extends StatelessWidget {
  const SettingsBlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScaffold(
      title: 'Blocked Users',
      child: _Unavailable(
        icon: Iconsax.user_minus,
        title: 'Blocking is not available yet',
        detail:
            'There is nothing behind this screen on the server, so an empty '
            'list here would not mean you have blocked nobody -- it would mean '
            'Kyron cannot tell. It will list them once blocking exists.',
      ),
    );
  }
}

class SettingsContactSupportScreen extends StatelessWidget {
  const SettingsContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScaffold(
      title: 'Help & Support',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Getting help',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            'Kyron is early, and the fastest way to reach someone who can '
            'actually fix a problem is to open an issue. Include what you '
            'were doing and what happened instead.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SpacingTokens.space20),
          const _Note(
            'There is no in-app support inbox yet, so this screen points at '
            'the place that is actually monitored rather than at a form that '
            'goes nowhere.',
          ),
        ],
      ),
    );
  }
}

class SettingsFeedbackScreen extends StatelessWidget {
  const SettingsFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsScaffold(
      title: 'Send Feedback',
      child: _Unavailable(
        icon: Iconsax.message_question,
        title: 'Feedback has nowhere to go yet',
        detail:
            'A form here would accept what you write and drop it -- there is '
            'no endpoint behind it. Rather than take feedback and lose it, '
            'this screen waits until there is somewhere to put it.',
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
          Icon(Iconsax.info_circle,
              size: 18, color: scheme.onSurface.withValues(alpha: .6)),
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
class _Unavailable extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _Unavailable({
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: SpacingTokens.space40),
        Icon(icon, size: 44, color: scheme.onSurface.withValues(alpha: .35)),
        const SizedBox(height: SpacingTokens.space16),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: scheme.onSurface.withValues(alpha: .7)),
        ),
      ],
    );
  }
}
