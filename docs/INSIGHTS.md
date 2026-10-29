# Insights

How your account is doing, who is seeing it, and what to do next. Opened from
the chart button beside Share at the top of your own profile. Only your own:
`GET /insights` answers about the signed-in account and takes no account as a
parameter.

Two tabs, over the last 7, 30 or 90 days, each number set against the same
length of time before it.

## What each number counts

| Number | What it is |
|:--|:--|
| **People reached** | Distinct people who were shown one of your posts, or opened one, **for the first time** in the period. Your own looks are not counted. |
| Followers / Not following you | Of those, how many follow you now. |
| **New followers** | Follows that started in the period **and still stand**. Unfollows are not recorded anywhere, so this is not "net followers" and does not say so. |
| Opens | First opens of your posts by other people: one person opening one post counts once. |
| Likes, Replies, Reposts, Saves | Given by other people, in the period, on any of your posts. |
| People reached each day | The first line, day by day, in your own time zone. |
| Top posts | Your five posts that reached the most people in the period. Tapping one opens its own analytics. |

**Why "first time".** A comparison with the period before needs to know who was
reached *then*, and the only times Kyron keeps for "last seen" are overwritten
every sitting. So reach is counted from when each post was first in front of
each person: `PostImpression.createdAt` (added for this, 1 November 2026) and
`PostView.createdAt`. Somebody who sees a new post of yours this month is
reached this month even if they saw an older one last month; somebody who only
scrolls past an old post again is not reached again. Impressions written before
the column existed were back-filled with the earliest time each row still knew,
which leans recent; from the migration on it is exact.

## The audience, and what it will not show

The Audience tab describes other people, so it has two floors:

- **Nothing about the audience at all under 20 people reached** in the period.
- **No group under 5 people** in any breakdown: an age band, a topic, a
  community.

Without them, "1 viewer, 25-34, in the Lagos Runners community" names
somebody. Both constants are in `InsightsService`.

What it shows above the floors:

- **Ages**, in bands, from the people reached who gave a birthday -- and it says
  how many that was, since it is rarely everyone.
- **Countries**, the five largest, from the people reached who have a country
  on their profile -- and, as with ages, how many that was.
- **Topics they follow** and **communities they are in**, the five largest.
- **When they are around**: the three busiest three-hour stretches of the week,
  from when they were last on your posts, turned into your own time zone on the
  phone.

**Cities and genders are not shown, because Kyron does not collect them.**
Threads shows both; it knows them from your phone and your account. A guess
presented as a measurement would be worse than the gap, and the screen says
so.

## Where countries come from

From the country on each person's profile (`UserProfile.country`, an ISO
3166-1 code, plus XK for Kosovo), picked from a list on Edit profile and at
sign-up. Not typed: "Lagos", "lagos nigeria" and "9ja" are one place and three
strings, and only a list can be counted. Not from IP addresses either, which
is how Meta does it: an address is personal data under the GDPR, it is wrong
behind every VPN and most mobile carriers, and a country somebody chose is one
they know is shown.

The cost is coverage. Only the people who picked a country are counted, which
is why the screen says how many that was, and why sign-up asks rather than
leaving it to Edit profile. The list's first rows are the countries the phone's
own settings point at (`en_NG` says Nigeria), as a suggestion, never chosen
for anybody.

The names come from Unicode CLDR, one file per app language in
`app/assets/countries/`, written by `scripts/generate-countries.py`. CLDR's
Igbo names are mostly still English; the rest are native.

What people had typed into the old free-text location was carried over by the
migration where it plainly names one country -- the whole of it ("Nigeria",
"UK") or its last part ("Lagos, Nigeria"). "Georgia", "Congo", "Korea",
"America" and bare two-letter codes are not read: "Atlanta, Georgia" is not in
the Caucasus. The text is kept in `location`; nothing shows it.

## Summary and growth tips

Threads writes its summary with an AI model. This one is rules
(`api/src/modules/insights/growth-tips.ts`): the same numbers always read the
same way, and none of it can be confidently wrong.

Every tip has a condition, and appears only when the condition holds for your
account in this period. At most four, in this order:

| Tip | When |
|:--|:--|
| Post something | No posts in the period. |
| Add a profile picture / Write a bio | Missing. |
| Post more often | Fewer than one post a week over the period. |
| Answer your replies | At least 5 replies from other people, and you answered under 30% of them. |
| Turn readers into followers | 100+ people reached who don't follow you, under 1% of them followed, and you have a bio. |
| Add topics to your posts | At least 2 posts, under half with a topic. |
| Do more of what worked | One post reached at least twice the median of your others (3 or more of them). |
| Post in *community* | The community most of your audience is in, if you have not posted there this period. Needs the audience floor. |
| Post when they are around | The busiest hour of your audience's week. Needs the audience floor. |

None of them quotes a figure from outside Kyron or promises an outcome. Each
says what your data shows and the mechanism that makes the advice work here --
a topic puts a post in that topic's feed and in front of the people who follow
it; a profile is what a stranger reads before deciding to follow.

## Not built

- **Profile link clicks.** Nothing records a tap on your website link.
- **Unfollows**, and so net followers.
- **Impressions as a count of sittings.** Reach is people, not views; a person
  seeing the same post five times is one.
- Any of it for somebody else's account, by design.

## Testing it

```sh
cd api
npx jest insights                                   # the rules, no database
DATABASE_URL=postgresql://... npx prisma migrate deploy
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest insights.db
```

The database spec checks reach against the period before, the daily line in a
far time zone, the per-post ranking, and both audience floors, countries
included.
