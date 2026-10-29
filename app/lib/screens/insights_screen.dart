// lib/screens/insights_screen.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/insights_report.dart';
import '../providers/insights_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';
import '../widgets/country_sheet.dart';
import '../widgets/empty_state.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/section_tabs.dart';

/// How your account is doing, who is seeing it, and what to do next.
///
/// Opened from the chart button beside Share on your own profile. Only your
/// own: the API answers about the signed-in account and nobody else.
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 2, vsync: this);
  int _days = 30;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final report = ref.watch(insightsProvider(_days));

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(_t(context, 'ins_title', 'Insights')),
        bottom: SectionTabs(
          controller: _tabs,
          labels: [
            _t(context, 'ins_tab_overview', 'Overview'),
            _t(context, 'ins_tab_audience', 'Audience'),
          ],
        ),
      ),
      body: SafeArea(
        child: report.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => EmptyState.failed(
            title: _t(context, 'ins_failed', 'Insights could not load'),
            detail: describeApiError(error, sessionIsLive: true),
            action: AppLocalizations.of(context).tryAgain,
            onAction: () => ref.invalidate(insightsProvider(_days)),
          ),
          data: (report) => RefreshIndicator(
            onRefresh: () => ref.refresh(insightsProvider(_days).future),
            child: TabBarView(
              controller: _tabs,
              children: [
                _Overview(report: report, period: _period(context)),
                _Audience(report: report, period: _period(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _period(BuildContext context) => PopupMenuButton<int>(
        key: const ValueKey('insights-period'),
        initialValue: _days,
        onSelected: (days) => setState(() => _days = days),
        itemBuilder: (context) => [
          for (final days in const [7, 30, 90])
            PopupMenuItem(
              value: days,
              child: Text(
                  _t(context, 'ins_days', 'Last {days} days', {'days': days})),
            ),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _t(context, 'ins_days', 'Last {days} days', {'days': _days}),
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: .6),
              ),
            ),
            const SizedBox(width: SpacingTokens.space4),
            const Icon(Iconsax.arrow_down_1_copy, size: 16),
          ],
        ),
      );
}

/// A catalog string with `{name}` slots filled in.
String _t(
  BuildContext context,
  String key,
  String fallback, [
  Map<String, Object> params = const {},
]) {
  var text = AppLocalizations.of(context).ui(key, fallback);
  params.forEach((name, value) {
    final shown = value is int ? formatCount(value) : '$value';
    text = text.replaceAll('{$name}', shown);
  });
  return text;
}

class _Overview extends StatelessWidget {
  const _Overview({required this.report, required this.period});

  final InsightsReport report;
  final Widget period;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final summary = report.summary.map((l) => _summaryLine(context, l));

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space16),
      children: [
        _Pad(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _t(context, 'ins_account', 'Your account'),
                  style: const TextStyle(
                    fontSize: TypographyTokens.fontSize4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              period,
            ],
          ),
        ),
        if (summary.isNotEmpty) ...[
          const SizedBox(height: SpacingTokens.space12),
          _Pad(
            child: Text(
              summary.join(' '),
              key: const ValueKey('insights-summary'),
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize3,
                height: 1.4,
              ),
            ),
          ),
        ],
        const SizedBox(height: SpacingTokens.space16),
        SizedBox(
          height: 118,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            children: [
              _Metric(
                label: _t(context, 'ins_reach', 'People reached'),
                value: report.reach,
                days: report.days,
                highlighted: true,
              ),
              _Metric(
                label: _t(context, 'ins_new_followers', 'New followers'),
                value: report.newFollowers,
                days: report.days,
              ),
              _Metric(
                label: _t(context, 'ins_opens', 'Opens'),
                value: report.opens,
                days: report.days,
              ),
              _Metric(
                label: _t(context, 'ins_likes', 'Likes'),
                value: report.likes,
                days: report.days,
              ),
              _Metric(
                label: _t(context, 'ins_replies', 'Replies'),
                value: report.comments,
                days: report.days,
              ),
              _Metric(
                label: _t(context, 'ins_reposts', 'Reposts'),
                value: report.reposts,
                days: report.days,
              ),
              _Metric(
                label: _t(context, 'ins_saves', 'Saves'),
                value: report.saves,
                days: report.days,
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        _Pad(
          child: Text(
            _t(
              context,
              'ins_reach_note',
              'People reached counts each person once: shown or opening one of your posts for the first time. New followers still follow you; unfollows are not counted.',
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: .5),
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space24),
        _Heading(_t(context, 'ins_chart', 'People reached each day')),
        _Pad(child: _ReachChart(days: report.timeline)),
        if (report.tips.isNotEmpty) ...[
          const SizedBox(height: SpacingTokens.space24),
          _Heading(_t(context, 'ins_grow', 'How to grow')),
          for (final tip in report.tips) _TipCard(tip: tip),
        ],
        const SizedBox(height: SpacingTokens.space24),
        _Heading(_t(context, 'ins_top_posts', 'Top posts')),
        if (report.topPosts.isEmpty)
          _Pad(
            child: Text(
              _t(context, 'ins_no_posts_reached',
                  'None of your posts reached anyone in this period.'),
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
            ),
          )
        else
          for (final post in report.topPosts) _TopPost(post: post),
      ],
    );
  }
}

