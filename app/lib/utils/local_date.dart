// lib/utils/local_date.dart
import 'package:intl/intl.dart';

/// [when] written by [format] in the reader's [locale], or in English where
/// the platform has no date data for it.
///
/// Kyron is translated into languages Flutter and intl have no dates for --
/// Yoruba, Hausa, Igbo, Xhosa, Somali -- and a DateFormat for one of them
/// throws while the screen is building. A date in English is a small thing
/// next to a screen that will not open.
String localDate(
  String? locale,
  DateFormat Function(String? locale) format,
  DateTime when,
) {
  try {
    return format(locale).format(when);
  } catch (_) {
    return format('en_US').format(when);
  }
}
