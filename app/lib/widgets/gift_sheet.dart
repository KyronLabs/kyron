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
import '../utils/format_count.dart';
import 'app_sheet.dart';

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
  /// count. The sheet itself shows the gift going, so there is no toast
  /// after it to say so twice.
  static Future<void> open(
    BuildContext context,
    FeedPost post, {
    required void Function(int gifts) onSent,
  }) async {
    final sent = await show(context, post);
    if (sent != null) onSent(sent.gifts);
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

  /// The gift that just went, shown large for a moment before the sheet
  /// closes. Null until then.
  GiftType? _sent;

  /// How long the sent gift is held on screen: long enough to register as
  /// "it went", short enough that nobody waits for it.
  static const _celebration = Duration(milliseconds: 650);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Decoded now, while the catalogue loads, so the grid arrives with its
    // pictures rather than filling in tile by tile.
    for (final type in GiftArt.drawn) {
      precacheImage(AssetImage(GiftArt.pathFor(type)), context);
    }
  }

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
      if (!mounted) return;
      setState(() => _sent = gift);
      await Future<void>.delayed(_celebration);
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
          SpacingTokens.space20,
          0,
          SpacingTokens.space20,
          SpacingTokens.space20,
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
                height: 260,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final wallet = data.wallet;
            final picked = _picked;
            final affordable = picked != null && picked.coins <= wallet.coins;
            final sent = _sent;

            final body = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.ui('ui_gift_title', 'Send a gift'),
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize6,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    _Balance(wallet: wallet),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: SpacingTokens.space8,
                  crossAxisSpacing: SpacingTokens.space8,
                  childAspectRatio: 0.82,
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
                  _notice(context, wallet),
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
                  child: _sending && sent == null
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

            // The sent gift pops up over the sheet for a moment: the sheet
            // fades back, the gift springs in, and then it all closes.
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  duration: MotionTokens.fast,
                  opacity: sent == null ? 1 : 0.15,
                  child: IgnorePointer(ignoring: sent != null, child: body),
                ),
                if (sent != null) _Sent(gift: sent),
              ],
            );
          },
        ),
      ),
    );
  }

  String _notice(BuildContext context, GiftWallet wallet) {
    final l10n = AppLocalizations.of(context);
    final refills = wallet.refillsAt;
    final notice = l10n.ui(
      'ui_gift_test_notice',
      'Test coins: they cannot be bought and have no cash value.',
    );
    if (refills == null) return notice;
    final when = DateFormat.MMMEd(Localizations.localeOf(context).toString())
        .format(refills);
    return '$notice ${l10n.ui('ui_gift_refills_on', r'Refills $date.').replaceAll(r'$date', when)}';
  }
}

/// "1 coin", "20 coins".
String coinLabel(AppLocalizations l10n, int coins) => coins == 1
    ? l10n.ui('ui_gift_one_coin', '1 coin')
    : l10n.ui('ui_gift_coins', r'$count coins').replaceAll(r'$count', '$coins');

/// A gift's picture: its artwork when the app has it, its emoji when not.
///
/// The catalogue is the server's, so a gift can arrive here before the app
/// that draws it. It shows its emoji then, rather than a gap.
class GiftArt extends StatelessWidget {
  final String type;
  final String emoji;
  final double size;

  const GiftArt({
    super.key,
    required this.type,
    required this.emoji,
    required this.size,
  });

  /// The gifts this build has artwork for, in assets/gifts/.
  static const drawn = {
    'spark',
    'rose',
    'fire',
    'star',
    'gem',
    'cake',
    'crown',
    'rocket',
  };

  static String pathFor(String type) => 'assets/gifts/$type.png';

  @override
  Widget build(BuildContext context) {
    final fallback = SizedBox.square(
      dimension: size,
      child: FittedBox(child: Text(emoji)),
    );
    if (!drawn.contains(type)) return fallback;
    return Image.asset(
      pathFor(type),
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

/// The coin, as the sheet draws it beside a balance and every price.
class CoinIcon extends StatelessWidget {
  final double size;

  const CoinIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) => Image.asset(
        GiftArt.pathFor('coin'),
        width: size,
        height: size,
        errorBuilder: (_, __, ___) => Icon(
          Iconsax.coin_1,
          size: size,
          color: const Color(0xFFF2B233),
        ),
      );
}

/// What is in hand, in the sheet's top right corner.
class _Balance extends StatelessWidget {
  final GiftWallet wallet;

  const _Balance({required this.wallet});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      label: l10n
          .ui('ui_gift_balance', r'You have $coins')
          .replaceAll(r'$coins', coinLabel(l10n, wallet.coins)),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space4,
          SpacingTokens.space4,
          SpacingTokens.space12,
          SpacingTokens.space4,
        ),
        decoration: BoxDecoration(
          color: scheme.onSurface.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CoinIcon(size: 22),
            const SizedBox(width: SpacingTokens.space4),
            Text(
              formatCount(wallet.coins),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize3,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
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
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
        child: AnimatedContainer(
          duration: MotionTokens.fast,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: picked
                ? scheme.primary.withValues(alpha: 0.10)
                : scheme.onSurface.withValues(alpha: 0.035),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
            border: Border.all(
              color: picked ? scheme.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          // Dimmed, not hidden, when it costs more than the wallet holds:
          // knowing what a Rocket costs is how somebody decides to save for
          // one.
          child: Opacity(
            opacity: affordable ? 1 : 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The picked one rises a little, so the choice reads from the
                // picture as well as the ring.
                AnimatedScale(
                  scale: picked ? 1.12 : 1,
                  duration: MotionTokens.fast,
                  curve: Curves.easeOutBack,
                  child: GiftArt(type: gift.type, emoji: gift.emoji, size: 48),
                ),
                const SizedBox(height: SpacingTokens.space8),
                _Price(coins: gift.coins),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A gift's price, under its picture: the coin and the number.
class _Price extends StatelessWidget {
  final int coins;

  const _Price({required this.coins});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CoinIcon(size: 14),
        const SizedBox(width: 3),
        Text(
          formatCount(coins),
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface.withValues(alpha: 0.8),
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

/// The gift that just went, springing up in the middle of the sheet.
class _Sent extends StatelessWidget {
  final GiftType gift;

  const _Sent({required this.gift});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      builder: (context, t, child) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        child: Transform.scale(scale: 0.6 + 0.4 * t, child: child),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GiftArt(type: gift.type, emoji: gift.emoji, size: 112),
          const SizedBox(height: SpacingTokens.space12),
          Text(
            AppLocalizations.of(context)
                .ui('ui_gift_sent_named', r'$gift sent')
                .replaceAll(r'$gift', gift.name),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize5,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
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
