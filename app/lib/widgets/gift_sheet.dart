// lib/widgets/gift_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/feed_post.dart';
import '../models/gift.dart';
import '../providers/gifts_provider.dart';
import '../repositories/gifts_repository.dart';
import '../utils/api_error_message.dart';
import 'app_sheet.dart';
import 'toast.dart';

/// Choosing a gift for a post and sending it.
///
/// Two steps on purpose: a tap picks, and the button sends. A grid where a
/// tap spends is a grid where a scroll that lands on a tile spends.
abstract final class GiftSheet {
  /// Answers with what was sent, or null if nothing was.
  static Future<SentGift?> show(BuildContext context, FeedPost post) {
    return showAppSheet<SentGift>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _Sheet(post: post),
    );
  }

  /// The sheet, for an engagement row: [onSent] gets the post's new gift
  /// count, and the reader is told it went.
  static Future<void> open(
    BuildContext context,
    FeedPost post, {
    required void Function(int gifts) onSent,
  }) async {
    final sent = await show(context, post);
    if (sent == null) return;
    onSent(sent.gifts);
    if (!context.mounted) return;
    Toast.show(
      context,
      AppLocalizations.of(context).ui('ui_gift_sent', 'Gift sent'),
      icon: Iconsax.gift_copy,
    );
  }
}

class _Sheet extends ConsumerStatefulWidget {
  final FeedPost post;

  const _Sheet({required this.post});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  late Future<GiftSheetData> _data = ref.read(giftsRepositoryProvider).sheet();

  GiftType? _picked;

  /// Made when a gift is picked and kept until it is sent, so pressing Send
  /// again after a failure is the same request rather than a second gift.
  String? _requestId;

  bool _sending = false;
  String? _error;

  void _pick(GiftType gift) {
    if (_sending) return;
    setState(() {
      if (_picked?.type != gift.type) {
        _picked = gift;
        _requestId = GiftsRepository.newRequestId();
      }
      _error = null;
    });
  }

  Future<void> _send() async {
    final gift = _picked;
    final requestId = _requestId;
    if (gift == null || requestId == null || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final sent = await ref
          .read(giftsRepositoryProvider)
          .send(widget.post.id, gift.type, requestId: requestId);
      if (mounted) Navigator.pop(context, sent);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(e, sessionIsLive: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space24,
          0,
          SpacingTokens.space24,
          SpacingTokens.space24,
        ),
        child: FutureBuilder<GiftSheetData>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _Failed(
                message: describeApiError(
                  snapshot.error!,
                  sessionIsLive: true,
                ),
                onRetry: () => setState(() {
                  _data = ref.read(giftsRepositoryProvider).sheet();
                }),
              );
            }
            final data = snapshot.data;
            if (data == null) {
              return const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final wallet = data.wallet;
            final picked = _picked;
            final affordable = picked != null && picked.coins <= wallet.coins;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.ui('ui_gift_title', 'Send a gift'),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize6,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: SpacingTokens.space4),
                _Balance(wallet: wallet),
                const SizedBox(height: SpacingTokens.space16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: SpacingTokens.space8,
                  crossAxisSpacing: SpacingTokens.space8,
                  childAspectRatio: 0.8,
                  children: [
                    for (final gift in data.catalogue)
                      _Tile(
                        gift: gift,
                        picked: picked?.type == gift.type,
                        affordable: gift.coins <= wallet.coins,
                        onTap: () => _pick(gift),
                      ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space12),
                // Said every time, not once: nobody should think these are
                // worth anything while they are not.
                Text(
                  l10n.ui(
                    'ui_gift_test_notice',
                    'Test coins: they refill every Monday, cannot be bought, '
                        'and have no cash value.',
                  ),
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    height: 1.4,
                    color: scheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: SpacingTokens.space8),
                  Text(
                    _error!,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      color: scheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: SpacingTokens.space16),
                FilledButton(
                  onPressed: affordable && !_sending ? _send : null,
                  child: _sending
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          picked == null
                              ? l10n.ui('ui_gift_pick', 'Pick a gift')
                              : affordable
                                  ? l10n
                                      .ui('ui_gift_send',
                                          r'Send $gift · $coins')
                                      .replaceAll(
                                        r'$gift',
                                        '${picked.emoji} ${picked.name}',
                                      )
                                      .replaceAll(
                                        r'$coins',
                                        coinLabel(l10n, picked.coins),
                                      )
                                  : l10n.ui(
                                      'ui_gift_not_enough', 'Not enough coins'),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// "1 coin", "20 coins".
String coinLabel(AppLocalizations l10n, int coins) => coins == 1
    ? l10n.ui('ui_gift_one_coin', '1 coin')
    : l10n.ui('ui_gift_coins', r'$count coins').replaceAll(r'$count', '$coins');

class _Balance extends StatelessWidget {
  final GiftWallet wallet;

  const _Balance({required this.wallet});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final refills = wallet.refillsAt;
    final when = refills == null
        ? null
        : DateFormat.MMMEd(Localizations.localeOf(context).toString())
            .format(refills);

    return Row(
      children: [
        Icon(Iconsax.coin_1_copy, size: 15, color: scheme.primary),
        const SizedBox(width: SpacingTokens.space4),
        Flexible(
          child: Text(
            [
              l10n
                  .ui('ui_gift_balance', r'You have $coins')
                  .replaceAll(r'$coins', coinLabel(l10n, wallet.coins)),
              if (when != null)
                l10n
                    .ui('ui_gift_refills', r'refills $date')
                    .replaceAll(r'$date', when),
            ].join(' · '),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize2,
              color: scheme.onSurface.withValues(alpha: 0.65),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final GiftType gift;
  final bool picked;
  final bool affordable;
  final VoidCallback onTap;

  const _Tile({
    required this.gift,
    required this.picked,
    required this.affordable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      selected: picked,
      label: '${gift.name}, ${coinLabel(l10n, gift.coins)}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        child: AnimatedContainer(
          duration: MotionTokens.fast,
          decoration: BoxDecoration(
            color: picked
                ? scheme.primary.withValues(alpha: 0.12)
                : scheme.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
            border: Border.all(
              color: picked ? scheme.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          // Dimmed, not hidden, when it costs more than the wallet holds:
          // knowing what a Crown costs is how somebody decides to save for one.
          child: Opacity(
            opacity: affordable ? 1 : 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExcludeSemantics(
                  child: Text(
                    gift.emoji,
                    style:
                        const TextStyle(fontSize: TypographyTokens.fontSize8),
                  ),
                ),
                const SizedBox(height: SpacingTokens.space4),
                Text(
                  gift.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize2,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                Text(
                  '${gift.coins}',
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    color: scheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
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
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: SpacingTokens.space12),
          OutlinedButton(
            onPressed: onRetry,
            child:
                Text(AppLocalizations.of(context).ui('ui_retry', 'Try again')),
          ),
        ],
      ),
    );
  }
}
