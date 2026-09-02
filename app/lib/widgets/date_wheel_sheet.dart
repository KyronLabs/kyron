// lib/widgets/date_wheel_sheet.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'action_button.dart';

/// Picking a date on three scrolling wheels.
///
/// Replaces the Material calendar dialog, which for "everything after March"
/// makes you navigate a grid of days to pick one you do not care about. Three
/// wheels say what they are, and every position is one flick away.
///
/// The day wheel follows the other two: February has 29 days in 2024 and 28 in
/// 2025, and a picker that offers the 30th of February is a picker that hands
/// back a date that does not exist.
class DateWheelSheet {
  static Future<DateTime?> show(
    BuildContext context, {
    required String title,
    DateTime? initial,
    DateTime? first,
    DateTime? last,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _Sheet(
        title: title,
        initial: initial,
        first: first ?? DateTime(2024),
        last: last ?? DateTime.now(),
      ),
    );
  }
}

const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class _Sheet extends StatefulWidget {
  final String title;
  final DateTime? initial;
  final DateTime first;
  final DateTime last;

  const _Sheet({
    required this.title,
    required this.initial,
    required this.first,
    required this.last,
  });

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  late int _year;
  late int _month;
  late int _day;

  late final FixedExtentScrollController _monthWheel;
  late final FixedExtentScrollController _dayWheel;
  late final FixedExtentScrollController _yearWheel;

  static const double _itemExtent = 40;

  @override
  void initState() {
    super.initState();
    // Clamped into range, so an initial value outside the allowed span does
    // not open the sheet on a row that cannot be selected.
    final start = _clamp(widget.initial ?? widget.last);
    _year = start.year;
    _month = start.month;
    _day = start.day;

    _monthWheel = FixedExtentScrollController(initialItem: _month - 1);
    _dayWheel = FixedExtentScrollController(initialItem: _day - 1);
    _yearWheel = FixedExtentScrollController(initialItem: _year - _firstYear);
  }

  @override
  void dispose() {
    _monthWheel.dispose();
    _dayWheel.dispose();
    _yearWheel.dispose();
    super.dispose();
  }

  int get _firstYear => widget.first.year;
  int get _lastYear => widget.last.year;

  DateTime _clamp(DateTime value) {
    if (value.isBefore(widget.first)) return widget.first;
    if (value.isAfter(widget.last)) return widget.last;
    return value;
  }

  /// How many days the chosen month actually has.
  ///
  /// Day zero of the next month is the last day of this one, which gets leap
  /// years right without a rule about them.
  int get _daysInMonth => DateTime(_year, _month + 1, 0).day;

  /// The date as the three wheels currently stand, with the day pulled back if
  /// the month it moved to is shorter.
  DateTime get _value => DateTime(_year, _month, _day.clamp(1, _daysInMonth));

  void _tick() => unawaited(HapticFeedback.selectionClick());

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final days = _daysInMonth;

    // The day wheel is rebuilt when a month change shortens it. Snapping the
    // controller back inside the new range stops it resting on a row that no
    // longer exists.
    if (_day > days) {
      _day = days;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _dayWheel.hasClients) {
          _dayWheel.jumpToItem(_day - 1);
        }
      });
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space20,
          0,
          SpacingTokens.space20,
          SpacingTokens.space20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: SpacingTokens.space12),

            SizedBox(
              height: _itemExtent * 5,
              child: Stack(
                children: [
                  // The band marking what is selected, behind the wheels.
                  Center(
                    child: Container(
                      height: _itemExtent,
                      decoration: BoxDecoration(
                        color: scheme.onSurface.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(RadiusTokens.radius12),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _Wheel(
                          controller: _monthWheel,
                          count: 12,
                          label: (index) => _months[index],
                          onChanged: (index) {
                            _tick();
                            setState(() => _month = index + 1);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _Wheel(
                          // Keyed on the length, so shortening the month
                          // rebuilds the wheel rather than leaving a 31st on a
                          // month that has 30 days.
                          key: ValueKey(days),
                          controller: _dayWheel,
                          count: days,
                          label: (index) => '${index + 1}',
                          onChanged: (index) {
                            _tick();
                            setState(() => _day = index + 1);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: _Wheel(
                          controller: _yearWheel,
                          count: _lastYear - _firstYear + 1,
                          label: (index) => '${_firstYear + index}',
                          onChanged: (index) {
                            _tick();
                            setState(() => _year = _firstYear + index);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: SpacingTokens.space16),

            // Said plainly, because three wheels showing a date outside the
            // allowed span would otherwise be corrected silently on Done.
            if (_value.isBefore(widget.first) || _value.isAfter(widget.last))
              Padding(
                padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
                child: Text(
                  'That date is outside the range this filter allows.',
                  style: TextStyle(fontSize: 12, color: scheme.error),
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Cancel',
                    kind: ActionButtonKind.outlined,
                    expand: true,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: ActionButton(
                    label: 'Done',
                    expand: true,
                    onPressed: _value.isBefore(widget.first) ||
                            _value.isAfter(widget.last)
                        ? null
                        : () => Navigator.pop(context, _value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  final FixedExtentScrollController controller;
  final int count;
  final String Function(int index) label;
  final ValueChanged<int> onChanged;

  const _Wheel({
    super.key,
    required this.controller,
    required this.count,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: _SheetState._itemExtent,
      // Snaps to a row rather than resting between two, which is what makes
      // one notch of scroll mean one item -- and one haptic.
      physics: const FixedExtentScrollPhysics(),
      // Flattens the wheel towards a flat list: a strong curve makes the rows
      // either side of the selection unreadable.
      diameterRatio: 2.2,
      perspective: 0.003,
      overAndUnderCenterOpacity: 0.35,
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: count,
        builder: (context, index) => Center(
          child: Text(
            label(index),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
