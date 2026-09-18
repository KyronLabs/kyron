from pathlib import Path
p=Path('/home/ubuntu/kyron/app/lib/l10n/app_localizations.dart')
s=p.read_text()
needle="  String ui(String key, String fallback) => Intl.message(fallback, name: key);\n"
addition="""  String authorPostsHidden(String author) => Intl.message(
        'You will not see posts from $author',
        name: 'authorPostsHidden',
        args: [author],
      );
  String authorBlocked(String author) => Intl.message(
        '$author blocked',
        name: 'authorBlocked',
        args: [author],
      );
  String nothingMatchesQuery(String what) => Intl.message(
        'Nothing on Kyron matches \"$what\"',
        name: 'nothingMatchesQuery',
        args: [what],
      );
  String repliesPolicy(String policy) => Intl.message(
        'Replies: $policy',
        name: 'repliesPolicy',
        args: [policy],
      );
  String feedTagDetail(String tab) => Intl.message(
        'Nothing has been posted under #$tab yet.',
        name: 'feedTagDetail',
        args: [tab],
      );
"""
if addition not in s: s=s.replace(needle,needle+addition)
p.write_text(s)
# Update source call sites.
for rel in ['widgets/post_options_sheet.dart','screens/search_screen.dart']:
 q=Path('/home/ubuntu/kyron/app/lib')/rel; x=q.read_text()
 x=x.replace("AppLocalizations.of(context).ui('ui_author_posts_hidden', 'You will not see posts from $author')", "AppLocalizations.of(context).authorPostsHidden(author)")
 x=x.replace("AppLocalizations.of(context).ui('ui_author_blocked', '$author blocked')", "AppLocalizations.of(context).authorBlocked(author)")
 x=x.replace("AppLocalizations.of(context).ui('ui_nothing_matches_query', 'Nothing on Kyron matches \"$what\"')", "AppLocalizations.of(context).nothingMatchesQuery(what)")
 x=x.replace("AppLocalizations.of(context).literalthisPost", "AppLocalizations.of(context).ui('ui_this_post', 'this post')")
 q.write_text(x)
q=Path('/home/ubuntu/kyron/app/lib/widgets/feed_canvas.dart'); x=q.read_text(); x=x.replace("l10n.ui('ui_feed_tag_detail', 'Nothing has been posted under #$tab yet.')", "l10n.feedTagDetail(tab)"); q.write_text(x)
q=Path('/home/ubuntu/kyron/app/lib/widgets/post_options_sheet.dart'); x=q.read_text(); x=x.replace("'Replies: ${chosen.label.toLowerCase()}'", "AppLocalizations.of(context).repliesPolicy(chosen.label.toLowerCase())"); q.write_text(x)
