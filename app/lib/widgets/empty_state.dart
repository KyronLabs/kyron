// lib/widgets/empty_state.dart
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// The picture an empty state puts above its sentence.
///
/// Named for what the screen means rather than what the picture is, so a
/// screen asks for [EmptyArt.caughtUp] and does not care that today that is a
/// party popper. Swapping the artwork is then one line here, not thirty across
/// the app.
///
/// Cut from the source renders by tools/build_empty_art.py, which squares each
/// one to a single box so every empty state draws the same shape whatever it
/// is holding.
class EmptyArt {
  final String _file;

  const EmptyArt._(this._file);

  String get asset => 'lib/assets/empty/$_file.png';

  /// Nothing posted here. A melting slushie.
  static const posts = EmptyArt._('slushie');

  /// No clips or photos. A tub of popcorn.
  static const videos = EmptyArt._('popcorn');

  /// No messages, no replies, no comments. A speech bubble.
  static const messages = EmptyArt._('bubble');

  /// Read it all, nothing waiting. Party poppers.
  static const caughtUp = EmptyArt._('poppers');

  /// Nobody to show. A pixel creature.
  static const people = EmptyArt._('creature');

  /// No communities. A toadstool.
  static const communities = EmptyArt._('mushroom');

  /// No topics or interests. A paint palette.
  static const topics = EmptyArt._('palette');

  /// Nothing trending. A trophy.
  static const trending = EmptyArt._('trophy');

  /// Nothing under this tag. A spiked ball.
  static const tag = EmptyArt._('spikeball');

  /// A search that matched nothing. A UFO.
  static const noMatch = EmptyArt._('ufo');

  /// Nothing saved. A star lollipop.
  static const saved = EmptyArt._('lollipop');

  /// Nothing liked. A doughnut.
  static const likes = EmptyArt._('donut');

  /// Nothing written. A keyboard key.
  static const drafts = EmptyArt._('fkey');

  /// Nothing muted or blocked. A spilled tin of salt.
  static const muted = EmptyArt._('salt');

  /// The camera features. Pixel sunglasses.
  static const lens = EmptyArt._('shades');

  /// Broadcasting. A LIVE badge.
  static const live = EmptyArt._('live');

  /// Polls. Crossed swords.
  static const polls = EmptyArt._('swords');

  /// A read that failed. A monitor showing nothing.
  static const offline = EmptyArt._('monitor');
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
    final image = Image.asset(
      art.asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      // The title says what the state is; the picture repeating it would have
      // a screen reader announce everything twice.
      excludeFromSemantics: true,
    );

    if (Theme.of(context).brightness == Brightness.dark) {
      return SizedBox(width: size, height: size, child: image);
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.translate(
            offset: Offset(0, size * 0.05),
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: size * 0.055,
                sigmaY: size * 0.055,
              ),
              child: Image.asset(
                art.asset,
                width: size,
                height: size,
                fit: BoxFit.contain,
                // Flattens the drawing to its own silhouette, which is what
                // gets blurred. Anything else would blur the artwork itself.
                color: Colors.black.withValues(alpha: 0.30),
                colorBlendMode: BlendMode.srcIn,
                excludeFromSemantics: true,
              ),
            ),
          ),
          image,
        ],
      ),
    );
  }
}
