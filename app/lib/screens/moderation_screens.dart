// lib/screens/moderation_screens.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/account_standing.dart';
import '../models/moderation_case.dart';
import '../providers/current_user_provider.dart';
import '../models/verification.dart';
import '../providers/enforcement_provider.dart';
import '../providers/verification_provider.dart';
import '../services/app_browser.dart';
import '../widgets/verified_badge.dart';
import '../repositories/moderation_repository.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/section_tabs.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';
import 'account_status_screen.dart';

/// The team's side of enforcement: what has been reported, what has been
/// appealed, and the decisions.
///
/// Reports used to be written down and read by nobody -- there was no
/// screen to read them on. Everything here is checked again by the server,
/// which answers 404 to an account that is not on the team; the app only
/// offers the way in to one /profile/me says is.

// ---- The queues ----------------------------------------------------------------

class ModerationQueueScreen extends ConsumerStatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  ConsumerState<ModerationQueueScreen> createState() =>
      _ModerationQueueScreenState();
}

class _ModerationQueueScreenState extends ConsumerState<ModerationQueueScreen>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _openReport(ReportCase item) async {
    final decided = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => ReportCaseScreen(item: item)),
    );
    if (decided ?? false) ref.invalidate(reportQueueProvider);
  }

  Future<void> _openVerification(VerificationCase item) async {
    final decided = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => VerificationCaseScreen(item: item),
      ),
    );
    if (decided ?? false) ref.invalidate(verificationQueueProvider);
  }

  Future<void> _openAppeal(AppealCase item) async {
    final decided = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => AppealCaseScreen(appeal: item)),
    );
    if (decided ?? false) ref.invalidate(appealQueueProvider);
  }

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportQueueProvider);
    final appeals = ref.watch(appealQueueProvider);
    final verifications = ref.watch(verificationQueueProvider);
    String count(AsyncValue<List<Object>> value) =>
        value.value?.isNotEmpty ?? false ? ' (${value.value!.length})' : '';

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Moderation'),
        bottom: SectionTabs(
          controller: _tabs,
          labels: [
            'Reports${count(reports)}',
            'Appeals${count(appeals)}',
            'Badges${count(verifications)}',
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabs,
          children: [
            _Queue<ReportCase>(
              value: reports,
              onRefresh: () async => ref.invalidate(reportQueueProvider),
              emptyTitle: 'Nothing reported',
              emptyDetail: 'Reports land here, one entry per reported '
                  'thing, with the urgent ones first.',
              item: (item) => _ReportTile(item, () => _openReport(item)),
            ),
            _Queue<AppealCase>(
              value: appeals,
              onRefresh: () async => ref.invalidate(appealQueueProvider),
              emptyTitle: 'No appeals waiting',
              emptyDetail: 'When somebody asks for a decision to be looked '
                  'at again, it lands here.',
              item: (item) => _AppealTile(item, () => _openAppeal(item)),
            ),
            _Queue<VerificationCase>(
              value: verifications,
              onRefresh: () async => ref.invalidate(verificationQueueProvider),
              emptyTitle: 'Nobody waiting for a badge',
              emptyDetail: 'Requests to be verified land here, oldest first.',
              item: (item) =>
                  _VerificationTile(item, () => _openVerification(item)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Queue<T> extends StatelessWidget {
  final AsyncValue<List<T>> value;
  final Future<void> Function() onRefresh;
  final String emptyTitle;
  final String emptyDetail;
  final Widget Function(T item) item;

  const _Queue({
    required this.value,
    required this.onRefresh,
    required this.emptyTitle,
    required this.emptyDetail,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => EmptyState(
        art: EmptyArt.offline,
        title: 'The queue could not be loaded',
        detail: describeApiError(error, sessionIsLive: true),
        action: 'Try again',
        onAction: onRefresh,
      ),
      data: (items) => RefreshIndicator(
        onRefresh: onRefresh,
        child: items.isEmpty
            ? ListView(
                children: [
                  EmptyState(
                    art: EmptyArt.caughtUp,
                    title: emptyTitle,
                    detail: emptyDetail,
                  ),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space20,
                  vertical: SpacingTokens.space8,
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Hairline(),
                itemBuilder: (_, i) => item(items[i]),
              ),
      ),
    );
  }
}

String _whose(ReportCase item) {
  final who = item.subject?.handle ?? 'a deleted account';
  return switch (item.target) {
    ReportTarget.comment => 'Reply by $who',
    ReportTarget.user => 'Account $who',
    _ => 'Post by $who',
  };
}

class _ReportTile extends StatelessWidget {
  final ReportCase item;
  final VoidCallback onTap;

  const _ReportTile(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);
    final excerpt = item.content ?? item.snapshot;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        item.urgent ? Iconsax.danger_copy : Iconsax.flag_copy,
        size: 20,
        color: item.urgent ? scheme.error : null,
      ),
      title: Text(_whose(item)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (excerpt != null)
            Text(excerpt, maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(
            [
              for (final r in item.reasons)
                r.count > 1 ? '${r.reason.label} ×${r.count}' : r.reason.label,
              'since ${standingDay(item.firstAt)}',
            ].join(' · '),
            style: TextStyle(color: item.urgent ? scheme.error : faint),
          ),
        ],
      ),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
      onTap: onTap,
    );
  }
}

class _AppealTile extends StatelessWidget {
  final AppealCase item;
  final VoidCallback onTap;

  const _AppealTile(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    final notice = item.action.notice;
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(decisionIcon(notice.kind), size: 20),
      title: Text(
        'Case ${notice.number}: ${decisionTitle(notice)}, '
        '${item.action.subject?.handle ?? 'a deleted account'}',
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.statement, maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(
            '${notice.rule.label} · appealed ${standingDay(item.createdAt)}'
            '${item.ownDecision ? ' · your decision' : ''}',
            style: TextStyle(color: faint),
          ),
        ],
      ),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
      onTap: onTap,
    );
  }
}

class _VerificationTile extends StatelessWidget {
  final VerificationCase item;
  final VoidCallback onTap;

  const _VerificationTile(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    final ready = item.requirements.every((r) => r.met);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        foregroundImage:
            item.avatarUrl == null ? null : NetworkImage(item.avatarUrl!),
        child: const Icon(Iconsax.user_copy, size: 18),
      ),
      title:
          Text('${item.name ?? item.handle} · ${item.request.category.label}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.request.about,
              maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(
            'Request ${item.request.number} · sent '
            '${standingDay(item.request.createdAt)}'
            '${ready ? '' : ' · no longer meets the requirements'}',
            style: TextStyle(color: faint),
          ),
        ],
      ),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
      onTap: onTap,
    );
  }
}

