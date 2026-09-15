import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_language.dart';
import '../providers/preferences_provider.dart';
import '../services/app_preferences.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import '../providers/feedback_provider.dart';
import '../repositories/feedback_repository.dart';
import '../utils/api_error_message.dart';
import '../services/app_info.dart';
import '../widgets/action_button.dart';
import '../widgets/toast.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/empty_state.dart';

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
                  icon: Icon(
                      _obscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy),
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

/// Reporting a bug or asking for something, from inside the app.
///
/// This screen used to say "Feedback has nowhere to go yet" and mean it: there
/// was no endpoint, so a form would have accepted what somebody wrote and
/// dropped it. There is one now, and it files an issue on the repository.
///
/// Two things it is careful about. It asks the server whether reports can be
/// filed *before* offering the form, so nobody writes three paragraphs into a
/// box that cannot send them. And it says plainly that what they write will be
/// public, because it will be: an issue on a public repository is readable by
/// anybody.
class SettingsFeedbackScreen extends ConsumerStatefulWidget {
  const SettingsFeedbackScreen({super.key});

  @override
  ConsumerState<SettingsFeedbackScreen> createState() =>
      _SettingsFeedbackScreenState();
}

class _SettingsFeedbackScreenState
    extends ConsumerState<SettingsFeedbackScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  FeedbackKind _kind = FeedbackKind.bug;
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
      Toast.show(context, 'Sent. It is report #${filed.number}.');
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (_available == null) {
      return const SettingsScaffold(
        title: 'Send Feedback',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_available == false) {
      return const SettingsScaffold(
        title: 'Send Feedback',
        child: EmptyState(
          art: EmptyArt.messages,
          title: 'Feedback cannot be sent right now',
          detail:
              'This build cannot reach the place reports are filed. Said here '
              'rather than in a form, so nothing you write is taken and lost.',
        ),
      );
    }

    return SettingsScaffold(
      title: 'Send Feedback',
      // A Column, not a ListView: SettingsScaffold already puts its child in a
      // scroll view, and a second one inside it is a vertical viewport given
      // unbounded height -- which does not lay out at all.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Two, drawn rather than hidden behind a menu: there are only two.
          Row(
            children: [
              for (final kind in FeedbackKind.values) ...[
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
                if (kind != FeedbackKind.values.last)
                  const SizedBox(width: SpacingTokens.space8),
              ],
            ],
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _title,
            maxLength: 120,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'In one line',
              hintText: 'The composer has no Post button',
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          TextField(
            controller: _body,
            maxLines: 8,
            maxLength: 4000,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'What happened',
              alignLabelWithHint: true,
              hintText: 'What you did, what you expected, what happened '
                  'instead.',
            ),
          ),
          const _Note(
            'This is filed as an issue on Kyron\'s public repository, so what '
            'you write here can be read by anybody. Your name, handle and '
            'email are not attached to it -- only the words above and which '
            'version of the app you are running.',
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
            label: 'Send',
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
          Icon(Iconsax.info_circle_copy,
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
