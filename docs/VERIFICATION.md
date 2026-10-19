# Verification: the badge beside a name

What the verified badge means, who can ask for it, how the team decides, and
what takes it away. The code is `api/src/modules/verification/`, the
`verifiedAt` column on `User`, and in the app
`app/lib/screens/verification_screen.dart`, the Badges tab in
`moderation_screens.dart`, and `widgets/verified_badge.dart` and
`widgets/stamp.dart`.

## What it means

**Somebody on the Kyron team checked that this account is who it says it
is.** That is all it says.

- It gives **no extra reach**. Nothing in the feed, search or suggestions
  reads it. It is drawn beside the name and nowhere else.
- It is **not for sale**, and never will be. A badge anybody can buy says
  only that somebody paid, and then it stops protecting anyone from
  impersonation, which is the one job it has.
- It is **not an endorsement**. A verified account is held to the same rules
  as every other, and a suspension or ban does not remove it: who an account
  is has not changed because it broke a rule. A banned account is not shown
  anywhere, so there is nothing to badge.

## Who can ask

The sidebar opens with a stamp, "Get verified", that leads to the page. An
account can send a request when all of these hold, and the page lists them
with a tick or not:

| Requirement | Why |
| --- | --- |
| A profile photo | The reviewer compares it with the linked pages. |
| A name on the profile | The badge vouches for the name; there has to be one. |
| A bio | Says who the account is, in its own words. |
| At least 7 days old | Rules out a throwaway made to impersonate somebody. |
| Active, and no decision against it in the last 90 days that was not reversed | A suspended account cannot ask, and one fresh from a decision waits. |

One request at a time. After a "no", the account can ask again after 30
days. A request can be withdrawn while it waits.

The request says which kind of account it is (creator, public figure,
journalist, organisation or brand, or something else), who it is in the
account's own words (30 to 1,000 characters), and one to three links.

## The evidence is links, never documents

Kyron does not ask for passports, driving licences or any identity
document, and the team must not accept one sent another way. Holding them
is a liability the service cannot justify, and they prove a person exists,
not that this account is theirs.

What proves it is **a page the person already controls that names this
Kyron account**: their website, another profile, a staff page, a
publication's author page. The page must mention the Kyron name or link to
the profile. A page that does not mention Kyron proves the page belongs to
somebody, not that this account does. The case screen says so above the
buttons.

## How the team decides

Requests wait in Settings → Moderation → **Badges**, oldest first. Each
shows the account (followers, posts, when it joined, its record), what it
says, the links, and the requirements **as they stand now** rather than when
it was sent: an account that has since lost its photo or picked up a
decision is marked.

- **Verify** asks once more, then gives the badge and tells the account.
- **Turn down** needs a reason of at least 10 characters, which the account
  is shown. Say what would have made it a yes.
- **Nobody decides their own request.** A request from somebody on the team
  is answered by somebody else, and the buttons are off on your own.

From an account's record, the team can also **give or remove the badge
directly**, without a request (for an account known to the team, or one
found to have been verified in error). Both need a reason, are written to
the audit log as `verification.granted` or `verification.revoked` with who
did it, and notify the account. Nobody can change their own badge this way
either.

Moderators and admins can do all of this; there is no separate role.

## What takes it away

- **A change of name.** The badge vouches for a name, so changing it removes
  the badge, and the account is told why and can ask again. Setting a name
  on an account that had none does not. The handle cannot be changed once
  set, so it needs no rule.
- **The team**, from the account's record, with a reason.
- **Deleting the account.**

## On the record

Every badge given or taken away has a row in `AuditLog`, so "why is this
account verified?" has one place to look:

| Action | When | `details` |
| --- | --- | --- |
| `verification.granted` | A request was approved | `by`, `request` (its number) |
| `verification.granted` | The team gave it directly | `by`, `reason` |
| `verification.revoked` | The team removed it directly | `by`, `reason` |
| `verification.lapsed` | The name changed | `reason: "renamed"`, `from`, `to` |

Requests, including the ones turned down or withdrawn, are kept in
`VerificationRequest` with their status, the answer, who gave it and when.

## Granting it outside the app

For the first accounts, before the app version with the Badges tab is out,
or when a person cannot use the app:

```sql
UPDATE "User" SET "verifiedAt" = now() WHERE id = '<user id>';
INSERT INTO "AuditLog" (id, "userId", action, details, "createdAt")
VALUES (gen_random_uuid(), '<user id>', 'verification.granted',
        '{"by": "<your user id>", "reason": "<how you checked>"}', now());
```

Always write the audit row: a badge with no record of who gave it, or why,
is the kind the team cannot defend later.

## Known limits

- **English only.** The page and notices are not translated yet.
- **No expiry.** A badge stays until the name changes or somebody removes
  it. If accounts start changing hands, add a periodic re-check.
- **No public explanation page.** Tapping the badge shows a tooltip; a page
  saying what it means, linked from it, would help people who have never
  seen one.

## Testing it

`verification.service.spec.ts` covers the rules. `verification.db.spec.ts`
runs asking, deciding, renaming and the direct grant against a real
Postgres; CI has no database, so it is skipped there. Run it before changing
anything here, the same way as the moderation one (see `MODERATION.md`):

```sh
cd api
DATABASE_URL=postgresql://... npx prisma migrate deploy
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest verification.db
```
