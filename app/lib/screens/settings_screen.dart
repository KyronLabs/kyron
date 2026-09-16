import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/auth_provider.dart';
import '../providers/identity_provider.dart';
import '../providers/current_user_provider.dart';
import '../models/app_theme.dart';
import '../providers/preferences_provider.dart';
import '../utils/api_error_message.dart';
import '../services/app_preferences.dart';
import '../widgets/action_sheet.dart';
import '../widgets/kyron_toggle.dart';
import '../routes.dart';

import 'dart:async';

import '../config/legal_links.dart';
import '../services/app_browser.dart';
import '../widgets/kyron_app_bar.dart';

import '../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  /// The signed-in account, read from the live Supabase session.
  ///
  /// These rows used to read "@alice" and "alice@kyron.so" -- hard-coded, so
  /// the settings screen showed the same person to everyone, and "Log Out"
  /// named an account nobody was signed in as.
  String get _email =>
      Supabase.instance.client.auth.currentUser?.email ?? 'Not signed in';

  String get _handle {
    final metadata =
        Supabase.instance.client.auth.currentUser?.userMetadata ?? const {};
    final username = (metadata['username'] as String?)?.trim();
    if (username != null && username.isNotEmpty) return '@$username';
    // No placeholder handle: "@user" for everyone is what made a real account
    // indistinguishable from filler elsewhere in the app.
    final email = Supabase.instance.client.auth.currentUser?.email;
    return email ?? 'Your account';
  }

  bool _loggingOut = false;

  /// Enough of a DID to recognise, in the width a settings row allows.
  static String _shortDid(String did) =>
      did.length <= 24 ? did : '${did.substring(0, 21)}…';

  /// Offers the palettes and applies whichever is chosen.
  ///
  /// A sheet rather than a switch. A switch cannot say "whatever the phone is
  /// set to", which is what most people want and what the app did before this
  /// setting existed; and the design system defines three palettes, not two.
  Future<void> _chooseTheme() async {
    final current = ref.read(preferencesProvider).theme;
    final chosen = await ActionSheet.show<AppTheme>(
      context,
      title: 'Appearance',
      actions: [
        for (final theme in AppTheme.values)
          SheetAction(
            value: theme,
            label: theme.label,
            detail: theme.detail,
            selected: theme == current,
            icon: switch (theme) {
              AppTheme.system => Iconsax.mobile_copy,
              AppTheme.light => Iconsax.sun_1_copy,
              AppTheme.dark => Iconsax.moon_copy,
              AppTheme.dim => Iconsax.lamp_on_copy,
            },
          ),
      ],
    );
    if (chosen == null) return;
    await ref.read(preferencesProvider.notifier).setTheme(chosen);
  }

  void _showTooltip(String message) {
    // Long-press help tooltip (Progressive-Disclosure)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _groupHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 24, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _settingsRow({
    required IconData icon,
    required String label,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    String? helpText,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: helpText != null ? () => _showTooltip(helpText) : null,
      // No horizontal drag handler here. There used to be one, announcing
      // "Reset <row> to default" in a snackbar and resetting nothing -- on
      // every row, including the ones that only navigate. It also swallowed
      // the swipe that pops the screen.
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        label: label,
        value: subtitle,
        // A floor, not a ceiling. This was a fixed `height: 56`, which is
        // enough for a label and a subtitle at one text size and not at
        // others -- the account row, whose subtitle is a whole email address,
        // shipped with Flutter's yellow-and-black "BOTTOM OVERFLOWED BY 4.0
        // PIXELS" banner drawn across it in a release build. A row that
        // cannot grow is wrong for every long value, not just that one.
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                // Icon: 24px, left-aligned, 8px padding
                Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface
                      .withOpacity(0.8),
                ),
                const SizedBox(width: 16),
                // Label + Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize4,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: 'SF Pro Rounded',
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          // Cut with an ellipsis rather than mid-character.
                          // The account row's subtitle is an email address, and
                          // a long one was being sliced off at whatever pixel
                          // the row ran out at.
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            color: Theme.of(context).colorScheme.onSurface
                                .withOpacity(0.6),
                            fontFamily: 'SF Pro Rounded',
                          ),
                        ),
                    ],
                  ),
                ),
                // Trailing: right-aligned, 16px padding, 48×48 hit-box
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Signs out, then sends the app back through the root gate.
  ///
  /// The confirm button used to pop the sheet and navigate to the welcome
  /// screen, under a comment reading "Perform logout and navigate to welcome"
  /// -- it did only the second half. Nothing ever called signOut, so the
  /// Supabase session survived untouched and the next launch restored it: you
  /// appeared to log out, and came back signed in.
  Future<void> _performLogout() async {
    Navigator.pop(context);
    setState(() => _loggingOut = true);
    try {
      await ref.read(authNotifierProvider.notifier).logout();
      if (!mounted) return;
      // Back to the root rather than straight to welcome, so RootScreen makes
      // the call from the auth state it can now see.
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _loggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not sign out: ${describeApiError(e)}')),
      );
    }
  }

  void _showLogoutConfirmation() {
    final avatarUrl = ref.read(currentUserProvider).value?.avatarUrl;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Who is actually being signed out. This asked about "@alice" for
            // everyone, so it named an account nobody was signed in as.
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  foregroundImage: avatarUrl == null
                      ? null
                      : NetworkImage(avatarUrl),
                  child: Icon(
                    Iconsax.user_copy,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface
                        .withValues(alpha: .5),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _handle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              AppLocalizations.of(context).logOutQuestion,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You will need to sign in again to get back to your account.",
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context).cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _performLogout,
                    child: Text(AppLocalizations.of(context).logOut),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.background,
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: TypographyTokens.fontSize5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Account Group (3 items)
            _groupHeader('Account'),
            _settingsRow(
              icon: Iconsax.user_copy,
              label: _handle,
              subtitle: _email,
              trailing: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.settingsChangeEmail),
                child: Text(AppLocalizations.of(context).changeEmail),
              ),
              helpText: 'Your profile and contact information',
            ),
            // The real one, and now a real identifier rather than a column
            // nobody wrote to. This row showed "did:plc:abc…" and copied
            // "did:plc:abcdef1234567890abcdef12" -- the same invented
            // identifier for everyone, to anyone who tapped Copy -- and then
            // showed "No DID yet" to everybody forever.
            //
            // Read from the vault rather than from the profile: the profile
            // carries whatever the server last sent, and the identifier is
            // established by this device after sign-in.
            Consumer(
              builder: (context, ref, _) {
                final did = ref.watch(myDidProvider).asData?.value;
                return _settingsRow(
                  icon: Iconsax.document_copy,
                  label: did == null
                      ? AppLocalizations.of(context).literalnoDidYet
                      : _shortDid(did),
                  trailing: did == null
                      ? null
                      : TextButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: did));
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context).didCopied,
                                ),
                              ),
                            );
                          },
                          child: Text(AppLocalizations.of(context).copy),
                        ),
                  helpText: 'Your Decentralized Identifier',
                );
              },
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withOpacity(0.1),
            ),

            // Privacy & Safety.
            //
            // No "Private Account" row. It was a switch over a bool this
            // screen kept to itself: there is no such field on the account,
            // and nothing in the API asks about one, so every post stayed
            // exactly as public as it had been. A privacy promise that the
            // system cannot keep is worse than no promise, so it is gone
            // rather than left looking like protection.
            _groupHeader('Privacy & Safety'),
            _settingsRow(
              icon: Iconsax.key_copy,
              label: AppLocalizations.of(context).literalpasswordLogin,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsPasswordLogin),
              helpText: 'Security settings',
            ),
            _settingsRow(
              icon: Iconsax.text_block_copy,
              label: AppLocalizations.of(context).mutedWordsAndTags,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.mutedWords),
              helpText: 'Keep posts containing these out of your feed',
            ),
            _settingsRow(
              icon: Iconsax.volume_slash_copy,
              label: AppLocalizations.of(context)
                  .literalmutedAndBlockedAccounts,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.mutedAccounts),
              helpText: 'Who you have muted or blocked',
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withOpacity(0.1),
            ),

            // Preferences: how the app behaves for this reader, on this
            // device. Was "Content & Display" and "App & Device", which split
            // font size from text scale's neighbours and put muting under
            // "device".
            _groupHeader('Preferences'),
            _settingsRow(
              icon: Iconsax.moon_copy,
              label: 'Appearance',
              subtitle: ref.watch(preferencesProvider).theme.label,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: _chooseTheme,
              helpText: 'Light, dark, or whatever the phone is set to',
            ),
            _settingsRow(
              icon: Iconsax.text_copy,
              label: AppLocalizations.of(context).literalfontSize,
              subtitle: AppPreferences.labelForScale(
                ref.watch(preferencesProvider).textScale,
              ),
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsFontSize),
              helpText: 'Adjust text size',
            ),
            _settingsRow(
              icon: Iconsax.global_copy,
              label: 'Language',
              subtitle: ref.watch(preferencesProvider).language.nativeName,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsLanguage),
              helpText: 'Choose your language',
            ),
            _settingsRow(
              icon: Iconsax.notification_copy,
              label: AppLocalizations.of(context).literalpushNotifications,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsNotifications),
              helpText: 'Notification preferences',
            ),
            // One row where there were two. "Auto-Download" and "Data Saver"
            // were opposite names for the same thing, neither of them read
            // anywhere, and a phone with both switched on had no answer. The
            // help text says what this one actually does rather than promising
            // a general reduction nothing measures.
            //
            // No "Location" row either: there is no geolocation package in the
            // app and no location permission in the manifest, so "Allow
            // location access" granted nothing and denied nothing.
            _settingsRow(
              icon: Iconsax.save_add_copy,
              label: AppLocalizations.of(context).literaldataSaver,
              trailing: KyronToggle(
                value: ref.watch(preferencesProvider).dataSaver,
                onChanged: (value) =>
                    ref.read(preferencesProvider.notifier).setDataSaver(value),
                semanticsLabel: 'Data Saver',
              ),
              helpText: 'Stop videos playing by themselves as you scroll',
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withOpacity(0.1),
            ),

            // Help & Support Group (3 items)
            _groupHeader('Help & Support'),
            _settingsRow(
              icon: Iconsax.info_circle_copy,
              label: AppLocalizations.of(context).helpCentre,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => AppBrowser.open(
                context,
                SupportLinks.helpCentre,
                title: SupportLinks.helpCentreTitle,
              ),
              helpText: 'Browse help articles',
            ),
            _settingsRow(
              icon: Iconsax.call_copy,
              label: AppLocalizations.of(context).literalcontactSupport,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsContactSupport),
              helpText: 'Get help from our team',
            ),
            _settingsRow(
              icon: Iconsax.message_edit_copy,
              label: AppLocalizations.of(context).literalsendFeedback,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsFeedback),
              helpText: 'Tell us what you think',
            ),
            _settingsRow(
              icon: Iconsax.info_circle_copy,
              label: AppLocalizations.of(context).about,
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.about),
              helpText: 'Version, policies, status and the system log',
            ),
            Divider(
              height: 1,
              thickness: 0.33,
              color: scheme.onSurface.withOpacity(0.1),
            ),

            // Danger Zone (1 item)
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: scheme.error.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: _settingsRow(
                icon: Iconsax.logout_copy,
                label: AppLocalizations.of(context).logOut,
                subtitle: _handle,
                trailing: _loggingOut
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Iconsax.arrow_right_3_copy,
                        size: 20,
                        color: Colors.red,
                      ),
                // Null while signing out, so a second tap cannot start another
                // sign-out over the top of the first.
                onTap: _loggingOut ? null : _showLogoutConfirmation,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
