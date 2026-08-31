// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../config/legal_links.dart';
import '../routes.dart';
import '../services/app_info.dart';
import '../services/app_log.dart';
import '../services/device_cache.dart';

/// Terms, privacy, service status, the system log, the running build -- and
/// the two maintenance actions that used to sit in the middle of Settings.
class AboutScreen extends ConsumerStatefulWidget {
  const AboutScreen({super.key});

  @override
  ConsumerState<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutScreen> {
  static const _cache = DeviceCache();

  AppInfo? _info;

  /// Null until measured; a dash is honest, "12 MB" before looking is not.
  int? _cacheBytes;
  bool _clearing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final info = await AppInfo.load();
    final bytes = await _cache.size();
    if (!mounted) return;
    setState(() {
      _info = info;
      _cacheBytes = bytes;
    });
  }

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
        title: const Text('About'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: SpacingTokens.space16),
            _Wordmark(info: _info),
            const SizedBox(height: SpacingTokens.space16),
            _group('Legal'),
            _Row(
              icon: Iconsax.document_text,
              label: LegalLinks.termsTitle,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.webview,
                arguments: LegalLinks.termsArguments,
              ),
            ),
            _Row(
              icon: Iconsax.shield_tick,
              label: LegalLinks.privacyTitle,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.webview,
                arguments: LegalLinks.privacyArguments,
              ),
            ),
            _divider(scheme),
            _group('Diagnostics'),
            _Row(
              icon: Iconsax.status_up,
              label: 'Service status',
              subtitle: 'Whether Kyron is reachable right now',
              onTap: () => Navigator.pushNamed(context, Routes.aboutStatus),
            ),
            _Row(
              icon: Iconsax.document_code,
              label: 'System log',
              subtitle: 'What this app has been doing',
              onTap: () => Navigator.pushNamed(context, Routes.aboutSystemLog),
            ),
            _Row(
              icon: Iconsax.warning_2,
              label: 'Send error report',
              subtitle: 'Share the log with support',
              onTap: () =>
                  Navigator.pushNamed(context, Routes.aboutErrorReport),
            ),
            _divider(scheme),
            _group('Storage'),
            _Row(
              icon: Iconsax.trash,
              label: 'Clear cache',
              subtitle: _cacheBytes == null
                  ? 'Measuring…'
                  : '${formatBytes(_cacheBytes!)} of cached images and files',
              trailing: _clearing
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              onTap: _clearing ? null : _clearCache,
            ),
            _divider(scheme),
            _group('Build'),
            _Row(
              icon: Iconsax.mobile,
              label: 'App version',
              subtitle: _info?.display ?? 'Reading…',
              trailing: const Icon(Iconsax.copy, size: 18),
              onTap: _info == null ? null : () => _copyBuild(_info!),
            ),
            const SizedBox(height: SpacingTokens.space40),
          ],
        ),
      ),
    );
  }

  Future<void> _clearCache() async {
    setState(() => _clearing = true);
    final freed = await _cache.clear();
    final remaining = await _cache.size();
    AppLog.instance.info('cache', 'Cleared ${formatBytes(freed)}');
    if (!mounted) return;
    setState(() {
      _clearing = false;
      _cacheBytes = remaining;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          freed == 0 ? 'Nothing to clear' : '${formatBytes(freed)} freed',
        ),
      ),
    );
  }

  Future<void> _copyBuild(AppInfo info) async {
    await Clipboard.setData(
      ClipboardData(text: '${info.packageName} ${info.display}'),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Build details copied')),
    );
  }

  Widget _group(String title) => Padding(
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

  Widget _divider(ColorScheme scheme) => Divider(
        height: 1,
        thickness: 0.33,
        color: scheme.onSurface.withValues(alpha: 0.1),
      );
}

class _Wordmark extends StatelessWidget {
  final AppInfo? info;

  const _Wordmark({required this.info});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
          ),
          child: Icon(Iconsax.flash_circle, size: 32, color: scheme.primary),
        ),
        const SizedBox(height: SpacingTokens.space12),
        Text('Kyron', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: SpacingTokens.space4),
        Text(
          info == null ? '' : 'Version ${info!.display}',
          style: TextStyle(
            fontSize: 13,
            color: scheme.onSurface.withValues(alpha: .6),
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _Row({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(label),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: trailing ?? const Icon(Iconsax.arrow_right_3, size: 18),
      onTap: onTap,
      enabled: onTap != null,
    );
  }
}
