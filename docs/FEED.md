# For You: how the feed decides what to show

The home feed's For You tab, end to end. The code is
`api/src/modules/feed/ranking.service.ts` (the scoring, as pure functions),
`FeedService.rankedPage` in `feed.service.ts` (the pool, the cursor, the
signals), and in the app `widgets/post_list_view.dart` and
`services/impression_reporter.dart` (what was on screen). Following and
Videos are not ranked: they are newest first.

## What went wrong, October 2026

For You showed nineteen posts, the same nineteen every session, and then
ended. Two causes, both fixed:

1. **A fourteen-day cutoff on the pool.** The ranker read the newest four
   hundred posts *of the last fourteen days*. Production then had 104 live
   posts, 20 of them inside the window; filters took one more. Everything
   older could never reach For You again, however little else there was.
2. **Only opened posts counted as seen.** Scrolling past a post recorded
   nothing, so a post somebody scrolled past every day looked unseen to the
   ranker and stayed at the top.

The fixes changed three more things: freshness now fades with the network's
pace rather than by wall clock, the app reports what was on screen, and each
session is ranked as the world stood when it began.

## The pool

The newest 400 posts (`candidatePool`) the reader may see: not deleted, not
by an account they blocked or muted or a banned one, not hidden or muted,
not containing a muted word, and only from communities they are in (unless
they asked for community posts to stay in Communities). **No age limit.**
Age is the score's job, and a score does not hide anything.

## The score

For each candidate:

```
score = (0.6 + engagement) × freshness × affinity × seen × shown × wobble
```

| Part | What it is |
|:--|:--|
| engagement | `ln(1 + likes + 2.5·comments + 4·reposts)`. Damped, so one hit does not own the feed for a fortnight. |
| freshness | `0.5 ^ (age / half-life)`. See below. |
| affinity | ×1.6 if the reader follows the author; up to ×1.6 more for authors they like, read (8s+) or asked to see more of; ×1.25 for a topic they follow; ×0.2 per "see less of this", floored at ×0.05. |
| seen | ×0.25 per time the reader **opened** the post, floored at ×0.02. |
| shown | ×0.5 per sitting the post was **on screen** without regard to opening, floored at ×0.05; the count halves every 48 hours since it was last shown, so a post passed over last week comes round again. |
| wobble | ×0.65–1.35, seeded per session, so two sessions read differently but one session pages coherently. |

Then no author appears more than twice in a row, and the result is paged.

### Freshness follows the network, not the clock

The half-life is **the time the network took to write its newest 20
posts** (a page of them), held between **1 day** and **7 days**. A fixed day
was tuned for a network writing hundreds of posts a day; on one writing two,
a week-old post scored a hundredth of a new one and an older post could
never come back. Measured in posts written since, "old" means "there is a
page of newer things to read", however long that took. On a busy network
this is the old behaviour exactly.

At Kyron's October 2026 pace this settles on the 7-day ceiling.

### What it does, on Kyron's numbers

`ranking.service.spec.ts` builds a pool shaped like production (104 posts
over seven weeks, 14 authors) and checks, and a simulation over 200 session
seeds confirmed:

- a reader who has seen nothing gets 8 to 10 of the newest twenty in their
  first ten;
- a reader who has been shown the newest nineteen three times today gets 14
  to 20 posts **they have not been shown** on their next first page (median
  17), and the nineteen are still there further down;
- every one of the 104 posts can be reached.

## What "on screen" means

The app wraps each For You card in a visibility check. A card that is at
least half on screen for **700ms** is "shown", which a flick through the feed
does not reach. The app reports each post **once per session** (a session is
one ranking: from a refresh to the next), batched every 4 seconds or 50
posts, and when the app goes to the background. A batch that fails is
dropped, not retried: a missed impression costs one post one place later.

`POST /feed/impressions` writes `PostImpression` (`viewerId`, `postId`,
`count`, `lastAt`, `prevAt`). A report within 10 minutes of the last for the
same post is the same sitting and changes nothing. Impressions are read by
ranking and nothing else; an author's view count still counts **opens**, one
per person (`PostView`), and is unaffected.

Only For You reports. Following is not ranked, and a second surface
reporting the same post inside one For You session would move it mid-session.

## Paging: one session, one world

A page cursor is `r<seed>-<offset>-<session start, ms>`. Every later page is
ranked **as of the session start**:

- no post written after it joins the pool;
- each post's impression and open counts are read as they stood then: the
  session's own report is undone using `prevAt`;
- likes, interest signals and reads from after it are ignored.

Without this, page one's posts would be reported as shown while the reader is
on them, drop down the order, and page two's offset would land past posts
nobody had seen. `feed.impressions.db.spec.ts` pages a real database while
recording impressions and checks there are no repeats and no gaps, and fails
if the session freeze is removed. An old two-part cursor still works and
ranks as of now. A session start in the future is treated as now.

## Known limits

- **No content understanding.** Topics come from what the author filed the
  post under; nothing reads the text or the pictures.
- **Impressions from old app versions are not reported**, so for people on
  them the feed still only knows what they opened. It still reaches every
  post.
- **The pool is the newest 400.** Past that, older posts are out of For You
  (they remain on profiles, in search and in their communities). At
  Kyron's size that is months away; when it is near, rank a sample of the
  older posts in too rather than raising the number.
- **`PostImpression` grows** with readers × posts shown. Nothing prunes it
  yet; rows older than a few weeks no longer change a score (the count has
  halved away), so pruning them would be safe.

## Testing it

```sh
cd api
npx jest ranking feed.service          # the rules, no database
DATABASE_URL=postgresql://... npx prisma migrate deploy
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest feed.impressions.db
```
