// lib/screens/browser/browser_chrome.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'browser_palette.dart';
import 'browser_tab.dart';

/// The grab rail across the top of the browser.
///
/// Also the only part of the sheet that answers a drag: the page under it
/// scrolls, and a sheet that dismissed on any downward swipe would fight it
/// every time a reader reached the top of a page.
class BrowserRail extends StatelessWidget {
  static const double height = 18;

  const BrowserRail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          width: 38,
          height: 4,
          decoration: BoxDecoration(
            color: BrowserPalette.of(context).rail,
            borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          ),
        ),
      ),
    );
  }
}

/// The origin's stand-in for a favicon: a colour and a letter from the host.
class OriginBadge extends StatelessWidget {
  final String host;
  final double size;

  /// Dimmed, for a tab that is not the one being read.
  final bool muted;

  const OriginBadge({
    super.key,
    required this.host,
    this.size = 18,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final colour = OriginMark.colour(host, dark: dark);

    return Opacity(
      opacity: muted ? 0.5 : 1,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(size * 0.32),
        ),
        child: Text(
          OriginMark.letter(host),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.56,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

/// The address, and the whole reason a link can stay inside Kyron.
///
/// The app used to send a stranger's link to Chrome partly so the reader could
/// see where it had taken them. This says so instead, on every page, without
/// leaving: what the page calls itself on the first line and where it actually
/// is on the second, with the second line turning red and naming the problem
/// the moment the connection stops being private.
///
/// Tapping opens the page sheet, which has the URL in full -- a host alone
/// cannot show you `/login` on a domain that only looks like your bank's.
class AddressPill extends StatelessWidget {
  static const double height = 42;

  final BrowserTab tab;
  final VoidCallback onTap;

  const AddressPill({super.key, required this.tab, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);
    final secure = tab.isSecure;
    final host = tab.host;
    final titled = tab.hasTitle;

    // Quiet under a title it is subordinate to; full strength when it is the
    // only line the pill has. Never quiet when it is a warning.
    final originColour =
        !secure ? palette.alarm : (titled ? palette.quiet : palette.ink);

    return Semantics(
      button: true,
      label: secure
          ? 'Page details. ${tab.label}, secure connection to $host'
          : 'Page details. ${tab.label}, connection to $host is not secure',
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space12,
            ),
            decoration: BoxDecoration(
              color: palette.pill,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
              border: Border.all(color: palette.pillEdge),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Until the page says what it is called, [tab.label] is
                      // the host, and a pill reading the host over the host
                      // looks like a fault rather than two facts.
                      if (titled) ...[
                        Text(
                          tab.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize2,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: palette.ink,
                          ),
                        ),
                        const SizedBox(height: 1),
                      ],
                      Row(
                        children: [
                          Icon(
                            secure ? Iconsax.lock_1 : Iconsax.lock_slash,
                            size: titled ? 11 : 13,
                            color: originColour,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              secure ? host : 'Not private  ·  $host',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: titled
                                    ? TypographyTokens.fontSize1
                                    : TypographyTokens.fontSize2,
                                height: 1.2,
                                color: originColour,
                                fontWeight: secure
                                    ? (titled
                                        ? FontWeight.w400
                                        : FontWeight.w500)
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: SpacingTokens.space8),
                Icon(Iconsax.arrow_down_1, size: 12, color: palette.quiet),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// How far the page has got, as a hairline along the foot of the chrome.
///
/// Gone entirely when nothing is loading, rather than sitting at full width:
/// a bar that is always there stops meaning anything.
class LoadBar extends StatelessWidget {
  static const double height = 2;

  final BrowserTab tab;

  const LoadBar({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    final showing = tab.isLoading && tab.failure == null;

    return SizedBox(
      height: height,
      child: AnimatedOpacity(
        opacity: showing ? 1 : 0,
        duration: const Duration(milliseconds: 260),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            // Never at nothing: a load that has just begun still has to look
            // like it began.
            widthFactor: (tab.progress / 100).clamp(0.04, 1.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: BrowserPalette.of(context).accent,
                borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One tab in the strip.
class TabChip extends StatelessWidget {
  static const double height = 30;

  final BrowserTab tab;
  final bool active;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const TabChip({
    super.key,
    required this.tab,
    required this.active,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);

    // Two controls sharing one background rather than one control with a
    // second inside it: nesting them made the tab's own semantics swallow the
    // close button's, so a reader could reach the tab and not the cross.
    return Container(
      height: height,
      constraints: const BoxConstraints(maxWidth: 172),
      decoration: BoxDecoration(
        color: active ? palette.pill : Colors.transparent,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
        border: Border.all(
          color: active ? palette.pillEdge : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Semantics(
              button: true,
              selected: active,
              label: tab.label,
              excludeSemantics: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(left: SpacingTokens.space8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OriginBadge(host: tab.host, size: 14, muted: !active),
                      const SizedBox(width: SpacingTokens.space8),
                      Flexible(
                        child: Text(
                          tab.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            fontWeight:
                                active ? FontWeight.w600 : FontWeight.w400,
                            color: active ? palette.ink : palette.quiet,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Wide enough to hit without being wide enough to hit by accident
          // while aiming at the tab itself.
          Semantics(
            button: true,
            label: 'Close ${tab.label}',
            excludeSemantics: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onClose,
              child: SizedBox(
                width: 28,
                height: height,
                child: Icon(
                  Iconsax.close_circle,
                  size: 13,
                  color: palette.quiet,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The tab strip, present only once there is more than one tab.
///
/// One link off a post is the ordinary case and deserves no furniture at all;
/// three links off a thread are a set, and a set wants seeing at once.
class TabStrip extends StatefulWidget {
  static const double height = 40;

  final List<BrowserTab> tabs;
  final int activeIndex;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onClose;

  const TabStrip({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onSelect,
    required this.onClose,
  });

  @override
  State<TabStrip> createState() => _TabStripState();
}

class _TabStripState extends State<TabStrip> {
  /// One per tab, so the strip can scroll the one being read into view. A tab
  /// opened off the right-hand end is the tab you are now reading, and a strip
  /// still showing the last three is showing the wrong three.
  final _keys = <BrowserTab, GlobalKey>{};

  @override
  void didUpdateWidget(TabStrip old) {
    super.didUpdateWidget(old);
    if (widget.activeIndex == old.activeIndex &&
        widget.tabs.length == old.tabs.length) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _showActive());
  }

  void _showActive() {
    if (!mounted || widget.activeIndex >= widget.tabs.length) return;
    final context = _keys[widget.tabs[widget.activeIndex]]?.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Keys for tabs that have gone are dead weight on a long session.
    _keys.removeWhere((tab, _) => !widget.tabs.contains(tab));

    return SizedBox(
      height: TabStrip.height,
      // Faded at both ends rather than cut. A chip sliced off mid-title at the
      // screen edge reads as a fault; the same chip fading out reads as more
      // of them along that way, which is what it is.
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0x00000000),
            Color(0xFF000000),
            Color(0xFF000000),
            Color(0x00000000),
          ],
          stops: [0, 0.045, 0.955, 1],
        ).createShader(bounds),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space12,
            0,
            SpacingTokens.space12,
            SpacingTokens.space8,
          ),
          clipBehavior: Clip.none,
          itemCount: widget.tabs.length,
          separatorBuilder: (_, __) =>
              const SizedBox(width: SpacingTokens.space4),
          itemBuilder: (context, index) {
            final tab = widget.tabs[index];
            return TabChip(
              key: _keys.putIfAbsent(tab, GlobalKey.new),
              tab: tab,
              active: index == widget.activeIndex,
              onTap: () => widget.onSelect(index),
              onClose: () => widget.onClose(index),
            );
          },
        ),
      ),
    );
  }
}

/// A control in the browser's chrome.
class BrowserButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double size;

  const BrowserButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);
    final on = onTap != null;

    return Semantics(
      button: true,
      enabled: on,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: 20,
            color: on ? palette.ink : palette.quiet.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

/// The tab counter, drawn rather than picked from an icon font.
///
/// The number has to sit inside the square and stay centred at two digits,
/// which a glyph with a number stamped on top of it does not manage.
class TabCountButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const TabCountButton({super.key, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);

    return Semantics(
      button: true,
      // Without this a reader hears the bare number inside the square, which
      // is the one thing about it that does not explain itself.
      excludeSemantics: true,
      label: count == 1 ? '1 page open' : '$count pages open',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: palette.ink, width: 1.6),
                borderRadius: BorderRadius.circular(RadiusTokens.radius8),
              ),
              child: Text(
                // Past ninety-nine the square is the wrong shape for the
                // number, and [BrowserSession.maxTabs] means it cannot happen.
                '$count',
                style: TextStyle(
                  fontSize: count > 9 ? 10 : 12,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: palette.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Back, forward, reload and share, along the bottom where a thumb is.
///
/// The safe-area inset goes underneath the row rather than inside it, so a
/// phone with a gesture bar does not shrink every control on this bar to a
/// third of its height.
class BrowserFoot extends StatelessWidget {
  static const double rowHeight = 52;

  /// The rule along the top. Counted on top of [rowHeight] rather than out of
  /// it: a border inside the box shortens every control in it, which is the
  /// small version of the mistake the bottom bar used to make with the
  /// gesture inset.
  static const double hairline = 1;

  final BrowserTab tab;
  final VoidCallback? onBack;
  final VoidCallback? onForward;
  final VoidCallback onReloadOrStop;
  final VoidCallback onShare;

  const BrowserFoot({
    super.key,
    required this.tab,
    required this.onBack,
    required this.onForward,
    required this.onReloadOrStop,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);
    final inset = MediaQuery.paddingOf(context).bottom;
    final loading = tab.isLoading && tab.failure == null;

    return Container(
      height: rowHeight + inset + hairline,
      padding: EdgeInsets.only(bottom: inset),
      decoration: BoxDecoration(
        color: palette.chrome,
        border: Border(
          top: BorderSide(color: palette.rule, width: hairline),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BrowserButton(
            icon: Iconsax.arrow_left_2,
            label: 'Back',
            size: rowHeight,
            onTap: onBack,
          ),
          BrowserButton(
            icon: Iconsax.arrow_right_3,
            label: 'Forward',
            size: rowHeight,
            onTap: onForward,
          ),
          BrowserButton(
            icon: loading ? Iconsax.close_square : Iconsax.refresh,
            label: loading ? 'Stop loading' : 'Reload',
            size: rowHeight,
            onTap: onReloadOrStop,
          ),
          BrowserButton(
            icon: Iconsax.export_3,
            label: 'Share this page',
            size: rowHeight,
            onTap: onShare,
          ),
        ],
      ),
    );
  }
}

/// What the page area shows when the page did not load.
///
/// A web view that fails renders nothing, and nothing looks exactly like a
/// page that is still coming. This says which host failed, why, and offers the
/// two things worth trying.
class PageFailure extends StatelessWidget {
  final BrowserTab tab;
  final VoidCallback onRetry;
  final VoidCallback onLeave;

  const PageFailure({
    super.key,
    required this.tab,
    required this.onRetry,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);

    return Center(
      child: ConstrainedBox(
        // A measure, not the whole width: the message is a paragraph, and a
        // paragraph running the width of a tablet is unreadable. It also means
        // the panel lays out the same whatever the page area hands it, rather
        // than asking two buttons to size themselves against no width at all.
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(SpacingTokens.space32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OriginBadge(host: tab.host, size: 44),
              const SizedBox(height: SpacingTokens.space20),
              Text(
                tab.host.isEmpty ? 'This page' : tab.host,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize4,
                  fontWeight: FontWeight.w600,
                  color: palette.ink,
                ),
              ),
              const SizedBox(height: SpacingTokens.space8),
              Text(
                tab.failure ?? 'The page did not load.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  height: 1.45,
                  color: palette.quiet,
                ),
              ),
              const SizedBox(height: SpacingTokens.space24),
              // Stacked, not side by side: split across a phone the two
              // labels get about 140 points each and "Open in browser" does
              // not fit in that, so it wrapped inside its own button.
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onRetry,
                  child: const Text('Try again'),
                ),
              ),
              const SizedBox(height: SpacingTokens.space8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onLeave,
                  child: const Text('Open in browser'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
