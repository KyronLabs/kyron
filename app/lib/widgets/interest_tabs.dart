// lib/widgets/interest_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// State management
final interestTabsProvider = StateNotifierProvider<InterestTabsNotifier, List<String>>((ref) {
  return InterestTabsNotifier();
});

class InterestTabsNotifier extends StateNotifier<List<String>> {
  InterestTabsNotifier() : super(['For You', 'Following', 'Videos']);

  void addTab(String interest) {
    if (state.length < 5 && !state.contains(interest)) {
      state = [...state, interest];
    }
  }

  void removeTab(String interest) {
    if (state.length > 2) {
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(interestTabsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillBg = isDark ? const Color(0xFF1F1F23) : const Color(0xFFF7F7F7);
    final textPrimary = isDark ? const Color(0xFFE5EBF5) : const Color(0xFF1A202C);

    return Container(
      height: 44,
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Scrollable tabs
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return _buildTabPill(
                  context,
                  tabs[index],
                  index == _selectedIndex,
                  pillBg,
                  textPrimary,
                  () => setState(() => _selectedIndex = index),
                );
              },
            ),
          ),
          
          // Fixed add button
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _buildAddButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(BuildContext context, String label, bool isActive, Color bg, Color text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4C8FFF).withOpacity(0.1) : bg,
          borderRadius: BorderRadius.circular(12),
          border: isActive ? Border.all(color: const Color(0xFF4C8FFF).withOpacity(0.3)) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFF4C8FFF) : text,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1A1A1D) : const Color(0xFFF8FAFC);
    final borderColor = isDark ? const Color(0xFF666666) : const Color(0xFF999999);
    final iconColor = isDark ? Colors.white.withOpacity(0.6) : const Color(0xFF718096);
    
    return GestureDetector(
      onTap: () => _showAddInterestSheet(context),
      child: Container(
        width: 40,
        height: 32,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 18,
            color: iconColor,
          ),
        ),
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

class AddInterestSheet extends ConsumerStatefulWidget {
  const AddInterestSheet({super.key});

  @override
  ConsumerState<AddInterestSheet> createState() => _AddInterestSheetState();
}

class _AddInterestSheetState extends ConsumerState<AddInterestSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  final List<String> _availableInterests = [
    '#SnowLeopard',
    '#ClimateLens',
    '#MemeEconomy',
    '#HotTakes',
    '#AI',
    '#TechNews',
    '#CryptoDaily',
    '#Fitness',
    '#GameDev',
    '#Photography',
    '#Cooking',
    '#Travel',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ref.watch(interestTabsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0D0D0F) : const Color(0xFFFFFFFF);
    final surface = isDark ? const Color(0xFF1A1A1D) : const Color(0xFFF8FAFC);
    final textPrimary = isDark ? const Color(0xFFE5EBF5) : const Color(0xFF1A202C);
    final textSecondary = isDark ? const Color(0xFF7E8A9A) : const Color(0xFF718096);

    final filteredInterests = _availableInterests
        .where((interest) => 
            !tabs.contains(interest) &&
            (_searchQuery.isEmpty || interest.toLowerCase().contains(_searchQuery.toLowerCase())))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              _buildHeader(context, textPrimary),
              _buildSearchField(surface, textSecondary),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildYourTabsSection(tabs, textPrimary, textSecondary),
                    const SizedBox(height: 24),
                    _buildAvailableSection(filteredInterests, textPrimary, textSecondary),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, Color textColor) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            'Add Interest',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(Color bg, Color hint) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
        decoration: InputDecoration(
          hintText: 'Search interests…',
          hintStyle: TextStyle(color: hint),
          prefixIcon: Icon(Icons.search, color: hint),
          filled: true,
          fillColor: bg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildYourTabsSection(List<String> tabs, Color primary, Color secondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Tabs',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
        ),
        const SizedBox(height: 4),
        Text(
          'Drag to reorder',
          style: TextStyle(fontSize: 12, color: secondary),
        ),
        const SizedBox(height: 12),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tabs.length,
          onReorder: (oldIndex, newIndex) {
            ref.read(interestTabsProvider.notifier).reorderTabs(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            final tab = tabs[index];
            return _buildDraggableChip(tab, primary, key: ValueKey(tab));
          },
        ),
      ],
    );
  }

  Widget _buildDraggableChip(String label, Color text, {required Key key}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipBg = isDark ? const Color(0xFF4C8FFF).withOpacity(0.1) : const Color(0xFF4C8FFF).withOpacity(0.08);
    final borderColor = isDark ? const Color(0xFF4C8FFF).withOpacity(0.3) : const Color(0xFF4C8FFF).withOpacity(0.2);
    
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(Icons.drag_handle, size: 20, color: text.withOpacity(0.6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text),
            ),
          ),
          if (ref.read(interestTabsProvider).length > 2)
            GestureDetector(
              onTap: () {
                ref.read(interestTabsProvider.notifier).removeTab(label);
              },
              child: Icon(Icons.close, size: 18, color: text.withOpacity(0.6)),
            ),
        ],
      ),
    );
  }

  Widget _buildAvailableSection(List<String> interests, Color primary, Color secondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Interests',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
        ),
        const SizedBox(height: 12),
        ...interests.map((interest) => _buildToggleChip(interest, primary)),
      ],
    );
  }

  Widget _buildToggleChip(String label, Color text) {
    final tabs = ref.watch(interestTabsProvider);
    final isAdded = tabs.contains(label);
    final canAdd = tabs.length < 5;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipBg = isDark ? const Color(0xFF1F1F23) : const Color(0xFFF7F7F7);

    return GestureDetector(
      onTap: canAdd && !isAdded ? () {
        ref.read(interestTabsProvider.notifier).addTab(label);
      } : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: !canAdd ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: chipBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text),
                ),
              ),
              Icon(
                canAdd ? Icons.add_circle_outline : Icons.check_circle,
                size: 20,
                color: canAdd ? const Color(0xFF4C8FFF) : const Color(0xFF4CD4B0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}