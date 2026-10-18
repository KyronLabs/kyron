# End-to-end encryption

Direct messages are sealed on the sending device and opened on the receiving
one. The server publishes public keys and carries ciphertext it has no key for.

This document is mostly about what that does **not** cover, because a
half-understood encryption feature is worse than none: people act on what they
believe it protects.

## How it works

**Keys.** Every account makes an X25519 keypair on each install the first time
it signs in there. The secret half is written to the same secure storage the
session token lives in, under that account's id, and never leaves the device.
The public half goes to `PUT /keys` with an opaque device id, also per account,
so the server is not told which accounts share a phone.

Sign-out keeps both, and keeps the public half published: signing back in
reads everything sealed to the key, including what arrived while signed out.
Another account signing in on the same phone has its own key and never reads
this one. Deleting the account erases the key from the phone.

Until 18 October 2026 there was one key per install, and sign-out deleted it.
Switching to another account and back -- or signing out and in again -- made a
new key, and everything sealed to the old one could never be opened on that
phone again. The update moves an install's existing key to the account signed
in on it, so nothing already sealed to it is lost.

**Sealing.** To write in a conversation the app fetches every device key in it
(`GET /keys/conversation/:id`, freshest first): the other person's, and the
writer's own. The message is sealed once, with **XChaCha20-Poly1305**, under a
random key made for that message alone. That key is then sealed again for each
device, under a key derived from X25519 between the writer's secret half and
that device's public one, run through HKDF-SHA256 — the raw exchange output is
not uniformly distributed, and feeding it straight to a cipher is the classic
way to weaken an otherwise sound scheme. Every nonce is fresh, drawn from the
platform's secure source; an AEAD makes a changed byte a refusal rather than a
different plaintext.

The writer's own devices are on the list because otherwise they could not read
their own messages after a restart. The list is capped at sixteen devices — a
reinstall publishes a new key and the old one stays listed — and the cap drops
the stalest of the writer's own installs first.

If the other person has published no key yet, the message is sent as written
and the bubble says so. It is never sealed for the writer alone.

**On the wire.** `k2.<sender>.<nonce>.<ciphertext>.<mac>.<keys>`, where
`<keys>` is one `<device id>:<nonce>:<sealed key>:<mac>` per device, joined by
`~`, every part base64url. The version prefix is there because a scheme that
cannot be changed is one that has to be right first time — and this one was
not.

**Reading.** A device finds its own entry by its key's id, derives the same
key from its secret half and the sender's public key carried in the envelope,
and opens the message key and then the message. It needs nothing from the
network, which is how the conversation list shows the last message without
fetching anybody's keys. Anything that does not parse as sealed is a plain
message and passes through untouched.

**Devices that came later.** A message is sealed for the devices listed when it
is sent, so a device that did not exist yet -- a new phone, a reinstall, a key
lost to the old sign-out -- was never among them. Such a device now asks
(`POST /messages/:id/keys/requests`), and the thread reads "Waiting for this
message. This may take a while." Every other device in the conversation is
told over the socket and checks on its next launch; any that can open the
message -- the sender's phone, or another of the reader's own -- seals the
message's key again, for the asking device's public key alone, under a key
derived from X25519 between the two devices (`kyron/dm/v2/share`), and posts it
(`POST /messages/keys/shares`). The asking device opens it with its secret half
and the message reads. A link card's key travels in the same answer.

The server stores the request and the answer and can read neither: the answer
is sealed for one device's key. It checks that the answering key is one the
answering account published, so a member cannot fill a request with noise in
somebody else's name, and it hands each device only answers for its own
account. The first answer stands. A device asks again only for a message it
still cannot open, and asking again clears an answer that did not open.

Only messages from the last **30 days** can be asked for or answered. That
bound is deliberate; see "No key verification" below for why.

### What `k1` got wrong

The first version, `k1.<nonce>.<ciphertext>.<mac>`, sealed each message under
one pairwise key: whichever the server happened to list first. The list
included the writer's own key and had no order, and when the writer's came
first the message was sealed under a secret derived from the writer's key
twice over, which only the writer can compute. They could read everything they
sent; the person they sent it to could read none of it, and saw "This message
cannot be read on this device."

`k2` replaced it on 11 October 2026. `k1` messages are still opened where they
can be, and never written. **The ones sealed the wrong way stay unreadable to
their recipient** — no key that could open them exists anywhere except on the
sender's device — and will read again only if they are sent again.

## What it does not protect

### One key per account per install

A key belongs to an account on one device. Consequences:

- **A new device reads older messages only when somebody answers for it.**
  Messages are sealed for the devices that were listed when they were sent. A
  new install asks for the last 30 days, and a message opens once a device
  that has it comes online -- which, if the only such device was the one that
  was wiped, is never. Older than 30 days, it does not ask.
- **Losing every device loses the history.** There is no key backup and no
  recovery phrase. Keys are no longer deleted on sign-out, but uninstalling
  the app deletes them, and on Android a development build and a Play build
  cannot replace each other without an uninstall.
