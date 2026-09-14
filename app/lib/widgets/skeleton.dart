// lib/widgets/skeleton.dart
//
// What a screen shows while it is loading: the shape of what is coming,
// rather than a spinner in the middle of nothing.
//
// A centred spinner tells the reader two things -- that something is
// happening, and nothing else. A skeleton says how much is coming and roughly
// what it looks like, so the page does not rearrange itself under them when it
// lands, and a slow connection reads as a page filling in rather than a page
// that might be broken.
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'hairline.dart';

/// One grey block, breathing.
///
/// The animation is shared by every block on screen through one controller in
/// [SkeletonGroup]: a page of forty rows animating independently is forty
/// tickers, and the sweep looks wrong when they are out of step.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius = RadiusTokens.radiusSm,
  });

  /// A circle, for an avatar.
  const SkeletonBox.circle({super.key, required double size})
      : width = size,
        height = size,
        radius = size;

  /// A line of text.
  ///
  /// With no [width] it fills what it is given, so the column holding it has
  /// to stretch -- in a column aligned to the start it has no width to take
  /// and comes out as nothing at all. Short lines carry an explicit width.
  const SkeletonBox.line({super.key, this.width, this.height = 12})
      : radius = 4;

  @override
  Widget build(BuildContext context) {
    final shimmer = SkeletonGroup.of(context);
    final scheme = Theme.of(context).colorScheme;

    // Two tones of the surface rather than grey: on a dark theme a fixed grey
    // is lighter than the page it sits on and reads as content, not absence.
    final base = scheme.onSurface.withValues(alpha: 0.07);
    final highlight = scheme.onSurface.withValues(alpha: 0.12);

    return SizedBox(
      width: width,
      height: height,
      child: shimmer == null
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(radius),
              ),
            )
          : AnimatedBuilder(
              animation: shimmer,
              builder: (context, _) {
                // From well off one edge to well off the other, so the
                // highlight enters and leaves rather than appearing in the
                // middle of the block.
                final sweep = -2 + shimmer.value * 4;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    gradient: LinearGradient(
                      // Swept across, so the highlight travels rather than
                      // the whole block pulsing -- which at this size looks
                      // like a rendering fault.
                      begin: Alignment(sweep - 1, 0),
                      end: Alignment(sweep + 1, 0),
                      colors: [base, highlight, base],
                      stops: const [0.35, 0.5, 0.65],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

/// Drives the sweep for every [SkeletonBox] under it.
class SkeletonGroup extends StatefulWidget {
  final Widget child;

  const SkeletonGroup({super.key, required this.child});

  static Animation<double>? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_SkeletonTicker>()?.animation;

  @override
  State<SkeletonGroup> createState() => _SkeletonGroupState();
}

class _SkeletonGroupState extends State<SkeletonGroup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _SkeletonTicker(
        animation: _controller,
        child: widget.child,
      );
}

class _SkeletonTicker extends InheritedWidget {
  final Animation<double> animation;

  const _SkeletonTicker({required this.animation, required super.child});

  @override
  bool updateShouldNotify(_SkeletonTicker old) => old.animation != animation;
}

/// A run of skeletons in the shape of one kind of row.
///
/// Wrapped in a [SkeletonGroup] and given the list's own padding, so what
/// appears while loading occupies the same place as what replaces it.
class SkeletonList extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int count;
  final EdgeInsets padding;
  final Widget? separator;

  const SkeletonList({
    super.key,
    required this.itemBuilder,
    this.count = 6,
    this.padding = EdgeInsets.zero,
    this.separator,
  });

  /// Posts, for the feed and any list of them.
  factory SkeletonList.posts({int count = 4}) => SkeletonList(
        count: count,
        itemBuilder: (context, index) => const _PostSkeleton(),
      );

  /// People, for followers, search results and Explore.
  factory SkeletonList.people({int count = 7}) => SkeletonList(
        count: count,
        itemBuilder: (context, index) => const _PersonSkeleton(),
      );

  /// Conversations, for the messages list.
  factory SkeletonList.conversations({int count = 8}) => SkeletonList(
        count: count,
        itemBuilder: (context, index) => const _ConversationSkeleton(),
      );

  /// Comments, indented the way a thread is.
  factory SkeletonList.comments({int count = 5}) => SkeletonList(
        count: count,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        // Every third one a reply, so the run reads as a conversation rather
        // than a list.
        itemBuilder: (context, index) =>
            _CommentSkeleton(indent: index % 3 == 1 ? 28 : 0),
      );

  /// Notifications: a small avatar, a line of what happened, a time.
  factory SkeletonList.notifications({int count = 8}) => SkeletonList(
        count: count,
        itemBuilder: (context, index) => const _NotificationSkeleton(),
      );

  /// Communities: a square badge rather than a round avatar.
  factory SkeletonList.communities({int count = 6}) => SkeletonList(
        count: count,
        itemBuilder: (context, index) => const _CommunitySkeleton(),
      );

  /// Chat bubbles, alternating sides.
  factory SkeletonList.messages({int count = 7}) => SkeletonList(
        count: count,
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space12,
          vertical: SpacingTokens.space12,
        ),
        itemBuilder: (context, index) => _BubbleSkeleton(mine: index.isOdd),
      );

  @override
  Widget build(BuildContext context) => SkeletonGroup(
        // A Column, not a ListView. There is nothing here to scroll to, and a
        // list nested inside another scroll view has no height to lay out in
        // -- which is not an error, it simply comes out as nothing at all.
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < count; index++) ...[
                if (index > 0 && separator != null) separator!,
                itemBuilder(context, index),
              ],
            ],
          ),
        ),
      );
}

