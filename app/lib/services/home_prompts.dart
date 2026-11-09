// lib/services/home_prompts.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One version's entries in the app's "What's new": a headline and the
/// sentence after it, as scripts/changelog.py app-notes writes them.
class WhatsNewVersion {
  final String version;
  final List<({String title, String detail})> items;

  const WhatsNewVersion({required this.version, required this.items});

  factory WhatsNewVersion.fromJson(Map<String, dynamic> json) =>
      WhatsNewVersion(
        version: json['version'] as String? ?? '',
        items: [
          for (final item in json['items'] as List? ?? const [])
            if (item is Map<String, dynamic>)
              (
                title: item['title'] as String? ?? '',
                detail: item['detail'] as String? ?? '',
              ),
        ],
      );
}

/// What the home screen offers on this launch, if anything.
sealed class HomePrompt {
  const HomePrompt();
}

/// The app was updated: what changed since the version last opened.
class WhatsNewPrompt extends HomePrompt {
  /// Newest first; more than one when versions were skipped.
  final List<WhatsNewVersion> versions;

  const WhatsNewPrompt(this.versions);
}

/// A few days in: one question about how it is going.
class CheckInPrompt extends HomePrompt {
  /// The day of use it is asked on: 3 or 10.
  final int day;

  const CheckInPrompt(this.day);
}

/// Decides what, if anything, the home screen shows when it opens: a "What's
/// new" after an update, or a check-in on the third and tenth day.
///
/// Never both on one launch -- two sheets in a row is a queue to get
/// through, not something to read -- and nothing on the very first launch,
/// when everything is new and nothing has been used yet.
abstract final class HomePrompts {
  static const seenVersionKey = 'whats_new_seen_version';
  static const firstOpenKey = 'home_first_open_at';
  static const checkInsKey = 'home_check_ins_asked';

  /// The days of use a check-in is asked on.
  static const checkInDays = [3, 10];

  /// The bundled notes, written at each release.
  static const notesAsset = 'lib/assets/whats_new.json';

  /// What to show now, if anything, and the record that it was shown.
  /// [notes] are the bundled versions, newest first.
  static Future<HomePrompt?> decide({
    required SharedPreferences prefs,
    required String version,
    required DateTime now,
    required List<WhatsNewVersion> notes,
  }) async {
    final firstOpen = prefs.getInt(firstOpenKey);
    final seen = prefs.getString(seenVersionKey);
    if (firstOpen == null) {
      // The first launch with these prompts: nothing to say yet. From here
      // the days are counted and the version is remembered.
      await prefs.setInt(firstOpenKey, now.millisecondsSinceEpoch);
      await prefs.setString(seenVersionKey, version);
      return null;
    }

    if (seen != version) {
      await prefs.setString(seenVersionKey, version);
      final since = notes
          .where(
            (n) =>
                (seen == null || _compare(n.version, seen) > 0) &&
                _compare(n.version, version) <= 0 &&
                n.items.isNotEmpty,
          )
          .toList();
      if (since.isNotEmpty) return WhatsNewPrompt(since);
    }

    final asked =
        (prefs.getStringList(checkInsKey) ?? const <String>[]).toSet();
    final days =
        now.difference(DateTime.fromMillisecondsSinceEpoch(firstOpen)).inDays;
    // The latest one due: somebody away from day 2 to day 11 is asked once,
    // as a day-10 user, rather than twice in a row.
    for (final day in checkInDays.reversed) {
      if (days >= day && !asked.contains('$day')) {
        await prefs.setStringList(checkInsKey, [
          ...asked,
          for (final d in checkInDays)
            if (d <= day) '$d',
        ]);
        return CheckInPrompt(day);
      }
    }
    return null;
  }

  /// The notes the build carries, or none if they cannot be read.
  static Future<List<WhatsNewVersion>> bundledNotes([
    AssetBundle? bundle,
  ]) async {
    try {
      final raw = await (bundle ?? rootBundle).loadString(notesAsset);
      return [
        for (final row in jsonDecode(raw) as List)
          if (row is Map<String, dynamic>) WhatsNewVersion.fromJson(row),
      ];
    } catch (_) {
      return const [];
    }
  }

  /// "0.1.42" against "0.1.9", by number rather than by letter.
  static int _compare(String a, String b) {
    List<int> parts(String v) => [
          for (final p in v.split('+').first.split('.')) int.tryParse(p) ?? 0,
        ];
    final x = parts(a), y = parts(b);
    for (var i = 0; i < 3; i++) {
      final l = i < x.length ? x[i] : 0;
      final r = i < y.length ? y[i] : 0;
      if (l != r) return l.compareTo(r);
    }
    return 0;
  }
}