class _Audience extends StatelessWidget {
  const _Audience({required this.report, required this.period});

  final InsightsReport report;
  final Widget period;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reached = report.reach.current;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space16),
      children: [
        _Pad(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _t(context, 'ins_reach', 'People reached'),
                  style: const TextStyle(
                    fontSize: TypographyTokens.fontSize4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              period,
            ],
          ),
        ),
        _Pad(
          child: Text(
            formatCount(reached),
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize9,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        _Pad(child: _Change(value: report.reach, days: report.days)),
        const SizedBox(height: SpacingTokens.space16),
        _Pad(
          child: Row(
            children: [
              Expanded(
                child: _Count(
                  label: _t(context, 'ins_followers', 'Followers'),
                  value: report.followersReached,
                ),
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(
                child: _Count(
                  label: _t(context, 'ins_non_followers', 'Not following you'),
                  value: report.strangersReached,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingTokens.space24),
        if (!report.audienceEnough)
          EmptyState(
            art: EmptyArt.people,
            compact: true,
            title: _t(context, 'ins_small_title', 'Not enough people yet'),
            detail: _t(
              context,
              'ins_small',
              'Who your audience is shows once {floor} people have seen your posts in this period. Any fewer, and it could point at someone.',
              {'floor': 20},
            ),
          )
        else ...[
          _Heading(_t(context, 'ins_ages', 'Ages')),
          if (report.ages.isEmpty)
            _Quiet(_t(context, 'ins_group_small',
                'No group is large enough to show yet.'))
          else ...[
            for (final age in report.ages)
              _Bar(
                label: age.band,
                share: report.agesKnown == 0 ? 0 : age.count / report.agesKnown,
              ),
            _Quiet(
              _t(
                context,
                'ins_ages_note',
                'From the {known} people reached who gave a birthday.',
                {'known': report.agesKnown},
              ),
            ),
          ],
          const SizedBox(height: SpacingTokens.space24),
          _Heading(_t(context, 'ins_countries', 'Countries')),
          if (report.countries.isEmpty)
            _Quiet(_t(context, 'ins_group_small',
                'No group is large enough to show yet.'))
          else
            for (final country in report.countries)
              _Bar(
                labelWidget: CountryLabel(
                  country.code,
                  style: const TextStyle(fontSize: TypographyTokens.fontSize2),
                ),
                label: country.code,
                share: report.countriesKnown == 0
                    ? 0
                    : country.count / report.countriesKnown,
              ),
          // Said every time, as the ages are: a country is something people
          // choose to give, and "60% Nigeria" of eleven is not of everyone.
          _Quiet(
            _t(
              context,
              'ins_countries_note',
              'From the {known} people reached who have a country on their profile.',
              {'known': report.countriesKnown},
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          _Heading(_t(context, 'ins_interests', 'Topics they follow')),
          _Groups(
            groups: report.interests,
            icon: Iconsax.hashtag_copy,
            onTap: (g) =>
                Navigator.pushNamed(context, Routes.topic, arguments: g.slug),
          ),
          const SizedBox(height: SpacingTokens.space24),
          _Heading(_t(context, 'ins_communities', 'Communities they are in')),
          _Groups(
            groups: report.communities,
            icon: Iconsax.people_copy,
            onTap: (g) => Navigator.pushNamed(
              context,
              Routes.community,
              arguments: g.slug,
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          _Heading(_t(context, 'ins_active', 'When they are around')),
          _Quiet(_t(context, 'ins_active_note', 'In your time zone.')),
          for (final slot in busiestSlots(report.activeHours))
            _Slot(weekday: slot.weekday, fromHour: slot.fromHour),
        ],
        const SizedBox(height: SpacingTokens.space24),
        _Pad(
          child: Text(
            _t(
              context,
              'ins_not_collected_city',
              'Countries are the ones people chose on their profiles. Kyron does not collect anyone\'s city or gender, so there is nothing to show for them.',
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: .5),
            ),
          ),
        ),
      ],
    );
  }
}

String _summaryLine(BuildContext context, InsightsLine line) {
  final p = line.params;
  String t(String fallback) => _t(context, 'ins_sum_${line.code}', fallback, p);
  return switch (line.code) {
    'reach_none' => t('Nobody new saw your posts in the last {days} days.'),
    'reach_first' => t('You reached {reach} people in the last {days} days.'),
    'reach_up_times' =>
      t('You reached {reach} people, {times}× as many as the period before.'),
    'reach_up_pct' =>
      t('You reached {reach} people, {pct}% more than the period before.'),
    'reach_down_pct' =>
      t('You reached {reach} people, {pct}% fewer than the period before.'),
    'reach_flat' =>
      t('You reached {reach} people, about as many as the period before.'),
    'mostly_strangers' =>
      t('{pct}% of them do not follow you yet: your posts are being found.'),
    'mostly_followers' =>
      t('{pct}% of them already follow you: your posts mostly reach people who know you.'),
    'top_interest' => t('More of them follow {name} than any other topic.'),
    _ => '',
  };
}

/// One tip: what to do, why it works here, and a way to do it.
class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip});

  final InsightsLine tip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final p = tip.params;
    final code = tip.code;
    String title(String fallback) =>
        _t(context, 'ins_tip_${code}_t', fallback, p);
    String body(String fallback) => _t(context, 'ins_tip_$code', fallback, p);

    final (heading, detail, icon) = switch (code) {
      'post_something' => (
          title('Post something'),
          body(
              'You have not posted in the last {days} days. Nothing reaches anyone without a post.'),
          Iconsax.edit_2_copy,
        ),
      'add_avatar' => (
          title('Add a profile picture'),
          body(
              'People who find one of your posts look at your profile before they follow. A face or a logo tells them somebody is there.'),
          Iconsax.user_square_copy,
        ),
      'add_bio' => (
          title('Write a bio'),
          body(
              'Say in a line what you post about, so a stranger knows what following you gets them.'),
          Iconsax.note_text_copy,
        ),
      'post_more' => (
          title('Post more often'),
          body(
              'You posted {posts} times in {days} days. Every post is another chance to be found, and a steady rhythm keeps you in your followers\' feeds.'),
          Iconsax.calendar_tick_copy,
        ),
      'answer_comments' => (
          title('Answer your replies'),
          body(
              '{received} people replied to your posts and you answered {answered}. They already cared enough to write: an answer turns a reader into a regular.'),
          Iconsax.message_text_copy,
        ),
      'convert_strangers' => (
          title('Turn readers into followers'),
          body(
              '{reached} people who do not follow you saw your posts, and {gained} followed. Make your bio and your newest posts say what they can expect from you.'),
          Iconsax.user_add_copy,
        ),
      'add_topics' => (
          title('Add topics to your posts'),
          body(
              '{without} of your {total} posts had no topic. A topic puts a post in that topic\'s feed and in front of the people who follow it.'),
          Iconsax.hashtag_copy,
        ),
      'more_like_top' => (
          title('Do more of what worked'),
          body(
              'One post reached {times}× as many people as your others usually do. Look at what it did differently, and do more of that.'),
          Iconsax.chart_success_copy,
        ),
      'post_in_community' => (
          title('Post in {name}'),
          body(
              'Many of the people who see your posts are in {name}. Posting there puts you in front of the rest of it.'),
          Iconsax.people_copy,
        ),
      'best_time' => (
          title('Post when they are around'),
          body('Your audience is most active on {when}. A post put up just before then has people there to meet it.')
              .replaceAll(
                  '{when}', _bestTime(context, tip.number('hourOfWeek'))),
          Iconsax.clock_copy,
        ),
      _ => ('', '', Iconsax.info_circle_copy),
    };
    if (heading.isEmpty) return const SizedBox.shrink();

    final action = _action(context, tip);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        0,
        SpacingTokens.space16,
        SpacingTokens.space12,
      ),
      child: Container(
        key: ValueKey('insights-tip-$code'),
        padding: const EdgeInsets.all(SpacingTokens.space16),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: scheme.primary),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  Text(
                    detail,
                    style: TextStyle(
                      height: 1.35,
                      color: scheme.onSurface.withValues(alpha: .75),
                    ),
                  ),
                  if (action != null)
                    Padding(
                      padding: const EdgeInsets.only(top: SpacingTokens.space8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: action.$2,
                        child: Text(action.$1),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Where a tip can be acted on, when there is somewhere.
  (String, VoidCallback)? _action(BuildContext context, InsightsLine tip) {
    void go(String route, [Object? arguments]) =>
        Navigator.pushNamed(context, route, arguments: arguments);
    return switch (tip.code) {
      'post_something' || 'post_more' => (
          _t(context, 'ins_act_post', 'Write a post'),
          () => go(Routes.composer),
        ),
      'add_avatar' || 'add_bio' || 'convert_strangers' => (
          _t(context, 'ins_act_profile', 'Edit your profile'),
          () => go(Routes.editProfile),
        ),
      'more_like_top' => (
          _t(context, 'ins_act_post_open', 'See the post'),
          () => go(Routes.postDetail, tip.text('postId')),
        ),
      'post_in_community' => (
          _t(context, 'ins_act_community', 'Open the community'),
          () => go(Routes.community, tip.text('slug')),
        ),
      _ => null,
    };
  }

  static String _bestTime(BuildContext context, int hourOfWeek) {
    final at = localHourOfWeek(hourOfWeek);
    final locale = Localizations.localeOf(context).toLanguageTag();
    // Any Monday, moved to the weekday: only its name is shown.
    final day = DateTime(2024, 1, at.weekday, at.hour);
    return '${DateFormat.EEEE(locale).format(day)}, '
        '${DateFormat.j(locale).format(day)}';
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.days,
    this.highlighted = false,
  });

  final String label;
  final Compared value;
  final int days;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 148,
      margin: const EdgeInsets.only(right: SpacingTokens.space12),
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: highlighted ? scheme.surfaceContainer : null,
        border: highlighted
            ? null
            : Border.all(color: scheme.outline.withValues(alpha: .25)),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              color: scheme.onSurface.withValues(alpha: .6),
            ),
          ),
          const Spacer(),
          Text(
            formatCount(value.current),
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize6,
              fontWeight: FontWeight.w800,
            ),
          ),
          _Change(value: value, days: days),
        ],
      ),
    );
  }
}

