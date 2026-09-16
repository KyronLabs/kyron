import '../l10n/app_localizations.dart';

// lib/widgets/interest_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/explore_provider.dart';
import '../providers/feed_provider.dart';

import 'empty_state.dart';
import 'skeleton.dart';

// State management
final interestTabsProvider =
    StateNotifierProvider<InterestTabsNotifier, List<String>>((ref) {
      return InterestTabsNotifier();
    });

/// Which tab the feed is showing.
///
/// Lifted out of the strip's own State. It was a plain `_selectedIndex` that
/// only recoloured a pill: pressing Following or Videos changed the highlight
/// and nothing else, and every tab read the same everyone-newest-first feed.
final selectedFeedTabProvider = StateProvider<String>((ref) => 'For You');

/// The feed a tab reads.
///
/// The three built-in tabs map onto their own endpoints. An interest tab the
/// reader added is a topic, so it reads that hashtag's feed -- which is what
/// makes adding one worth doing.
PostListSource feedSourceForTab(String tab) {
  switch (tab) {
    case 'For You':
      return PostListSource.recent;
    case 'Following':
      return PostListSource.following;
    case 'Videos':
      return PostListSource.videos;
    default:
      return PostListSource.hashtag(tab.replaceAll(RegExp(r'[\s#]'), ''));
  }
}

class InterestTabsNotifier extends StateNotifier<List<String>> {
  InterestTabsNotifier() : super(['For You', 'Following', 'Videos']);

  /// The most tabs the strip will hold. Past this the row stops being
  /// scannable, and the picker says so rather than going quiet.
  static const int maximum = 5;

  /// The fewest. Removing below this would leave a strip with nothing to
  /// switch between.
  static const int minimum = 2;

  bool get isFull => state.length >= maximum;

  void addTab(String interest) {
    if (!isFull && !state.contains(interest)) {
      state = [...state, interest];
    }
  }

  void removeTab(String interest) {
    if (state.length > minimum) {
      state = state.where((tab) => tab != interest).toList();
    }
  }

  void reorderTabs(int oldIndex, int newIndex) {
    final items = List<String>.from(state);
    if (newIndex > oldIndex) newIndex--;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }
}

class InterestTabs extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  const InterestTabs({super.key, this.scrollController});

  @override
  ConsumerState<InterestTabs> createState() => _InterestTabsState();
}