/// One request for the badge: who, what they say, and where to check.
class VerificationCaseScreen extends ConsumerStatefulWidget {
  final VerificationCase item;

  const VerificationCaseScreen({super.key, required this.item});

  @override
  ConsumerState<VerificationCaseScreen> createState() =>
      _VerificationCaseScreenState();
}

class _VerificationCaseScreenState
    extends ConsumerState<VerificationCaseScreen> {
  bool _sending = false;

  Future<void> _answer({required bool approve}) async {
    final item = widget.item;
    String? response;
    if (approve) {
      final sure = await confirmSheet(
        context,
        title: 'Verify ${item.name ?? item.handle}?',
        detail: 'The badge shows beside their name everywhere, and they are '
            'told. Only say yes if the links show this account is theirs.',
        confirm: 'Verify',
      );
      if (!sure) return;
    } else {
      response = await askForText(
        context,
        title: 'Turn this request down?',
        detail: 'They are told, with what you write here, and can ask again '
            'in 30 days. Say what would have made it a yes.',
        hint: 'What was missing',
        confirm: 'Turn down',
      );
      if (response == null) return;
    }
    if (!mounted) return;
    setState(() => _sending = true);
    try {
      await ref.read(verificationRepositoryProvider).decide(
            item.request.id,
            approve: approve,
            response: response,
          );
      if (!mounted) return;
      Toast.show(context, approve ? 'Verified.' : 'Turned down.');
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _sending = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);
    return SettingsScaffold(
      title: 'Request ${item.request.number}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.ownRequest) ...[
            const _Warning(
              'This is your own request, so somebody else on the team has '
              'to answer it.',
            ),
            const SizedBox(height: SpacingTokens.space16),
          ],
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 22,
              foregroundImage:
                  item.avatarUrl == null ? null : NetworkImage(item.avatarUrl!),
              child: const Icon(Iconsax.user_copy, size: 20),
            ),
            title: Text(item.name ?? item.handle),
            subtitle: Text(
              [
                if (item.username != null) '@${item.username}',
                '${item.followers} followers',
                '${item.posts} posts',
                if (item.joined != null) 'joined ${standingDay(item.joined!)}',
              ].join(' · '),
              style: TextStyle(color: faint),
            ),
            trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.moderationAccount,
              arguments: item.accountId,
            ),
          ),
          if (item.bio != null) Text(item.bio!, style: TextStyle(color: faint)),
          _Heading('As ${item.request.category.label.toLowerCase()}, they say'),
          Quote(item.request.about),
          const _Heading('Where to check'),
          for (final link in item.request.links)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.link_21_copy, size: 20),
              title: Text(link, maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Iconsax.export_3_copy, size: 16),
              onTap: () => AppBrowser.open(context, link),
            ),
          Text(
            'Look for this Kyron account named on the page -- its name, or a '
            'link to it. A page that does not mention Kyron proves the page '
            'is theirs, not that this account is.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const _Heading('Requirements, as they stand now'),
          for (final r in item.requirements)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    r.met ? Iconsax.tick_circle : Iconsax.close_circle_copy,
                    size: 18,
                    color: r.met ? scheme.primary : scheme.error,
                  ),
                  const SizedBox(width: SpacingTokens.space8),
                  Expanded(child: Text(r.label)),
                ],
              ),
            ),
          const SizedBox(height: SpacingTokens.space24),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  label: 'Turn down',
                  kind: ActionButtonKind.outlined,
                  expand: true,
                  busy: _sending,
                  onPressed:
                      item.ownRequest ? null : () => _answer(approve: false),
                ),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: ActionButton(
                  label: 'Verify',
                  icon: Iconsax.verify_copy,
                  expand: true,
                  busy: _sending,
                  onPressed:
                      item.ownRequest ? null : () => _answer(approve: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space24),
        ],
      ),
    );
  }
}

