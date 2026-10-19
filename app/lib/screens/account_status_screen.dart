// lib/screens/account_status_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../config/legal_links.dart';
import '../models/account_standing.dart';
import '../providers/auth_provider.dart';
import '../providers/enforcement_provider.dart';
import '../repositories/moderation_repository.dart';
import '../routes.dart';
import '../services/app_browser.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';

// ---- Words shared with the team's screens ----------------------------------

final _day = DateFormat('d MMM y');
final _moment = DateFormat('d MMM y, HH:mm');

String standingDay(DateTime when) => _day.format(when);
String standingMoment(DateTime when) => _moment.format(when);

/// What a decision did, as a title: "Post removed", "Suspended for 7 days".
String decisionTitle(ModerationNotice notice) => switch (notice.kind) {
      ModerationKind.remove => notice.target == ReportTarget.comment
          ? 'Reply removed'
          : 'Post removed',
      ModerationKind.warn => 'Warning',
      ModerationKind.suspend => notice.endsAt == null
          ? 'Suspended'
          : 'Suspended for ${_days(notice.createdAt, notice.endsAt!)}',
      ModerationKind.ban => 'Banned',
    };

String _days(DateTime from, DateTime to) {
  final days = (to.difference(from).inHours / 24).round();
  return days == 1 ? '1 day' : '$days days';
}

/// Where an appeal stands, in a few words, or null when there is nothing
/// to say.
String? appealState(ModerationNotice notice) {
  if (notice.reversed) return 'Reversed';
  final appeal = notice.appeal;
  if (appeal != null) {
    return switch (appeal.status) {
      AppealStatus.open => 'Appeal under review',
      AppealStatus.upheld => 'Appealed: the decision stands',
      AppealStatus.overturned => 'Appeal accepted',
    };
  }
  return notice.appealBy == null ? null : 'Can be appealed';
}

IconData decisionIcon(ModerationKind kind) => switch (kind) {
      ModerationKind.remove => Iconsax.trash_copy,
      ModerationKind.warn => Iconsax.warning_2_copy,
      ModerationKind.suspend => Iconsax.timer_pause_copy,
      ModerationKind.ban => Iconsax.slash_copy,
    };

// ---- Account status ------------------------------------------------------------

/// Settings > Account status: everything decided about this account, why,
/// and what came of the things it reported.
///
/// Kyron had a report button and nothing behind it. Now that reports are
/// acted on, the account they are acted against is always told -- here,
/// with the rule, the team's own words and what it said -- and can appeal
/// from the same place.
class AccountStatusScreen extends ConsumerStatefulWidget {
  const AccountStatusScreen({super.key});

  @override
  ConsumerState<AccountStatusScreen> createState() =>
      _AccountStatusScreenState();
}

class _AccountStatusScreenState extends ConsumerState<AccountStatusScreen> {
  @override
  void initState() {
    super.initState();
    // Opening the page is reading it. Best effort: an unread mark that
    // lingers is a dot, not a fault.
    unawaited(
      ref.read(enforcementRepositoryProvider).markSeen().catchError((_) {}),
    );
  }

  Future<void> _open(ModerationNotice notice) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => ModerationNoticeScreen(notice: notice)),
    );
    ref.invalidate(standingProvider);
  }

  @override
  Widget build(BuildContext context) {
    final standing = ref.watch(standingProvider);
    return SettingsScaffold(
      title: 'Account status',
      child: standing.when(
        loading: () => const Padding(
          padding: EdgeInsets.only(top: SpacingTokens.space40),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => EmptyState(
          art: EmptyArt.offline,
          title: 'Account status could not be loaded',
          detail: describeApiError(error, sessionIsLive: true),
          action: 'Try again',
          onAction: () => ref.invalidate(standingProvider),
        ),
        data: (standing) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StandingCard(standing: standing),
            if (standing.notices.isNotEmpty) ...[
              const _Group('Decisions about your account'),
              for (final notice in standing.notices)
                _NoticeTile(notice: notice, onTap: () => _open(notice)),
            ],
            if (standing.reports.isNotEmpty) ...[
              const _Group('Things you reported'),
              for (final report in standing.reports) _ReportTile(report),
            ],
            if (standing.notices.isEmpty && standing.reports.isEmpty) ...[
              const SizedBox(height: SpacingTokens.space16),
              Text(
                'Nothing has been decided about your account. If the team '
                'ever removes something of yours or restricts your account, '
                'it is listed here with the reason, and you can appeal it.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: SpacingTokens.space24),
            TextButton.icon(
              onPressed: () => AppBrowser.open(
                context,
                LegalLinks.terms,
                title: LegalLinks.termsTitle,
              ),
              icon: const Icon(Iconsax.document_text_copy, size: 18),
              label: const Text("Read Kyron's rules"),
            ),
          ],
        ),
      ),
    );
  }
}

