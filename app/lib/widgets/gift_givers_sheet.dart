// lib/widgets/gift_givers_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/feed_post.dart';
import '../models/gift.dart';
import '../providers/gifts_provider.dart';
import 'app_sheet.dart';
import 'gift_sheet.dart' show CoinIcon, GiftArt;
import 'hairline.dart';
import 'post_card.dart' show PostAvatar, openAuthor;
import 'verified_badge.dart';

/// Who gave a post gifts, and what: the list the gift pill opens.
///
/// The biggest giver first, with a word for it, and each person's gifts
/// drawn as the gifts themselves -- a gift is given partly to be seen
/// giving it, and this is where it is seen. Sending one is the heart's
/// long press; the pill is for looking.
abstract final class GiftGiversSheet {
  static Future<void> show(BuildContext context, FeedPost post) =>
      showAppSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _Sheet(post: post),
      );
}

class _Sheet extends ConsumerStatefulWidget {
  final FeedPost post;

  const _Sheet({required this.post});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  late Future<PostGifts> _gifts = _load();

  Future<PostGifts> _load() =>
      ref.read(giftsRepositoryProvider).givers(widget.post.id);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.7;

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: FutureBuilder<PostGifts>(
          future: _gifts,
          builder: (context, snap) {
            final data = snap.data;
            final givers = data?.givers ?? const <GiftGiver>[];
            final total = data?.total ?? widget.post.gifts;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    SpacingTokens.space20,
                    SpacingTokens.space8,
                    SpacingTokens.space20,
                    SpacingTokens.space12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.ui('ui_gifts_title', 'Gifts'),
                        style: const TextStyle(
                          fontSize: TypographyTokens.fontSize5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space2),
                      Text(
                        _summary(l10n, total, data == null ? null : givers),
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize2,
                          color: scheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                const RuleLine(),
                if (snap.connectionState != ConnectionState.done)
                  const SizedBox(
                    height: 160,
                    child: Center(
                      child: SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else if (snap.hasError)
                  _Failed(
                    onRetry: () => setState(() => _gifts = _load()),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                        vertical: SpacingTokens.space8,
                      ),
                      itemCount: givers.length,
                      separatorBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.only(left: 72),
                        child: RuleLine(),
                      ),
                      itemBuilder: (context, i) => _GiverRow(
                        key: ValueKey('gift-giver-${givers[i].user.id}'),
                        giver: givers[i],
                        top: i == 0 && givers.length > 1,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// "12 gifts from 4 people", or just the count until the people arrive.
  static String _summary(
    AppLocalizations l10n,
    int total,
    List<GiftGiver>? givers,
  ) {
    final gifts = total == 1
        ? l10n.ui('ui_gifts_count_one', '1 gift')
        : l10n
            .ui('ui_gifts_count', r'$count gifts')
            .replaceAll(r'$count', '$total');
    if (givers == null || givers.isEmpty) return gifts;
    final from = givers.length == 1
        ? l10n.ui('ui_gifts_from_one', 'from 1 person')
        : l10n
            .ui('ui_gifts_from_people', r'from $count people')
            .replaceAll(r'$count', '${givers.length}');
    return '$gifts $from';
  }
}

class _GiverRow extends StatelessWidget {
  final GiftGiver giver;

  /// The biggest giver, when there is more than one: said in words.
  final bool top;

  const _GiverRow({super.key, required this.giver, required this.top});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    void open() {
      Navigator.pop(context);
      openAuthor(context, giver.user);
    }

    return InkWell(
      onTap: open,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space20,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            PostAvatar(author: giver.user, radius: 20),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: NameWithBadge(
                          name: giver.user.displayName,
                          verified: giver.user.verified,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (top) ...[
                        const SizedBox(width: SpacingTokens.space8),
                        _TopGifter(
                            label: l10n.ui('ui_top_gifter', 'Top gifter')),
                      ],
                    ],
                  ),
                  const SizedBox(height: SpacingTokens.space4),
                  // Their gifts, as the gifts: the most valuable first.
                  Wrap(
                    spacing: SpacingTokens.space8,
                    runSpacing: SpacingTokens.space4,
                    children: [
                      for (final g in giver.gifts)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GiftArt(type: g.type, size: 20),
                            if (g.count > 1) ...[
                              const SizedBox(width: 2),
                              Text(
                                '×${g.count}',
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize1,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            const CoinIcon(size: 16),
            const SizedBox(width: SpacingTokens.space4),
            Text(
              '${giver.coins}',
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize3,
                fontWeight: FontWeight.w700,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The word beside the biggest giver: gold, small, and only one of them.
class _TopGifter extends StatelessWidget {
  final String label;

  const _TopGifter({required this.label});

  /// The gold of the gift art's crown, deep enough to read on white, and
  /// its brighter self on black.
  static Color colourOf(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFFFFC93C)
      : const Color(0xFF9C6B00);

  @override
  Widget build(BuildContext context) {
    final gold = colourOf(Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: gold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize0,
          fontWeight: FontWeight.w700,
          color: gold,
        ),
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  final VoidCallback onRetry;

  const _Failed({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(SpacingTokens.space24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.ui('ui_gifts_load_failed', "Couldn't load who sent gifts."),
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(l10n.ui('ui_retry', 'Try again')),
          ),
        ],
      ),
    );
  }
}
