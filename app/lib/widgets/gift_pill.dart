// lib/widgets/gift_pill.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import 'gift_sheet.dart' show GiftArt;

/// What a post has been given: the best gifts and how many, in a pill that
/// hangs off the bottom-right corner of the post.
///
/// It replaces two older ways of saying the same thing, both worn by the
/// heart: your own gift took the heart's place, and everyone's gifts were a
/// crown on it. The heart is a heart again and means likes; the gifts have
/// their own place, on the post they were given to.
///
/// White with a line round it and a soft lift in the light, like the
/// selection menu; in the dark a step lighter than the page rather than the
/// menu's black, which on a near-black page read as a hole in the post
/// instead of something resting on it.
class GiftPill extends StatelessWidget {
  /// Most valuable first, as the API sends them.
  final List<String> types;

  /// How many gifts in all, not how many kinds.
  final int count;

  /// You gave one of them: the count is in the accent.
  final bool yours;

  /// Send one -- null on your own post, which cannot be given anything.
  final VoidCallback? onTap;

  const GiftPill({
    super.key,
    required this.types,
    required this.count,
    this.yours = false,
    this.onTap,
  });

  static const double height = 26;

  /// Each gift's size, and how far along the next one starts: they overlap,
  /// the best in front, as faces in a reply count do.
  static const double giftSize = 16;
  static const double step = 12;

  /// The outline that cuts each gift out of the one behind it.
  static const double cut = 1.2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    final colours = (
      fill: dark ? const Color(0xFF1E1E21) : const Color(0xFFFFFFFF),
      ink: dark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
    );
    final shown = types.take(3).toList();
    final gifts =
        shown.isEmpty ? 0.0 : giftSize + step * (shown.length - 1) + 2 * cut;

    return Semantics(
      button: onTap != null,
      label: '$count ${count == 1 ? 'gift' : 'gifts'}',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: height,
          padding: const EdgeInsets.only(left: 5, right: 9),
          decoration: BoxDecoration(
            color: colours.fill,
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(
              color: dark
                  ? colours.ink.withValues(alpha: 0.12)
                  : scheme.outline.withValues(alpha: 0.3),
              width: 0.5,
            ),
            boxShadow: dark
                ? null
                // Two, close and far, so it lifts without a grey rim along
                // its lower edge.
                : const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: gifts,
                height: giftSize + 2 * cut,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // The least valuable first, so the best is drawn last:
                    // in front, on the left.
                    for (var i = shown.length - 1; i >= 0; i--)
                      Positioned(
                        left: step * i,
                        top: 0,
                        child: _Cut(type: shown[i], page: colours.fill),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _count(count),
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: yours
                      ? scheme.primary
                      : colours.ink.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _count(int n) {
    if (n < 1000) return '$n';
    if (n < 10000) {
      final k = (n / 100).floor() / 10;
      return '${k == k.roundToDouble() ? k.toInt() : k}K';
    }
    if (n < 1000000) return '${n ~/ 1000}K';
    return '${(n / 1000000).toStringAsFixed(1)}M';
  }
}

/// One gift with a ring of the pill's colour round its shape, like a
/// sticker, so it reads against the gift it overlaps.
class _Cut extends StatelessWidget {
  final String type;
  final Color page;

  const _Cut({required this.type, required this.page});

  @override
  Widget build(BuildContext context) {
    const box = GiftPill.giftSize + 2 * GiftPill.cut;
    return SizedBox.square(
      dimension: box,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(page, BlendMode.srcIn),
            child: GiftArt(type: type, size: box),
          ),
          GiftArt(type: type, size: GiftPill.giftSize),
        ],
      ),
    );
  }
}

/// A post's content with its [GiftPill] hung off the bottom-right corner,
/// and what comes under the post -- its actions -- below.
///
/// The pill straddles the content's bottom edge: half on the post, half in
/// the gap under it. On a picture, a link card or a voice note that half is
/// a corner of the frame -- the card's own padding, or the photo's edge --
/// and never words. When the post ends in words, which run to the right
/// edge, the words get room under them first, so the pill sits below the
/// last line rather than over it. And the gap under the content grows by
/// the other half, so the pill never touches Save and Share beneath it.
///
/// The spot is kept even with no gifts yet, unseen, so a gift being sent
/// has somewhere to fly to: see [anchorOf].
class GiftPillHost extends StatefulWidget {
  final Widget content;
  final Widget footer;

  /// The gap between [content] and [footer] when there is no pill.
  final double gap;

  /// Whether [content] ends in words, which need room under them.
  final bool endsInText;

  final List<String> types;
  final int count;
  final bool yours;

  /// Send one, given the pill's spot to fly the gift to. Null on your own.
  final void Function(BuildContext anchor)? onTap;

  const GiftPillHost({
    super.key,
    required this.content,
    required this.footer,
    required this.types,
    required this.count,
    this.gap = SpacingTokens.space8,
    this.endsInText = false,
    this.yours = false,
    this.onTap,
  });

  /// Whether [post]'s content, as a card or the post's page draws it, ends
  /// in its words with nothing under them.
  static bool endsInWords(FeedPost post) =>
      post.content.trim().isNotEmpty &&
      post.media.isEmpty &&
      post.poll == null &&
      post.quotedPost == null &&
      post.firstLink == null;

  /// How far in from the right edge the pill sits.
  static const double inset = SpacingTokens.space8;

  /// The pill's spot, for a gift to fly to, from anywhere under the host --
  /// the heart that was held, say. Null outside one.
  static BuildContext? anchorOf(BuildContext context) => context
      .findAncestorStateOfType<_GiftPillHostState>()
      ?._anchor
      .currentContext;

  @override
  State<GiftPillHost> createState() => _GiftPillHostState();
}

class _GiftPillHostState extends State<GiftPillHost> {
  final _anchor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final shown = widget.count > 0;
    const half = GiftPill.height / 2;
    // The pill's lower half is inside the stack, not hung below it: a stack
    // paints what overflows it but does not pass it taps, and half the pill
    // would not open the gifts.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: !shown
                    ? 0
                    : widget.endsInText
                        ? GiftPill.height
                        : half,
              ),
              child: widget.content,
            ),
            Positioned(
              right: GiftPillHost.inset,
              // With nothing to show, the spot is still kept -- unseen, and
              // only for a gift to fly to -- where the pill will appear.
              bottom: shown ? 0 : -half,
              child: KeyedSubtree(
                key: _anchor,
                child: AnimatedSwitcher(
                  duration: MotionTokens.normal,
                  switchInCurve: Curves.easeOutBack,
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: shown
                      ? GiftPill(
                          key: const ValueKey('gift-pill'),
                          types: widget.types,
                          count: widget.count,
                          yours: widget.yours,
                          onTap: widget.onTap == null
                              ? null
                              : () => widget.onTap!(
                                    _anchor.currentContext ?? context,
                                  ),
                        )
                      : const SizedBox.square(dimension: GiftPill.height),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: widget.gap),
        widget.footer,
      ],
    );
  }
}
