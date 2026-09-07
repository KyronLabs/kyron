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

**Sealing.** To write in a conversation the app fetches the members' public keys
(`GET /keys/conversation/:id`), derives a shared secret per key with X25519, and
runs it through HKDF-SHA256 — the raw exchange output is not uniformly
distributed and feeding it straight to a cipher is the classic way to weaken an
otherwise sound scheme.

The message is sealed with **XChaCha20-Poly1305**, an AEAD: a changed byte is a
refusal, not a different plaintext. The nonce is fresh per message, drawn from
the platform's secure source.

**On the wire.** `k1.<nonce>.<ciphertext>.<mac>`, each part base64url, in the
same column a plain message used. The `k1` prefix is a version — a scheme that
cannot be changed is one that has to be right first time.

**Reading.** The app tries each shared secret it holds. Anything that does not
parse as a sealed message is a plain one and passes through untouched, which is
what everything written before this existed looks like.

## What it does not protect

### One key per install

A key belongs to a device, not an account. Consequences:

- **A second device cannot read what the first received.** Sign in on a tablet
  and the history stays unreadable there.
- **Losing the device loses the history.** There is no key backup and no
  recovery. Signing out deletes the secret half deliberately: it is that
  device's identity and it leaves with the account that made it.
- **Only the first key is used when sealing.** Somebody with a phone and a
  tablet has two published keys; a message is currently sealed under one, so it
  arrives readable on one device and not the other. Sealing per device needs the
  wire to carry several ciphertexts, and that is the next change.

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
- **Metadata is not, and cannot be.** The server knows who is talking to whom,
  how often, at what times, and how long each message is. That is what it needs
  to route and page conversations at all.
- **Push notification text is not.** A push carrying the message body goes
  through Google's servers as plaintext. When both sides have keys the push
  should say only that a message arrived; that is not wired yet.
- **Nothing is sealed unless both sides have published a key.** A conversation
  with somebody on an older build sends as it always did. The bubble carries a
  lock when the message was sealed, so the reader is told which they got rather
  than left to assume.

## What would close each gap

| Gap | What it needs |
|:--|:--|
| One device only | Seal per recipient key; carry several ciphertexts on the wire |
| No forward secrecy | A double ratchet. Large, and the right eventual answer |
| No verification | Fingerprint comparison in the UI, and a warning when a key changes |
| Attachments in the clear | Encrypt the file before upload; the key travels in the sealed message |
| Push carries plaintext | Send only "a message arrived" once keys are present |
| No backup | A recovery phrase the user writes down, encrypting the secret half |

## Honestly

What is built is real encryption, correctly used, with tested primitives —
the round trip, tamper rejection and nonce uniqueness are all covered in
`app/test/message_crypto_test.dart`. It raises the cost of a database leak from
"read everything" to "read nothing".

It is **not** Signal, and it should not be described as though it were. The
README says direct messages are encrypted and links here rather than claiming a
guarantee this design does not make.
