import '../l10n/app_localizations.dart';

// lib/screens/about_subscreens.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/service_status_provider.dart';
import '../services/app_info.dart';
import '../services/app_log.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/empty_state.dart';
import '../services/app_browser.dart';
import '../widgets/kyron_app_bar.dart';

// ===========================================================================
// SERVICE STATUS
// ===========================================================================

/// What the API says about itself: right now, and over the last sixty days.
///
/// The way a status page is read: one line saying whether everything is
/// working, a bar per day for each part of the service, what went wrong and
/// when, and then the raw details for whoever is diagnosing something.
class ServiceStatusScreen extends ConsumerWidget {
  const ServiceStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceStatusProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(AppLocalizations.of(context).serviceStatus),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh_copy, size: 20),
            tooltip: AppLocalizations.of(context).literalcheckAgain,
            onPressed: () {
              ref.read(serviceStatusProvider.notifier).check();
              ref.invalidate(serviceHistoryProvider);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, _) => _Unreachable(
            message: error.toString(),
            onRetry: ref.read(serviceStatusProvider.notifier).check,
          ),
          data: (status) => ListView(
            padding: const EdgeInsets.all(SpacingTokens.space20),
            children: [
              _Banner(
                healthy: status.isHealthy,
                problem: status.problem,
                // Something /health cannot see from inside the API: sign-in
                // failing at Supabase. The history knows.
                failing: [
                  for (final incident in ref
                          .watch(serviceHistoryProvider)
                          .asData
                          ?.value
                          ?.incidents ??
                      const <StatusIncident>[])
                    if (incident.ongoing)
                      _componentName(context, incident.component),
                ],
              ),
              const SizedBox(height: SpacingTokens.space32),
              const _History(),
              const SizedBox(height: SpacingTokens.space32),
              _SectionLabel(
                AppLocalizations.of(context).ui('ui_status_details', 'Details'),
              ),
              const SizedBox(height: SpacingTokens.space8),
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
                  fontSize: TypographyTokens.fontSize1,
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

  /// What is wrong, in a sentence. Null when nothing is.
  final String? problem;

  /// Components with an incident still open, by name. A healthy answer
  /// from /health with one of these is not "all systems operational".
  final List<String> failing;

  const _Banner({
    required this.healthy,
    this.problem,
    this.failing = const [],
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (healthy && failing.isNotEmpty) {
      return _degraded(context, scheme);
    }
    // The mark carries the colour; the words stay in the text colour, where
    // they can be read. Aqua text on white is under 2:1.
    final mark = healthy ? KyronTheme.successAqua : scheme.error;

    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: healthy
            ? scheme.surfaceContainer
            : scheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(
          color: healthy
              ? scheme.outline.withValues(alpha: 0.15)
              : scheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            healthy ? Iconsax.tick_circle : Iconsax.warning_2,
            color: mark,
            size: 26,
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Text(
              healthy
                  ? AppLocalizations.of(context)
                      .ui('ui_status_all_ok', 'All systems operational')
                  // Say what is wrong, rather than pointing at rows that all
                  // read fine and leaving the reader to guess which one meant
                  // something.
                  : problem ?? 'Kyron answered, but something is not right.',
              style: TextStyle(
                fontSize: TypographyTokens.fontSize4,
                fontWeight: FontWeight.w700,
                color: healthy ? scheme.onSurface : scheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on _Banner {
  /// Up, with something not working: which, by name.
  Widget _degraded(BuildContext context, ColorScheme scheme) => Container(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        decoration: BoxDecoration(
          color: _Bars._amber.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.all(color: _Bars._amber.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.warning_2, color: _Bars._amber, size: 26),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).ui(
                      'ui_status_degraded',
                      'Some systems are having problems',
                    ),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize4,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    failing.join(', '),
                    style: TextStyle(
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

/// A section's heading.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {this.aside});

  final String text;

  /// Quieter words after it, on the same line.
  final String? aside;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: TypographyTokens.fontSize5,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (aside != null) ...[
          const SizedBox(width: SpacingTokens.space8),
          Text(
            aside!,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ],
    );
  }
}

/// [build] in the reader's locale, or in English where the platform has no
/// date or number data for it -- never an exception on a status screen.
String _localized(
  BuildContext context,
  String Function(String? locale) build,
) {
  try {
    return build(Localizations.maybeLocaleOf(context)?.toLanguageTag());
  } catch (_) {
    return build('en_US');
  }
}

/// A percentage to at most two places: 100%, 99.5%, 98.07%.
String _percent(BuildContext context, double value) => _localized(
      context,
      (locale) => '${NumberFormat('0.##', locale).format(value)}%',
    );

/// What a component is called on screen.
String _componentName(BuildContext context, String id) {
  final l10n = AppLocalizations.of(context);
  return switch (id) {
    'api' => l10n.ui('ui_status_api', 'API'),
    'database' => l10n.ui('ui_status_database', 'Database'),
    'auth' => l10n.ui('ui_status_auth', 'Sign-in'),
    _ => id,
  };
}

/// Uptime per component, as a bar a day, and the incidents behind it.
class _History extends ConsumerWidget {
  const _History();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final history = ref.watch(serviceHistoryProvider);
    final unavailable = _Note(
      l10n.ui(
        'ui_status_unavailable',
        'Uptime history is not available yet.',
      ),
    );

    return history.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: SpacingTokens.space24),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      error: (_, __) => unavailable,
      data: (history) {
        if (history == null) return unavailable;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(
              l10n.ui('ui_status_uptime', 'Uptime'),
              aside: l10n.ui('ui_status_last_60', 'Last 60 days'),
            ),
            const SizedBox(height: SpacingTokens.space16),
            for (final component in history.components)
              _ComponentUptime(component: component, days: history.days),
            const SizedBox(height: SpacingTokens.space16),
            _SectionLabel(
              l10n.ui('ui_status_incidents', 'Recent incidents'),
            ),
            const SizedBox(height: SpacingTokens.space12),
            if (history.incidents.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(SpacingTokens.space16),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
                ),
                child: Text(
                  l10n.ui(
                    'ui_status_no_incidents',
                    'No incidents in the last 60 days.',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              )
            else
              for (final incident in history.incidents)
                _IncidentTile(incident: incident),
            const SizedBox(height: SpacingTokens.space12),
            // How the bars are made, so a grey one is not read as an outage
            // and a green one is not read as more than it is.
            Text(
              l10n.ui(
                'ui_status_footnote',
                'Kyron checks itself every 5 minutes while it is running. '
                    'A grey day had no checks.',
              ),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      );
}

/// One component: its name and uptime, a bar per day, and the ends of the
/// window under them.
class _ComponentUptime extends StatelessWidget {
  const _ComponentUptime({required this.component, required this.days});

  final StatusComponent component;
  final int days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final muted = TextStyle(
      fontSize: TypographyTokens.fontSize1,
      color: scheme.onSurface.withValues(alpha: 0.5),
    );
    final uptime = component.uptime;

    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _componentName(context, component.id),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                uptime == null ? '—' : _percent(context, uptime),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space8),
          _Bars(component: component, days: days),
          const SizedBox(height: SpacingTokens.space4),
          Row(
            children: [
              Text(l10n.ui('ui_status_60_days_ago', '60 days ago'),
                  style: muted),
              const Spacer(),
              Text(l10n.ui('ui_status_today', 'Today'), style: muted),
            ],
          ),
        ],
      ),
    );
  }
}

/// A bar for each of the last [days] days, oldest on the left: aqua for a
/// day every check passed, amber for one with a few failures, red for one
/// with many, and grey for a day with no checks at all.
class _Bars extends StatelessWidget {
  const _Bars({required this.component, required this.days});

  final StatusComponent component;
  final int days;

  /// No design token for a warning yet; this is the amber the status pages
  /// this follows use for "partial".
  static const _amber = Color(0xFFF5A524);

  /// Failing more than this share of a day's checks is an outage, not a
  /// blip.
  static const _outage = 0.05;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now().toUtc();
    final today = DateTime.utc(now.year, now.month, now.day);

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          for (var i = 0; i < days; i++)
            Builder(
              builder: (context) {
                final date = today.subtract(Duration(days: days - 1 - i));
                final key = date.toIso8601String().substring(0, 10);
                final day = component.days[key];
                final color = day == null || day.checks == 0
                    ? scheme.onSurface.withValues(alpha: 0.12)
                    : day.failures == 0
                        ? KyronTheme.successAqua
                        : day.failureRate < _outage
                            ? _amber
                            : scheme.error;
                final when = _localized(
                  context,
                  (locale) => DateFormat.MMMd(locale).format(date),
                );
                final what = day == null || day.checks == 0
                    ? AppLocalizations.of(context)
                        .ui('ui_status_no_data', 'No data')
                    : _percent(
                        context,
                        (day.checks - day.failures) / day.checks * 100,
                      );
                return Expanded(
                  child: Tooltip(
                    message: '$when · $what',
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            BorderRadius.circular(RadiusTokens.radius2),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

/// One incident: what failed, from when to when, and what it said.
class _IncidentTile extends StatelessWidget {
  const _IncidentTile({required this.incident});

  final StatusIncident incident;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final start = incident.startedAt;
    final end = incident.endedAt;
    final from = _localized(
      context,
      (locale) => DateFormat.MMMd(locale).add_jm().format(start),
    );
    final to = end == null
        ? null
        : _localized(
            context,
            (locale) => (end.year == start.year &&
                        end.month == start.month &&
                        end.day == start.day
                    ? DateFormat.jm(locale)
                    : DateFormat.MMMd(locale).add_jm())
                .format(end),
          );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: SpacingTokens.space8),
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.warning_2_copy,
                size: 16,
                color: incident.ongoing ? scheme.error : _Bars._amber,
              ),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Text(
                  _componentName(context, incident.component),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (incident.ongoing)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.error.withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(RadiusTokens.radiusFull),
                  ),
                  child: Text(
                    AppLocalizations.of(context)
                        .ui('ui_status_ongoing', 'Ongoing'),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize1,
                      fontWeight: FontWeight.w600,
                      color: scheme.error,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space4),
          Text(
            to == null ? from : '$from – $to',
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          if (incident.detail != null) ...[
            const SizedBox(height: SpacingTokens.space4),
            Text(
              incident.detail!,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
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
    return Center(
      child: SingleChildScrollView(
        child: EmptyState.failed(
          title: AppLocalizations.of(context).literalkyronDidNotAnswer,
          detail: message,
          action: 'Check again',
          onAction: onRetry,
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
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(AppLocalizations.of(context).systemLog),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.copy_copy, size: 20),
            tooltip: AppLocalizations.of(context).copy,
            onPressed: _copy,
          ),
          IconButton(
            icon: const Icon(Iconsax.trash_copy, size: 20),
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
                child: EmptyState(
                  compact: true,
                  art: EmptyArt.drafts,
                  title: AppLocalizations.of(context).literalnothingLoggedYet,
                  detail: 'Failed requests and other notable events show up '
                      'here.',
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
        content: Text(
          text.isEmpty
              ? AppLocalizations.of(context).nothingToCopy
              : AppLocalizations.of(context).logCopied,
        ),
      ),
    );
  }

  Future<void> _clear() async {
    await AppLog.instance.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).logCleared)),
    );
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
                  fontSize: TypographyTokens.fontSize1,
                  color: scheme.onSurface.withValues(alpha: .5),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Text(
                entry.source,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize1,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space2),
          SelectableText(
            entry.message,
            style: const TextStyle(fontSize: TypographyTokens.fontSize2),
          ),
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
      title: AppLocalizations.of(context).sendErrorReport,
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
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).whatYouWereDoing,
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _includeLog,
            onChanged: (value) => setState(() => _includeLog = value),
            title: Text(AppLocalizations.of(context).attachSystemLog),
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
            icon: const Icon(Iconsax.send_1_copy, size: 18),
            label: Text(AppLocalizations.of(context).sendToSupport),
          ),
          const SizedBox(height: SpacingTokens.space8),
          OutlinedButton.icon(
            onPressed: _copy,
            icon: const Icon(Iconsax.copy_copy, size: 18),
            label: Text(AppLocalizations.of(context).copyReportInstead),
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
      ..writeln(
        _notes.text.trim().isEmpty
            ? '(no description given)'
            : _notes.text.trim(),
      )
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
    // A mail app, not a browser: no web view sends mail. AppBrowser.leave is
    // the only call in the app allowed to hand a link to another app, and it
    // answers false rather than throwing when nothing takes it.
    final launched = await AppBrowser.leave(uri);

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
      SnackBar(content: Text(AppLocalizations.of(context).reportCopied)),
    );
  }
}