/// "+825%" against the period before, or "New" when there was nothing
/// before -- a percentage over zero is not a number.
class _Change extends StatelessWidget {
  const _Change({required this.value, required this.days});

  final Compared value;
  final int days;

  @override
  Widget build(BuildContext context) {
    final change = value.change;
    final scheme = Theme.of(context).colorScheme;
    final String text;
    final Color colour;
    if (change == null) {
      if (value.current == 0) return const SizedBox(height: 18);
      text = _t(context, 'ins_new', 'New');
      colour = Colors.green.shade700;
    } else {
      final pct = (change * 100).round();
      text = '${pct > 0 ? '+' : ''}$pct%';
      colour = pct > 0
          ? Colors.green.shade700
          : pct < 0
              ? scheme.error
              : scheme.onSurface.withValues(alpha: .5);
    }
    return Tooltip(
      message: _t(
        context,
        'ins_vs_before',
        'Against the {days} days before',
        {'days': days},
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize2,
          fontWeight: FontWeight.w600,
          color: colour,
        ),
      ),
    );
  }
}

/// The daily line, filled underneath, with three dates along the bottom.
class _ReachChart extends StatelessWidget {
  const _ReachChart({required this.days});

  final List<({DateTime date, int reach})> days;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final peak = days.fold<int>(0, (a, d) => math.max(a, d.reach));
    final label = TextStyle(
      fontSize: TypographyTokens.fontSize1,
      color: scheme.onSurface.withValues(alpha: .5),
    );
    String date(int i) => DateFormat.MMMd(locale).format(days[i].date);

