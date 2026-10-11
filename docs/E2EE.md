# End-to-end encryption

Direct messages are sealed on the sending device and opened on the receiving
one. The server publishes public keys and carries ciphertext it has no key for.

This document is mostly about what that does **not** cover, because a
half-understood encryption feature is worse than none: people act on what they
believe it protects.

## How it works

**Keys.** Every install makes an X25519 keypair on first sign-in. The secret
half is written to the same secure storage the session token lives in and never
leaves the device. The public half goes to `PUT /keys` with an opaque device id.

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

### One key per install

A key belongs to a device, not an account. Consequences:

- **A new device cannot read what arrived before it existed.** Messages are
  sealed for the devices that were listed when they were sent. Sign in on a
  tablet and everything from then on reads there; the history before it does
  not.
- **Losing the device loses the history.** There is no key backup and no
  recovery. Signing out deletes the secret half deliberately: it is that
  device's identity and it leaves with the account that made it.
- **Stale keys linger.** An uninstalled app never withdraws its key, so it
  stays listed and keeps being sealed for, up to the cap, until the account
  signs out of it. Harmless — nobody holds its secret half — but it makes
  envelopes larger than they need to be.

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

### Not everything is sealed

- **Attachments are not.** Photos, video and voice go to storage in the clear.
  Only the text of a message is encrypted.
- **Reactions are not, by decision.** The emoji somebody reacts with is stored
  readable beside the sealed message it reacts to, so the server knows that
  Ada answered a message with 😂 without knowing what the message said. That
  was chosen over sealing them, for now, as the same trade attachments make;
  the two should be sealed together. The realtime event for a reaction still
  carries only ids, and the emoji is fetched over an authenticated request.
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
| No backup | A recovery phrase the user writes down, encrypting the secret half |

## Honestly

What is built is real encryption, correctly used, with tested primitives —
the round trip, tamper rejection and nonce uniqueness are all covered in
`app/test/message_crypto_test.dart`. It raises the cost of a database leak from
"read everything" to "read nothing".

It is **not** Signal, and it should not be described as though it were. The
README says direct messages are encrypted and links here rather than claiming a
guarantee this design does not make.
