from pathlib import Path
root=Path('/home/ubuntu/kyron/app/lib')
repls={
'widgets/post_options_sheet.dart': {
"'Post text copied'":"AppLocalizations.of(context).ui('ui_post_text_copied', 'Post text copied')",
"'Link copied'":"AppLocalizations.of(context).ui('ui_link_copied', 'Link copied')",
"'Noted. This helps shape what you are shown.'":"AppLocalizations.of(context).ui('ui_interest_noted', 'Noted. This helps shape what you are shown.')",
"'Hidden. We will show you fewer like it.'":"AppLocalizations.of(context).ui('ui_posts_hidden', 'Hidden. We will show you fewer like it.')",
"'Post hidden'":"AppLocalizations.of(context).ui('ui_post_hidden', 'Post hidden')",
"'Thread muted'":"AppLocalizations.of(context).ui('ui_thread_muted', 'Thread muted')",
"label: 'Mute $author'":"label: AppLocalizations.of(context).literalmuteAuthor(author)",
"'You will stop seeing their posts. They are not told.'":"AppLocalizations.of(context).ui('ui_mute_detail', 'You will stop seeing their posts. They are not told.')",
"'You will not see posts from $author'":"AppLocalizations.of(context).ui('ui_author_posts_hidden', 'You will not see posts from $author')",
"label: 'Block $author'":"label: AppLocalizations.of(context).literalblockAuthor(author)",
"'Neither of you will see the other, or be able to follow.'":"AppLocalizations.of(context).ui('ui_block_detail', 'Neither of you will see the other, or be able to follow.')",
"label: 'Report $author'":"label: AppLocalizations.of(context).literalreportAuthor(author)",
"subject: 'this post'":"subject: AppLocalizations.of(context).literalthisPost",
"'It is removed from your profile and from everyone else\\'s feed. '\n          'Replies to it go with it.'":"AppLocalizations.of(context).ui('ui_post_delete_detail', 'It is removed from your profile and from everyone else\\'s feed. Replies to it go with it.')",
"title: Text('Block $author?')":"title: Text(AppLocalizations.of(context).literalblockAuthor2(author))",
"'Neither of you will see the other on Kyron, and any follow between '\n          'you is removed. They are not told.'":"AppLocalizations.of(context).ui('ui_block_detail', 'Neither of you will see the other on Kyron, and any follow between you is removed. They are not told.')",
"'$author blocked'":"AppLocalizations.of(context).ui('ui_author_blocked', '$author blocked')",
"'Post deleted'":"AppLocalizations.of(context).ui('ui_post_deleted', 'Post deleted')",
},
'widgets/sliding_drawer_content.dart': {
"_stat(context, user.followers, 'Followers')":"_stat(context, user.followers, AppLocalizations.of(context).followers)",
"_stat(context, user.following, 'Following')":"_stat(context, user.following, AppLocalizations.of(context).following)",
"label: 'Communities'":"label: AppLocalizations.of(context).communities",
"label: 'Settings'":"label: AppLocalizations.of(context).settings",
"'Could not load your profile'":"AppLocalizations.of(context).ui('ui_could_not_load_profile', 'Could not load your profile')",
"'Terms'":"AppLocalizations.of(context).ui('ui_terms', 'Terms')",
"'Privacy'":"AppLocalizations.of(context).ui('ui_privacy', 'Privacy')",
"'Help'":"AppLocalizations.of(context).ui('ui_help', 'Help')",
"'Feedback'":"AppLocalizations.of(context).ui('ui_feedback', 'Feedback')",
"'Decentralized ID'":"AppLocalizations.of(context).ui('ui_decentralized_id', 'Decentralized ID')",
},
'screens/search_screen.dart': {
"? 'Search people'\n                  : 'Search posts'":"? AppLocalizations.of(context).ui('ui_search_people', 'Search people')\n                  : AppLocalizations.of(context).ui('ui_search_posts', 'Search posts')",
"? 'Find people on Kyron'\n            : 'Search everything posted'":"? AppLocalizations.of(context).ui('ui_find_people_on_kyron', 'Find people on Kyron')\n            : AppLocalizations.of(context).ui('ui_search_everything_posted', 'Search everything posted')",
"? 'Search by handle or display name.'\n            : 'Words, or a filter — an account, a date range, or what a '\n                'post carries.'":"? AppLocalizations.of(context).ui('ui_search_by_handle_or_display_name', 'Search by handle or display name.')\n            : AppLocalizations.of(context).ui('ui_words_or_filter', 'Words, or a filter — an account, a date range, or what a post carries.')",
"detail: 'Two characters or more.'":"detail: AppLocalizations.of(context).ui('ui_two_characters_or_more', 'Two characters or more.')",
"? 'No posts match those filters.'\n            : 'Nothing on Kyron matches \"$what\".'":"? AppLocalizations.of(context).ui('ui_no_posts_match_filters', 'No posts match those filters.')\n            : AppLocalizations.of(context).ui('ui_nothing_matches_query', 'Nothing on Kyron matches \"$what\"')",
"tooltip: 'Clear'":"tooltip: AppLocalizations.of(context).ui('ui_search_clear', 'Clear')",
"tooltip: 'Filters'":"tooltip: AppLocalizations.of(context).ui('ui_search_filters', 'Filters')",
},
'screens/settings_screen.dart': {
"title: 'Appearance'":"title: AppLocalizations.of(context).ui('ui_appearance', 'Appearance')",
"title: Text(\n          'Settings',":"title: Text(AppLocalizations.of(context).settings),",
"_groupHeader('Account')":"_groupHeader(AppLocalizations.of(context).ui('ui_account', 'Account'))",
"helpText: 'Your profile and contact information'":"helpText: AppLocalizations.of(context).ui('ui_settings_profile_contact', 'Your profile and contact information')",
"helpText: 'Security settings'":"helpText: AppLocalizations.of(context).ui('ui_settings_security', 'Security settings')",
"helpText: 'Who you have muted or blocked'":"helpText: AppLocalizations.of(context).ui('ui_settings_muted_blocked', 'Who you have muted or blocked')",
},
}
for rel,m in repls.items():
 p=root/rel; s=p.read_text()
 for a,b in m.items():
  if a in s: s=s.replace(a,b)
  else: print('MISS',rel,a)
 p.write_text(s)
