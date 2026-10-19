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
  recovery phrase yet -- the Kyron Vault, below, is the design for one. Keys
  are no longer deleted on sign-out, but uninstalling the app deletes them,
  and on Android a development build and a Play build cannot replace each
  other without an uninstall.
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
| No backup | The Kyron Vault, below: every key the account has had, sealed under a key only the account's own unlockers can open |
| Signed-out key stays on the phone | "Sign out and remove from this phone", which erases it |

## Planned: the Kyron Vault

**Status: designed, not built.** Waiting on a domain (kyron.so) to tie passkeys
to the app. Nothing here is true of the app today.

### The problem it solves

A message is sealed for the device keys that existed when it was sent. Lose
every device that held one of those keys -- a reinstall, a new phone, a phone
in a river -- and the message is gone. "Waiting for this message" recovers it
only when another device that holds the key comes online, and on 18 October
2026 that was nobody: three messages had been sealed for the recipients'
installs, since wiped, and for the Google test device that sent them, since
thrown away.

### The rule no design gets round

To restore a key on a blank device, the device needs something only its owner
has. If Kyron's server could restore a key from the login alone, Kyron could
read the messages, and this would not be end-to-end encryption.

Every system that does this well -- WhatsApp's backups, Signal's PIN, iCloud
Advanced Data Protection, 1Password -- builds recovery from the same
ingredients: a device the owner still has, something they know, a credential
their platform syncs for them, or a server that cannot read what it guards
because tamper-proof hardware stops it. The vault offers several and needs any
one.

### How it works

**One Account Key per account.** 32 random bytes, made on the first device
that turns the vault on. No server ever sees it.

**The vault.** Every message key the account has ever had, on any device -- and
its identity (DID) key -- sealed under the Account Key with
XChaCha20-Poly1305, and stored on Kyron's server. Each entry's associated data
names the account and the entry, so the server cannot move an entry to another
account or pass one key off as another: it fails to open rather than opening
as the wrong thing. A device adds its own key to the vault when it makes one.

**Unlockers.** The Account Key is sealed again, separately, under each of the
account's unlockers. Any one of them opens it. The server stores these sealed
copies and can open none of them.

| Unlocker | What the owner does | What it trusts |
|:--|:--|:--|
| Passkey | Touches the fingerprint sensor or looks at the camera | The platform's passkey sync -- Google Password Manager, iCloud Keychain -- which is itself end-to-end encrypted under the screen lock |
| Another device | Points an old phone's camera at a QR code on the new one | Nothing: the key goes from screen to camera |
| Recovery code | Writes down 24 words, once | Nothing but the paper |
| Block Store (Android) | Nothing: restored with the phone | Google's backup, end-to-end encrypted under the screen lock |

- **Passkey.** A passkey made for Kyron's domain, with the WebAuthn *PRF*
  extension: asked with a fixed salt, the passkey returns the same 32-byte
  secret every time, computed inside the authenticator, and never reveals its
  private key. HKDF over that secret (`kyron/vault/v1/passkey`) is the key
  that seals the Account Key. Passkeys sync across the owner's phones,
  tablets and browsers, so a new phone signed in to the same Google or Apple
  account has it already. This is how WhatsApp's passkey-encrypted backups,
  launched in October 2025, work.
- **Another device.** The new device shows a QR code holding a one-time
  X25519 public key. The old device reads it with its camera, seals the
  Account Key for that key, and sends it through the server. The server
  carries it and cannot open it, and because the public key travelled by
  camera it cannot swap in its own.
- **Recovery code.** 256 random bits, shown as 24 words. Random enough that
  HKDF is all it needs -- no slow password hashing, because there is nothing
  to guess. Shown once, at setup, with the plain warning that whoever holds it
  can read every message.
- **Block Store.** On Android, the Account Key is also kept in Google Play
  services' Block Store, one entry per account. Google documents that Block
  Store survives an uninstall and reinstall when the owner has backup on, and
  moves to a new phone restored during setup. Backed up to the cloud only when
  `isEndToEndEncryptionAvailable()` says so -- Android 9 or later, with a
  screen lock -- because without that, Google could read it. Block Store
  checks the app's signature, so a development build and a Play build cannot
  read each other's.

**A new device.** Sign in. If the account has a vault, the app asks for the
easiest unlocker it has -- Block Store silently, then the passkey, then
"scan from your other phone", then the recovery code -- opens the Account Key,
downloads the vault, and every message sealed for any key the account ever had
opens at once. Nobody else has to be online. "Waiting for this message" stays,
for messages from before the vault existed.

**Several accounts on one phone.** One Account Key, one vault and one set of
unlockers per account, as message keys already are.

### Losing a device

The lost device knows the Account Key, so removing it makes a new one: every
vault entry is sealed again under it, every unlocker is sealed again, and the
lost device's message key is withdrawn so nothing new is sealed for it. The
passkey can be asked again on the spot. The recovery code cannot -- the device
doing this does not know it, and keeping something that could reseal it would
be keeping the code -- so **removing a device issues a new recovery code**,
and the old one stops working.

What the lost device could already read, it still can: its own key opens what
was sealed for it. Removing it closes the future, not the past. That is true
of every end-to-end system.

### What it does not do

- **It cannot recover from nothing.** No device, no passkey, no Block Store,
  no recovery code: the history is gone. The app says so when the vault is set
  up, not when it is too late.
- **No PIN.** A 4- or 6-digit PIN guarded only by Kyron's server is a PIN
  Kyron's server could try every value of in minutes, which is encryption in
  name only. Signal makes PINs safe by checking them inside secure enclaves
  that limit guesses even against Signal (Secure Value Recovery). If Kyron
  ever offers a PIN, that is the bar, and it is real infrastructure.
- **No new cryptography.** XChaCha20-Poly1305, X25519, HKDF-SHA256 and WebAuthn
  PRF, as they are. What is new is putting them together for a social app's
  direct messages, and the experience: "Welcome back -- touch to unlock your
  messages."

### What a server compromise gets

| Attacker | Gets |
|:--|:--|
| A database leak | Sealed vault entries and sealed Account Keys: nothing readable |
| An actively malicious server | Still not the Account Key. It can withhold the vault, or serve an old copy of it, which loses the keys added since -- a denial of service, not a disclosure |
| Somebody with the recovery code | Everything. It is a password, and is shown as one |
| Somebody in the owner's Google or Apple account, with their screen lock | The passkey, and so the vault: the same exposure as the rest of that account |

### Before it can be built

- **A domain.** Passkeys belong to a domain (the relying party). kyron.so
  would serve `/.well-known/assetlinks.json` for Android and
  `/.well-known/apple-app-site-association` for iOS, tying the app to it.
- **PRF where it runs.** Google Password Manager supports PRF on Android;
  third-party password managers on Android cannot offer it yet. iCloud
  Keychain supports it from iOS 18. Windows to be checked when this is built.
  Where PRF is missing, the device falls back to the QR code and the
  recovery code.

### Order

1. The vault, with passkey and recovery-code unlockers.
2. "Scan from your other phone".
3. Block Store, as the silent first try on Android.

## Honestly

What is built is real encryption, correctly used, with tested primitives —
the round trip, tamper rejection and nonce uniqueness are all covered in
`app/test/message_crypto_test.dart`. It raises the cost of a database leak from
"read everything" to "read nothing".

It is **not** Signal, and it should not be described as though it were. The
README says direct messages are encrypted and links here rather than claiming a
guarantee this design does not make.