// ---- One reported thing --------------------------------------------------------

class ReportCaseScreen extends ConsumerStatefulWidget {
  final ReportCase item;

  const ReportCaseScreen({super.key, required this.item});

  @override
  ConsumerState<ReportCaseScreen> createState() => _ReportCaseScreenState();
}

class _ReportCaseScreenState extends ConsumerState<ReportCaseScreen> {
  bool _dismissing = false;

  Future<void> _dismiss() async {
    final sure = await confirmSheet(
      context,
      title: 'Dismiss these reports?',
      detail: 'Nothing happens to ${widget.item.subject?.handle ?? 'it'}. '
          'Whoever reported it is told the team found no rule broken.',
      confirm: 'Dismiss',
    );
    if (!sure || !mounted) return;
    setState(() => _dismissing = true);
    try {
      await ref
          .read(enforcementRepositoryProvider)
          .dismiss(widget.item.target, widget.item.targetId);
      if (!mounted) return;
      Toast.show(context, 'Dismissed.');
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _dismissing = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  Future<void> _decide() async {
    final item = widget.item;
    final subject = item.subject;
    if (subject == null) return;
    final decided = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => DecisionScreen(
          subject: subject,
          target: item.isContent ? item.target : null,
          targetId: item.isContent ? item.targetId : null,
          contentGone: item.isContent && item.content == null,
          rule: item.likelyRule,
        ),
      ),
    );
    if ((decided ?? false) && mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final subject = item.subject;
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);

    return SettingsScaffold(
      title: 'Report',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.urgent) ...[
            const _Warning(
              'Somebody may be at risk. If anybody is in immediate danger, '
              'contact the emergency services where they are. Material that '
              'sexualises a child must be removed and reported to the '
              'authorities, not only taken down: see docs/MODERATION.md.',
            ),
            const SizedBox(height: SpacingTokens.space16),
          ],
          Text(
            _whose(item),
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize5,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (item.isContent) ...[
            const SizedBox(height: SpacingTokens.space12),
            if (item.content != null)
              Quote(item.content!)
            else ...[
              if (item.snapshot != null) Quote(item.snapshot!, italic: true),
              const SizedBox(height: SpacingTokens.space4),
              Text(
                'Already deleted. This is the copy kept when it was first '
                'reported.',
                style: TextStyle(color: faint),
              ),
            ],
            if (item.postId != null && item.content != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.postDetail,
                    arguments: item.postId,
                  ),
                  icon: const Icon(Iconsax.export_3_copy, size: 16),
                  label: Text(
                    item.target == ReportTarget.comment
                        ? 'Open the post it is on'
                        : 'Open the post',
                  ),
                ),
              ),
          ],
          if (subject != null) ...[
            const _Heading('Whose'),
            AccountLine(account: subject),
          ],
          _Heading('Reports (${item.reports.length})'),
          for (final report in item.reports)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.reason.label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (report.detail != null) Text(report.detail!),
                  Text(
                    '${report.reporter == null ? 'Somebody' : '@${report.reporter}'}'
                    ', ${standingMoment(report.createdAt)}',
                    style: TextStyle(color: faint),
                  ),
                ],
              ),
            ),
          const SizedBox(height: SpacingTokens.space16),
          Row(
            children: [
              ActionButton(
                label: 'Dismiss',
                kind: ActionButtonKind.outlined,
                busy: _dismissing,
                onPressed: _dismiss,
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: ActionButton(
                  label: 'Decide',
                  icon: Iconsax.judge_copy,
                  expand: true,
                  onPressed: subject == null ? null : _decide,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space24),
        ],
      ),
    );
  }
}

