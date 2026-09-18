import json,re
from pathlib import Path
root=Path('/home/ubuntu/kyron/app/lib/l10n')
remove={'ui_replies_policy','ui_author_posts_hidden','ui_author_blocked','ui_nothing_matches_query','ui_feed_tag_detail'}
for p in root.glob('app_*.arb'):
 d=json.loads(p.read_text())
 for k in remove: d.pop(k,None)
 p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
for p in (root/'generated').glob('messages_*.dart'):
 s=p.read_text()
 for key in remove:
  s=re.sub(r"\n\s*'"+re.escape(key)+r"':.*?(?=\n\s*'[^']+':|\n\s*};)", '', s, flags=re.S)
 p.write_text(s)
