import '../l10n/app_localizations.dart';

// lib/widgets/post_actions_row.dart
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/feed_post.dart';
import '../utils/format_count.dart';

import 'gift_sheet.dart';
import 'like_burst.dart';
import 'post_action_colors.dart';

/// The engagement row under a post.
///
/// Presentational, and shared: the feed card and the post's own screen both
/// draw this one, so the two cannot end up with a different set of buttons in
/// a different order -- which they had, down to the post screen having no
/// reply and no share at all. Each screen passes its own callbacks, because
/// each keeps the post in a different place.
class PostActionsRow extends StatelessWidget {
  final FeedPost post;

  final VoidCallback onReply;
  final VoidCallback onRepost;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final VoidCallback onShare;

  /// Opens the gift sheet, from a long press on the heart. There is no gift
  /// button: the row stays the five actions it always was, and a gift is the
  /// like you hold. Null leaves the heart as a like and nothing more -- on
  /// your own post, say, where there is nobody to give to.
  ///
  /// Given the heart's own context, so whatever is sent can fly back to it.
  final void Function(BuildContext heart)? onGift;

  /// Draw the counts beside the icons. False on a post's own screen, where
  /// they are already spelled out in full above the row.
  final bool showCounts;

  const PostActionsRow({
    super.key,
    required this.post,
    required this.onReply,
    required this.onRepost,
    required this.onLike,
    required this.onSave,
    required this.onShare,
    this.onGift,
    this.showCounts = true,
  });

  @override
  Widget build(BuildContext context) {
    // The three that are about the post -- reply, repost, like -- sit
    // together on the left with their counts. Save and share are about what
    // *you* do with it afterwards and carry no count, so they go to the right
    // rather than being strung along the same evenly spaced row where a bare
    // icon reads as a number that happens to be missing.
    return Row(
      children: [
        PostAction(
          icon: Iconsax.message_text_copy,
          label: showCounts && post.comments > 0
              ? formatCount(post.comments)
              : null,
          tooltip: AppLocalizations.of(context).reply,
          onTap: onReply,
        ),
        const SizedBox(width: SpacingTokens.space20),
        PostAction(
          // Outline until you act on it, filled once you have -- so the state
          // reads at a glance instead of only by colour.
          icon:
              post.reposted ? Iconsax.repeat_circle_copy : Iconsax.repeat_copy,
          label:
              showCounts && post.reposts > 0 ? formatCount(post.reposts) : null,
          active: post.reposted,
          activeColor: PostActionColors.repost,
          tooltip: AppLocalizations.of(context).repost,
          onTap: onRepost,
        ),
        const SizedBox(width: SpacingTokens.space20),
        PostAction(
          // Keyed by post, so a list that reuses this row for another post
          // starts it afresh rather than playing a landing for a gift that
          // never flew.
          key: ValueKey('like-${post.id}'),
          icon: post.liked ? Iconsax.heart : Iconsax.heart_copy,
          // Once you have sent the post a gift, the heart is that gift. A tap
          // is still a like; the count beside it is still the likes.
          art: post.viewerGift == null
              ? null
              : GiftArt(type: post.viewerGift!, size: 21),
          artKey: post.viewerGift,
          // What the post has been given, by anyone: a tiny crown on the
          // heart, the most valuable in the middle.
          topper: post.topGifts.isEmpty ? null : GiftStack(post.topGifts),
          label: showCounts && post.likes > 0 ? formatCount(post.likes) : null,
          active: post.liked,
          activeColor: PostActionColors.like,
          tooltip: post.liked ? 'Unlike' : 'Like',
          burst: true,
          onTap: onLike,
          onLongPress: onGift,
          longPressHint:
              AppLocalizations.of(context).ui('ui_gift_title', 'Send a gift'),
        ),
        const Spacer(),
        PostAction(
          icon: post.saved ? Iconsax.archive_tick : Iconsax.archive_add_copy,
          active: post.saved,
          activeColor: PostActionColors.save,
          tooltip: post.saved
              ? AppLocalizations.of(context).literalremoveFromSaved
              : AppLocalizations.of(context).save,
          onTap: onSave,
        ),
        const SizedBox(width: SpacingTokens.space12),
        PostAction(
          icon: Iconsax.export_1_copy,
          tooltip: 'Share',
          onTap: onShare,
        ),
      ],
    );
  }
}

