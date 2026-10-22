// lib/utils/notification_text.dart
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/account_standing.dart';
import '../models/notification_model.dart';
import '../repositories/moderation_repository.dart';

/// What a person did, after their name: "liked your post".
String notificationAction(AppLocalizations l10n, NotificationType type) =>
    switch (type) {
      NotificationType.like => l10n.ui('ui_notif_liked', 'liked your post'),
      NotificationType.comment =>
        l10n.ui('ui_notif_replied', 'replied to your post'),
      NotificationType.follow => l10n.ui('ui_notif_followed', 'followed you'),
      NotificationType.repost =>
        l10n.ui('ui_notif_reposted', 'reposted your post'),
      // Never shown after a name: these rows have none.
      NotificationType.account || NotificationType.report => '',
    };

/// A rule, in the reader's language. The report screen's own labels are
/// English, and a notice that names the rule should not be.
String ruleLabel(AppLocalizations l10n, ReportReason reason) =>
    switch (reason) {
      ReportReason.spam => l10n.ui('ui_rule_spam', 'Spam'),
      ReportReason.harassment =>
        l10n.ui('ui_rule_harassment', 'Harassment or bullying'),
      ReportReason.hate => l10n.ui('ui_rule_hate', 'Hate speech'),
      ReportReason.violence =>
        l10n.ui('ui_rule_violence', 'Violence or threats'),
      ReportReason.selfHarm =>
        l10n.ui('ui_rule_self_harm', 'Suicide or self-harm'),
      ReportReason.sexualContent =>
        l10n.ui('ui_rule_sexual_content', 'Adult content'),
      ReportReason.childSafety =>
        l10n.ui('ui_rule_child_safety', 'Child safety'),
      ReportReason.misinformation =>
        l10n.ui('ui_rule_misinformation', 'False information'),
      ReportReason.impersonation =>
        l10n.ui('ui_rule_impersonation', 'Impersonation'),
      ReportReason.intellectualProperty =>
        l10n.ui('ui_rule_intellectual_property', 'Intellectual property'),
      ReportReason.illegalGoods =>
        l10n.ui('ui_rule_illegal_goods', 'Illegal goods or services'),
      ReportReason.somethingElse =>
        l10n.ui('ui_rule_something_else', 'Something else'),
    };

/// What was reported, as a noun: "A post".
String reportedThing(AppLocalizations l10n, ReportTarget? target) =>
    switch (target) {
      ReportTarget.comment => l10n.ui('ui_reports_a_reply', 'A reply'),
      ReportTarget.user => l10n.ui('ui_reports_an_account', 'An account'),
      ReportTarget.communityMessage =>
        l10n.ui('ui_reports_a_message', 'A community chat message'),
      ReportTarget.post || null => l10n.ui('ui_reports_a_post', 'A post'),
    };

/// A row from Kyron rather than from a person: what it says, and the line
/// under it.
({String headline, String? detail}) moderationText(
  AppLocalizations l10n,
  NotificationModel row, {
  String? locale,
}) {
  final account = row.account;
  if (row.type == NotificationType.report) {
    final report = row.report;
    final headline = report?.actioned ?? false
        ? l10n.ui(
            'ui_notif_report_actioned',
            'We acted on something you '
                'reported. Thank you for telling us.')
        : l10n.ui(
            'ui_notif_report_dismissed',
            'We looked at something you '
                'reported and did not find that it broke our rules.');
    final detail = [
      if (report != null)
        l10n
            .ui('ui_notif_reported_for', r'Reported for: $reason')
            .replaceAll(r'$reason', ruleLabel(l10n, report.reason)),
      if (row.postSnippet != null) row.postSnippet!,
    ].join(' · ');
    return (headline: headline, detail: detail.isEmpty ? null : detail);
  }
  if (account == null) {
    return (
      headline: l10n.ui('ui_notif_account_update', 'Your account was updated'),
      detail: null,
    );
  }
  final number = '${account.number}';
  final headline = switch (account.event) {
    'appeal' => account.overturned
        ? l10n
            .ui('ui_notif_appeal_accepted',
                r'Your appeal on case $number was accepted')
            .replaceAll(r'$number', number)
        : l10n
            .ui('ui_notif_appeal_upheld',
                r'We looked at your appeal on case $number again, and the decision stands')
            .replaceAll(r'$number', number),
    'reversal' => l10n
        .ui('ui_notif_reversed', r'We reversed case $number')
        .replaceAll(r'$number', number),
    _ => _decision(l10n, account, locale),
  };
  final detail = account.event == 'decision'
      ? [
          l10n
              .ui('ui_notif_case', r'Case $number · $rule')
              .replaceAll(r'$number', number)
              .replaceAll(r'$rule', ruleLabel(l10n, account.rule)),
          if (row.postSnippet != null) row.postSnippet!,
        ].join(' · ')
      : null;
  return (headline: headline, detail: detail);
}

String _decision(
  AppLocalizations l10n,
  AccountNoticeRow account,
  String? locale,
) =>
    switch (account.kind) {
      ModerationKind.remove => switch (account.target) {
          ReportTarget.post =>
            l10n.ui('ui_notif_removed_post', 'Your post was removed'),
          ReportTarget.comment =>
            l10n.ui('ui_notif_removed_reply', 'Your reply was removed'),
          ReportTarget.communityMessage => l10n.ui('ui_notif_removed_message',
              'Your message in a community chat was removed'),
          _ => l10n.ui(
              'ui_notif_removed_other', 'Something you posted was removed'),
        },
      ModerationKind.warn =>
        l10n.ui('ui_notif_warned', 'Your account has a warning'),
      ModerationKind.suspend => account.endsAt == null
          ? l10n.ui('ui_notif_suspended', 'Your account is suspended')
          : l10n
              .ui('ui_notif_suspended_until',
                  r'Your account is suspended until $date')
              .replaceAll(
                r'$date',
                DateFormat.yMMMd(locale).format(account.endsAt!),
              ),
      ModerationKind.ban =>
        l10n.ui('ui_notif_banned', 'Your account has been banned'),
    };
