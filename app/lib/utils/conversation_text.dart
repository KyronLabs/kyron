// lib/utils/conversation_text.dart
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/post_media.dart' show MediaKind;

/// The last message as one line.
///
/// Already opened by the list's notifier. One that could not be opened says
/// it is encrypted rather than printing what the server holds, and a
/// message with no words says what it carries -- a voice note, a photo --
/// rather than nothing. It used to be nothing: the list was never sent the
/// attachments, so "You:" stood alone beside every voice note.
String conversationPreview(AppLocalizations l10n, DirectMessage last) {
  if (last.unreadable) {
    return l10n.ui('ui_dm_preview_sealed', 'Encrypted message');
  }
  final body = last.body.trim();
  if (body.isNotEmpty) {
    // One line: a message written over several shows its first words, not
    // a blank where the line break fell.
    return body.replaceAll(RegExp(r'\s+'), ' ');
  }
  final media = last.media;
  if (media.isEmpty) return '';
  final kinds = media.map((m) => m.kind).toSet();
  if (kinds.length > 1) {
    return l10n.ui('ui_dm_quote_attachment', 'Attachment');
  }
  return switch (kinds.single) {
    MediaKind.voice => l10n.ui('ui_dm_quote_voice', 'Voice note'),
    MediaKind.image => media.length == 1
        ? l10n.ui('ui_dm_preview_photo', 'Photo')
        : l10n.ui('ui_dm_preview_photos', 'Photos'),
    MediaKind.video => l10n.ui('ui_dm_preview_video', 'Video'),
    MediaKind.gif => l10n.ui('ui_dm_preview_gif', 'GIF'),
  };
}

/// When the last message was sent, the way a messenger says it: the time
/// today, "Yesterday", the weekday within the week, then the date. "3w"
/// is a feed's way of saying it, and says nothing about when to reply.
String conversationTime(
  AppLocalizations l10n,
  DateTime at, {
  DateTime? now,
  String? locale,
}) {
  final today = now ?? DateTime.now();
  // Whole calendar days, in UTC, so a day the clocks went forward on still
  // counts as one.
  final daysAgo = DateTime.utc(today.year, today.month, today.day)
      .difference(DateTime.utc(at.year, at.month, at.day))
      .inDays;
  if (daysAgo == 1) return l10n.ui('ui_dm_yesterday', 'Yesterday');

  DateFormat format(String? locale) {
    if (daysAgo <= 0) return DateFormat.jm(locale);
    if (daysAgo < 7) return DateFormat.E(locale);
    if (at.year == today.year) return DateFormat.MMMd(locale);
    return DateFormat.yMMMd(locale);
  }

  // In the reader's own language and clock. A locale with no date data
  // falls back to English rather than taking the row down with it.
  try {
    return format(locale).format(at);
  } catch (_) {
    return format('en_US').format(at);
  }
}
