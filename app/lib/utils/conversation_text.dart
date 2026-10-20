// lib/utils/conversation_text.dart
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart' show CommunityLastPost;
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
  final event = last.event;
  if (event != null) return groupEventText(l10n, event);
  final once = last.once;
  if (once != null) {
    return '${mediaPreview(l10n, [once.kind])} · '
        '${l10n.ui('ui_once_label', 'View once')}';
  }
  if (last.unreadable) {
    return l10n.ui('ui_dm_preview_sealed', 'Encrypted message');
  }
  final body = last.body.trim();
  if (body.isNotEmpty) {
    // One line: a message written over several shows its first words, not
    // a blank where the line break fell.
    return body.replaceAll(RegExp(r'\s+'), ' ');
  }
  return mediaPreview(l10n, [for (final m in last.media) m.kind]);
}

/// What a message or a post with no words carries, in a word: a voice note,
/// a photo, several. Empty when it carries nothing.
String mediaPreview(AppLocalizations l10n, List<MediaKind> media) {
  if (media.isEmpty) return '';
  final kinds = media.toSet();
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

/// A community's newest post as one line, said by whom: "You: ..." for the
/// reader's own, the author's name before anybody else's.
String communityPreview(
  AppLocalizations l10n,
  CommunityLastPost? post, {
  required bool mine,
}) {
  if (post == null) {
    return l10n.ui('ui_community_no_posts', 'No posts yet');
  }
  final body = post.body.trim();
  final what = body.isNotEmpty
      ? body.replaceAll(RegExp(r'\s+'), ' ')
      : mediaPreview(l10n, post.media);
  final who = mine
      ? l10n.ui('ui_dm_you_prefix', 'You:')
      : '${post.authorName?.trim().isNotEmpty == true ? post.authorName!.trim() : l10n.ui('ui_dm_someone', 'Someone')}:';
  return '$who $what';
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

/// A line about a group, in words: "Ada added Ben, Cy".
///
/// Always the person's name, the reader's own included. "You" takes a
/// different form of the verb in most of the languages this is translated
/// into, and one string per person would double every one of these.
String groupEventText(AppLocalizations l10n, GroupEvent event) {
  final users = event.users.map((u) => u.name).join(', ');
  final template = switch (event.type) {
    GroupEventType.created =>
      l10n.ui('ui_group_event_created', r'$actor created the group'),
    GroupEventType.renamed =>
      l10n.ui('ui_group_event_renamed', r'$actor renamed the group $title'),
    GroupEventType.added =>
      l10n.ui('ui_group_event_added', r'$actor added $users'),
    GroupEventType.removed =>
      l10n.ui('ui_group_event_removed', r'$actor removed $users'),
    GroupEventType.left => l10n.ui('ui_group_event_left', r'$actor left'),
    GroupEventType.role => switch (event.role) {
        MemberRole.owner =>
          l10n.ui('ui_group_event_owner', r'$actor made $users the owner'),
        MemberRole.admin =>
          l10n.ui('ui_group_event_admin', r'$actor made $users an admin'),
        MemberRole.spectator => l10n.ui(
            'ui_group_event_spectator', r'$actor made $users a spectator'),
        _ => l10n.ui('ui_group_event_member', r'$actor made $users a member'),
      },
    GroupEventType.joinRole => event.role == MemberRole.spectator
        ? l10n.ui('ui_group_event_join_spectator',
            r'$actor set new people to join as spectators')
        : l10n.ui('ui_group_event_join_member',
            r'$actor set new people to join as members'),
  };
  // Replaced in one pass, so a name that happens to contain "$users" is
  // printed as it is rather than substituted again.
  return template.replaceAllMapped(
    RegExp(r'\$(actor|users|title)'),
    (m) => switch (m[1]) {
      'actor' => event.actorName,
      'users' => users,
      _ => '“${event.title ?? ''}”',
    },
  );
}

/// What somebody may do in a group, as a word.
String memberRoleLabel(AppLocalizations l10n, MemberRole role) =>
    switch (role) {
      MemberRole.owner => l10n.ui('ui_community_role_owner', 'Owner'),
      MemberRole.admin => l10n.ui('ui_group_role_admin', 'Admin'),
      MemberRole.member => l10n.ui('ui_group_role_member', 'Member'),
      MemberRole.spectator => l10n.ui('ui_group_role_spectator', 'Spectator'),
    };
