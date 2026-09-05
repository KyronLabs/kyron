// lib/widgets/section_tabs.dart
import 'package:flutter/material.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'hairline.dart';

/// The pager at the top of a section: Explore, Communities, Messages.
///
/// One widget for all three, because they had drifted. Each drew its own
/// [TabBar] inside its own bordered container, and left Material 3's divider
/// switched on underneath -- so every one of them carried a one-pixel
/// `outlineVariant` line and a half-pixel hand-rolled one stacked on top of
/// each other. Two soft lines a fraction apart is what a thick, blurry rule
/// looks like.
class SectionTabs extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> labels;

  const SectionTabs({
    super.key,
    required this.controller,
    required this.labels,
  });

  static const double _height = 46;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: _height,
          child: TabBar(
            controller: controller,
            // Material 3 draws its own full-width divider under a TabBar. The
            // hairline below is the one this app wants, so this one goes.
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            indicatorColor: scheme.primary,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: scheme.primary,
            unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            labelPadding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            // Scrollable, so a long label is not squeezed into a third of the
            // screen and ellipsised. "My Communities" was.
            isScrollable: labels.length > 3 || labels.any((l) => l.length > 10),
            tabAlignment: labels.length > 3 || labels.any((l) => l.length > 10)
                ? TabAlignment.start
                : TabAlignment.fill,
            tabs: [for (final label in labels) Tab(text: label)],
          ),
        ),
        const Hairline(),
      ],
    );
  }
}