/// One button in the engagement row.
///
/// Every one of them gives a little when pressed. The like also bursts, which
/// is the one action people take for pleasure rather than for a purpose --
/// see [LikeBurstPainter]. Taking a like back gets the give and nothing else:
/// firing a celebration in both directions makes a button look like it is
/// congratulating you for changing your mind.
class PostAction extends StatefulWidget {
  final IconData icon;
  final String? label;
  final bool active;
  final Color? activeColor;
  final String tooltip;
  final VoidCallback onTap;

  /// Throw a ring and sparks when this turns on. The like, and nothing else:
  /// a row where every control celebrates has no way left to mark the one
  /// that matters.
  final bool burst;

  /// What holding it does, if anything: the like's gift sheet. Given this
  /// button's context, so the sheet knows where it was opened from.
  final void Function(BuildContext context)? onLongPress;

  /// Drawn in place of [icon]: the gift you sent, on the like.
  final Widget? art;

  /// What [art] is, so a change of it can be told apart from a rebuild.
  /// Becoming something new plays the landing: a punch and a gold burst.
  final String? artKey;

  /// What a screen reader says holding it does. The gesture is invisible, so
  /// without this it is unreachable for anybody not looking at the screen.
  final String? longPressHint;

  /// Drawn just above the icon, taking no room: the row, the count beside
  /// the icon and the place a tap lands are exactly as they are without it.
  final Widget? topper;

  /// The glyph's size: 17 on a post, a step down on a comment, which sits
  /// under the post in the hierarchy and should not out-shout it.
  final double iconSize;

  const PostAction({
    super.key,
    required this.icon,
    this.label,
    this.active = false,
    this.activeColor,
    required this.tooltip,
    required this.onTap,
    this.burst = false,
    this.onLongPress,
    this.longPressHint,
    this.art,
    this.artKey,
    this.topper,
    this.iconSize = 17,
  });

  @override
  State<PostAction> createState() => _PostActionState();
}

class _PostActionState extends State<PostAction> with TickerProviderStateMixin {
  late final AnimationController _play = AnimationController(
    vsync: this,
    // Long enough for the sparks to travel and go, short enough that a second
    // tap is never waiting on the first.
    duration: const Duration(milliseconds: 620),
  );

  /// Whether the run in progress is a celebration or just a press.
  bool _celebrating = false;

  /// Whether the celebration in progress is a gift landing, in gold, rather
  /// than a like.
  bool _landing = false;

  /// The burst's gold: the coin's, so a gift's arrival reads as a gift's.
  static const _gold = Color(0xFFF2B233);