/// An account in one line, for beside a case: handle, standing, record.
class AccountLine extends StatelessWidget {
  final CaseAccount account;

  const AccountLine({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    final standing = switch (account.status) {
      StandingStatus.banned => 'banned',
      StandingStatus.suspended => account.suspendedUntil == null
          ? 'suspended'
          : 'suspended until ${standingDay(account.suspendedUntil!)}',
      StandingStatus.active => 'in good standing',
    };
    final record = account.standingActions == 0
        ? 'no decisions on record'
        : account.standingActions == 1
            ? '1 decision on record'
            : '${account.standingActions} decisions on record';
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        foregroundImage:
            account.avatarUrl == null ? null : NetworkImage(account.avatarUrl!),
        child: const Icon(Iconsax.user_copy, size: 18),
      ),
      title: NameWithBadge(
        name: [
          account.handle,
          if (account.onTeam) '(${account.role.toLowerCase()})',
        ].join(' '),
        verified: account.verified,
      ),
      subtitle: Text(
        [
          standing,
          record,
          if (account.createdAt != null)
            'joined ${standingDay(account.createdAt!)}',
        ].join(' · '),
        style: TextStyle(color: faint),
      ),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
      onTap: () => Navigator.pushNamed(
        context,
        Routes.moderationAccount,
        arguments: account.id,
      ),
    );
  }
}

// ---- Deciding --------------------------------------------------------------------

/// What the account is told, to start from: the rule in a sentence, and what
/// the decision does. The moderator edits it -- a template alone reads as a
/// machine, and the point is that a person looked.
String noticeTemplate({
  required ReportReason rule,
  required ModerationKind kind,
  required ReportTarget? target,
  required bool removing,
  int days = 7,
}) {
  final what = switch (target) {
    ReportTarget.comment => 'This reply',
    ReportTarget.post => 'This post',
    _ => 'Your account',
  };
  final why = switch (rule) {
    ReportReason.spam =>
      'Kyron does not allow repetitive, misleading or unwanted promotion.',
    ReportReason.harassment =>
      'Kyron does not allow abuse, threats or unwanted contact aimed at a '
          'person.',
    ReportReason.hate =>
      'Kyron does not allow attacking people for who they are.',
    ReportReason.violence =>
      'Kyron does not allow threatening, glorifying or inciting harm.',
    ReportReason.selfHarm =>
      'Kyron does not allow encouraging or depicting self-harm. If you are '
          'struggling, please talk to someone you trust or a local helpline.',
    ReportReason.sexualContent =>
      'Kyron does not allow sexual content shown without warning.',
    ReportReason.childSafety =>
      'Kyron does not allow anything that endangers or sexualises a minor.',
    ReportReason.misinformation =>
      'Kyron does not allow misleading claims about health, elections or '
          'events that could cause harm.',
    ReportReason.impersonation =>
      'Kyron does not allow pretending to be somebody else.',
    ReportReason.intellectualProperty =>
      "Kyron does not allow using somebody else's work or trademark without "
          'permission.',
    ReportReason.illegalGoods =>
      'Kyron does not allow selling or promoting anything unlawful.',
    ReportReason.somethingElse => "It goes against Kyron's rules.",
  };
  final did = switch (kind) {
    ModerationKind.remove => 'It has been removed.',
    ModerationKind.warn => removing
        ? 'It has been removed, and this is a warning: nothing else is '
            'restricted, but it stays on your record.'
        : 'This is a warning: nothing is restricted, but it stays on your '
            'record.',
    ModerationKind.suspend =>
      '${removing ? 'It has been removed, and your' : 'Your'} account can '
          'read but not post for ${days == 1 ? '1 day' : '$days days'}.',
    ModerationKind.ban =>
      '${removing ? 'It has been removed, and your' : 'Your'} account is '
          'banned.',
  };
  final opening = target == null
      ? "$what broke Kyron's rule on ${rule.label.toLowerCase()}."
      : "$what broke Kyron's rule on ${rule.label.toLowerCase()}.";
  return '$opening $why $did';
}

