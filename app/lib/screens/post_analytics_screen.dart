// lib/screens/post_analytics_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_comment.dart';
import '../providers/feed_provider.dart';
import '../utils/api_error_message.dart';
import '../utils/format_count.dart';

final postAnalyticsProvider = StateNotifierProvider.family<
    PostAnalyticsNotifier, AsyncValue<PostAnalytics>, String>(
  (ref, postId) => PostAnalyticsNotifier(ref, postId),
);

class PostAnalyticsNotifier extends StateNotifier<AsyncValue<PostAnalytics>> {
  final Ref _ref;
  final String _postId;

  PostAnalyticsNotifier(this._ref, this._postId) : super(const AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(
        await _ref.read(feedRepositoryProvider).analytics(_postId),
      );
    } catch (e, st) {
      state = AsyncError(describeApiError(e, sessionIsLive: true), st);
    }
  }
}

/// How one of your posts is doing. Only its author can open this -- the API
/// answers 404 to anyone else, so a reach figure is never handed out.
class PostAnalyticsScreen extends ConsumerWidget {
  final String postId;

  const PostAnalyticsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postAnalyticsProvider(postId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Post analytics'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh_copy, size: 20),
            tooltip: 'Refresh',
            onPressed: ref.read(postAnalyticsProvider(postId).notifier).load,
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _Failed(
            message: '$error',
            onRetry: ref.read(postAnalyticsProvider(postId).notifier).load,
          ),
          data: (report) => _Report(report: report),
        ),
      ),
    );
  }
}

class _Report extends StatelessWidget {
  final PostAnalytics report;

  const _Report({required this.report});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final rate = report.engagementRate;

    return ListView(
      padding: const EdgeInsets.all(SpacingTokens.space20),
      children: [
        Row(
          children: [
            Expanded(
              child: _Tile(
                icon: Iconsax.eye_copy,
                value: formatCount(report.views),
                label: 'Viewers',
                // Said plainly, because "views" usually means opens and this
                // does not: the same person refreshing is still one viewer.
                note: 'Distinct people, not opens',
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: _Tile(
                icon: Iconsax.heart_copy,
                value: formatCount(report.likes),
                label: 'Likes',
              ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space12),
        Row(
          children: [
            Expanded(
              child: _Tile(
                icon: Iconsax.message_text_copy,
                value: formatCount(report.comments),
                label: 'Comments',
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: _Tile(
                icon: Iconsax.archive_add_copy,
                value: formatCount(report.saves),
                label: 'Saves',
              ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space20),
        _Row(
          label: 'Engagement',
          // Null, not 0%, when nobody has seen it: a rate over zero viewers is
          // unknown, and "0%" reads as "nobody engaged" rather than "nobody
          // looked".
          value: rate == null
              ? 'No viewers yet'
              : '${(rate * 100).toStringAsFixed(rate >= 0.1 ? 0 : 1)}%',
        ),
        _Row(label: 'Posted', value: _stamp(report.createdAt)),
        const SizedBox(height: SpacingTokens.space24),
        Text(
          'VIEWERS PER DAY',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: scheme.onSurface.withValues(alpha: .5),
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        if (report.timeline.isEmpty)
          Text(
            'Nobody has opened this post yet.',
            style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
          )
        else
          _Timeline(days: report.timeline),
      ],
    );
  }

  static String _stamp(DateTime at) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${at.day} ${months[at.month - 1]} ${at.year}';
  }
}

/// A bar per day, scaled against the busiest one.
class _Timeline extends StatelessWidget {
  final List<DailyViews> days;

  const _Timeline({required this.days});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final peak = days.fold<int>(1, (a, d) => d.views > a ? d.views : a);

    return Column(
      children: [
        for (final day in days)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
            child: Row(
              children: [
                SizedBox(
                  width: 76,
                  child: Text(
                    day.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurface.withValues(alpha: .6),
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RadiusTokens.radius4),
                    child: LinearProgressIndicator(
                      value: day.views / peak,
                      minHeight: 10,
                      backgroundColor: scheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space12),
                SizedBox(
                  width: 36,
                  child: Text(
                    formatCount(day.views),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String? note;

  const _Tile({
    required this.icon,
    required this.value,
    required this.label,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: scheme.onSurface.withValues(alpha: .7),
            ),
          ),
          if (note != null) ...[
            const SizedBox(height: SpacingTokens.space4),
            Text(
              note!,
              style: TextStyle(
                fontSize: 11,
                color: scheme.onSurface.withValues(alpha: .45),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _Failed({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: SpacingTokens.space16),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
