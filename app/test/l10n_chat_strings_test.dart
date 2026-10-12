import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:kyron_app/l10n/app_localizations.dart';
import 'package:kyron_app/l10n/generated/messages_all.dart';

/// The chat strings, through the lookup the app actually uses, in every
/// language there is a catalog for.
///
/// The ARB files are what scripts/check-localization.py reads; the generated
/// Dart is what the app reads, and nothing compared the two. When these
/// strings were first added, a bad escape put a NUL where the name should
/// have been in "Ada is typing" -- in every language -- and the ARB check
/// passed. This reads each string back through Intl, the way the screen
/// does, and holds it to the catalog.
const _keys = [
  'ui_dm_you_replied',
  'ui_dm_attach',
  'ui_dm_new',
  'ui_dm_starter',
  'ui_dm_wave',
  'ui_dm_new_messages',
  'ui_dm_reaction_remove',
  'ui_dm_someone',
  'ui_dm_quote_message',
  'ui_dm_quote_attachment',
  'ui_dm_unreadable',
  'ui_dm_preview_sealed',
  'ui_dm_e2ee_notice',
  'ui_dm_not_encrypted',
  'ui_dm_sent',
  'ui_dm_seen',
  'ui_dm_sending',
  'ui_dm_take_photo',
  'ui_media_more',
  'ui_media_save',
  'ui_media_share',
  'ui_media_saving',
  'ui_media_saved',
  'ui_media_save_failed',
  'ui_media_save_denied',
  'ui_status_all_ok',
  'ui_status_uptime',
  'ui_status_last_60',
  'ui_status_60_days_ago',
  'ui_status_today',
  'ui_status_api',
  'ui_status_database',
  'ui_status_auth',
  'ui_status_incidents',
  'ui_status_no_incidents',
  'ui_status_ongoing',
  'ui_status_no_data',
  'ui_status_details',
  'ui_status_footnote',
  'ui_status_unavailable',
  'ui_status_degraded',
  'ui_dm_voice',
  'voice_ready_send',
  'ui_dm_quote_gone',
  'ui_dm_quote_open',
  'ui_dm_quote_voice',
  'ui_liked_by_author',
  'ui_add_photo_or_clip',
  'ui_dm_info_media',
  'ui_dm_info_voice_notes',
  'ui_dm_info_chat',
  'ui_dm_info_wallpaper',
  'ui_dm_info_mute_row',
  'ui_dm_info_mute_detail',
  'ui_dm_info_block_detail',
  'ui_dm_wallpaper_none',
  'ui_dm_wallpaper_photo',
  'ui_dm_unmuted',
  'ui_dm_remove_failed',
  'ui_dm_info_profile',
  'ui_dm_unmute',
  'ui_dm_info_no_media',
  'ui_dm_info_see_all',
  'ui_dm_media_tab',
  'ui_dm_wallpaper_sample_theirs',
  'ui_dm_wallpaper_sample_mine',
  'ui_wallpaper_mist',
  'ui_wallpaper_dusk',
  'ui_wallpaper_sage',
  'ui_wallpaper_sand',
  'ui_wallpaper_dots',
  'ui_dm_wallpaper_apply',
  'ui_dm_wallpaper_current',
  'ui_dm_link_card_remove',
  'ui_share_search',
  'ui_share_post',
  'ui_share_note',
  'ui_share_send',
  'ui_share_sent',
  'ui_share_some_failed',
  'ui_share_failed',
  'ui_follower_one',
];

void main() {
  final catalogs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => RegExp(r'app_[a-z]+\.arb$').hasMatch(f.path))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('there are catalogs to read', () {
    // A path that matches nothing would pass every test below.
    expect(catalogs.length, greaterThan(60));
  });

  for (final file in catalogs) {
    final locale = RegExp(r'app_([a-z]+)\.arb$').firstMatch(file.path)![1]!;
    final arb = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    test('$locale: every chat string reads as its catalog says', () async {
      await initializeMessages(locale);
      Intl.withLocale(locale, () {
        final l10n = AppLocalizations();
        for (final key in _keys) {
          expect(
            l10n.ui(key, '<fallback>'),
            arb[key],
            reason: '$locale/$key fell back or differs from the catalog',
          );
        }
        for (final (actual, key) in [
          (l10n.dmReplied('Ada'), 'dmReplied'),
          (l10n.dmTyping('Ada'), 'dmTyping'),
        ]) {
          expect(
            actual,
            (arb[key] as String).replaceAll(r'${name}', 'Ada'),
            reason: '$locale/$key',
          );
          expect(actual, isNot(contains('\u0000')), reason: '$locale/$key');
        }
      });
    });
  }
}
