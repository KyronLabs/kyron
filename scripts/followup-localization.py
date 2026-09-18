#!/usr/bin/env python3
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARB = ROOT / 'app/lib/l10n/app_en.arb'
entries = {
 'ui_communities':'Communities','ui_settings':'Settings','ui_appearance':'Appearance','ui_language':'Language',
 'ui_account':'Account','ui_content_display':'Content & Display','ui_app_device':'App & Device',
 'ui_terms':'Terms','ui_privacy':'Privacy','ui_help':'Help','ui_feedback':'Feedback',
 'ui_decentralized_id':'Decentralized ID','ui_find_people_on_kyron':'Find people on Kyron',
 'ui_search_everything_posted':'Search everything posted','ui_search_by_handle_or_display_name':'Search by handle or display name.',
 'ui_words_or_filter':'Words, or a filter — an account, a date range, or what a post carries.',
 'ui_two_characters_or_more':'Two characters or more.','ui_no_posts_match_filters':'No posts match those filters.',
 'ui_search_clear':'Clear','ui_search_filters':'Filters','ui_post_text_copied':'Post text copied',
 'ui_link_copied':'Link copied','ui_interest_noted':'Noted. This helps shape what you are shown.',
 'ui_posts_hidden':'Hidden. We will show you fewer like it.','ui_post_hidden':'Post hidden',
 'ui_thread_muted':'Thread muted','ui_replies_policy':'Replies: ${chosen.label.toLowerCase()}',
 'ui_post_deleted':'Post deleted','ui_author_posts_hidden':'You will not see posts from ${author}',
 'ui_author_blocked':'${author} blocked','ui_post_delete_detail':'It is removed from your profile and from everyone else\'s feed. Replies to it go with it.',
 'ui_block_detail':'Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.',
 'ui_mute_detail':'You will stop seeing their posts. They are not told.',
 'ui_about_terms_of_service':'Terms of Service','ui_about_privacy_policy':'Privacy Policy',
 'ui_settings_profile_contact':'Your profile and contact information','ui_settings_security':'Security settings',
 'ui_settings_muted_blocked':'Who you have muted or blocked','ui_settings_content_display':'Content & Display',
 'ui_settings_app_device':'App & Device','ui_settings_data_saver':'Data Saver',
 'ui_settings_language_detail':'Choose your language','ui_settings_notifications_detail':'Notification preferences',
 'ui_settings_help_articles':'Browse help articles','ui_settings_team_help':'Get help from our team',
 'ui_settings_feedback_detail':'Tell us what you think',
 'ui_could_not_load_profile':'Could not load your profile','ui_search_people':'Search people',
 'ui_search_posts':'Search posts','ui_nothing_matches_query':'Nothing on Kyron matches "${what}"',
 'ui_this_post':'this post',
 'authorPostsHidden':'You will not see posts from ${author}','authorBlocked':'${author} blocked',
 'nothingMatchesQuery':'Nothing on Kyron matches "${what}"','repliesPolicy':'Replies: ${policy}',
 'feedTagDetail':'Nothing has been posted under #${tab} yet.',
 'ui_preferences':'Preferences','ui_appearance_detail':'Light, dark, or whatever the phone is set to',
 'ui_legal':'Legal','ui_diagnostics':'Diagnostics','ui_saved_posts':'Saved posts','ui_liked_posts':'Liked posts',
 'ui_nothing_saved_yet':'Nothing saved yet','ui_no_likes_yet':'No likes yet',
 'ui_saved_posts_detail':'Tap the archive icon on any post to keep it here. Only you can see what you save.',
 'ui_liked_posts_detail':'Posts you like show up here, most recent first.',
 'ui_could_not_load_saved_posts':'Could not load your saved posts',
 'ui_could_not_load_liked_posts':'Could not load your liked posts',
 'ui_feed_following_empty':'Nothing from the people you follow','ui_feed_videos_empty':'No videos yet',
 'ui_feed_empty':'Nothing here yet','ui_feed_following_detail':'Follow a few accounts and their posts will show up here.',
 'ui_feed_videos_detail':'Posts carrying a clip will show up here.','ui_feed_for_you_detail':'Posts will show up here as people write them.',
 'ui_feed_tag_detail':'Nothing has been posted under #${tab} yet.','ui_could_not_load_feed':'Could not load your feed',
 'ui_share_this_post':'Share this post',
}
data = json.loads(ARB.read_text())
for k,v in entries.items(): data.setdefault(k,v)
data['@@last_modified']='2026-09-18T00:40:00Z'
ARB.write_text(json.dumps(data, ensure_ascii=False, indent=2)+'\n')
print('English catalog:', sum(not k.startswith('@') for k in data))