class DecisionScreen extends ConsumerStatefulWidget {
  final CaseAccount subject;

  /// The post or reply it is about, if it is about one.
  final ReportTarget? target;
  final String? targetId;

  /// Its author already deleted it: nothing to take down.
  final bool contentGone;
  final ReportReason rule;

  const DecisionScreen({
    super.key,
    required this.subject,
    this.target,
    this.targetId,
    this.contentGone = false,
    this.rule = ReportReason.somethingElse,
  });

  @override
  ConsumerState<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends ConsumerState<DecisionScreen> {
  late ModerationKind _kind =
      widget.target != null ? ModerationKind.remove : ModerationKind.warn;
  late ReportReason _rule = widget.rule;
  late bool _remove = widget.target != null && !widget.contentGone;
  int _days = 7;
  final _message = TextEditingController();
  final _note = TextEditingController();

  /// Whether the moderator has written their own; then the template stops
  /// following the choices above it.
  bool _edited = false;
  bool _sending = false;
  String? _error;

  bool get _aboutContent => widget.target != null;

  @override
  void initState() {
    super.initState();
    _refill();
  }

  @override
  void dispose() {
    _message.dispose();
    _note.dispose();
    super.dispose();
  }

  void _refill() {
    if (_edited) return;
    _message.text = noticeTemplate(
      rule: _rule,
      kind: _kind,
      target: widget.target,
      removing: _remove,
      days: _days,
    );
  }

  void _choose(VoidCallback change) {
    setState(change);
    setState(_refill);
  }

  String get _verb => switch (_kind) {
        ModerationKind.remove => widget.target == ReportTarget.comment
            ? 'Remove the reply'
            : 'Remove the post',
        ModerationKind.warn => 'Send warning',
        ModerationKind.suspend =>
          'Suspend for ${_days == 1 ? '1 day' : '$_days days'}',
        ModerationKind.ban => 'Ban ${widget.subject.handle}',
      };

  Future<void> _send() async {
    if (_kind == ModerationKind.ban) {
      final sure = await confirmSheet(
        context,
        title: 'Ban ${widget.subject.handle}?',
        detail: 'Their posts disappear for everybody, and they can only see '
            'why, appeal, contact support or delete their account. A new '
            'account at the same email address starts banned too.',
        confirm: 'Ban',
        destructive: true,
      );
      if (!sure || !mounted) return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final action = await ref.read(enforcementRepositoryProvider).act(
            kind: _kind,
            rule: _rule,
            message: _message.text.trim(),
            note: _note.text.trim(),
            subjectId: widget.subject.id,
            target: widget.target,
            targetId: widget.targetId,
            removeContent: _kind == ModerationKind.remove || _remove,
            days: _days,
          );
      if (!mounted) return;
      Toast.show(
        context,
        'Case ${action.notice.number} decided. ${widget.subject.handle} '
        'has been told.',
      );
      Navigator.of(context).pop(true);
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
    final kinds = [
      if (_aboutContent && !widget.contentGone) ModerationKind.remove,
      ModerationKind.warn,
      ModerationKind.suspend,
      ModerationKind.ban,
    ];
    String kindLabel(ModerationKind kind) => switch (kind) {
          ModerationKind.remove => 'Remove only',
          ModerationKind.warn => 'Warn',
          ModerationKind.suspend => 'Suspend',
          ModerationKind.ban => 'Ban',
        };

    return SettingsScaffold(
      title: 'Decide',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AccountLine(account: widget.subject),
          const _Heading('What happens'),
          Wrap(
            spacing: SpacingTokens.space8,
            runSpacing: SpacingTokens.space8,
            children: [
              for (final kind in kinds)
                ChoiceChip(
                  label: Text(kindLabel(kind)),
                  selected: _kind == kind,
                  onSelected: (_) => _choose(() => _kind = kind),
                ),
            ],
          ),
          if (_aboutContent &&
              !widget.contentGone &&
              _kind != ModerationKind.remove)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                widget.target == ReportTarget.comment
                    ? 'Take the reply down too'
                    : 'Take the post down too',
              ),
              value: _remove,
              onChanged: (value) => _choose(() => _remove = value),
            ),
          if (_kind == ModerationKind.suspend) ...[
            const SizedBox(height: SpacingTokens.space12),
            Wrap(
              spacing: SpacingTokens.space8,
              children: [
                for (final days in const [1, 3, 7, 30])
                  ChoiceChip(
                    label: Text(days == 1 ? '1 day' : '$days days'),
                    selected: _days == days,
                    onSelected: (_) => _choose(() => _days = days),
                  ),
              ],
            ),
          ],
          const _Heading('Which rule'),
          DropdownButtonFormField<ReportReason>(
            initialValue: _rule,
            isExpanded: true,
            items: [
              for (final reason in ReportReason.values)
                DropdownMenuItem(value: reason, child: Text(reason.label)),
            ],
            onChanged: (value) {
              if (value != null) _choose(() => _rule = value);
            },
          ),
          const _Heading('What they are told'),
          TextField(
            controller: _message,
            maxLines: 6,
            maxLength: 2000,
            onChanged: (_) => setState(() => _edited = true),
            decoration: const InputDecoration(
              helperText: 'Sent to them as written, with the case number '
                  'and a way to appeal.',
              helperMaxLines: 2,
            ),
          ),
          const _Heading('A note for the team'),
          TextField(
            controller: _note,
            maxLines: 3,
            maxLength: 2000,
            decoration: const InputDecoration(
              hintText: 'Optional. Never shown to them.',
            ),
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
            label: _verb,
            expand: true,
            busy: _sending,
            destructive: _kind == ModerationKind.ban,
            onPressed: _message.text.trim().length < 20 ? null : _send,
          ),
          const SizedBox(height: SpacingTokens.space24),
        ],
      ),
    );
  }
}