  /// The lift a long press gives: the icon rises a little, swells, and
  /// settles back as the sheet comes up. Its own controller, so holding a
  /// heart that is mid-burst does not cut the burst short.
  late final AnimationController _lift = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );

  /// On the icon, so a long press can hand over where the icon itself is --
  /// not the button with its count -- for a gift to fly to.
  final _iconKey = GlobalKey();

  /// How far past the icon the burst is allowed to spill, each side.
  static const double _reach = 15;

  @override
  void didUpdateWidget(PostAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    final art = widget.artKey;
    // With animations turned off the gift simply takes the heart's place, as
    // it arrived there without a flight.
    if (art != null &&
        art != oldWidget.artKey &&
        !MediaQuery.disableAnimationsOf(context)) {
      _celebrating = true;
      _landing = true;
      _play.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _play.dispose();
    _lift.dispose();
    super.dispose();
  }

  void _tapped() {
    // selectionClick is the lightest thing the platform offers -- the tick of
    // a picker passing a notch, not the thud of a confirmation. Anything
    // heavier on a control people press while reading is intrusive.
    unawaited(HapticFeedback.selectionClick());

    // Read from what it is about to become, not from what it is: the state
    // arrives from the notifier a frame later, and waiting for it puts the
    // animation behind the finger.
    _celebrating = widget.burst && !widget.active;
    _landing = false;
    _play.forward(from: 0);

    widget.onTap();
  }

  void _held() {
    final onLongPress = widget.onLongPress;
    if (onLongPress == null) return;
    // One step above a tap's tick, so holding reads as something different
    // from pressing -- and well short of the buzz Android gives a long press
    // by default, which is why this is not left to the InkWell.
    unawaited(HapticFeedback.lightImpact());
    _lift.forward(from: 0);
    onLongPress(_iconKey.currentContext ?? context);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colour = widget.active
        ? (widget.activeColor ?? scheme.primary)
        : scheme.onSurface.withValues(alpha: 0.55);

    final holdable = widget.onLongPress != null;

    // On a touch screen a tooltip opens on a long press. On the heart that
    // press is the gift sheet, and a "Like" bubble arriving with it is noise;
    // a mouse still gets the tooltip on hover.
    final button = Tooltip(
      message: widget.tooltip,
      triggerMode: holdable ? TooltipTriggerMode.manual : null,
      child: InkWell(
        onTap: _tapped,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        // No ripple and no pressed highlight. These buttons already answer a
        // tap -- the icon punches, and a like throws a burst -- and Material's
        // grey rectangle arriving underneath that read as a shadow smeared
        // behind the icon. Hover and focus are left alone: they are what a
        // pointer on the Windows build has to go on.
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _play,
                builder: (context, child) {
                  final t = _play.value;
                  final scale = t == 0
                      ? 1.0
                      : (_celebrating ? likePunch(t) : unlikePunch(t));

                  return Stack(
                    // So the burst can spill past a 17px icon. Nothing above
                    // this clips either -- the row leaves it the room.
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      if (_celebrating && t > 0 && t < 1)
                        Positioned(
                          left: -_reach,
                          right: -_reach,
                          top: -_reach,
                          bottom: -_reach,
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: LikeBurstPainter(
                                t: t,
                                colour: _landing
                                    ? _gold
                                    : widget.activeColor ??
                                        PostActionColors.like,
                              ),
                            ),
                          ),
                        ),
                      Transform.scale(scale: scale, child: child),
                      if (widget.topper != null)
                        // Its bottom on the icon's top. Outside the icon's
                        // box, which the Stack above lets it paint into, and
                        // out of hit testing, so it never takes a tap.
                        Positioned.fill(
                          child: IgnorePointer(
                            // Its own size, neither squeezed into the
                            // icon's box nor stretched to it: stretched, the
                            // row was as wide as the icon and its gifts sat
                            // off to the left of the heart's centre.
                            child: OverflowBox(
                              minWidth: 0,
                              minHeight: 0,
                              maxWidth: double.infinity,
                              maxHeight: double.infinity,
                              alignment: Alignment.topCenter,
                              child: FractionalTranslation(
                                translation: const Offset(0, -1),
                                child: widget.topper,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                child: AnimatedBuilder(
                  animation: _lift,
                  builder: (context, child) {
                    final t = _lift.value;
                    return Transform.translate(
                      offset: Offset(0, -2.5 * liftCurve(t)),
                      child: Transform.scale(
                        scale: 1 + 0.18 * liftCurve(t),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: _iconKey,
                    child: widget.art ??
                        Icon(widget.icon, size: widget.iconSize, color: colour),
                  ),
                ),
              ),
              if (widget.label != null) ...[
                const SizedBox(width: SpacingTokens.space4),
                // The number changes under a finger, so it moves rather than
                // swapping: up as it grows, down as it shrinks, which is the
                // direction the count itself went.
                AnimatedSwitcher(
                  duration: MotionTokens.fast,
                  switchInCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) => ClipRect(
                    child: SlideTransition(
                      position: Tween(
                        begin: Offset(0, widget.active ? 0.7 : -0.7),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  child: Text(
                    widget.label!,
                    key: ValueKey(widget.label),
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize1,
                      color: colour,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (!holdable) return button;

    // Outside the InkWell rather than its own onLongPress, which would fire
    // the platform's long-press feedback on top of [_held]'s. A tap still
    // reaches the InkWell: it ends before the long press can claim it.
    //
    // A recognizer of its own, because a GestureDetector's long press waits
    // the platform's 500ms and that felt like a wait. See [holdToGift].
    return Semantics(
      onLongPressHint: widget.longPressHint,
      onLongPress: _held,
      child: RawGestureDetector(
        // The Semantics above gives the long press and says what it does;
        // the detector's own annotation would replace that hint with none.
        excludeFromSemantics: true,
        gestures: {
          LongPressGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
            () => LongPressGestureRecognizer(duration: holdToGift),
            (recognizer) => recognizer.onLongPress = _held,
          ),
        },
        child: button,
      ),
    );
  }
}

/// How long the heart is held before the gift sheet opens.
///
/// Shorter than the platform's 500ms long press: held that long, the heart
/// sat still for half a second and read as nothing happening. Not much
/// shorter, because the heart is also tapped quickly and often, and a hold
/// that fires too soon turns a slow like into a gift sheet.
const holdToGift = Duration(milliseconds: 350);

/// How far into its lift a long-pressed icon is, for t from 0 to 1: up
/// quickly, a moment at the top, and back down. Zero at both ends, so the
/// icon is exactly where it was once the lift is done.
double liftCurve(double t) {
  if (t <= 0 || t >= 1) return 0;
  if (t < 0.35) return Curves.easeOutCubic.transform(t / 0.35);
  if (t < 0.5) return 1;
  return 1 - Curves.easeInOutCubic.transform((t - 0.5) / 0.5);
}

/// A count as a sentence: "1 like", "12 likes", "1.2K likes".
///
/// Spelled out rather than shown as a bare number beside an icon, because a
/// post's own screen has the room and "1 likes" is the kind of thing that
/// makes an app look unfinished.
String countLabel(int value, String singular, {String? plural}) {
  final word = value == 1 ? singular : (plural ?? '${singular}s');
  return '${formatCount(value)} $word';
}

/// The gifts a post has been given, worn on its heart like a crown.
///
/// The most valuable sits in the notch at the top of the heart, in front and
/// a little raised; the next two, smaller, rest on its lobes behind it,
/// tipped outwards. Each is cut out of what is behind it by a thin outline in
/// the page's colour, the way a sticker is, so three gifts overlapping each
/// other and the heart's line still read as three things at 11 points.
///
/// Low on purpose. A tower of three, or a row floating over the icon, stood
/// in the 8 points between the row and the words above it; worn on the
/// heart, the crown rises only [rise] above the icon's top.
///
/// Tiny on purpose, too: it says "people gave this something" at a glance
/// without competing with the heart or the count beside it, which are the
/// likes.
class GiftStack extends StatelessWidget {
  /// Most valuable first, as the API sends them.
  final List<String> types;

  const GiftStack(this.types, {super.key});

  /// The crown's gift, and the two beside it.
  static const double size = 11;
  static const double sideSize = 7.5;

  /// How far the crown reaches above the icon's top: the rest of it sits
  /// down on the heart.
  static const double rise = 8.5;

  /// The outline that cuts each gift out of what is behind it.
  static const double cut = 0.9;

  /// Where each gift sits, from the crown's centre: across, down, its tilt
  /// in turns, and its size. The second gift takes the left lobe.
  static const _slots = [
    (dx: 0.0, dy: 0.0, turn: 0.0, size: size),
    (dx: -6.5, dy: 1.6, turn: -0.045, size: sideSize),
    (dx: 6.5, dy: 1.6, turn: 0.045, size: sideSize),
  ];

  /// With two gifts there is no middle: the best on the left, in front,
  /// leaning in on the second.
  static const _pair = [
    (dx: -2.5, dy: 0.0, turn: -0.02, size: size),
    (dx: 5.0, dy: 1.6, turn: 0.045, size: sideSize),
  ];

  static const double width = size + 2 * (6.5 + sideSize / 2 - size / 2) + 2;
  static const double height = size + 2;

  @override
  Widget build(BuildContext context) {
    final shown = types.take(3).toList();
    final names = shown.map((t) => t[0].toUpperCase() + t.substring(1));
    final slots = shown.length == 2 ? _pair : _slots;
    final page = Theme.of(context).scaffoldBackgroundColor;
    return Semantics(
      label: 'Gifted: ${names.join(', ')}',
      // Paint only: the box above the icon stays [rise] tall, and the crown
      // is drawn down onto the heart from there.
      child: SizedBox(
        width: width,
        height: rise,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // The least valuable first, so the best is drawn last: in front.
            for (var i = shown.length - 1; i >= 0; i--)
              _gift(shown[i], slots[i], page),
          ],
        ),
      ),
    );
  }

  Widget _gift(
    String type,
    ({double dx, double dy, double turn, double size}) slot,
    Color page,
  ) {
    final box = slot.size + 2 * cut;
    return Positioned(
      left: width / 2 + slot.dx - box / 2,
      // The crown's top at the box's top; the side gifts lower, on the lobes.
      top: (size - slot.size) / 2 + slot.dy - cut,
      width: box,
      height: box,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(slot.turn),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The cut: the gift's own shape, a little bigger, in the page's
            // colour -- it follows the art, where a disc would read as a
            // badge.
            ColorFiltered(
              colorFilter: ColorFilter.mode(page, BlendMode.srcIn),
              child: GiftArt(type: type, size: box),
            ),
            GiftArt(type: type, size: slot.size),
          ],
        ),
      ),
    );
  }
}
