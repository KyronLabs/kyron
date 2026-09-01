import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/auth_provider.dart';
import '../providers/current_user_provider.dart';
import '../providers/preferences_provider.dart';
import '../utils/api_error_message.dart';
import '../services/app_preferences.dart';
import '../widgets/kyron_toggle.dart';
import '../routes.dart';
import 'dart:async';

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

  // Local state for toggles (batch save on exit)
  bool _privateAccount = false;
  bool _darkMode = true;
  bool _autoDownload = true;
  bool _dataSaver = false;
  bool _location = false;
  void _resetToDefault(String setting) {
    // Hidden gesture: swipe left resets (power-users)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reset $setting to default'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
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
          fontSize: 12,
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
      onHorizontalDragEnd: (details) {
        // Swipe left → Reset to Default (hidden gesture)
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          _resetToDefault(label);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        label: label,
        value: subtitle,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Icon: 24px, left-aligned, 8px padding
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'SF Pro Rounded',
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
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
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  foregroundImage:
                      avatarUrl == null ? null : NetworkImage(avatarUrl),
                  child: Icon(
                    Iconsax.user_copy,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
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
                          fontSize: 16,
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
            const Text('Log Out?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: _performLogout,
                    child: const Text('Log Out'),
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                child: const Text('Change Email'),
              ),
              helpText: 'Your profile and contact information',
            ),
            // The real one. This row showed "did:plc:abc…" and copied
            // "did:plc:abcdef1234567890abcdef12" -- the same invented
            // identifier for everyone, to anyone who tapped Copy.
            Consumer(
              builder: (context, ref, _) {
                final did = ref.watch(currentUserProvider).asData?.value.did;
                return _settingsRow(
                  icon: Iconsax.document_copy,
                  label: did == null ? 'No DID yet' : _shortDid(did),
                  trailing: did == null
                      ? null
                      : TextButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: did));
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('DID copied to clipboard'),
                              ),
                            );
                          },
                          child: const Text('Copy'),
                        ),
                  helpText: 'Your Decentralized Identifier',
                );
              },
            ),
            Divider(
                height: 1,
                thickness: 0.33,
                color: scheme.onSurface.withOpacity(0.1)),

            // Privacy & Safety Group (3 items)
            _groupHeader('Privacy & Safety'),
            _settingsRow(
              icon: Iconsax.lock_copy,
              label: 'Private Account',
              trailing: KyronToggle(
                value: _privateAccount,
                onChanged: (value) => setState(() => _privateAccount = value),
                semanticsLabel: 'Private Account',
              ),
              helpText: 'Only followers can see your posts',
            ),
            _settingsRow(
              icon: Iconsax.key_copy,
              label: 'Password & Login',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsPasswordLogin),
              helpText: 'Security settings',
            ),
            Divider(
                height: 1,
                thickness: 0.33,
                color: scheme.onSurface.withOpacity(0.1)),

            // Content & Display Group (4 items)
            _groupHeader('Content & Display'),
            _settingsRow(
              icon: Iconsax.moon_copy,
              label: 'Dark Mode',
              trailing: KyronToggle(
                value: _darkMode,
                onChanged: (value) {
                  setState(() => _darkMode = value);
                  // TODO: Apply theme change immediately
                },
                semanticsLabel: 'Dark Mode',
              ),
              helpText: 'Use dark theme',
            ),
            _settingsRow(
              icon: Iconsax.text_copy,
              label: 'Font Size',
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
              icon: Iconsax.direct_inbox_copy,
              label: 'Auto-Download',
              trailing: KyronToggle(
                value: _autoDownload,
                onChanged: (value) => setState(() => _autoDownload = value),
                semanticsLabel: 'Auto-Download',
              ),
              helpText: 'Automatically download media',
            ),
            Divider(
                height: 1,
                thickness: 0.33,
                color: scheme.onSurface.withOpacity(0.1)),

            // App & Device Group (4 items)
            _groupHeader('App & Device'),
            _settingsRow(
              icon: Iconsax.save_add_copy,
              label: 'Data Saver',
              trailing: KyronToggle(
                value: _dataSaver,
                onChanged: (value) => setState(() => _dataSaver = value),
                semanticsLabel: 'Data Saver',
              ),
              helpText: 'Reduce data usage',
            ),
            _settingsRow(
              icon: Iconsax.text_block_copy,
              label: 'Muted words and tags',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.mutedWords),
              helpText: 'Keep posts containing these out of your feed',
            ),
            _settingsRow(
              icon: Iconsax.volume_slash_copy,
              label: 'Muted and blocked accounts',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.mutedAccounts),
              helpText: 'Who you have muted or blocked',
            ),
            _settingsRow(
              icon: Iconsax.notification_copy,
              label: 'Push Notifications',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsNotifications),
              helpText: 'Notification preferences',
            ),
            _settingsRow(
              icon: Iconsax.location_copy,
              label: 'Location',
              trailing: KyronToggle(
                value: _location,
                onChanged: (value) => setState(() => _location = value),
                semanticsLabel: 'Location',
              ),
              helpText: 'Allow location access',
            ),
            Divider(
                height: 1,
                thickness: 0.33,
                color: scheme.onSurface.withOpacity(0.1)),

            // Help & Support Group (3 items)
            _groupHeader('Help & Support'),
            _settingsRow(
              icon: Iconsax.info_circle_copy,
              label: 'Help Centre',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.webview, arguments: {
                'url': 'https://help.kyron.so',
                'title': 'Help Centre',
              }),
              helpText: 'Browse help articles',
            ),
            _settingsRow(
              icon: Iconsax.call_copy,
              label: 'Contact Support',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsContactSupport),
              helpText: 'Get help from our team',
            ),
            _settingsRow(
              icon: Iconsax.message_edit_copy,
              label: 'Send Feedback',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () =>
                  Navigator.pushNamed(context, Routes.settingsFeedback),
              helpText: 'Tell us what you think',
            ),
            _settingsRow(
              icon: Iconsax.info_circle_copy,
              label: 'About',
              trailing: const Icon(Iconsax.arrow_right_3_copy, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.about),
              helpText: 'Version, policies, status and the system log',
            ),
            Divider(
                height: 1,
                thickness: 0.33,
                color: scheme.onSurface.withOpacity(0.1)),

            // Danger Zone (1 item)
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: scheme.error.withValues(alpha: 0.3), width: 1),
                ),
              ),
              child: _settingsRow(
                icon: Iconsax.logout_copy,
                label: 'Log Out',
                subtitle: _handle,
                trailing: _loggingOut
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Iconsax.arrow_right_3_copy,
                        size: 20, color: Colors.red),
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
