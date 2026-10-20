# Messaging: groups and view once

What a conversation can be besides two people writing to each other, and what
a photo, clip or voice note sent "view once" does and does not promise. The
encryption under both is [E2EE.md](E2EE.md); this is what is built on it.

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
the key to whoever turns up). That is not built, and when it is, it will say
plainly that it is not encrypted.

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
  screenshots, all on the community-chat side of the line above.
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

## Testing it

`messages.groups.db.spec.ts` runs groups and view once against a real
Postgres: roles, spectators, raised hands, history from joining, the key
share refusal, one open, the sweep's timing and the 14-day expiry.
`groups.service.spec.ts` and `view-once.service.spec.ts` hold the same rules
without a database, so CI checks them. On the app side,
`groups_and_view_once_test.dart` drives the screens.

```sh
cd api
MODERATION_TEST_DATABASE_URL=postgresql://... npx jest messages.groups.db
```