class _PostSkeleton extends StatelessWidget {
  const _PostSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const SkeletonBox.circle(size: 40),
                const SizedBox(width: SpacingTokens.space12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonBox.line(width: 120, height: 13),
                    SizedBox(height: SpacingTokens.space8),
                    SkeletonBox.line(width: 80, height: 11),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SpacingTokens.space12),
            const SkeletonBox.line(),
            const SizedBox(height: SpacingTokens.space8),
            const SkeletonBox.line(),
            const SizedBox(height: SpacingTokens.space8),
            const FractionallySizedBox(
              // Short, so a block of lines reads as a paragraph rather than
              // as a table.
              alignment: Alignment.centerLeft,
              widthFactor: 0.55,
              child: SkeletonBox.line(),
            ),
            const SizedBox(height: SpacingTokens.space16),
            Row(
              children: const [
                SkeletonBox(width: 44, height: 14),
                SizedBox(width: SpacingTokens.space20),
                SkeletonBox(width: 44, height: 14),
                SizedBox(width: SpacingTokens.space20),
                SkeletonBox(width: 44, height: 14),
              ],
            ),
            const SizedBox(height: SpacingTokens.space16),
            const Hairline(),
          ],
        ),
      );
}

class _PersonSkeleton extends StatelessWidget {
  const _PersonSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            const SkeletonBox.circle(size: 48),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SkeletonBox.line(width: 140, height: 13),
                  SizedBox(height: SpacingTokens.space8),
                  SkeletonBox.line(width: 90, height: 11),
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            const SkeletonBox(width: 84, height: 32, radius: 16),
          ],
        ),
      );
}

class _ConversationSkeleton extends StatelessWidget {
  const _ConversationSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            const SkeletonBox.circle(size: 52),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SkeletonBox.line(width: 110, height: 13),
                  ),
                  SizedBox(height: SpacingTokens.space8),
                  SkeletonBox.line(height: 11),
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space12),
            const SkeletonBox.line(width: 28, height: 10),
          ],
        ),
      );
}

class _CommentSkeleton extends StatelessWidget {
  final double indent;

  const _CommentSkeleton({required this.indent});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: indent,
          top: SpacingTokens.space12,
          bottom: SpacingTokens.space4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox.circle(size: 34),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SkeletonBox.line(width: 100, height: 12),
                  ),
                  SizedBox(height: SpacingTokens.space8),
                  SkeletonBox.line(),
                  SizedBox(height: SpacingTokens.space4),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.7,
                    child: SkeletonBox.line(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _BubbleSkeleton extends StatelessWidget {
  final bool mine;

  const _BubbleSkeleton({required this.mine});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
        child: Row(
          mainAxisAlignment:
              mine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            SkeletonBox(
              width: mine ? 160 : 210,
              height: 40,
              radius: RadiusTokens.radiusLg,
            ),
          ],
        ),
      );
}

