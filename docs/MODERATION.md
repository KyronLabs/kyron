# Moderation: reports, decisions and appeals

How Kyron enforces its rules, who can do it, and what the account on the
other end is told. The code is `api/src/modules/moderation/enforcement.*`,
`api/src/common/guards/standing.ts`, and in the app
`app/lib/screens/account_status_screen.dart` and `moderation_screens.dart`.

Before this existed, Kyron had a report button and nothing behind it: reports
were written to a table nobody could read from the app, the account status
column was set by nothing, and a "suspended" account could do everything,
because the only check was in a password sign-in no client uses.

## The principles

1. **Nothing is done to an account that it is not told about.** Every
   decision sends a push, is a row in Notifications, and appears in
   Settings → Account status, with the rule, the team's own words, and what
   the post or reply said.
2. **Every decision can be appealed, once, for six months.** The EU's Digital
   Services Act asks platforms it covers for at least six months; nothing
   about a smaller service makes a shorter window fairer.
3. **Somebody else hears the appeal.** A moderator cannot decide an appeal
   against their own decision. An admin can, because a team of one has no
   second pair of eyes, and the record shows who decided.
4. **Undoing is complete.** Overturning a decision, or reversing it as a
   mistake, restores what it removed and lifts what it restricted. Status is
   always worked out again from the decisions still standing, so lifting a
   ban leaves a suspension that is still running.
5. **The record is permanent.** Decisions are never deleted, only reversed,
   with who reversed them and why.

## Who moderates

Roles are `USER`, `MODERATOR` and `ADMIN`, on the `User` row. **No route can
change a role.** Who can ban people is decided by whoever holds the database
credentials:

```sh
cd api
DATABASE_URL=... npm run account:role -- you@example.com ADMIN
DATABASE_URL=... npm run account:role -- @handle MODERATOR
DATABASE_URL=... npm run account:role -- @handle USER   # off the team
```

Each change is written to `AuditLog` (`role.changed`). In the Supabase SQL
editor the equivalent is
`UPDATE "User" SET role = 'ADMIN' WHERE email = '...';`. Writing the audit
row is then up to you.

| | Moderator | Admin |
|---|---|---|
| Read the report and appeal queues | yes | yes |
| Decide about an ordinary account | yes | yes |
| Decide about somebody on the team | no | yes |
| Decide about their own account | no | no |
| Hear an appeal against their own decision | no | yes, on the record |

Staff see **Settings → Moderation**, and **Decide about this post** in a
post's menu. Every team route answers 404 to anybody else, so the routes do
not even confirm they exist.

## What a decision does

One decision is one notice and one appeal, even when it both removes a post
and restricts the account.

| Decision | The post or reply | The account |
|---|---|---|
| Remove | taken down | nothing else |
| Warn | taken down, or left up | a notice on its record; nothing restricted |
| Suspend (1–365 days) | taken down, or left up | **read-only** until it ends |
| Ban | taken down, or left up | **locked out** but for the below |

What each standing allows (`refuses()` in `standing.ts`, and pinned by
`api/src/public-routes.spec.ts`):

- **Suspended:** every `GET` still answers. Nothing that writes does, except
  what protects the account: reporting, blocking, muting, hiding. A
  suspended account can still be harassed.
- **Banned:** only seeing why (`GET /moderation/standing`), appealing,
  hearing the answer (push registration), contacting support
  (`/feedback`), and leaving (`DELETE /account`, `DELETE /keys`,
  `DELETE /devices`). Its posts, replies and profile disappear for everybody
  else, and are not deleted: an overturned ban brings them back. Its
  realtime socket is refused.

A suspension ends by itself: the guard sees the time has passed and puts the
account back to `ACTIVE` on its next request.

### Ban evasion

A ban stores a sha256 hash of the account's email address
(`BannedIdentity`). A banned account can still delete itself, which removes
the address with everything else, but a new sign-up whose address hashes to
a banned one starts banned too. Its ban names the original case, and can be
appealed like any other, because an address can change hands.

This stops the easy case only. A new email address is a new account.
Stopping that takes device or network signals, which Kyron does not collect.

### When an account is deleted

Decisions about it stay on the record (case number, rule, dates, who
decided), so leaving does not wipe a ban, but **not** what it wrote. The
snapshot of its post, reply or community chat message is cleared from the
decision and from any reports about it. Its appeals go with it. **The privacy
policy should say this** (see below).

## Reports

- What can be reported: an account, a post, a reply, and a message in a
  community chat. A community chat message can be reported only by somebody
  in that community who can read it, and the report keeps a copy of the
  words, the chat and the community, since a moderator may delete it from the
  chat before the team looks. The copy also says what the message carried
  (`[image]`, `[voice]`, and a poll's answers as `[poll: a / b]`, which can be
  the abuse as much as its question). The team sees the pictures and voice
  notes themselves on the case, behind links that last a quarter of an hour:
  they are not in the community and cannot open the chat. A message's earlier
  versions are kept when its author edits it, so it can be judged on what it
  said, not on what it was changed to. Taking one down hides it from the chat and lets
  go of its pin; reversing that puts it back, unless its author or a
  community moderator had deleted it themselves.
- One per person per thing. A second report from the same person updates the
  first, so a brigade cannot look like a consensus.
