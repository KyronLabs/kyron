/**
 * Everything a push says, in English: the catalog every other language is
 * checked against.
 *
 * A push is shown by the phone's own notification system, before the app has
 * a chance to say anything, so its words have to be decided here -- in the
 * language of the phone that will show them, which each device tells the
 * server when it registers (DeviceToken.locale). Placeholders are `{name}`;
 * a translation keeps every one its English has.
 *
 * Adding a key here makes every other catalog fail to compile until it has
 * the key too.
 */
export const en = {
  // Who did something, when there is no name to give.
  someone: 'Someone',
  and_one_other: '{name} and 1 other',
  and_others: '{name} and {count} others',

  followed: 'Followed you',
  liked: 'Liked your post',
  liked_quote: 'Liked your post: “{snippet}”',
  reposted: 'Reposted your post',
  reposted_quote: 'Reposted your post: “{snippet}”',
  replied: 'Replied to you',
  replied_quote: 'Replied: “{snippet}”',

  // Direct messages and groups. Never the message itself: it is sealed.
  group: 'Group',
  new_message: 'New message',
  dm_once: 'Sent something to view once',
  dm_attachment: 'Sent an attachment',
  dm_group_message: 'Sent a message',
  dm_message: 'Sent you a message',
  named_line: '{name}: {text}',
  group_added: '{name} added you to the group.',
  group_hand: '{name} raised a hand to ask to write.',

  // What a community chat message carried, when it had no words.
  chat_poll: 'Poll: {text}',
  chat_photo: 'Photo',
  chat_gif: 'GIF',
  chat_clip: 'Clip',
  chat_voice: 'Voice note',

  // A decision about the reader's account.
  mod_removed_post: 'Your post was removed.',
  mod_removed_reply: 'Your reply was removed.',
  mod_removed_message: 'Your message in a community chat was removed.',
  mod_removed_other: 'Something you posted was removed.',
  mod_warned: 'Your account has a warning.',
  mod_suspended_until: 'Your account is suspended until {date}.',
  mod_banned: 'Your account has been banned.',
  mod_rule: 'Rule: {rule}.',
  mod_rules_general: "It broke Kyron's rules.",
  mod_case: 'Case {number}: open Kyron to see why, or to appeal.',
  mod_reversed: 'We reversed case {number}.',
  appeal_accepted:
    'Your appeal on case {number} was accepted, and the decision is reversed.',
  appeal_upheld:
    'We looked at your appeal on case {number} again, and the decision stands.',
  report_actioned:
    'We acted on something you reported. Thank you for telling us.',
  report_dismissed:
    "We looked at something you reported and did not find that it broke Kyron's rules. Thank you for telling us.",

  // The rules, as the app names them (ui_rule_* in the app's catalogs).
  rule_spam: 'Spam',
  rule_harassment: 'Harassment or bullying',
  rule_hate: 'Hate speech',
  rule_violence: 'Violence or threats',
  rule_self_harm: 'Suicide or self-harm',
  rule_sexual_content: 'Adult content',
  rule_child_safety: 'Child safety',
  rule_misinformation: 'False information',
  rule_impersonation: 'Impersonation',
  rule_intellectual_property: 'Intellectual property',
  rule_illegal_goods: 'Illegal goods or services',

  verified: "You're verified. The badge now shows beside your name.",
  verify_declined: 'Your request to be verified was not approved.',
  verify_removed: 'Your verified badge was removed.',
  verify_lapsed_rename:
    'Your verified badge was removed because your name changed. Ask again from the menu and somebody will check the new one.',

  // To the team.
  staff_title: 'Kyron moderation',
  staff_appeal: 'An appeal is waiting for review.',
  staff_report_urgent: 'An urgent report is waiting: somebody may be at risk.',
  staff_report: 'A report is waiting for review.',
  staff_verify: 'Somebody asked to be verified.',

  test_working: 'Notifications are working.',
} as const;

export type PushKey = keyof typeof en;

/** A catalog: every key, in one language. */
export type Copy = Readonly<Record<PushKey, string>>;