    return Semantics(
      label: _t(context, 'ins_chart', 'People reached each day'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 36,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatCount(peak), style: label),
                      Text(formatCount(peak ~/ 2), style: label),
                      Text('0', style: label),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: _LinePainter(
                      values: [for (final d in days) d.reach],
                      peak: peak,
                      line: scheme.onSurface,
                      grid: scheme.outline.withValues(alpha: .2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (days.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date(0), style: label),
                  Text(date(days.length ~/ 2), style: label),
                  Text(date(days.length - 1), style: label),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.values,
    required this.peak,
    required this.line,
    required this.grid,
  });

  final List<int> values;
  final int peak;
  final Color line;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (final y in [0.0, size.height / 2, size.height]) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    if (values.isEmpty) return;

    final top = math.max(1, peak);
    final step = values.length == 1 ? 0.0 : size.width / (values.length - 1);
    Offset at(int i) => Offset(
          i * step,
          size.height - (values[i] / top) * size.height,
        );

    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < values.length; i++) {
      path.lineTo(at(i).dx, at(i).dy);
    }
    final fill = Path.from(path)
      ..lineTo(at(values.length - 1).dx, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [line.withValues(alpha: .15), line.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_LinePainter old) =>
      old.values != values || old.peak != peak || old.line != line;
}

class _TopPost extends StatelessWidget {
  const _TopPost({required this.post});