- The queue groups reports by the thing reported, and lists **urgent ones
  first** (child safety, self-harm, violence), then oldest first.
- Every report pushes a notification to the team ("A report is waiting", or
  "An urgent report is waiting"). Volume is small today; revisit this when it
  is not.
- Whoever reported is told the outcome, without detail: "we acted on
  something you reported", or "we did not find that it broke Kyron's rules".
  It comes as a push and as a row in Notifications, and both open
  **Settings → Your reports**: every report from the last 90 days, what it
  was about, the rule, and where it stands (*In review*, *Action taken*, *No
  rule broken*). The confirmation after sending a report says a notification
  will follow and links there. It used to be a section at the foot of
  Account status, which is about decisions against the account and is not
  where anybody looks for what came of something they reported.

### In Notifications

Decisions and report outcomes are rows in Notifications beside likes and
replies, worked out from the tables that already hold them, like every other
row there: there is no notifications table to fan out into.

| Row | From | Opens |
|:--|:--|:--|
| A decision (warning, removal, suspension, ban) | `ModerationAction` | Account status |
| An appeal decided, either way | `Appeal.decidedAt` | Account status |
| A decision reversed as a mistake | `ModerationAction.reversedAt` | Account status |
| A report actioned or dismissed | `Report.resolvedAt` | Your reports |

An appeal that overturns a decision also reverses it; that shows once, as the
appeal's row. These rows have no actor, and the app draws them as from Kyron,
with a shield or a flag, never as from a person. They count towards the
unread figure like the rest. The API sends them only to an app that asks
(`include=moderation` on `GET /notifications` and `GET /notifications/unread`),
because an app from before them would not know what to draw.

## Appeals

- Settings → Account status → the decision → **Appeal this decision**. At
  least 20 characters, so the reviewer has something to weigh.
- One appeal per decision, for 180 days (`APPEAL_DAYS`).
- The team sees it in Moderation → Appeals, with the original decision, its
  team note, the content, and the account's record. Upholding or overturning
  needs a response, which is sent to the account as written.

## What the team must do outside the app

Kyron's software cannot do these, and they are not optional:

- **Child sexual abuse material.** Removing it is not enough. In most places
  the law requires reporting it: to NCMEC's CyberTipline in the US, the IWF
  in the UK, or the national hotline elsewhere (inhope.org lists them). Do not
  download or forward the material. Ban the account, and keep the case
  number. The app's urgent-case banner says so.
- **Someone in immediate danger** (self-harm, threats of violence): contact
  emergency services where they are, if you can tell where.
- **Read the queue.** A notification arrives for each report and appeal, but
  nothing escalates if nobody acts. Decide how often someone checks, and
  keep to it.
- **Watch abuse@spidroid.com and privacy@spidroid.com.** The privacy policy
  and the app both name them.

## The published terms need updating

The terms at kyron-terms-and-privacy.onrender.com (not in this repository)
say appeals go to abuse@spidroid.com **within 30 days**. The app now offers
appeals in Settings → Account status for **180 days**. Update the terms to
say so, and to describe:

- the decisions (removal, warning, suspension, ban) and what a suspension
  allows;
- that a new account at a banned address starts banned;
- that decisions are kept after an account is deleted, without its content
  (also the privacy policy);
- that community chats are not end-to-end encrypted: what is said in them is
  stored readable, and the community's moderators and Kyron's team can read
  it (the privacy policy). Direct messages and groups still are.

## Known limits

- **Direct messages cannot be moderated.** They are end-to-end encrypted;
  the server holds nothing readable. The defence there is blocking, and
  reporting the account.
- **Media is judged through its post.** Removing a post removes its media
  from view; there is no separate image review. A community chat message's
  pictures are shown on its case (above), and kept when a community
  moderator deletes it; its author deleting it erases them, as it erases the
  words.
- **Earlier versions of an edited chat message are kept but not yet shown**
  on the case. The snapshot is what it said when first reported.
- **Community moderation is separate.** Community bans (`CommunityBan`) and
  deleting messages in a community's chats are run by each community's own
  moderators and are not covered here ([MESSAGING.md](MESSAGING.md#community-chats)).
  A community chat message deleted by a community moderator keeps its words,
  so a report about it can still be judged.
- **Staff on an app from before community chats** see a community chat
  message report as a post, and acting on it fails safely ("No such post"):
  the app sends the message's id as a post's. Update the app to judge them.
- **No automatic escalation.** Repeated warnings do not turn into a
  suspension by themselves. The reviewer sees the account's record on every
  case and decides.
- **Translated, except the team's own words.** Account status, a case, the
  appeal form, the ban screen, the report form, the rows in Notifications and
  Your reports, and the pushes are in every language the app has, dates
  included. What a reviewer writes (the message on a decision, the answer to
  an appeal) is shown as written. The team's own screens are English.

## Testing it

`enforcement.db.spec.ts` runs the whole flow against a real Postgres: report,
decide, appeal, overturn, ban, reverse, delete, re-sign-up. CI has no
database, so it is skipped there. Run it before changing anything here:

```sh
cd api
DATABASE_URL=postgresql://... npx prisma migrate deploy
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest enforcement.db
```

To run every database spec together, run them one at a time:
`npx jest db.spec --runInBand`. They share the database, and run side by side
one spec's posts land in another's feed.
