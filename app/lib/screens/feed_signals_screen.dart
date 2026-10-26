// lib/screens/feed_signals_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/interest_signal.dart';
import '../providers/moderation_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/empty_state.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/toast.dart';

/// Everything "Show more posts like this" and "Not interested in this" are
/// telling the reader's feeds, and a way to take each one back.
///
/// "Not interested" used to be a near-mute on the author that nobody could
/// see or undo. Every signal now fades on its own, and this is where the
/// reader can see what is still being read and stop any of it now.
class FeedSignalsScreen extends ConsumerStatefulWidget {
  const FeedSignalsScreen({super.key});

  @override
  ConsumerState<FeedSignalsScreen> createState() => _FeedSignalsScreenState();
}

class _FeedSignalsScreenState extends ConsumerState<FeedSignalsScreen> {
  List<InterestSignal>? _signals;
  String? _error;
  final _removing = <String>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final signals =
          await ref.read(moderationRepositoryProvider).interestSignals();
      if (mounted) setState(() => _signals = signals);
    } catch (e) {
      if (mounted) {
        setState(() => _error = describeApiError(e, sessionIsLive: true));
      }
    }
  }

  Future<void> _remove(InterestSignal signal) async {
    if (!_removing.add(signal.postId)) return;
    setState(() {});
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(moderationRepositoryProvider).clearInterest(signal.postId);
      if (!mounted) return;
      setState(() {
        _signals = [
          for (final s in _signals ?? const <InterestSignal>[])
            if (s.postId != signal.postId) s,
        ];
      });
      Toast.show(context, l10n.ui('ui_feed_signal_removed', 'Removed'));
    } catch (e) {
      if (mounted) Toast.show(context, l10n.literalthatDidNotGoThroughTryAgain);
    } finally {
      _removing.remove(signal.postId);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final signals = _signals;

    final Widget body;
    if (_error != null && signals == null) {
      body = EmptyState.failed(
        title: l10n.ui('ui_feed_signals', 'Your feed signals'),
        detail: _error,
        onAction: _load,
      );
    } else if (signals == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (signals.isEmpty) {
      body = EmptyState(
        art: EmptyArt.posts,
        title: l10n.ui('ui_feed_signals_empty_title', 'Nothing here yet'),
        detail: l10n.ui(
          'ui_feed_signals_empty',
          'Tap Show more posts like this or Not interested in this on a post, and it shows up here.',
        ),
      );
    } else {
      body = ListView.separated(
        itemCount: signals.length,
        separatorBuilder: (_, __) => const Hairline(),
        itemBuilder: (context, index) => _SignalRow(
          signal: signals[index],
          busy: _removing.contains(signals[index].postId),
          onRemove: () => _remove(signals[index]),
        ),
      );
    }

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(l10n.ui('ui_feed_signals', 'Your feed signals')),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Text(
                l10n.ui(
                  'ui_feed_signals_intro',
                  'These shape Home and Explore, mostly by what each post was about. Each one fades by half every month and stops counting after six. Remove one to stop it now.',
                ),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  color: scheme.onSurface.withValues(alpha: .7),
                ),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  const _SignalRow({
    required this.signal,
    required this.busy,
    required this.onRemove,
  });

  final InterestSignal signal;
  final bool busy;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final what = signal.more
        ? l10n.ui('ui_feed_signal_more', 'Show more like this')
        : l10n.ui('ui_feed_signal_less', 'Not interested');
    final about = [
      ...signal.topics,
      for (final tag in signal.hashtags) '#$tag',
    ];
    final details = [
      what,
      if (signal.authorName.isNotEmpty) signal.authorName,
      if (about.isNotEmpty) about.take(3).join(', '),
      if (signal.strength < 0.5) l10n.ui('ui_feed_signal_fading', 'Fading'),
    ].join(' · ');

    return ListTile(
      leading: Icon(
        signal.more ? Iconsax.like_1_copy : Iconsax.dislike_copy,
        size: 20,
        // Fainter as it fades, so the list says at a glance what still
        // counts for much.
        color: scheme.onSurface.withValues(alpha: .35 + .5 * signal.strength),
      ),
      title: Text(
        signal.excerpt.isEmpty ? what : signal.excerpt,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        details,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: scheme.onSurface.withValues(alpha: .6)),
      ),
      trailing: busy
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : IconButton(
              icon: const Icon(Iconsax.close_circle_copy, size: 18),
              tooltip: l10n.remove,
              onPressed: onRemove,
            ),
    );
  }
}
