// lib/widgets/gift_sheet.dart
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'gift_motion.dart';

/// Choosing a gift for a post and sending it.
///
/// Two steps on purpose: a tap picks, and the button sends. A grid where a
/// tap spends is a grid where a scroll that lands on a tile spends.
abstract final class GiftSheet {
  /// Answers with what was sent, or null if nothing was.
  static Future<SentGift?> show(BuildContext context, FeedPost post) async =>
      (await _show(context, post))?.sent;

  static Future<_Outcome?> _show(BuildContext context, FeedPost post) =>
      showAppSheet<_Outcome>(
        context: context,
        isScrollControlled: true,
        builder: (context) => _Sheet(post: post),
      );

  /// The sheet, opened from the heart: whatever is sent flies out of the
  /// sheet, shrinks onto [heart] and becomes it. [onSent] is called as it
  /// lands, which is what turns the heart into the gift -- so the change
  /// arrives with the gift rather than ahead of it.
  ///
  /// No toast, and no flight with animations turned off: the heart simply
  /// changes.
  static Future<void> open(
    BuildContext heart,
    FeedPost post, {
    required void Function(SentGift sent) onSent,
  }) async {
    final outcome = await _show(heart, post);
    if (outcome == null) return;
    // Scrolled away or closed while the sheet was up: nothing to fly to.
    if (!heart.mounted) {
      onSent(outcome.sent);
      return;
    }
    final from = outcome.from;
    final box = heart.findRenderObject();
    if (from == null ||
        box is! RenderBox ||
        !box.attached ||
        MediaQuery.disableAnimationsOf(heart)) {
      onSent(outcome.sent);
      return;
    }
    GiftFlight.fly(
      heart,
      art: GiftArt(type: outcome.gift.type, size: from.width),
      from: from,
      to: box.localToGlobal(box.size.center(Offset.zero)),
      landingSize: 21,
      onArrive: () {
        // The softest tick there is, as it lands: felt, not announced.
        unawaited(HapticFeedback.selectionClick());
        onSent(outcome.sent);
      },
    );
  }
}

/// What the sheet closes with: what was sent, and where on screen it was
/// when the sheet let go of it, so its flight can start from there.
class _Outcome {
  final SentGift sent;
  final GiftType gift;
  final Rect? from;

  const _Outcome({required this.sent, required this.gift, this.from});
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

  /// Set as the sheet lets go of the sent gift: its picture here hides, and
  /// the one flying to the heart takes over from the same spot.
  bool _launched = false;

  /// Where the sent gift's picture is, to measure it before it flies.
  final _sentArt = GlobalKey();

  /// How long the sent gift is held on screen: long enough for its burst to
  /// play and register as "it went", short enough that nobody waits for it.
  static const _celebration = Duration(milliseconds: 900);

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
        // A tick as the choice moves, like a picker passing a notch.
        unawaited(HapticFeedback.selectionClick());
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
      // One soft knock as it goes: the moment the coins are spent.
      unawaited(HapticFeedback.lightImpact());
      setState(() => _sent = gift);
      await Future<void>.delayed(_celebration);
      if (!mounted) return;
      final box = _sentArt.currentContext?.findRenderObject();
      final from = box is RenderBox && box.attached
          ? box.localToGlobal(Offset.zero) & box.size
          : null;
      setState(() => _launched = true);
      Navigator.pop(context, _Outcome(sent: sent, gift: gift, from: from));
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
                      : picked == null
                          ? Text(l10n.ui('ui_gift_pick', 'Pick a gift'))
                          : affordable
                              ? _SendLabel(gift: picked)
                              : Text(l10n.ui(
                                  'ui_gift_not_enough', 'Not enough coins')),
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
                if (sent != null)
                  _Sent(gift: sent, artKey: _sentArt, launched: _launched),
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

/// A gift's picture: its artwork, always -- never an emoji.
///
/// The catalogue is the server's, so a gift can arrive here before the app
/// that draws it. It shows a wrapped present then, in the coin's gold,
/// rather than a gap or a glyph that looks different on every phone.
class GiftArt extends StatelessWidget {
  final String type;
  final double size;

  const GiftArt({super.key, required this.type, required this.size});

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
      child: FittedBox(
        child: Icon(Iconsax.gift, color: const Color(0xFFF2B233), size: size),
      ),
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
                  child: GiftMotion(
                    type: gift.type,
                    playing: affordable,
                    picked: picked,
                    child: GiftArt(type: gift.type, size: 48),
                  ),
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

/// The send button's words once a gift is picked: "Send Fire", the coin
/// and the price. The picture says which gift; the button says what it costs.
class _SendLabel extends StatelessWidget {
  final GiftType gift;

  const _SendLabel({required this.gift});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      label:
          '${l10n.ui('ui_gift_send_named', r'Send $gift').replaceAll(r'$gift', gift.name)}, '
          '${coinLabel(l10n, gift.coins)}',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n
                .ui('ui_gift_send_named', r'Send $gift')
                .replaceAll(r'$gift', gift.name),
          ),
          const SizedBox(width: SpacingTokens.space8),
          const CoinIcon(size: 16),
          const SizedBox(width: 3),
          Text(
            formatCount(gift.coins),
            style: const TextStyle(
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// The gift that just went, in the middle of the sheet: it springs up with a
/// wobble, throws out sparkles over a glow, and holds for a beat before it
/// flies to the heart.
class _Sent extends StatefulWidget {
  final GiftType gift;

  /// On the picture, so the sheet can say where its flight starts.
  final Key artKey;

  /// Whether it has left: the flying copy has taken over, so this one hides.
  final bool launched;

  const _Sent({
    required this.gift,
    required this.artKey,
    required this.launched,
  });

  @override
  State<_Sent> createState() => _SentState();
}

class _SentState extends State<_Sent> with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _t.value = 1;
    } else if (!_t.isAnimating && _t.value == 0) {
      _t.forward();
    }
  }

  @override
  void dispose() {
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const art = 112.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _t,
          builder: (context, child) {
            final t = _t.value;
            // In with a spring over the first half; a wobble that dies away.
            final rise = Curves.elasticOut.transform((t / 0.55).clamp(0, 1));
            final wobble = 0.22 * math.sin(t * 3 * math.pi) * (1 - t);
            return SizedBox.square(
              dimension: art * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (t > 0 && t < 1)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(painter: GiftBurstPainter(t: t)),
                      ),
                    ),
                  Opacity(
                    opacity: widget.launched ? 0 : 1,
                    child: Transform.rotate(
                      angle: wobble,
                      child: Transform.scale(
                        scale: 0.35 + 0.65 * rise,
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: KeyedSubtree(
            key: widget.artKey,
            child: GiftArt(type: widget.gift.type, size: art),
          ),
        ),
        FadeTransition(
          opacity: CurvedAnimation(
            parent: _t,
            curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
          ),
          child: Text(
            AppLocalizations.of(context)
                .ui('ui_gift_sent_named', r'$gift sent')
                .replaceAll(r'$gift', widget.gift.name),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize5,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
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
