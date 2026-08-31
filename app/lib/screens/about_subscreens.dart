// lib/screens/about_subscreens.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/service_status_provider.dart';
import '../services/app_info.dart';
import '../services/app_log.dart';
import '../widgets/settings_scaffold.dart';

// ===========================================================================
// SERVICE STATUS
// ===========================================================================

/// What the API says about itself, right now.
class ServiceStatusScreen extends ConsumerWidget {
  const ServiceStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceStatusProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Service status'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh, size: 20),
            tooltip: 'Check again',
            onPressed: ref.read(serviceStatusProvider.notifier).check,
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _Unreachable(
            message: error.toString(),
            onRetry: ref.read(serviceStatusProvider.notifier).check,
          ),
          data: (status) => ListView(
            padding: const EdgeInsets.all(SpacingTokens.space20),
            children: [
              _Banner(healthy: status.isHealthy),
              const SizedBox(height: SpacingTokens.space24),
              _Line('API', status.status),
              _Line('Database', status.database),
              if (status.databaseDetail != null)
                _Line('Detail', status.databaseDetail!),
              _Line('Mirror tables', status.mirrorTables),
              _Line('Round trip', '${status.latency.inMilliseconds} ms'),
              const SizedBox(height: SpacingTokens.space24),
              Text(
                'TOKEN VERIFICATION',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: scheme.onSurface.withValues(alpha: .5),
                ),
              ),
              const SizedBox(height: SpacingTokens.space8),
              for (final entry in status.auth.entries)
                _Line(entry.key, '${entry.value}'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final bool healthy;

  const _Banner({required this.healthy});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = healthy ? scheme.primary : scheme.error;

    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(healthy ? Iconsax.tick_circle : Iconsax.warning_2, color: color),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Text(
              healthy
                  ? 'Kyron is up and the database is connected.'
                  : 'Kyron answered, but something is not right. The rows '
                      'below say what.',
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _Unreachable extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _Unreachable({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 44, color: scheme.error),
            const SizedBox(height: SpacingTokens.space16),
            Text('Kyron did not answer',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: SpacingTokens.space16),
            TextButton(onPressed: onRetry, child: const Text('Check again')),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final String label;
  final String value;

  const _Line(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SYSTEM LOG
// ===========================================================================

/// What the app has actually been doing, newest last.
class SystemLogScreen extends StatefulWidget {
  const SystemLogScreen({super.key});

  @override
  State<SystemLogScreen> createState() => _SystemLogScreenState();
}

class _SystemLogScreenState extends State<SystemLogScreen> {
  @override
  void initState() {
    super.initState();
    AppLog.instance.load();
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
        title: const Text('System log'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.copy, size: 20),
            tooltip: 'Copy',
            onPressed: _copy,
          ),
          IconButton(
            icon: const Icon(Iconsax.trash, size: 20),
            tooltip: 'Clear',
            onPressed: _clear,
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: AppLog.instance.revision,
          builder: (context, _, __) {
            // Newest first on screen: the thing that just went wrong is the
            // thing you opened this to read.
            final entries = AppLog.instance.entries.reversed.toList();
            if (entries.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingTokens.space32),
                  child: Text(
                    'Nothing logged yet. Failed requests and other notable '
                    'events show up here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onSurface.withValues(alpha: .6),
                    ),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingTokens.space8,
              ),
              itemCount: entries.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: scheme.onSurface.withValues(alpha: 0.08),
              ),
              itemBuilder: (context, index) => _Entry(entry: entries[index]),
            );
          },
        ),
      ),
    );
  }

  Future<void> _copy() async {
    final text = AppLog.instance.asText();
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text.isEmpty ? 'Nothing to copy' : 'Log copied'),
      ),
    );
  }

  Future<void> _clear() async {
    await AppLog.instance.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Log cleared')));
  }
}

class _Entry extends StatelessWidget {
  final LogEntry entry;

