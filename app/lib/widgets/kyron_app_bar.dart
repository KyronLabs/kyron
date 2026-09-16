// lib/widgets/kyron_app_bar.dart
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'hairline.dart';

/// Kyron's top bar: an [AppBar] that draws a line instead of turning blue.
///
/// Material 3 marks "the page has scrolled under me" by raising the bar to
/// `scrolledUnderElevation` and washing it in `surfaceTint`, which is the
/// primary colour. Kyron's themes turn both off -- see the note on
/// `appBarTheme` in the design system -- because a bar that tints only while
/// the list is moving reads as a rendering fault rather than a state.
///
/// The state is still worth showing: a bar over content that runs underneath
/// it needs an edge, and a bar over the top of a page does not. So this draws
/// the same hairline the app uses between every other header and its content,
/// and only once something has actually scrolled beneath it.
///
/// Everything else is an [AppBar] and forwards to one.
class KyronAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KyronAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.titleSpacing,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.toolbarHeight,
    this.flexibleSpace,
    this.titleTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.leadingWidth,
    this.systemOverlayStyle,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  /// Whatever the screen puts under the toolbar -- a pager, a search field.
  /// The hairline goes below it, because the line belongs between the whole
  /// header and the content, not in the middle of the header.
  final PreferredSizeWidget? bottom;

  final double? titleSpacing;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final double? leadingWidth;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      toolbarHeight: toolbarHeight,
      flexibleSpace: flexibleSpace,
      titleTextStyle: titleTextStyle,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
      bottom: _ScrolledUnderHairline(under: bottom),
    );
  }
}

/// The screen's own `bottom`, with a line under it once the page has moved.
///
/// The line is drawn into space the bar already occupies rather than added to
/// its height: a hairline is one device pixel, and growing the toolbar by a
/// third of a logical pixel the first time somebody scrolls would shift every
/// row on the page down by that much.
class _ScrolledUnderHairline extends StatefulWidget
    implements PreferredSizeWidget {
  const _ScrolledUnderHairline({this.under});

  final PreferredSizeWidget? under;

  @override
  Size get preferredSize => under?.preferredSize ?? const Size.fromHeight(0);

  @override
  State<_ScrolledUnderHairline> createState() => _ScrolledUnderHairlineState();
}

class _ScrolledUnderHairlineState extends State<_ScrolledUnderHairline> {
  ScrollNotificationObserverState? _observer;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _observer?.removeListener(_onScroll);
    _observer = ScrollNotificationObserver.maybeOf(context);
    _observer?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _observer?.removeListener(_onScroll);
    _observer = null;
    super.dispose();
  }

  /// The same two notifications [AppBar] itself listens to, for the same
  /// reason: the update covers scrolling, and the metrics notification covers
  /// a page that arrives already scrolled -- restored state, a jump to an
  /// anchor -- where no drag ever happens.
  void _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification ||
        notification is ScrollMetricsNotification) {
      if (notification.depth != 0) return;
      final under = notification.metrics.extentBefore > 0;
      if (under != _scrolledUnder && mounted) {
        setState(() => _scrolledUnder = under);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final line = AnimatedOpacity(
      opacity: _scrolledUnder ? 1 : 0,
      // A state change, so micro (90ms) -- the same step the design system
      // gives every press state.
      duration: MotionTokens.micro,
      child: const Hairline(),
    );

    final under = widget.under;
    if (under == null) {
      // Nothing of its own to draw, so the line sits on the toolbar's own
      // bottom edge and the bar keeps its height.
      return SizedBox(
        height: 0,
        child: OverflowBox(
          alignment: Alignment.bottomCenter,
          maxHeight: hairlineWidth(context),
          child: line,
        ),
      );
    }

    // Laid over the screen's own bottom rather than stacked in a column with
    // it. `AppBar` hands its `bottom` an unbounded height in some layouts, and
    // an Expanded inside a min-size Column then fails `hasSize` -- which is
    // what a pager under one of these bars did on the first run of this.
    return Stack(
      fit: StackFit.passthrough,
      children: [
        under,
        Positioned(left: 0, right: 0, bottom: 0, child: line),
      ],
    );
  }
}
