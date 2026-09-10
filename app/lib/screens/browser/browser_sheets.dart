// lib/screens/browser/browser_sheets.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'browser_chrome.dart';
import 'browser_palette.dart';
import 'browser_tab.dart';

/// What a reader picked from the page sheet.
enum PageChoice { copy, share, leave }

/// Everything about the page being read, and the three things to do with it.
///
/// The host in the bar is what stops a link being a trick, but a host alone
/// cannot: `secure-bank.example.com/login` and `example.com/secure-bank/login`
/// read the same at a glance and one of them is not the bank. This shows the
/// address in full, wrapped rather than cut, and says in words whether the
/// connection is private.
abstract final class PageSheet {
  static Future<PageChoice?> show(BuildContext context, BrowserTab tab) {
    return showModalBottomSheet<PageChoice>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final palette = BrowserPalette.of(context);
        final secure = tab.isSecure;

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.7,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SpacingTokens.space20,
                      0,
                      SpacingTokens.space20,
                      SpacingTokens.space16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OriginBadge(host: tab.host, size: 34),
                        const SizedBox(width: SpacingTokens.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tab.label,
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize4,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25,
                                  color: palette.ink,
                                ),
                              ),
                              const SizedBox(height: SpacingTokens.space8),
                              SelectableText(
                                tab.url.toString(),
                                style: TextStyle(
                                  fontSize: TypographyTokens.fontSize2,
                                  height: 1.45,
                                  color: palette.quiet,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space20,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(SpacingTokens.space12),
                      decoration: BoxDecoration(
                        color: (secure ? palette.accent : palette.alarm)
                            .withValues(alpha: 0.10),
                        borderRadius:
                            BorderRadius.circular(RadiusTokens.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            secure ? Iconsax.lock_1 : Iconsax.lock_slash,
                            size: 16,
                            color: secure ? palette.accent : palette.alarm,
                          ),
                          const SizedBox(width: SpacingTokens.space8),
                          Expanded(
                            child: Text(
                              secure
                                  ? 'Encrypted between this device and '
                                      '${tab.host}.'
                                  : 'Sent in the clear. Anyone on the network '
                                      'between you and ${tab.host} can read '
                                      'it.',
                              style: TextStyle(
                                fontSize: TypographyTokens.fontSize1,
                                height: 1.4,
                                color: palette.ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space8),
                  _Row(
                    icon: Iconsax.copy,
                    label: 'Copy link',
                    onTap: () => Navigator.pop(context, PageChoice.copy),
                  ),
                  _Row(
                    icon: Iconsax.export_3,
                    label: 'Share',
                    onTap: () => Navigator.pop(context, PageChoice.share),
                  ),
                  _Row(
                    icon: Iconsax.global,
                    label: 'Open in browser',
                    detail: 'Leaves Kyron and hands the page to your phone',
                    onTap: () => Navigator.pop(context, PageChoice.leave),
                  ),
                  const SizedBox(height: SpacingTokens.space8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// What a reader picked from the tab sheet: a tab to read, one to close, or
/// the lot.
sealed class TabChoice {
  const TabChoice();
}

class ReadTab extends TabChoice {
  final int index;
  const ReadTab(this.index);
}

class ShutTab extends TabChoice {
  final int index;
  const ShutTab(this.index);
}

class ShutEveryTab extends TabChoice {
  const ShutEveryTab();
}

/// Every page the browser has open.
///
/// The strip along the top holds two or three before it starts scrolling; this
/// is where the rest of them are, at a size where the title and the host are
/// both readable.
abstract final class TabSheet {
  static Future<TabChoice?> show(
    BuildContext context, {
    required List<BrowserTab> tabs,
    required int activeIndex,
  }) {
    return showModalBottomSheet<TabChoice>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final palette = BrowserPalette.of(context);

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    SpacingTokens.space20,
                    0,
                    SpacingTokens.space20,
                    SpacingTokens.space12,
                  ),
                  child: Text(
                    tabs.length == 1
                        ? '1 page open'
                        : '${tabs.length} pages open',
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize1,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: palette.quiet,
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      final tab = tabs[index];
                      final reading = index == activeIndex;

                      return ListTile(
                        onTap: () => Navigator.pop(context, ReadTab(index)),
                        leading: OriginBadge(host: tab.host, size: 30),
                        title: Text(
                          tab.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            fontWeight:
                                reading ? FontWeight.w600 : FontWeight.w400,
                            color: palette.ink,
                          ),
                        ),
                        subtitle: Text(
                          reading ? '${tab.host}  ·  Reading' : tab.host,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: TypographyTokens.fontSize1,
                            color: reading ? palette.accent : palette.quiet,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Iconsax.close_circle, size: 18),
                          tooltip: 'Close ${tab.label}',
                          onPressed: () =>
                              Navigator.pop(context, ShutTab(index)),
                        ),
                      );
                    },
                  ),
                ),
                if (tabs.length > 1)
                  _Row(
                    icon: Iconsax.close_square,
                    label: 'Close all pages',
                    destructive: true,
                    onTap: () => Navigator.pop(context, const ShutEveryTab()),
                  ),
                const SizedBox(height: SpacingTokens.space8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// One action line, shaped like the rest of Kyron's sheets.
class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? detail;
  final bool destructive;
  final VoidCallback onTap;

  const _Row({
    required this.icon,
    required this.label,
    required this.onTap,
    this.detail,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final palette = BrowserPalette.of(context);
    final colour = destructive ? palette.alarm : palette.ink;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 20, color: colour),
      title: Text(
        label,
        style: TextStyle(
          fontSize: TypographyTokens.fontSize3,
          color: colour,
        ),
      ),
      subtitle: detail == null
          ? null
          : Text(
              detail!,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                color: palette.quiet,
              ),
            ),
    );
  }
}
