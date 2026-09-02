// lib/widgets/search_filter_sheet.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/search_provider.dart';
import 'action_button.dart';
import 'date_wheel_sheet.dart';

/// A date the way it reads on a chip: `4 Mar 2026`.
String formatFilterDate(DateTime value) =>
    '${value.day} ${_months[value.month - 1]} ${value.year}';

/// Human-readable chips for whatever filters are set.
List<String> describeFilters(SearchFilters filters) => [
      if (filters.from != null) 'from @${filters.from}',
      if (filters.after != null) 'after ${formatFilterDate(filters.after!)}',
      if (filters.before != null) 'before ${formatFilterDate(filters.before!)}',
      if (filters.has != null) 'has ${filters.has}',
    ];

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Narrowing a search: an account, a date range, and what a post carries.
class SearchFilterSheet {
  static Future<void> show(
    BuildContext context, {
    required SearchFilters filters,
    required ValueChanged<SearchFilters> onApply,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _Sheet(initial: filters, onApply: onApply),
    );
  }
}

class _Sheet extends StatefulWidget {
  final SearchFilters initial;
  final ValueChanged<SearchFilters> onApply;

  const _Sheet({required this.initial, required this.onApply});

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  late final TextEditingController _from =
      TextEditingController(text: widget.initial.from ?? '');

  late DateTime? _after = widget.initial.after;
  late DateTime? _before = widget.initial.before;
  late String? _has = widget.initial.has;

  @override
  void dispose() {
    _from.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      // For the keyboard, so the handle field is not covered while it is
      // being typed into.
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space20,
            0,
            SpacingTokens.space20,
            SpacingTokens.space20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Narrow this search',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: _anythingSet ? _reset : null,
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space12),
              _Label(text: 'From an account'),
              TextField(
                controller: _from,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  hintText: 'handle',
                  prefixText: '@',
                ),
              ),
              const SizedBox(height: SpacingTokens.space16),
              _Label(text: 'Posted between'),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: 'After',
                      value: _after,
                      // Cannot be later than the other end of the range, so
                      // an empty range cannot be picked at all.
                      lastDate: _before,
                      onPick: (value) => setState(() => _after = value),
                    ),
                  ),
                  const SizedBox(width: SpacingTokens.space12),
                  Expanded(
                    child: _DateField(
                      label: 'Before',
                      value: _before,
                      firstDate: _after,
                      onPick: (value) => setState(() => _before = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space16),
              _Label(text: 'Carrying'),
              Wrap(
                spacing: SpacingTokens.space8,
                runSpacing: SpacingTokens.space8,
                children: [
                  for (final option in const [
                    ('image', 'Photos', Iconsax.gallery_copy),
                    ('video', 'Videos', Iconsax.video_copy),
                    ('gif', 'GIFs', Iconsax.emoji_happy_copy),
                    ('link', 'Links', Iconsax.link_copy),
                  ])
                    _Choice(
                      label: option.$2,
                      icon: option.$3,
                      selected: _has == option.$1,
                      // Tapping the chosen one again clears it, which is the
                      // only way to unset a single-choice row.
                      onTap: () => setState(
                        () => _has = _has == option.$1 ? null : option.$1,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space24),
              ActionButton(
                label: 'Show results',
                icon: Iconsax.search_normal_1_copy,
                expand: true,
                onPressed: _apply,
              ),
              const SizedBox(height: SpacingTokens.space8),
              Text(
                'Filters apply to posts. Setting one switches to the Posts '
                'tab.',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _anythingSet =>
      _from.text.trim().isNotEmpty ||
      _after != null ||
      _before != null ||
      _has != null;

  void _reset() {
    setState(() {
      _from.clear();
      _after = null;
      _before = null;
      _has = null;
    });
  }

  void _apply() {
    final handle = _from.text.trim().replaceAll(RegExp(r'^@+'), '');
    widget.onApply(
      SearchFilters(
        from: handle.isEmpty ? null : handle,
        after: _after,
        before: _before,
        has: _has,
      ),
    );
    Navigator.pop(context);
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?> onPick;

  const _DateField({
    required this.label,
    required this.value,
    required this.onPick,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final set = value != null;

    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(RadiusTokens.radius12),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space12),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(RadiusTokens.radius12),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.calendar_1_copy,
              size: 16,
              color: scheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(width: SpacingTokens.space8),
            Expanded(
              child: Text(
                set ? formatFilterDate(value!) : label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: set ? FontWeight.w600 : FontWeight.w400,
                  color: set
                      ? scheme.onSurface
                      : scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            if (set)
              InkWell(
                onTap: () => onPick(null),
                customBorder: const CircleBorder(),
                child: Icon(
                  Iconsax.close_circle_copy,
                  size: 15,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await DateWheelSheet.show(
      context,
      title: '\$label date',
      initial: value,
      // Kyron did not exist before this, and a date in the future matches
      // nothing -- so neither is offered.
      first: firstDate ?? DateTime(2024),
      last: lastDate ?? now,
    );
    if (picked != null) onPick(picked);
  }
}

class _Choice extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _Choice({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.space12,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: selected ? scheme.primary : scheme.onSurface,
            ),
            const SizedBox(width: SpacingTokens.space4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? scheme.primary : scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
