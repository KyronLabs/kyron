# Messaging: groups, view once and community chats

What a conversation can be besides two people writing to each other, what a
photo, clip or voice note sent "view once" does and does not promise, and the
chats inside communities, which are a different thing. The encryption under
groups and view once is [E2EE.md](E2EE.md); community chats are not
end-to-end encrypted, and say so.

## Groups

A group is a conversation with a name and up to **32 people**, its creator
included. It is end-to-end encrypted the same way a conversation between two
is: every message is sealed on the sender's phone for the devices of everyone
in it, and the server stores ciphertext.

### Why 32

Every message is sealed once per device it goes to — about 120 characters
each. Thirty-two people with a phone or two apiece is an envelope of a few
kilobytes, which is fine. Three hundred is not, and neither is the time to
seal it on a mid-range phone for every message. A group bigger than that is a
different thing: a community chat everyone can join, which cannot be
end-to-end encrypted in any meaningful sense (the server would have to hand
the key to whoever turns up). That is a [community chat](#community-chats),
and it says plainly that it is not encrypted.

The ceiling on how many devices one message is sealed for went from 16 to 64
with groups, and the order changed: everybody's freshest device first, one
each, then everybody's second, and so on (`MessageVault.seal`). Before, the
first 16 in the server's order were taken, which in a group would have shut
whole people out the moment one member had a drawer of old installs.

### Roles

| Role | Can |
|:--|:--|
| **Owner** | Everything an admin can, plus make and unmake admins, and hand the group on. There is one. |
| **Admin** | Add and remove people, rename the group, move people between member and spectator, answer raised hands, choose what new people join as. |
| **Member** | Write, react, leave. |
| **Spectator** | Read and react. Raise a hand to ask to write. |

The server holds every one of these rules (`GroupsService`); the app only
leaves out buttons that would be refused. An admin cannot touch another admin
or the owner. Handing the group on makes the old owner an admin, never two
owners. When the owner leaves, the group passes to the admin who has been in
it longest — or, with no admins, the longest-standing member, and only then a
spectator.

**Spectators** are what the Threads screenshots this came from call them:
people who are there to follow, not to talk. An admin can set a group so that
everybody added from then on starts as a spectator. A spectator who wants to
say something raises a hand; the admins get a push and a banner, and answer it
with "Let them write" (member) or "Dismiss".

### History starts when you join

Somebody added to a group sees what is said from the moment they were added,
not before. Two reasons, and the second is the one that matters:

- What was said before was sealed for the devices in the group then. Theirs
  were not among them, so it would be a wall of "cannot be read".
- A device that cannot open a message can ask another to seal its key again
  for it ([E2EE.md](E2EE.md), *key requests*). Left alone, that would let a
  newcomer ask for the last 30 days of a group nobody agreed to show them.
  The server refuses a key request for anything older than the asker's
  joining.

### Lines about the group

"Ada added Ben", "Ada made Cy a spectator", "Ada renamed the group" are
stored as messages with an `event` and no body, carrying the names as they
were at that moment, so the line still reads after somebody changes theirs or
leaves. These are **not sealed** — the server writes them, so it knows them.
It knows who is in the group anyway (it has to, to route messages), and the
group's name. See *What the server knows*, below.

### What is not built

- Polls, pinned messages, live rooms, a "joined" count: all in the Threads
  screenshots, all on the community-chat side of the line above. Community
  chats have pins and a joined count; polls and live rooms are not built
  anywhere.
- Group photos. The avatar is two members' pictures.
- Muting a group mutes it for the reader, as in a conversation between two.
  There is no "only admins can write" switch beyond making people spectators.

## View once

A photo, a clip or a voice note sent view once can be opened **once by each
person it was sent to**, and is then deleted from Kyron's storage. The sender
cannot open it again either.

### How it works

1. The file goes to a **private** storage bucket (`kyron-private`), not the
   public one every other attachment uses. The upload answers with a
   reference (`once/<sender>_<time>_<id>.<ext>`), never an address. The
   composer's usual picker cannot be used for this: it uploads what is picked
   straight away, to the public bucket, so a view-once photo has its own
   pick-and-preview step that uploads nothing until Send.
2. The message carries the reference. Every response that includes the
   message strips it: a view-once attachment reaches no client with a URL.
3. Opening it (`POST /messages/:id/items/:messageId/open`) records the open
   first — one row per person, so a second open is refused (410) — and then
   answers a signed link that stops working in **two minutes** for a photo,
   or the length of the clip or note plus a minute (never more than fifteen).
   The sender is refused (403).
4. When everyone it went to has opened it, the message is marked to be
   deleted once the last link has run out. A sweep every ten minutes deletes
   the file and clears the reference. Anything unopened after **14 days**
   goes the same way. Deleting the message deletes the file.

"Everyone it went to" is everyone in the conversation when it was sent, but
the sender. Somebody added to a group later was not sent it.

On the phone the picture is fetched into memory and never written to disk; a
clip and a voice note are streamed. Closing the viewer is the end of it.

### What it does not promise

Be straight about this in the app and anywhere else it is described:

- **On Android** the viewer sets `FLAG_SECURE`: no screenshot, no screen
  recording, and a blank card in the recent-apps list. **On iPhone that is not
  possible** — iOS only tells an app a screenshot was taken, after the fact.
  Kyron does not yet do even that.
- **No phone can stop another camera** pointed at the screen.
- **It is not end-to-end encrypted.** The file is in a private bucket, behind
  a link only the API hands out, and only once per person — which is
  strictly better than every other attachment, which sits in a public bucket
  at an unguessable address forever. But the server could read it in the
  minutes or days before it is deleted. Sealing attachments is the gap
  [E2EE.md](E2EE.md) already lists, and view once should be sealed first
  when it is closed.
- **Deleted means deleted from storage.** Storage providers keep backups on
  their own schedule; Supabase's are not under this app's control.

## Community chats

A community can have up to **20 chats**, each with a name (up to 40
characters, one of each name per community whatever the case) and an optional
line about what it is for. They are listed on the community's page, above its
posts.

**They are not end-to-end encrypted**, and every chat says so above its first
message, as does the screen for opening one. A room anyone in a community can
walk into cannot be sealed for all of them in any meaningful sense. Messages
are stored as plain text the server, the community's moderators and Kyron's
team can read. They live in their own tables (`CommunityChat`,
`CommunityChatMember`, `CommunityChatMessage`, `CommunityChatReaction`), apart
from conversations, and never touch the message vault. Supabase's own API
roles have no grants on those tables and row-level security is on with no
policies, so the only way in is the API.

### Who can do what

| | Read and react | Write | Delete | Open, edit, pin, close |
|:--|:--|:--|:--|:--|
| Not in the community | — | — | — | — |
| In the community, not joined (a spectator) | yes | — | their own | — |
| Joined | yes | yes, except in an announcements chat | their own | — |
| A community moderator | yes | yes | their own, a member's, a former member's | yes |
| The community's owner | yes | yes | anybody's | yes |

- Being in the community is checked on **every request**, not remembered.
  Somebody removed or banned from it loses every chat on their next request;
  leaving it leaves all its chats in the same transaction.
- **Joining** a chat is what lets somebody write in it, counts them in its
  "joined" figure, gives them an unread count, and sends them live updates.
  Reading needs only membership of the community.
- An **announcements** chat (`writers: MODERATORS`) is written in by the owner
  and moderators only. Everybody in the community can still read and react.
- Closing a chat cannot be undone in the app. Its messages stay in the
  database, shown to nobody, so a report already made about one can still be
  reviewed.

### Limits

- A message is up to 2,000 characters.
- Five messages in ten seconds per person per chat, for everyone (429).
- Slow mode, per chat, from off to an hour between messages. The owner and
  moderators are not slowed.
- A reply has to answer a message in the same chat that is still up.
- Each check and the write it guards run in one transaction under a Postgres
  advisory lock -- per sender per chat for messages, per community for opening
  and renaming chats -- so requests sent side by side cannot all pass the
  check before any of them writes.

### Taking messages down

- An author who deletes their own message erases its words.
- A moderator who deletes somebody else's takes it out of the chat but keeps
  the words, for review. A moderator cannot delete the owner's or another
  moderator's; the owner can delete anybody's. The app offers delete only
  where the server would allow it.
- Anybody in the community who can read a message can report it to Kyron
  ([MODERATION.md](MODERATION.md)). A decision against it takes it down; a
  reversal puts it back, unless its author or a moderator had already
  deleted it.
- Deleting a pinned message unpins it.
- Blocks work both ways: neither side sees the other's messages, and a reply
  to a hidden message shows as unavailable.
- When an account is deleted its chat messages go with it, and the copies of
  them in reports are cleared.

### Live updates and reactions

The server sends `community.chat.message`, `community.chat.message.deleted`,
`community.chat.reaction` and `community.chat.updated` -- ids only, never the
text -- to people who joined the chat and are still in the community. The app
reads the message itself over HTTP, behind the same membership check, and only
for a chat that is open. A spectator gets no live updates; their open chat
asks again every 20 seconds. A message taken down stays down on screen even
when a page asked for just before the takedown lands just after it.

A reaction is a single emoji, one per person per message; a new one replaces
the old. Reactions are shown as counts, and who reacted is not sent.

### What is not built

- Joined community chats in the Messages inbox. The API can list them
  (`GET /community-chats/joined`); the app reaches chats from the community's
  page.
- Push notifications for community chats.
- Photos, clips, voice notes and link cards: community chats are text.
- Polls, live audio rooms, editing a message, search, muting a chat.

## What the server knows

| | Sealed | Readable by the server |
|:--|:--|:--|
| What is said | yes | — |
| Link cards | yes | — |
| Reactions | — | yes, by decision ([E2EE.md](E2EE.md)) |
| Who is in a group, and as what | — | yes, it routes by it |
| A group's name | — | yes |
| Lines about the group | — | yes, the server writes them |
| A view-once file | — | yes, until it is deleted |
| Who opened a view-once message, when | — | yes |
| Everything in a community chat | — | yes, it is not encrypted |

## Testing it

`messages.groups.db.spec.ts` runs groups and view once against a real
Postgres: roles, spectators, raised hands, history from joining, the key
share refusal, one open, the sweep's timing and the 14-day expiry.
`groups.service.spec.ts` and `view-once.service.spec.ts` hold the same rules
without a database, so CI checks them. On the app side,
`groups_and_view_once_test.dart` drives the screens.

`community-chats.db.spec.ts` does the same for community chats: the grants,
who may read, write and run them, limits (including requests sent side by
side), takedowns, pins, blocks, reports and reversals, removal from the
community, and a community closing. `community-chats.service.spec.ts` holds
the rules CI can check, and `community_chats_test.dart` the screens.

```sh
cd api
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest messages.groups.db
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest community-chats.db
```