// ---- One account's record --------------------------------------------------

class ModerationAccountScreen extends ConsumerWidget {
  final String accountId;

  const ModerationAccountScreen({super.key, required this.accountId});

  /// Gives or takes the badge without a request, on the record.
  Future<void> _setBadge(
    BuildContext context,
    WidgetRef ref,
    CaseAccount account,
  ) async {
    final giving = !account.verified;
    final who = account.name ?? account.handle;
    final reason = await askForText(
      context,
      title: giving ? 'Verify $who?' : 'Remove $who\'s badge?',
      detail: giving
          ? 'The badge shows beside their name everywhere, and they are '
              'told. Say how you know it is them.'
          : 'They are told, with what you write here, and can ask again.',
      hint: giving ? 'How you checked' : 'Why it comes off',
      confirm: giving ? 'Verify' : 'Remove',
    );
    if (reason == null || !context.mounted) return;
    try {
      await ref
          .read(verificationRepositoryProvider)
          .setVerified(account.id, verified: giving, reason: reason);
      ref.invalidate(accountRecordProvider(accountId));
      if (context.mounted) {
        Toast.show(context, giving ? 'Verified.' : 'Badge removed.');
      }
    } catch (error) {
      if (context.mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  Future<void> _reverse(
    BuildContext context,
    WidgetRef ref,
    CaseAction action,
  ) async {
    final reason = await askForText(
      context,
      title: 'Reverse case ${action.notice.number}?',
      detail: 'Anything it removed comes back and anything it restricted '
          'lifts. They are told, with what you write here.',
      hint: 'Why it was a mistake',
      confirm: 'Reverse',
    );
    if (reason == null || !context.mounted) return;
    try {
      await ref
          .read(enforcementRepositoryProvider)
          .reverse(action.notice.id, reason);
      ref.invalidate(accountRecordProvider(accountId));
      if (context.mounted) Toast.show(context, 'Reversed.');
    } catch (error) {
      if (context.mounted) {
        Toast.show(context, describeApiError(error, sessionIsLive: true));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(accountRecordProvider(accountId));
    final me = ref.watch(currentUserProvider).value?.id;
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    return SettingsScaffold(
      title: 'Account record',
      child: record.when(
        loading: () => const Padding(
          padding: EdgeInsets.only(top: SpacingTokens.space40),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => EmptyState(
          art: EmptyArt.offline,
          title: 'The record could not be loaded',
          detail: describeApiError(error, sessionIsLive: true),
          action: 'Try again',
          onAction: () => ref.invalidate(accountRecordProvider(accountId)),
        ),
        data: (record) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NameWithBadge(
              name: record.account.name ?? record.account.handle,
              verified: record.account.verified,
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize5,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              [
                record.account.handle,
                if (record.openReports > 0)
                  '${record.openReports} open report'
                      '${record.openReports == 1 ? '' : 's'} about the account',
              ].join(' · '),
              style: TextStyle(color: faint),
            ),
            const SizedBox(height: SpacingTokens.space16),
            ActionButton(
              label: 'Decide about this account',
              icon: Iconsax.judge_copy,
              expand: true,
              onPressed: () async {
                final decided = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => DecisionScreen(subject: record.account),
                  ),
                );
                if (decided ?? false) {
                  ref.invalidate(accountRecordProvider(accountId));
                }
              },
            ),
            const SizedBox(height: SpacingTokens.space8),
            ActionButton(
              label: record.account.verified
                  ? 'Remove the verified badge'
                  : 'Give the verified badge',
              icon: Iconsax.verify_copy,
              kind: ActionButtonKind.outlined,
              expand: true,
              // Nobody gives themselves the badge, or takes it off.
              onPressed: record.account.id == me
                  ? null
                  : () => _setBadge(context, ref, record.account),
            ),
            const _Heading('Decisions'),
            if (record.actions.isEmpty)
              Text('None.', style: TextStyle(color: faint)),
            for (final action in record.actions) ...[
              _RecordEntry(
                action: action,
                onReverse: action.notice.reversed
                    ? null
                    : () => _reverse(context, ref, action),
              ),
              const Hairline(),
            ],
            const SizedBox(height: SpacingTokens.space24),
          ],
        ),
      ),
    );
  }
}

class _RecordEntry extends StatelessWidget {
  final CaseAction action;
  final VoidCallback? onReverse;

  const _RecordEntry({required this.action, this.onReverse});

  @override
  Widget build(BuildContext context) {
    final notice = action.notice;
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    final state = appealState(notice);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(decisionIcon(notice.kind), size: 18),
              const SizedBox(width: SpacingTokens.space8),
              Expanded(
                child: Text(
                  'Case ${notice.number}: ${decisionTitle(notice)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration:
                        notice.reversed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              if (onReverse != null)
                TextButton(onPressed: onReverse, child: const Text('Reverse')),
            ],
          ),
          Text(
            [
              notice.rule.label,
              standingDay(notice.createdAt),
              if (action.moderator != null) 'by @${action.moderator}',
              if (state != null) state,
            ].join(' · '),
            style: TextStyle(color: faint),
          ),
          const SizedBox(height: SpacingTokens.space4),
          Text(notice.message),
          if (action.note != null) ...[
            const SizedBox(height: SpacingTokens.space4),
            Text('Team note: ${action.note}', style: TextStyle(color: faint)),
          ],
          if (notice.reversal != null) ...[
            const SizedBox(height: SpacingTokens.space4),
            Text('Reversed: ${notice.reversal}',
                style: TextStyle(color: faint)),
          ],
        ],
      ),
    );
  }
}

