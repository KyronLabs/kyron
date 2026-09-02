// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/feed_provider.dart';
import '../providers/search_provider.dart';
import '../routes.dart';
import '../widgets/action_button.dart';
import '../widgets/person_tile.dart';
import '../widgets/post_card.dart';
import '../widgets/search_filter_sheet.dart';

/// Finding people and posts.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // The screen exists to be typed into, so it opens with the keyboard up.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    final notifier = ref.read(searchProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        titleSpacing: 0,
        // The field is inset from the trailing edge rather than running into
        // it: the previous one sat flush against the screen edge, so its
        // clear button had no margin at all.
        title: Padding(
          padding: const EdgeInsets.only(right: SpacingTokens.space12),
          child: TextField(
            controller: _controller,
            focusNode: _focus,
            textInputAction: TextInputAction.search,
            onChanged: notifier.query,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: state.mode == SearchMode.people
                  ? 'Search people'
                  : 'Search posts',
              // No padding of its own any more. This field was the one that
              // looked right, so its height became the theme's -- and a field
              // that restates it is a field that drifts away from it again.
              prefixIcon: const Icon(Iconsax.search_normal_1_copy, size: 19),
              // Matching the design system's field height. Written out rather
              // than read from it because these are the icon boxes, not the
              // field: they have to agree with it, and a box shorter than the
              // field pulls the glyph off centre.
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 44,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 44,
              ),
              suffixIcon: _Trailing(
                showClear: !state.isIdle,
                filterCount: state.filters.count,
                onClear: () {
                  _controller.clear();
                  notifier.clear();
                },
                onFilter: () => SearchFilterSheet.show(
                  context,
                  filters: state.filters,
                  onApply: notifier.setFilters,
                ),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: _Modes(
            mode: state.mode,
            filters: state.filters,
            onSelect: notifier.setMode,
            onClearFilters: () => notifier.setFilters(const SearchFilters()),
          ),
        ),
      ),
      body: SafeArea(child: _body(state)),
    );
  }

  Widget _body(SearchState state) {
    final notifier = ref.read(searchProvider.notifier);

    if (state.isIdle) {
      return _Hint(
        icon: Iconsax.search_normal_1_copy,
        title: state.mode == SearchMode.people
            ? 'Find people on Kyron'
            : 'Search everything posted',
        detail: state.mode == SearchMode.people
            ? 'Search by handle or display name.'
            : 'Words, or a filter — an account, a date range, or what a '
                'post carries.',
      );
    }
    if (state.isTooShort) {
      return const _Hint(
        icon: Iconsax.keyboard_copy,
        title: 'Keep typing',
        detail: 'Two characters or more.',
      );
    }
    if (state.error != null) {
      return _Hint(
        icon: Iconsax.cloud_cross_copy,
        title: 'Search failed',
        detail: state.error!,
        action: 'Try again',
        onAction: notifier.retry,
      );
    }
    if (state.isSearching && state.results.isEmpty && state.posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.foundNothing) {
      final what = state.query.trim();
      return _Hint(
        icon: Iconsax.search_status_copy,
        title: 'Nothing matched',
        detail: what.isEmpty
            ? 'No posts match those filters.'
            : 'Nothing on Kyron matches "$what".',
      );
    }

    if (state.mode == SearchMode.posts) {
      return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) => PostCard(
          post: state.posts[index],
          source: PostListSource.recent,
        ),
      );
    }

    return ListView.separated(
      itemCount: state.results.length,
      separatorBuilder: (context, _) => Divider(
        height: 1,
        thickness: 0.5,
        indent: SpacingTokens.space16 + 48 + SpacingTokens.space12,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
      ),
      itemBuilder: (context, index) {
        final person = state.results[index];
        return PersonTile(
          person: person,
          onOpen: () => openProfile(
            context,
            username: person.username,
            userId: person.id,
          ),
        );
      },
    );
  }
}

/// Clear and filter, at the trailing edge of the field.
class _Trailing extends StatelessWidget {
  final bool showClear;
  final int filterCount;
  final VoidCallback onClear;
  final VoidCallback onFilter;

  const _Trailing({
    required this.showClear,
    required this.filterCount,
    required this.onClear,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showClear)
          _Tap(
            tooltip: 'Clear',
            onTap: onClear,
            child: Icon(
              Iconsax.close_circle_copy,
              size: 17,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        _Tap(
          tooltip: 'Filters',
          onTap: onFilter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Iconsax.setting_4_copy,
                size: 18,
                color: filterCount > 0
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.6),
              ),
              // A count, not a dot: how many filters are on is the thing
              // worth knowing before opening the sheet again.
              if (filterCount > 0)
                Positioned(
                  right: -5,
                  top: -4,
                  child: Container(
                    width: 13,
                    height: 13,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$filterCount',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: scheme.onPrimary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: SpacingTokens.space8),
      ],
    );
  }
}

class _Tap extends StatelessWidget {
  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  const _Tap({
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(width: 32, height: 32, child: Center(child: child)),
        ),
      ),
    );
  }
}

/// People / Posts, plus the chips for whatever filters are on.
class _Modes extends StatelessWidget {
  final SearchMode mode;
  final SearchFilters filters;
  final ValueChanged<SearchMode> onSelect;
  final VoidCallback onClearFilters;

  const _Modes({
    required this.mode,
    required this.filters,
    required this.onSelect,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        children: [
          for (final option in SearchMode.values)
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: _Pill(
                label: option == SearchMode.people ? 'People' : 'Posts',
                selected: option == mode,
                onTap: () => onSelect(option),
              ),
            ),
          if (!filters.isEmpty)
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: Center(
                child: SizedBox(
                  height: 22,
                  child: VerticalDivider(
                    width: SpacingTokens.space8,
                    color: scheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          for (final chip in describeFilters(filters))
            Padding(
              padding: const EdgeInsets.only(right: SpacingTokens.space8),
              child: _Pill(label: chip, selected: true, onTap: onClearFilters),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space16,
            vertical: SpacingTokens.space8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            border: Border.all(
              color: selected
                  ? scheme.primary.withValues(alpha: 0.5)
                  : scheme.outline.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? scheme.primary : scheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final String? action;
  final VoidCallback? onAction;

  const _Hint({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: scheme.onSurface.withValues(alpha: .3)),
            const SizedBox(height: SpacingTokens.space16),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .65)),
            ),
            if (action != null && onAction != null) ...[
              const SizedBox(height: SpacingTokens.space16),
              ActionButton(
                label: action!,
                icon: Iconsax.refresh_copy,
                kind: ActionButtonKind.tonal,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
