// lib/widgets/selection_menu.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import 'hairline.dart';

/// The menu over selected text in a post, a comment or a reply: Copy,
/// Search, Select all.
///
/// Drawn here rather than left to the platform's, whose Material menu is a
/// tinted grey in both themes -- a smudge on white and a grey slab on black.
/// This one is the page turned up: black words on white in the light theme,
/// white on black in the dark, with the hairline between its items and,
/// in the dark, around its edge, so a black menu on a black page still has
/// one.
class SelectionMenu extends StatelessWidget {
  final TextSelectionToolbarAnchors anchors;
  final List<SelectionMenuItem> items;

  const SelectionMenu({super.key, required this.anchors, required this.items});

  /// The menu for selected text in [state], with Search added when there is
  /// anything to search for. [selected] is the text, as the selection area
  /// last reported it; [onSearch] is what Search does with it.
  static Widget forRegion(
    BuildContext context,
    SelectableRegionState state, {
    required String? selected,
    required void Function(String text) onSearch,
  }) {
    final l10n = AppLocalizations.of(context);
    final given = state.contextMenuButtonItems;
    ContextMenuButtonItem? of(ContextMenuButtonType type) {
      for (final item in given) {
        if (item.type == type) return item;
      }
      return null;
    }

    final copy = of(ContextMenuButtonType.copy);
    final all = of(ContextMenuButtonType.selectAll);
    final query = selected?.trim() ?? '';
    final items = [
      if (copy != null)
        SelectionMenuItem(
          label: l10n.ui('ui_copy', 'Copy'),
          onPressed: copy.onPressed ?? () {},
        ),
      if (query.isNotEmpty)
        SelectionMenuItem(
          label: l10n.ui('ui_search', 'Search'),
          onPressed: () {
            // Close the menu and let the selection go before leaving, or
            // both are still there when the reader comes back.
            ContextMenuController.removeAny();
            state.clearSelection();
            onSearch(query);
          },
        ),
      if (all != null)
        SelectionMenuItem(
          label: l10n.ui('ui_select_all', 'Select all'),
          onPressed: all.onPressed ?? () {},
        ),
    ];
    if (items.isEmpty) return const SizedBox.shrink();
    return SelectionMenu(anchors: state.contextMenuAnchors, items: items);
  }

  /// The menu's own colours: the page's, turned up to full.
  static ({Color fill, Color ink}) coloursOf(Brightness brightness) =>
      brightness == Brightness.dark
          ? (fill: const Color(0xFF000000), ink: const Color(0xFFFFFFFF))
          : (fill: const Color(0xFFFFFFFF), ink: const Color(0xFF000000));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = coloursOf(theme.brightness);
    final dark = theme.brightness == Brightness.dark;
    final rule = RuleLine.colourOf(theme.colorScheme);

    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      if (i > 0) {
        // The hairline between items, as tall as the words rather than the
        // menu, so the items read as one strip with breaks in it.
        children.add(
          Container(
            width: RuleLine.weight,
            height: 20,
            color: dark ? colours.ink.withValues(alpha: 0.25) : rule,
          ),
        );
      }
      children.add(_Item(item: items[i], ink: colours.ink));
    }

    final menu = Container(
      decoration: BoxDecoration(
        color: colours.fill,
        borderRadius: BorderRadius.circular(RadiusTokens.radius16),
        // The rule around its edge in both themes -- on black it is the only
        // edge a black menu has -- and, in the light, a shadow soft and wide
        // enough to lift it without a grey smear along the bottom.
        border: Border.all(
          color: dark ? colours.ink.withValues(alpha: 0.2) : rule,
          width: RuleLine.weight,
        ),
        boxShadow: dark
            ? null
            : const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 24,
                  offset: Offset(0, 6),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: Row(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );

    // Placed as the platform's own menus are: above the selection when
    // there is room, below it when there is not, kept on screen.
    final padding = MediaQuery.paddingOf(context);
    const gap = SpacingTokens.space8;
    final above = anchors.primaryAnchor - const Offset(0, gap);
    final below = (anchors.secondaryAnchor ?? anchors.primaryAnchor) +
        const Offset(0, gap);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        SpacingTokens.space8,
        padding.top + SpacingTokens.space8,
        SpacingTokens.space8,
        SpacingTokens.space8,
      ),
      child: CustomSingleChildLayout(
        delegate: TextSelectionToolbarLayoutDelegate(
          anchorAbove: above -
              Offset(SpacingTokens.space8, padding.top + SpacingTokens.space8),
          anchorBelow: below -
              Offset(SpacingTokens.space8, padding.top + SpacingTokens.space8),
        ),
        child: menu,
      ),
    );
  }
}

/// One thing the menu offers.
class SelectionMenuItem {
  final String label;
  final VoidCallback onPressed;

  const SelectionMenuItem({required this.label, required this.onPressed});
}

class _Item extends StatelessWidget {
  final SelectionMenuItem item;
  final Color ink;

  const _Item({required this.item, required this.ink});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: item.onPressed,
        splashFactory: NoSplash.splashFactory,
        highlightColor: ink.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space12,
          ),
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize3,
              fontWeight: FontWeight.w500,
              color: ink,
              height: 1,
            ),
          ),
        ),
      );
}