// ---- One appeal ------------------------------------------------------------------

class AppealCaseScreen extends ConsumerStatefulWidget {
  final AppealCase appeal;

  const AppealCaseScreen({super.key, required this.appeal});

  @override
  ConsumerState<AppealCaseScreen> createState() => _AppealCaseScreenState();
}

class _AppealCaseScreenState extends ConsumerState<AppealCaseScreen> {
  bool _sending = false;

  Future<void> _decide({required bool overturn}) async {
    final response = await askForText(
      context,
      title: overturn ? 'Overturn the decision?' : 'Uphold the decision?',
      detail: overturn
          ? 'Anything it removed comes back and anything it restricted '
              'lifts. They are told, with what you write here.'
          : 'Nothing changes. They are told, with what you write here, and '
              'cannot appeal this decision again.',
      hint: overturn
          ? 'What the first decision missed'
          : 'Why the decision stands',
      confirm: overturn ? 'Overturn' : 'Uphold',
    );
    if (response == null || !mounted) return;
    setState(() => _sending = true);
    try {
      await ref.read(enforcementRepositoryProvider).decide(
            widget.appeal.id,
            overturn: overturn,
            response: response,
          );
      if (!mounted) return;
      Toast.show(context, overturn ? 'Overturned.' : 'Upheld.');
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _sending = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appeal = widget.appeal;
    final notice = appeal.action.notice;
    final subject = appeal.action.subject;
    final faint =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: .55);
    final isAdmin = ref.watch(currentUserProvider).value?.role == 'ADMIN';
    // The server refuses it anyway; this says why before anybody tries.
    final barred = appeal.ownDecision && !isAdmin;

    return SettingsScaffold(
      title: 'Appeal on case ${notice.number}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (appeal.ownDecision) ...[
            _Warning(
              barred
                  ? 'You made this decision, so somebody else on the team '
                      'has to hear its appeal.'
                  : 'You made this decision. As an admin you can still '
                      'decide its appeal when there is nobody else, and the '
                      'record will show it.',
            ),
            const SizedBox(height: SpacingTokens.space16),
          ],
          if (subject != null) AccountLine(account: subject),
          _Heading(decisionTitle(notice)),
          Text(
            [
              notice.rule.label,
              standingMoment(notice.createdAt),
              if (appeal.action.moderator != null)
                'by @${appeal.action.moderator}',
            ].join(' · '),
            style: TextStyle(color: faint),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Quote(notice.message),
          if (appeal.action.note != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            Text('Team note: ${appeal.action.note}',
                style: TextStyle(color: faint)),
          ],
          if (notice.snapshot != null) ...[
            const _Heading('What it was about'),
            Quote(notice.snapshot!, italic: true),
          ],
          const _Heading('Their appeal'),
          Quote(appeal.statement),
          Text(
            'Sent ${standingMoment(appeal.createdAt)}',
            style: TextStyle(color: faint),
          ),
          const SizedBox(height: SpacingTokens.space24),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  label: 'Uphold',
                  kind: ActionButtonKind.outlined,
                  expand: true,
                  busy: _sending,
                  onPressed: barred ? null : () => _decide(overturn: false),
                ),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: ActionButton(
                  label: 'Overturn',
                  expand: true,
                  busy: _sending,
                  onPressed: barred ? null : () => _decide(overturn: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingTokens.space24),
        ],
      ),
    );
  }
}

