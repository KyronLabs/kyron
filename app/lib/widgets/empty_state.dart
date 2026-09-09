// lib/widgets/empty_state.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'empty_artwork.dart';

/// The picture an empty state puts above its sentence.
///
/// Named for what the screen means rather than what the picture is, so a
/// screen asks for [EmptyArt.caughtUp] and does not care what that draws.
/// Every call site was already written that way, which is why swapping the
/// whole set is this file and nothing else.
///
/// It used to be eighteen rendered PNGs at three scales -- a doughnut, a UFO,
/// crossed swords, a tin of salt -- sharing a purple gradient and nothing
/// else, and fixed in colour whatever theme they were shown in. Each is now a
/// mark on a card and a glyph on a chip, drawn by [EmptyArtwork] from the
/// scheme, so the set is one thing and reads as one thing.
class EmptyArt {
  final EmptyMark mark;
  final IconData chip;

  const EmptyArt._(this.mark, this.chip);

  /// Nothing posted here.
  static const posts = EmptyArt._(EmptyMark.lines, EmptyChips.post);

  /// No clips or photos.
  static const videos = EmptyArt._(EmptyMark.play, EmptyChips.video);

  /// No messages, no replies, no comments.
  static const messages = EmptyArt._(EmptyMark.lines, EmptyChips.message);

  /// Read it all, nothing waiting.
  static const caughtUp = EmptyArt._(EmptyMark.token, EmptyChips.done);

  /// Nobody to show.
  static const people = EmptyArt._(EmptyMark.person, EmptyChips.people);

  /// No communities.
  static const communities = EmptyArt._(EmptyMark.group, EmptyChips.community);

  /// No topics or interests.
  static const topics = EmptyArt._(EmptyMark.group, EmptyChips.topic);

  /// Nothing trending.
  static const trending = EmptyArt._(EmptyMark.lines, EmptyChips.trending);

  /// Nothing under this tag.
  static const tag = EmptyArt._(EmptyMark.lines, EmptyChips.topic);

  /// A search that matched nothing.
  static const noMatch = EmptyArt._(EmptyMark.none, EmptyChips.search);

  /// Nothing saved.
  static const saved = EmptyArt._(EmptyMark.token, EmptyChips.saved);

  /// Nothing liked.
  static const likes = EmptyArt._(EmptyMark.token, EmptyChips.like);

  /// Nothing written.
  static const drafts = EmptyArt._(EmptyMark.lines, EmptyChips.draft);

  /// Nothing muted or blocked.
  static const muted = EmptyArt._(EmptyMark.person, EmptyChips.muted);

  /// The camera features.
  static const lens = EmptyArt._(EmptyMark.person, EmptyChips.lens);

  /// Broadcasting.
  static const live = EmptyArt._(EmptyMark.play, EmptyChips.live);

  /// Polls.
  static const polls = EmptyArt._(EmptyMark.group, EmptyChips.poll);

  /// A read that failed.
  static const offline = EmptyArt._(EmptyMark.none, EmptyChips.offline);
}

/// What a screen says when it has nothing to show.
///
/// One widget for empty and for failed, because the two are the same shape and
/// were drifting apart: the feed's version had a title, a detail line and a
/// 48px icon, the follow lists' had one line of text and a 40px one, the
/// drafts screen and the muted screens each had their own, and notifications
/// had a pulsing gradient circle all of its own.
class EmptyState extends StatelessWidget {
  /// Drawn at [_artSize] above the title.
  final EmptyArt art;

  /// What is missing, in a few words. The line people actually read.
  final String title;

  /// Why, or what to do about it. Omitted when the title says it all.
  final String? detail;

  /// The button under it, and what it does. Both or neither.
  final String? action;
  final VoidCallback? onAction;

  /// Smaller, for an empty state inside a card or a sheet rather than a
  /// screen of its own.
  final bool compact;

  static const double _artSize = 108;
  static const double _compactArtSize = 76;

  const EmptyState({
    super.key,
    required this.art,
    required this.title,
    this.detail,
    this.action,
    this.onAction,
    this.compact = false,
  });

  /// The shape a failed read takes: the reason, and a way to retry.
  const EmptyState.failed({
    super.key,
    required this.title,
    this.detail,
    this.onAction,
    this.action = 'Try again',
    this.compact = false,
  }) : art = EmptyArt.offline;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final detail = this.detail;
    final action = this.action;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SpacingTokens.space32,
        vertical: compact ? SpacingTokens.space24 : SpacingTokens.space40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Art(art: art, size: compact ? _compactArtSize : _artSize),
          SizedBox(
            height: compact ? SpacingTokens.space16 : SpacingTokens.space20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            // Was titleMedium, which is 16 and reads as a caption under a
            // picture this size. This is the sentence on the screen.
            style: TextStyle(
              fontSize: compact ? 17 : 20,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: scheme.onSurface,
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 14 : 15,
                height: 1.4,
                color: scheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
          if (action != null && onAction != null) ...[
            const SizedBox(height: SpacingTokens.space20),
            FilledButton.tonal(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space24,
                  vertical: SpacingTokens.space12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
                ),
              ),
              child: Text(
                action,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// The same thing, filling what is left of a scroll view.
  Widget get sliver => SliverFillRemaining(hasScrollBody: false, child: this);

  /// The same thing in a list of its own, so pull-to-refresh still works when
  /// there is nothing to scroll.
  Widget get scrollable => LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: this,
            ),
          ],
        ),
      );
}

/// The picture, and on a light background the shadow that holds it down.
///
/// The artwork was rendered on black, so the pale pieces -- the monitor, the
/// paint palette -- have nothing to sit against on a white screen and float
/// off it. A contact shadow puts them back on the page without touching their
/// colour, which tinting them would.
class _Art extends StatelessWidget {
  final EmptyArt art;
  final double size;

  const _Art({required this.art, required this.size});

  @override
  Widget build(BuildContext context) {
    // The title says what the state is; the picture repeating it would have a
    // screen reader announce everything twice.
    return ExcludeSemantics(
      child: EmptyArtwork(mark: art.mark, chip: art.chip, size: size),
    );
  }
}