/// Where the account stands, at the top of the page.
class StandingCard extends StatelessWidget {
  final AccountStanding standing;

  const StandingCard({super.key, required this.standing});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (icon, title, detail, tint) = switch (standing.status) {
      StandingStatus.active => (
          Iconsax.shield_tick_copy,
          'Your account is in good standing',
          'Nothing is restricting it.',
          scheme.primary,
        ),
      StandingStatus.suspended => (
          Iconsax.timer_pause_copy,
          standing.until == null
              ? 'Your account is suspended'
              : 'Suspended until ${standingMoment(standing.until!)}',
          'You can read, but not post, reply, follow or message until then. '
              'Reporting, blocking and muting still work.',
          scheme.tertiary,
        ),
      StandingStatus.banned => (
          Iconsax.slash_copy,
          'Your account is banned',
          'Only this page, appeals, support and deleting your account still '
              'work.',
          scheme.error,
        ),
    };

    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: tint.withValues(alpha: .25), width: .5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tint, size: 22),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: TypographyTokens.fontSize4,
                  ),
                ),
                const SizedBox(height: SpacingTokens.space4),
                Text(detail, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  final String title;
  const _Group(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: SpacingTokens.space24,
          bottom: SpacingTokens.space4,
        ),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .5),
          ),
        ),
      );
}

class _NoticeTile extends StatelessWidget {
  final ModerationNotice notice;
  final VoidCallback onTap;

  const _NoticeTile({required this.notice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final state = appealState(notice);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(decisionIcon(notice.kind), size: 20),
      title: Text(
        decisionTitle(notice),
        style: TextStyle(
          decoration: notice.reversed ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        [
          notice.rule.label,
          standingDay(notice.createdAt),
          if (state != null) state,
        ].join(' · '),
        style: TextStyle(color: scheme.onSurface.withValues(alpha: .55)),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!notice.seen)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: SpacingTokens.space8),
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          const Icon(Iconsax.arrow_right_3_copy, size: 18),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _ReportTile extends StatelessWidget {
  final ReportUpdate report;
  const _ReportTile(this.report);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final what = switch (report.target) {
      ReportTarget.comment => 'A reply',
      ReportTarget.user => 'An account',
      _ => 'A post',
    };
    final outcome = switch (report.outcome) {
      ReportOutcome.pending => 'Waiting for review',
      ReportOutcome.actioned => 'Action taken',
      ReportOutcome.dismissed => 'No rule broken',
    };
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Iconsax.flag_copy, size: 20),
      title: Text('$what, for ${report.reason.label.toLowerCase()}'),
      subtitle: Text(
        [
          if (report.about != null) report.about!,
          '$outcome · ${standingDay(report.createdAt)}',
        ].join('\n'),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: scheme.onSurface.withValues(alpha: .55)),
      ),
    );
  }
}

// ---- One decision --------------------------------------------------------------

/// One decision: what happened, why, what it was about, and the appeal.
class ModerationNoticeScreen extends ConsumerStatefulWidget {
  final ModerationNotice notice;

  const ModerationNoticeScreen({super.key, required this.notice});

  @override
  ConsumerState<ModerationNoticeScreen> createState() =>
      _ModerationNoticeScreenState();
}