class _NotificationSkeleton extends StatelessWidget {
  const _NotificationSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBox.circle(size: 38),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SkeletonBox.line(),
                  SizedBox(height: SpacingTokens.space8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SkeletonBox.line(width: 60, height: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _CommunitySkeleton extends StatelessWidget {
  const _CommunitySkeleton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space16,
          vertical: SpacingTokens.space12,
        ),
        child: Row(
          children: [
            const SkeletonBox(
              width: 48,
              height: 48,
              radius: RadiusTokens.radiusMd,
            ),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SkeletonBox.line(width: 130, height: 13),
                  ),
                  SizedBox(height: SpacingTokens.space8),
                  SkeletonBox.line(height: 11),
                ],
              ),
            ),
            const SizedBox(width: SpacingTokens.space8),
            const SkeletonBox(width: 64, height: 30, radius: 15),
          ],
        ),
      );
}

/// The Videos wall's own shape: a staggered two-column stack of tiles.
///
/// The Videos tab loaded behind [SkeletonList.posts], so a wall of clips
/// announced itself as a column of paragraphs with avatars and engagement rows
/// and then replaced every bit of it. This is the shape that actually lands --
/// the same two columns, the same gutters, the same corner radius as
/// `MediaTileGrid`.
class SkeletonTileWall extends StatelessWidget {
  final int count;

  const SkeletonTileWall({super.key, this.count = 8});

  /// Aspect ratios, cycled. Uneven on purpose: a stagger whose tiles are all
  /// the same height is a grid, and what replaces this is not one. Kept inside
  /// the bounds `MediaTileGrid` clamps a real attachment to.
  static const List<double> _ratios = [0.72, 1.0, 0.62, 0.86, 0.66, 1.12];

  @override
  Widget build(BuildContext context) {
    // Laid out against the width it is given rather than by AspectRatio, so
    // the two columns stay level with the real grid's spacing on any screen.
    return SkeletonGroup(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final column = (constraints.maxWidth - SpacingTokens.space8) / 2;
            final columns = [<Widget>[], <Widget>[]];
            for (var index = 0; index < count; index++) {
              final side = columns[index % 2];
              if (side.isNotEmpty) {
                side.add(const SizedBox(height: SpacingTokens.space8));
              }
              side.add(
                SkeletonBox(
                  height: column / _ratios[index % _ratios.length],
                  radius: RadiusTokens.radiusMd,
                ),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var side = 0; side < columns.length; side++) ...[
                  if (side > 0) const SizedBox(width: SpacingTokens.space8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: columns[side],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// One full-screen clip, while the first page of them is on its way.
///
/// The full-screen feed showed the word "Loading…" in the middle of a black
/// screen, which is indistinguishable from a clip that will never arrive. This
/// is where the caption and the rail are about to be.
class SkeletonClip extends StatelessWidget {
  const SkeletonClip({super.key});

  /// The rail has seven buttons: like, reply, repost, save, share, sound,
  /// more.
  static const int _railButtons = 7;

  @override
  Widget build(BuildContext context) {
    // Fixed tones rather than the scheme's: this screen is black whatever the
    // theme is, so a skeleton drawn from `onSurface` is invisible on it in
    // light mode.
    return const SkeletonGroup(
      child: _ClipBody(),
    );
  }
}

class _ClipBody extends StatelessWidget {
  const _ClipBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.black),
        // The rail, down the right-hand edge.
        Positioned(
          right: SpacingTokens.space8,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var index = 0;
                      index < SkeletonClip._railButtons;
                      index++)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: SpacingTokens.space8),
                      child: _OnBlack(child: SkeletonBox.circle(size: 36)),
                    ),
                ],
              ),
            ),
          ),
        ),
        // The caption, bottom left, clear of the rail.
        Positioned(
          left: SpacingTokens.space16,
          right: 88,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _OnBlack(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SkeletonBox.circle(size: 32),
                        SizedBox(width: SpacingTokens.space8),
                        SkeletonBox.line(width: 110, height: 15),
                      ],
                    ),
                  ),
                  SizedBox(height: SpacingTokens.space12),
                  _OnBlack(child: SkeletonBox.line(width: 220, height: 13)),
                  SizedBox(height: SpacingTokens.space8),
                  _OnBlack(child: SkeletonBox.line(width: 150, height: 13)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Lets [SkeletonBox] draw on black.
///
/// Its tones come from `onSurface`, which on a light theme is near-black --
/// invisible on this screen, which is black in either theme. A local dark
/// scheme gives the boxes something to be lighter than.
class _OnBlack extends StatelessWidget {
  final Widget child;

  const _OnBlack({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          onSurface: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      child: child,
    );
  }
}
