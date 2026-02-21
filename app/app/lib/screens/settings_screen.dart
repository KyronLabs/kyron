import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/kyron_toggle.dart';
import '../routes.dart';
import 'dart:async';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Local state for toggles (batch save on exit)
  bool _privateAccount = false;
  bool _darkMode = true;
  bool _autoDownload = true;
  bool _dataSaver = false;
  bool _location = false;
  String _cacheSize = '12 MB';
  Timer? _cacheTimer;

  @override
  void initState() {
    super.initState();
    _computeCacheSize();
  }

  @override
  void dispose() {
    _cacheTimer?.cancel();
    super.dispose();
  }

  void _computeCacheSize() {
    // Simulate cache computation - cached for 60s (Doherty)
    if (_cacheTimer?.isActive ?? false) return;
    
    final random = DateTime.now().millisecondsSinceEpoch % 40 + 10;
    setState(() => _cacheSize = '$random MB');
    _cacheTimer = Timer(const Duration(seconds: 60), _computeCacheSize);
  }

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
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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

  void _showLogoutConfirmation() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
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
            const Text('Log Out?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Are you sure you want to log out of @alice?'),
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                      // Perform logout and navigate to welcome
                      Navigator.pushNamedAndRemoveUntil(context, Routes.welcome, (route) => false);
                    },
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
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.close_square),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Account Group (3 items)
            _groupHeader('Account'),
            _settingsRow(
              icon: Iconsax.user,
              label: '@alice',
              subtitle: 'alice@kyron.so',
              trailing: TextButton(
                onPressed: () => Navigator.pushNamed(context, Routes.settingsChangeEmail),
                child: const Text('Change Email'),
              ),
              helpText: 'Your profile and contact information',
            ),
            _settingsRow(
              icon: Iconsax.document_copy,
              label: 'did:plc:abc…',
              trailing: TextButton(
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: 'did:plc:abcdef1234567890abcdef12'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('DID copied to clipboard')),
                  );
                },
                child: const Text('Copy'),
              ),
              helpText: 'Your Decentralized Identifier',
            ),
            Divider(height: 1, thickness: 0.33, color: scheme.onSurface.withOpacity(0.1)),
            
            // Privacy & Safety Group (3 items)
            _groupHeader('Privacy & Safety'),
            _settingsRow(
              icon: Iconsax.lock,
              label: 'Private Account',
              trailing: KyronToggle(
                value: _privateAccount,
                onChanged: (value) => setState(() => _privateAccount = value),
                semanticsLabel: 'Private Account',
              ),
              helpText: 'Only followers can see your posts',
            ),
            _settingsRow(
              icon: Iconsax.user_remove,
              label: 'Blocked Users',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsBlockedUsers),
              helpText: 'Manage blocked accounts',
            ),
            _settingsRow(
              icon: Iconsax.key,
              label: 'Password & Login',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsPasswordLogin),
              helpText: 'Security settings',
            ),
            Divider(height: 1, thickness: 0.33, color: scheme.onSurface.withOpacity(0.1)),
            
            // Content & Display Group (4 items)
            _groupHeader('Content & Display'),
            _settingsRow(
              icon: Iconsax.moon,
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
              icon: Iconsax.text,
              label: 'Font Size',
              subtitle: 'Medium',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsFontSize),
              helpText: 'Adjust text size',
            ),
            _settingsRow(
              icon: Iconsax.global,
              label: 'Language',
              subtitle: 'English',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsLanguage),
              helpText: 'Choose your language',
            ),
            _settingsRow(
              icon: Iconsax.direct_inbox,
              label: 'Auto-Download',
              trailing: KyronToggle(
                value: _autoDownload,
                onChanged: (value) => setState(() => _autoDownload = value),
                semanticsLabel: 'Auto-Download',
              ),
              helpText: 'Automatically download media',
            ),
            Divider(height: 1, thickness: 0.33, color: scheme.onSurface.withOpacity(0.1)),
            
            // App & Device Group (4 items)
            _groupHeader('App & Device'),
            _settingsRow(
              icon: Iconsax.save_add,
              label: 'Data Saver',
              trailing: KyronToggle(
                value: _dataSaver,
                onChanged: (value) => setState(() => _dataSaver = value),
                semanticsLabel: 'Data Saver',
              ),
              helpText: 'Reduce data usage',
            ),
            _settingsRow(
              icon: Iconsax.notification,
              label: 'Push Notifications',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsNotifications),
              helpText: 'Notification preferences',
            ),
            _settingsRow(
              icon: Iconsax.location,
              label: 'Location',
              trailing: KyronToggle(
                value: _location,
                onChanged: (value) => setState(() => _location = value),
                semanticsLabel: 'Location',
              ),
              helpText: 'Allow location access',
            ),
            _settingsRow(
              icon: Iconsax.trash,
              label: 'Clear Cache',
              subtitle: _cacheSize,
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () {
                setState(() => _cacheSize = '0 MB');
                _computeCacheSize();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared')),
                );
              },
              helpText: 'Free up storage space',
            ),
            Divider(height: 1, thickness: 0.33, color: scheme.onSurface.withOpacity(0.1)),
            
            // Help & Support Group (3 items)
            _groupHeader('Help & Support'),
            _settingsRow(
              icon: Iconsax.info_circle,
              label: 'Help Centre',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.webview, arguments: {
                'url': 'https://help.kyron.so',
                'title': 'Help Centre',
              }),
              helpText: 'Browse help articles',
            ),
            _settingsRow(
              icon: Iconsax.call,
              label: 'Contact Support',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsContactSupport),
              helpText: 'Get help from our team',
            ),
            _settingsRow(
              icon: Iconsax.message_edit,
              label: 'Send Feedback',
              trailing: const Icon(Iconsax.arrow_right_3, size: 20),
              onTap: () => Navigator.pushNamed(context, Routes.settingsFeedback),
              helpText: 'Tell us what you think',
            ),
            Divider(height: 1, thickness: 0.33, color: scheme.onSurface.withOpacity(0.1)),
            
            // Danger Zone (1 item)
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: scheme.error.withOpacity(0.3), width: 1),
                ),
              ),
              child: _settingsRow(
                icon: Iconsax.logout,
                label: 'Log Out',
                subtitle: '@alice',
                trailing: const Icon(Iconsax.arrow_right_3, size: 20, color: Colors.red),
                onTap: _showLogoutConfirmation,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}