// lib/screens/your_reports_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/account_standing.dart';
import '../providers/enforcement_provider.dart';
import '../utils/api_error_message.dart';
import '../utils/local_date.dart';
import '../utils/notification_text.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/settings_scaffold.dart';

/// Settings > Your reports: everything this account reported in the last 90
/// days, and what came of each.
///
/// It was a section at the foot of Account status, which is about decisions
/// made against the account -- not where anybody looks to find out what
/// happened to something they reported. Each outcome is also a row in
/// Notifications and a push, so this is the record rather than the alert.
class YourReportsScreen extends ConsumerWidget {
  const YourReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final standing = ref.watch(standingProvider);
    final scheme = Theme.of(context).colorScheme;

    return SettingsScaffold(
      title: l10n.ui('ui_reports_title', 'Your reports'),
      child: standing.when(
        loading: () => const Padding(
          padding: EdgeInsets.only(top: SpacingTokens.space40),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => EmptyState.failed(
          title: l10n.ui(
            'ui_reports_failed',
            'Your reports could not be loaded',
          ),
          detail: describeApiError(error, sessionIsLive: true),
          onAction: () => ref.invalidate(standingProvider),
        ),
        data: (standing) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.ui(
                'ui_reports_intro',
                'What you reported in the last 90 days, and what came of '
                    'it. You get a notification when the team decides. '
                    'Nobody you report is told who reported them.',
              ),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: SpacingTokens.space16),
            if (standing.reports.isEmpty)
              EmptyState(
                art: EmptyArt.caughtUp,
                title: l10n.ui('ui_reports_none', 'Nothing reported'),
                detail: l10n.ui(
                  'ui_reports_none_detail',
                  'When you report a post, a reply, a message or an '
                      'account, it is listed here with what came of it.',
                ),
              )
            else
              for (final report in standing.reports) ...[
                ReportRow(report: report),
                const Hairline(),
              ],
          ],
        ),
      ),
    );
  }
}

/// One report: what it was about, why, and where it stands.
class ReportRow extends StatelessWidget {
  final ReportUpdate report;

  const ReportRow({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    String day(DateTime when) => localDate(locale, DateFormat.yMMMd, when);
    final about = report.about?.trim();

    return Padding(
      key: ValueKey('report-${report.id}'),
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              Iconsax.flag_copy,
              size: 20,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${reportedThing(l10n, report.target)} · '
                        '${ruleLabel(l10n, report.reason)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: SpacingTokens.space8),
                    OutcomePill(outcome: report.outcome),
                  ],
                ),
                if (about != null && about.isNotEmpty) ...[
                  const SizedBox(height: SpacingTokens.space4),
                  Text(
                    '“$about”',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                const SizedBox(height: SpacingTokens.space4),
                Text(
                  [
                    l10n
                        .ui('ui_reports_sent_on', r'Reported $date')
                        .replaceAll(r'$date', day(report.createdAt)),
                    if (report.resolvedAt != null)
                      l10n
                          .ui('ui_reports_decided_on', r'Decided $date')
                          .replaceAll(
                            r'$date',
                            day(report.resolvedAt!.toLocal()),
                          ),
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Where a report stands, in a word or two, coloured so the list reads at a
/// glance.
class OutcomePill extends StatelessWidget {
  final ReportOutcome outcome;

  const OutcomePill({super.key, required this.outcome});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final (label, ink) = switch (outcome) {
      ReportOutcome.pending => (
          l10n.ui('ui_reports_pending', 'In review'),
          scheme.onSurface.withValues(alpha: 0.7),
        ),
      ReportOutcome.actioned => (
          l10n.ui('ui_reports_actioned', 'Action taken'),
          const Color(0xFF17A35A),
        ),
      ReportOutcome.dismissed => (
          l10n.ui('ui_reports_dismissed', 'No rule broken'),
          scheme.primary,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: ink.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize1,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
      ),
    );
  }
}