- **A signed-out key stays on the phone.** Somebody with the phone and the
  means to read its secure storage -- a rooted handset, say -- could take a
  signed-out account's key as they could a signed-in one's. Deleting the
  account erases it; a "remove this account from this phone" choice at
  sign-out does not exist yet.
- **Stale keys linger.** An uninstalled app never withdraws its key, so it
  stays listed and keeps being sealed for, up to the cap. Harmless — nobody
  holds its secret half — but it makes envelopes larger than they need to be.

### No forward secrecy

One long-lived key per install means a compromised device key opens **every**
message that device ever received, not just future ones. Signal solves this with
a ratchet that rotates keys per message. This does not have one.

### No key verification

The server says which key belongs to whom, and nothing checks that. A server
that handed you an attacker's key in place of your correspondent's could read
everything that followed — the classic active man-in-the-middle.

Every serious end-to-end system eventually grows a way for two people to compare
a fingerprint out of band — in person, over the phone, on another service. That
is not built. **Until it is, this protects against a passive server and a
database leak, not against an actively malicious server.**

Answering requests for keys widens what such a server could do. Before, a key
it published under somebody's name read only what was sent after. Now it could
also ask with that key and be answered, automatically, for the last 30 days of
history. That is the trade for new devices being able to read at all — the
same one WhatsApp's "Waiting for this message" makes — and the 30-day window
is the bound on it. A passive server or a database leak still reads nothing:
every answer is sealed for one device's key.

### Not everything is sealed

- **Attachments are not.** Photos, video and voice go to storage in the clear.
  Only the text of a message is encrypted.
- **Reactions are not, by decision.** The emoji somebody reacts with is stored
  readable beside the sealed message it reacts to, so the server knows that
  Ada answered a message with 😂 without knowing what the message said. That
  was chosen over sealing them, for now, as the same trade attachments make;
  the two should be sealed together. The realtime event for a reaction still
  carries only ids, and the emoji is fetched over an authenticated request.
- **Link cards are sealed, and made by the sender.** The card under a link
  in a message — title, site, a small copy of the picture — is read from the
  page by the sender's phone and sealed beside the words, never fetched by
  the server the way a post's card is: asking the server would hand it the
  address out of a message it otherwise cannot read. The trade is the one
  Signal and WhatsApp make. The linked site sees one request, from the
  sender, who is sharing the link anyway. Readers draw the card from what
  arrived and never contact the site, so it cannot learn who read the
  message or when. A reader's phone accepts a card only for a link that
  appears in the message's own words, so a card cannot dress one address up
  as another; the sender can take the card off before sending; and the
  server refuses an open card beside sealed words.
- **Metadata is not, and cannot be.** The server knows who is talking to whom,
  how often, at what times, and how long each message is. That is what it needs
  to route and page conversations at all.
- **Push notifications say only that something arrived.** They used to carry
  the message body, and this section used to say that body went through
  Google as plaintext. That was half of it. A push is drawn by the phone's own
  notification system, with no chance for the app to open it first, so a
  *sealed* message arrived on the lock screen as its ciphertext — `k1.Zx9f…`
  — and only an unsealed one went through in the clear. Now every message
  push reads "Sent you a message" or "Sent an attachment", under the
  sender's name. Getting the words back means a push the app handles itself:
  it wakes, fetches the message, opens it on the device and draws the
  notification. Not built.
- **Nothing is sealed unless both sides have published a key.** A conversation
  with somebody on an older build sends as it always did. The thread says
  "Messages are end-to-end encrypted" once, above the first sealed message,
  and any message after that point that went as written carries an open lock
  beside it — so the reader is told which they got rather than left to
  assume. History from before that point is plain throughout and is not
  marked message by message. (This used to be a lock under every run of
  messages: the same thing said a hundred times down a screen, with the
  exception, which is what matters, no easier to spot.)

## What would close each gap

| Gap | What it needs |
|:--|:--|
| No forward secrecy | A double ratchet. Large, and the right eventual answer |
| No verification | Fingerprint comparison in the UI, and a warning when a key changes |
| Attachments in the clear | Encrypt the file before upload; the key travels in the sealed message |
| Reactions readable | Send a reaction as a small sealed message that names the one it reacts to |
| Push shows no preview | A data-only push the app opens on the device and draws itself |
| No backup | A recovery phrase the user writes down, encrypting the secret half; or Android's Block Store, which keeps a small secret across reinstalls and new phones, sealed with the screen lock |
| Signed-out key stays on the phone | "Sign out and remove from this phone", which erases it |

## Honestly

What is built is real encryption, correctly used, with tested primitives —
the round trip, tamper rejection and nonce uniqueness are all covered in
`app/test/message_crypto_test.dart`. It raises the cost of a database leak from
"read everything" to "read nothing".

It is **not** Signal, and it should not be described as though it were. The
README says direct messages are encrypted and links here rather than claiming a
guarantee this design does not make.