  final InsightsTopPost post;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
      title: Text(
        post.excerpt.isEmpty ? '—' : post.excerpt,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _t(
          context,
          'ins_post_line',
          '{reach} reached · {likes} likes · {replies} replies',
          {
            'reach': post.reach,
            'likes': post.likes,
            'replies': post.comments,
          },
        ),
        style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
      ),
      trailing: const Icon(Iconsax.arrow_right_3_copy, size: 18),
      onTap: () => Navigator.pushNamed(
        context,
        Routes.postAnalytics,
        arguments: post.id,
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            formatCount(value),
            style: const TextStyle(
              fontSize: TypographyTokens.fontSize6,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.label, required this.share, this.labelWidget});

  final String label;
  final double share;

  /// Drawn in place of [label] when the label is more than words: a flag.
  final Widget? labelWidget;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        0,
        SpacingTokens.space16,
        SpacingTokens.space12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget ?? Text(label),
          const SizedBox(height: SpacingTokens.space4),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(RadiusTokens.radius4),
                  child: LinearProgressIndicator(
                    value: share.clamp(0, 1),
                    minHeight: 8,
                    backgroundColor: scheme.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation(scheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space12),
              SizedBox(
                width: 52,
                child: Text(
                  '${(share * 100).toStringAsFixed(share >= .1 ? 0 : 1)}%',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: .6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Groups extends StatelessWidget {
  const _Groups({
    required this.groups,
    required this.icon,
    required this.onTap,
  });

  final List<AudienceGroup> groups;
  final IconData icon;
  final void Function(AudienceGroup) onTap;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return _Quiet(_t(
          context, 'ins_group_small', 'No group is large enough to show yet.'));
    }
    return _Pad(
      child: Wrap(
        spacing: SpacingTokens.space8,
        runSpacing: SpacingTokens.space8,
        children: [
          for (final g in groups)
            ActionChip(
              avatar: Icon(icon, size: 16),
              label: Text('${g.name} · ${formatCount(g.count)}'),
              onPressed: () => onTap(g),
            ),
        ],
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({required this.weekday, required this.fromHour});

  final int weekday;
  final int fromHour;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final from = DateTime(2024, 1, weekday, fromHour);
    final to = from.add(const Duration(hours: 3));
    final hours = DateFormat.j(locale);
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
      leading: const Icon(Iconsax.clock_copy, size: 20),
      title: Text(DateFormat.EEEE(locale).format(from)),
      subtitle: Text('${hours.format(from)} – ${hours.format(to)}'),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          0,
          SpacingTokens.space16,
          SpacingTokens.space12,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: TypographyTokens.fontSize4,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}

class _Quiet extends StatelessWidget {
  const _Quiet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => _Pad(
        child: Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: .55),
            ),
          ),
        ),
      );
}

class _Pad extends StatelessWidget {
  const _Pad({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        child: child,
      );
}