class _InterestTabsState extends ConsumerState<InterestTabs> {
  /// The strip's height, and the height of every target in it. The
  /// guidelines put the floor for a touch target at 44; the pills used to sit
  /// in a 4px inset that left them 36, with the strip above and below them
  /// dead to the finger.
  static const double _height = 44;

  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(interestTabsProvider);
    final selected = ref.watch(selectedFeedTabProvider);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: _height,
      color: scheme.surface,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                left: SpacingTokens.space16,
                right: SpacingTokens.space8,
              ),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final tab = tabs[index];
                return _TabPill(
                  label: tab,
                  isActive: tab == selected,
                  onTap: () =>
                      ref.read(selectedFeedTabProvider.notifier).state = tab,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space16),
            child: _AddButton(onTap: () => _showAddInterestSheet(context)),
          ),
        ],
      ),
    );
  }

  void _showAddInterestSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddInterestSheet(),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: isActive,
      child: GestureDetector(
        onTap: onTap,
        // The pill is shorter than the strip it sits in; opaque so the band
        // above and below it presses the tab too.
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(right: SpacingTokens.space8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space12,
                vertical: SpacingTokens.space8,
              ),
              decoration: BoxDecoration(
                // The accent, taken from the theme. All of this used to be
                // #4C8FFF written out by hand, which is not the accent the
                // design system documents and does not follow the theme.
                color: isActive
                    ? scheme.primary.withValues(alpha: 0.1)
                    : scheme.primaryContainer,
                borderRadius: BorderRadius.circular(RadiusTokens.radius12),
                border: isActive
                    ? Border.all(color: scheme.primary.withValues(alpha: 0.3))
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize2,
                  fontWeight: FontWeight.w500,
                  color: isActive ? scheme.primary : scheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  /// What the finger gets. The drawn button is smaller; this was 40 x 32 all
  /// the way through, which is under the floor in both directions.
  static const double _target = 44;
  static const double _drawnWidth = 40;
  static const double _drawnHeight = 32;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: AppLocalizations.of(context).literaladdAnInterest,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox.square(
          dimension: _target,
          child: Center(
            child: Container(
              width: _drawnWidth,
              height: _drawnHeight,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(RadiusTokens.radius12),
                border: Border.all(
                  color: scheme.onSurface.withValues(alpha: 0.2),
                ),
              ),
              // Outlined, like every other glyph in this strip and the
              // sheet it opens. Iconsax ships each one twice and the `_copy`
              // suffix is the outline.
              child: Icon(
                Iconsax.add_copy,
                size: 18,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Picks an interest to follow as a tab.
///
/// What it offers is what is actually trending -- the same
/// `feed/trending/tags` read Explore runs. It used to be a list of twelve
/// hashtags written into this file: #SnowLeopard, #MemeEconomy and friends,
/// none of which had to exist, so adding one could hand the reader a tab with
/// nothing behind it.
class AddInterestSheet extends ConsumerStatefulWidget {
  const AddInterestSheet({super.key});

  @override
  ConsumerState<AddInterestSheet> createState() => _AddInterestSheetState();
}

class _AddInterestSheetState extends ConsumerState<AddInterestSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(RadiusTokens.radius20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _header(scheme),
              _searchField(scheme),
              Expanded(child: _body(scrollController, scheme)),
            ],
          ),
        );
      },
    );
  }

  Widget _header(ColorScheme scheme) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space8),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Iconsax.arrow_left_copy, color: scheme.onSurface),
              tooltip: 'Back',
              onPressed: () => Navigator.pop(context),
            ),
            // Expanded rather than a bare Text with a Spacer after it: the
            // title takes its natural width, so at a large text size it
            // pushes Done off the edge of the sheet.
            Expanded(
              child: Text(
                'Add an interest',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: TypographyTokens.fontSize5,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).done),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        0,
        SpacingTokens.space16,
        SpacingTokens.space8,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        style: TextStyle(
          fontSize: TypographyTokens.fontSize3,
          color: scheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).searchTrendingTags,
          hintStyle: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5)),
          prefixIcon: Icon(
            Iconsax.search_normal_1_copy,
            size: 18,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
          filled: true,
          fillColor: scheme.primaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(RadiusTokens.radius12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _body(ScrollController controller, ColorScheme scheme) {
    final tabs = ref.watch(interestTabsProvider);
    final trending = ref.watch(trendingProvider);
    final query = _searchQuery.trim().toLowerCase();

    // Tags arrive without their #; the tabs carry one, and `feedSourceForTab`
    // strips it again on the way to the hashtag feed.
    final offered = trending.items
        .map((tag) => '#${tag.tag}')
        .where(
          (label) =>
              !tabs.contains(label) &&
              (query.isEmpty || label.toLowerCase().contains(query)),
        )
        .toList();

    return ListView(
      controller: controller,
      padding: const EdgeInsets.all(SpacingTokens.space16),
      children: [
        // What the reader opened this for comes first. Your tabs used to sit
        // above it, which put the list you came to pick from below the fold
        // of a half-height sheet.
        _sectionTitle(
          'Trending now',
          tabs.length >= InterestTabsNotifier.maximum
              ? 'Five tabs is the most the strip holds. Remove one to add '
                    'another.'
              : null,
          scheme,
        ),
        _offered(trending, offered, scheme),
        const SizedBox(height: SpacingTokens.space24),
        _sectionTitle('Your tabs', 'Drag to reorder', scheme),
        _yourTabs(tabs, scheme),
      ],
    );
  }

  Widget _offered(
    ExploreList trending,
    List<String> offered,
    ColorScheme scheme,
  ) {
    if (trending.loading) {
      return SkeletonList.tags(count: 6);
    }

    final error = trending.error;
    if (error != null) {
      return EmptyState.failed(
        title: AppLocalizations.of(context).literalcouldNotLoadTrendingTags,
        detail: error,
        compact: true,
        onAction: ref.read(trendingProvider.notifier).refresh,
      );
    }

    if (offered.isEmpty) {
      if (trending.items.isEmpty) {
        return EmptyState(
          art: EmptyArt.trending,
          title: AppLocalizations.of(context).literalnothingIsTrendingYet,
          detail: 'Hashtags turn up here as people start using them.',
          compact: true,
        );
      }
      if (_searchQuery.trim().isNotEmpty) {
        return EmptyState(
          art: EmptyArt.noMatch,
          title: AppLocalizations.of(context).literalnoTrendingTagMatchesThat,
          compact: true,
        );
      }
      return EmptyState(
        art: EmptyArt.caughtUp,
        title: AppLocalizations.of(context)
            .literalyouAlreadyFollowEveryTrendingTag,
        compact: true,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [for (final label in offered) _ToggleChip(label: label)],
    );
  }

  Widget _sectionTitle(String title, String? detail, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: TypographyTokens.fontSize4,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: SpacingTokens.space4),
            Text(
              detail,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _yourTabs(List<String> tabs, ColorScheme scheme) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tabs.length,
      onReorder: (oldIndex, newIndex) => ref
          .read(interestTabsProvider.notifier)
          .reorderTabs(oldIndex, newIndex),
      itemBuilder: (context, index) {
        final tab = tabs[index];
        return _DraggableChip(
          key: ValueKey(tab),
          label: tab,
          canRemove: tabs.length > InterestTabsNotifier.minimum,
          onRemove: () =>
              ref.read(interestTabsProvider.notifier).removeTab(tab),
        );
      },
    );
  }
}

class _DraggableChip extends StatelessWidget {
  final String label;
  final bool canRemove;
  final VoidCallback onRemove;

  const _DraggableChip({
    super.key,
    required this.label,
    required this.canRemove,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: SpacingTokens.space8),
      padding: const EdgeInsets.only(left: SpacingTokens.space12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(RadiusTokens.radius12),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.menu_1_copy,
            size: 20,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface,
              ),
            ),
          ),
          if (canRemove)
            IconButton(
              // An IconButton rather than a bare 18px glyph: the tap area was
              // the size of the icon, which is well under the 44 floor.
              icon: Icon(
                Iconsax.close_circle_copy,
                size: 18,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
              tooltip: 'Remove $label',
              onPressed: onRemove,
            )
          else
            const SizedBox(width: SpacingTokens.space12),
        ],
      ),
    );
  }
}

class _ToggleChip extends ConsumerWidget {
  final String label;

  _ToggleChip({required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final notifier = ref.read(interestTabsProvider.notifier);
    // Watched, so the row stops being addable the moment the fifth tab lands.
    final isFull =
        ref.watch(interestTabsProvider).length >= InterestTabsNotifier.maximum;

    return Semantics(
      button: !isFull,
      enabled: !isFull,
      label: 'Add $label as a tab',
      child: GestureDetector(
        onTap: isFull ? null : () => notifier.addTab(label),
        behavior: HitTestBehavior.opaque,
        child: AnimatedOpacity(
          duration: MotionTokens.fast,
          opacity: isFull ? 0.5 : 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: SpacingTokens.space8),
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
              vertical: SpacingTokens.space12,
            ),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(RadiusTokens.radius12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      fontWeight: FontWeight.w500,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Icon(Iconsax.add_circle_copy, size: 20, color: scheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