class _ModerationNoticeScreenState
    extends ConsumerState<ModerationNoticeScreen> {
  late ModerationNotice _notice = widget.notice;

  Future<void> _appeal() async {
    final updated = await Navigator.of(context).push<ModerationNotice>(
      MaterialPageRoute(builder: (_) => AppealScreen(notice: _notice)),
    );
    if (updated != null && mounted) setState(() => _notice = updated);
  }

  @override
  Widget build(BuildContext context) {
    final notice = _notice;
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);
    final appeal = notice.appeal;

    return SettingsScaffold(
      title: 'Case ${notice.number}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(decisionIcon(notice.kind), size: 22),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Text(
                  decisionTitle(notice),
                  style: const TextStyle(
                    fontSize: TypographyTokens.fontSize6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            [
              'For breaking the rule on ${notice.rule.label.toLowerCase()}',
              'Decided ${standingMoment(notice.createdAt)}',
              if (notice.kind == ModerationKind.suspend &&
                  notice.endsAt != null)
                'Ends ${standingMoment(notice.endsAt!)}',
            ].join('\n'),
            style: TextStyle(color: faint, height: 1.4),
          ),
          if (notice.reversed) ...[
            const SizedBox(height: SpacingTokens.space16),
            _Callout(
              icon: Iconsax.refresh_circle_copy,
              text: [
                'Reversed on ${standingDay(notice.reversedAt!)}. Anything it '
                    'removed is back, and nothing it restricted still applies.',
                if (notice.reversal != null) notice.reversal!,
              ].join('\n\n'),
            ),
          ],
          const _Heading('What the team said'),
          Quote(notice.message),
          if (notice.snapshot != null) ...[
            _Heading(
              notice.target == ReportTarget.comment
                  ? 'Your reply'
                  : notice.target == ReportTarget.post
                      ? 'Your post'
                      : 'What it was about',
            ),
            Quote(notice.snapshot!, italic: true),
          ],
          const _Heading('Appeal'),
          if (appeal != null) ...[
            Text(appealState(notice) ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              'You wrote, on ${standingDay(appeal.createdAt)}:',
              style: TextStyle(color: faint),
            ),
            const SizedBox(height: SpacingTokens.space4),
            Quote(appeal.statement),
            if (appeal.response != null) ...[
              const SizedBox(height: SpacingTokens.space12),
              Text(
                'The answer, on ${standingDay(appeal.decidedAt ?? appeal.createdAt)}:',
                style: TextStyle(color: faint),
              ),
              const SizedBox(height: SpacingTokens.space4),
              Quote(appeal.response!),
            ] else ...[
              const SizedBox(height: SpacingTokens.space8),
              Text(
                'Somebody else on the team is looking at it again. You will '
                'get a notification when it is decided.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ] else if (notice.reversed) ...[
            Text(
              'Nothing to appeal: the decision was reversed.',
              style: TextStyle(color: faint),
            ),
          ] else if (notice.appealBy != null) ...[
            Text(
              'If you think this was a mistake, you can ask for it to be '
              'looked at again until ${standingDay(notice.appealBy!)}. '
              'Somebody else on the team decides.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: SpacingTokens.space12),
            ActionButton(
              label: 'Appeal this decision',
              icon: Iconsax.message_question_copy,
              expand: true,
              onPressed: _appeal,
            ),
          ] else
            Text(
              'This decision can no longer be appealed. If something is '
              'wrong, contact support.',
              style: TextStyle(color: faint),
            ),
          const SizedBox(height: SpacingTokens.space24),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;
  const _Heading(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: SpacingTokens.space24,
          bottom: SpacingTokens.space8,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: TypographyTokens.fontSize4,
          ),
        ),
      );
}

/// Somebody's words, set apart from the page's own.
class Quote extends StatelessWidget {
  final String text;
  final bool italic;

  const Quote(this.text, {super.key, this.italic = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        border: Border.all(
          color: scheme.onSurface.withValues(alpha: .1),
          width: .5,
        ),
      ),
      child: SelectableText(
        text,
        style: TextStyle(
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          height: 1.4,
        ),
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Callout({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// ---- Appealing ------------------------------------------------------------------

/// Asking for a decision to be looked at again. Once per decision.
class AppealScreen extends ConsumerStatefulWidget {
  final ModerationNotice notice;

  const AppealScreen({super.key, required this.notice});

  /// The server's minimum, so the button can say so before it is pressed.
  static const minLength = 20;

  @override
  ConsumerState<AppealScreen> createState() => _AppealScreenState();
}

class _AppealScreenState extends ConsumerState<AppealScreen> {
  final _statement = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _statement.dispose();
    super.dispose();
  }

  bool get _canSend =>
      !_sending && _statement.text.trim().length >= AppealScreen.minLength;

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final updated = await ref
          .read(enforcementRepositoryProvider)
          .appeal(widget.notice.id, _statement.text.trim());
      if (!mounted) return;
      ref.invalidate(standingProvider);
      Toast.show(
        context,
        'Appeal sent. You will get a notification when it is decided.',
      );
      Navigator.of(context).pop(updated);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(error, sessionIsLive: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SettingsScaffold(
      title: 'Appeal case ${widget.notice.number}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Say why you think the decision was wrong: what the post meant, '
            'what the team may have missed, or why the rule does not fit. '
            'Somebody other than whoever decided reads it.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _statement,
            maxLines: 8,
            maxLength: 2000,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Your appeal',
              alignLabelWithHint: true,
              hintText: 'I was quoting the scam to warn people about it.',
            ),
          ),
          Text(
            'You can appeal each decision once.',
            style: Theme.of(context).textTheme.bodySmall,
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
            label: 'Send appeal',
            expand: true,
            busy: _sending,
            onPressed: _canSend ? _send : null,
          ),
        ],
      ),
    );
  }
}

// ---- Banned ---------------------------------------------------------------------

/// What a banned account sees instead of Kyron.
///
/// Everything else answers it with a refusal, so this is the whole app for
/// it: why, the appeal, support, deleting the account, and signing out. It
/// checks again when asked, so an appeal accepted while it is open lets the
/// account straight back in.
class RestrictedScreen extends ConsumerStatefulWidget {
  const RestrictedScreen({super.key});

  @override
  ConsumerState<RestrictedScreen> createState() => _RestrictedScreenState();
}

class _RestrictedScreenState extends ConsumerState<RestrictedScreen> {
  bool _leaving = false;

  Future<void> _checkAgain() async {
    ref.invalidate(standingProvider);
    final standing = await ref.read(standingProvider.future);
    if (!mounted) return;
    if (standing.status != StandingStatus.banned) {
      ref.read(restrictionProvider.notifier).state = null;
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    }
  }

  Future<void> _signOut() async {
    setState(() => _leaving = true);
    try {
      await ref.read(authNotifierProvider.notifier).logout();
      if (!mounted) return;
      ref.read(restrictionProvider.notifier).state = null;
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } catch (error) {
      if (!mounted) return;
      setState(() => _leaving = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  Future<void> _open(ModerationNotice notice) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(builder: (_) => ModerationNoticeScreen(notice: notice)),
    );
    ref.invalidate(standingProvider);
  }

  @override
  Widget build(BuildContext context) {
    final standing = ref.watch(standingProvider);
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);

    return PopScope(
      // Back has nowhere to go: everything behind this answers with a ban.
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _checkAgain,
            child: ListView(
              padding: const EdgeInsets.all(SpacingTokens.space20),
              children: [
                const SizedBox(height: SpacingTokens.space24),
                const Icon(Iconsax.slash_copy, size: 40),
                const SizedBox(height: SpacingTokens.space16),
                const Text(
                  'Your account has been banned',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: SpacingTokens.space24),
                standing.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, _) => Text(
                    describeApiError(error, sessionIsLive: true),
                    textAlign: TextAlign.center,
                  ),
                  data: (standing) {
                    final notice = standing.restrictedBy;
                    if (notice == null) {
                      return Text(
                        'Pull down to check again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: faint),
                      );
                    }
                    final state = appealState(notice);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Case ${notice.number}, for breaking the rule on '
                          '${notice.rule.label.toLowerCase()}. The team said:',
                          style: TextStyle(color: faint),
                        ),
                        const SizedBox(height: SpacingTokens.space8),
                        Quote(notice.message),
                        const SizedBox(height: SpacingTokens.space16),
                        ActionButton(
                          label:
                              notice.appeal == null && notice.appealBy != null
                                  ? 'See details and appeal'
                                  : 'See details',
                          icon: Iconsax.document_text_copy,
                          expand: true,
                          onPressed: () => _open(notice),
                        ),
                        if (state != null && notice.appeal != null) ...[
                          const SizedBox(height: SpacingTokens.space8),
                          Text(
                            state,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: faint),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: SpacingTokens.space24),
                const Hairline(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Iconsax.message_question_copy, size: 20),
                  title: const Text('Contact support'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.settingsContactSupport,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Iconsax.document_text_copy, size: 20),
                  title: const Text("Read Kyron's rules"),
                  onTap: () => AppBrowser.open(
                    context,
                    LegalLinks.terms,
                    title: LegalLinks.termsTitle,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Iconsax.trash_copy, size: 20),
                  title: const Text('Delete your account'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.deleteAccount),
                ),
                const SizedBox(height: SpacingTokens.space16),
                ActionButton(
                  label: 'Sign out',
                  icon: Iconsax.logout_copy,
                  kind: ActionButtonKind.outlined,
                  expand: true,
                  busy: _leaving,
                  onPressed: _signOut,
                ),
                const SizedBox(height: SpacingTokens.space12),
                Text(
                  'Deleting your account does not lift a ban: a new account '
                  'at the same email address starts banned too.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