  const _Entry({required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (entry.level) {
      LogLevel.error => scheme.error,
      LogLevel.warning => scheme.tertiary,
      LogLevel.info => scheme.onSurface.withValues(alpha: .6),
    };

    final at = entry.at;
    final stamp = '${_two(at.hour)}:${_two(at.minute)}:${_two(at.second)}';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space16,
        vertical: SpacingTokens.space8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                stamp,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: .5),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Text(
                entry.source,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space2),
          SelectableText(entry.message, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}

// ===========================================================================
// ERROR REPORT
// ===========================================================================

/// Sending the log to support, with whatever the person wants to add.
class ErrorReportScreen extends StatefulWidget {
  const ErrorReportScreen({super.key});

  @override
  State<ErrorReportScreen> createState() => _ErrorReportScreenState();
}

class _ErrorReportScreenState extends State<ErrorReportScreen> {
  static const _supportAddress = 'support@kyron.so';

  /// How much of the log to attach. Comfortably inside what mail apps accept
  /// in a mailto body, with room for the description above it.
  static const _maxLogCharacters = 6000;

  final _notes = TextEditingController();
  AppInfo? _info;
  bool _includeLog = true;

  @override
  void initState() {
    super.initState();
    AppLog.instance.load();
    AppInfo.load().then((info) {
      if (mounted) setState(() => _info = info);
    });
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = AppLog.instance.entries.length;

    return SettingsScaffold(
      title: 'Send error report',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What went wrong?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: SpacingTokens.space8),
          TextField(
            controller: _notes,
            maxLines: 5,
            maxLength: 1000,
            decoration: const InputDecoration(
              hintText: 'What you were doing when it happened.',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _includeLog,
            onChanged: (value) => setState(() => _includeLog = value),
            title: const Text('Attach the system log'),
            subtitle: Text(
              entries == 0
                  ? 'Nothing logged yet'
                  : '$entries recent entries. Review them under About › '
                      'System log before sending.',
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          FilledButton.icon(
            onPressed: _send,
            icon: const Icon(Iconsax.send_1, size: 18),
            label: const Text('Send to support'),
          ),
          const SizedBox(height: SpacingTokens.space8),
          OutlinedButton.icon(
            onPressed: _copy,
            icon: const Icon(Iconsax.copy, size: 18),
            label: const Text('Copy report instead'),
          ),
          const SizedBox(height: SpacingTokens.space16),
          Text(
            'The report opens in your mail app so you can read it before it '
            'goes anywhere. Nothing is sent in the background.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  String _compose() {
    final buffer = StringBuffer()
      ..writeln(_notes.text.trim().isEmpty
          ? '(no description given)'
          : _notes.text.trim())
      ..writeln()
      ..writeln('---')
      ..writeln('App: ${_info?.display ?? 'unknown'}')
      ..writeln('Package: ${_info?.packageName ?? 'unknown'}')
      ..writeln('Reported: ${DateTime.now().toIso8601String()}');

    if (_includeLog) {
      final log = AppLog.instance.asText();
      buffer
        ..writeln()
        ..writeln('--- system log ---')
        // Trimmed to the tail: a mailto URI has a length limit, and past it
        // some mail apps silently drop the body rather than truncating it.
        ..writeln(log.isEmpty ? '(empty)' : _tail(log, _maxLogCharacters));
    }
    return buffer.toString();
  }

  Future<void> _send() async {
    final subject = 'Kyron error report (${_info?.display ?? 'unknown'})';
    // Built by hand rather than through Uri's queryParameters, which encodes
    // spaces as '+'; several mail apps render those literally in the body.
    final uri = Uri.parse(
      'mailto:$_supportAddress'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(_compose())}',
    );

    // A mail app is not guaranteed to exist. Falling back to the clipboard is
    // better than a button that appears to do nothing.
    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      launched = false;
    }

    if (!mounted) return;
    if (!launched) {
      await _copy();
      return;
    }
    Navigator.pop(context);
  }

  /// The last [limit] characters, cut at a line boundary so the report does
  /// not start mid-entry.
  static String _tail(String text, int limit) {
    if (text.length <= limit) return text;
    final cut = text.substring(text.length - limit);
    final newline = cut.indexOf('\n');
    final trimmed = newline == -1 ? cut : cut.substring(newline + 1);
    return '(earlier entries omitted)\n$trimmed';
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _compose()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report copied. Paste it into an email to support.'),
      ),
    );
  }
}