// ---- Small pieces ----------------------------------------------------------------

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

class _Warning extends StatelessWidget {
  final String text;
  const _Warning(this.text);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.danger_copy, size: 18, color: scheme.error),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/// Asks once more before something that is hard to take back.
Future<bool> confirmSheet(
  BuildContext context, {
  required String title,
  required String detail,
  required String confirm,
  bool destructive = false,
}) async {
  final sure = await showModalBottomSheet<bool>(
    context: context,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpacingTokens.space8),
            Text(detail),
            const SizedBox(height: SpacingTokens.space24),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: MaterialLocalizations.of(context).cancelButtonLabel,
                    kind: ActionButtonKind.outlined,
                    expand: true,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: ActionButton(
                    label: confirm,
                    expand: true,
                    destructive: destructive,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return sure ?? false;
}

/// Asks for a few words -- why, or what to tell them -- before going ahead.
/// Null when it was cancelled.
Future<String?> askForText(
  BuildContext context, {
  required String title,
  required String detail,
  required String hint,
  required String confirm,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _TextSheet(
      title: title,
      detail: detail,
      hint: hint,
      confirm: confirm,
    ),
  );
}

class _TextSheet extends StatefulWidget {
  final String title;
  final String detail;
  final String hint;
  final String confirm;

  const _TextSheet({
    required this.title,
    required this.detail,
    required this.hint,
    required this.confirm,
  });

  @override
  State<_TextSheet> createState() => _TextSheetState();
}

class _TextSheetState extends State<_TextSheet> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SpacingTokens.space20,
        right: SpacingTokens.space20,
        top: SpacingTokens.space20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + SpacingTokens.space20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize6,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(widget.detail),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            controller: _text,
            autofocus: true,
            maxLines: 4,
            maxLength: 2000,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(hintText: widget.hint),
          ),
          const SizedBox(height: SpacingTokens.space8),
          ActionButton(
            label: widget.confirm,
            expand: true,
            onPressed: _text.text.trim().length < 10
                ? null
                : () => Navigator.pop(context, _text.text.trim()),
          ),
        ],
      ),
    );
  }
}
