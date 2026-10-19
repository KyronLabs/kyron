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
   decision sends a notification and appears in Settings → Account status,
   with the rule, the team's own words, and what the post or reply said.
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
snapshot of its post is cleared from the decision and from any reports about
it. Its appeals go with it. **The privacy policy should say this** (see
below).

## Reports

- One per person per thing. A second report from the same person updates the
  first, so a brigade cannot look like a consensus.
- The queue groups reports by the thing reported, and lists **urgent ones
  first** (child safety, self-harm, violence), then oldest first.
- Every report pushes a notification to the team ("A report is waiting", or
  "An urgent report is waiting"). Volume is small today; revisit this when it
  is not.
- Whoever reported is told the outcome, without detail: "we acted on
  something you reported", or "we did not find that it broke Kyron's rules".
  Settings → Account status lists their reports and outcomes for 90 days.

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
  (also the privacy policy).

## Known limits

- **Direct messages cannot be moderated.** They are end-to-end encrypted;
  the server holds nothing readable. The defence there is blocking, and
  reporting the account.
- **Media is judged through its post.** Removing a post removes its media
  from view; there is no separate image review.
- **Community moderation is separate.** Community bans (`CommunityBan`) are
  run by each community's own moderators and are not covered here.
- **No automatic escalation.** Repeated warnings do not turn into a
  suspension by themselves. The reviewer sees the account's record on every
  case and decides.
- **English only.** The notices and screens are not translated yet.

## Testing it

`enforcement.db.spec.ts` runs the whole flow against a real Postgres: report,
decide, appeal, overturn, ban, reverse, delete, re-sign-up. CI has no
database, so it is skipped there. Run it before changing anything here:

```sh
cd api
DATABASE_URL=postgresql://... npx prisma migrate deploy
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest enforcement.db
```
