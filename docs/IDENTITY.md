# The account identifier

Every account can hold a `did:key` — a decentralised identifier that it has
proved, cryptographically, that it controls.

This file used to be called *Portable identity*, and was mostly about what the
identifier did **not** yet give you, because the README had sold portable
identity as the reason Kyron exists. That question is now settled.

## The decision: stop here

**Decided on 11 October 2026. Kyron keeps the identifier as a verifiable
account fingerprint and is not building portable identity.** No recovery
phrase, no signed posts, no export, no federation. What is described under
*What is built* stays, works, and is all there is.

The roadmap had laid out two paths — carry on, or stop — and this is why it
is the second:

- **Portability needs somebody on the other end.** An export is only
  portable if another server reads it. No such server exists, and building one
  is designing a federation protocol. The protocol people mean when they say
  this, AT Protocol, has its own identity method (`did:plc`), so a Kyron
  `did:key` would not have been recognised there either without adopting its
  whole stack.
- **Every step towards it is a cost now and a benefit later.** A recovery
  phrase is real work and a real support burden — a phrase somebody loses is
  an account nobody can prove they own. Signed posts mean a key on every
  device that composes. None of it is visible to a person using the app today.
- **The app had not shipped.** Every week spent on the identity layer was a
  week the thing people would actually use stayed in debug builds. It is in
  closed testing now (October 2026), which is the reason this held, not a
  reason to reopen it.

What Kyron *is* is true today without any of it: an open-source social app you
can run yourself, with a ranking engine anybody can read. That is the
positioning, in the README and everywhere else.

### What would reopen it

A concrete consumer, not an aspiration. The most likely one is the
positioning itself: somebody running their own Kyron who needs to move an
account between two instances. That is a real reason to build a signed export
and the recovery that has to come before it — and it would come with a reader
on the other end, which is exactly what is missing now. Anything that would
only make portability possible *in principle* is not a reason.

## What is built

**The identifier is a public key.** A `did:key` is not a name in a registry;
it is an Ed25519 public key, multicodec-tagged and base58-encoded:

```
did:key:z6Mkk8HFsQVr2wXg51EssDiEzonMxgai8T5w2YtzTkVAjXW3
```

Anyone holding that string has everything needed to check a signature made
with the matching secret. No directory to query, no server to trust — not even
Kyron's.

**The key is made on the device.** On first sign-in, alongside the message
keypair, and written to the same secure storage the session token lives in. The
secret half never leaves.

**Claiming it requires proving it.** Anyone can type any identifier into any
field, so a stored DID means nothing unless the account demonstrated it holds
the key. The exchange:

1. `GET /identity/did/challenge` returns a 32-byte nonce and the exact string
   to sign — `kyron-did-claim:v1:<account id>:<nonce>`.
2. The app checks the string starts with that prefix, signs it, and sends the
   signature with the identifier to `PUT /identity/did`.
3. The server rebuilds the message from **its own** idea of who is asking,
   verifies the signature against the key inside the identifier, and only then
   writes the column.

The account id is inside the signed message, so a proof made for one account
does not count for another. The nonce is spent by one attempt — successful or
not — so a live challenge cannot be ground against. The prefix check on the
client is what stops this being a signing oracle: an identifier is only worth
something because its holder signs nothing it did not mean to.

The two implementations are checked against each other, not only against
themselves: the client's tests build a DID from the key bytes the *server*
decodes out of the specification's published test vector, and a claim generated
in Dart was verified by the TypeScript verifier before this shipped.

## What it does not do

### It is not portable, and is not going to be

The identifier is yours and provable — but nothing consumes it. There is no
export, no federation, no second server that would recognise it, and no
protocol that would carry your posts to one. **It identifies you to Kyron and
to anybody you show it to, and that is all** — which, after the decision
above, is what it is for.

### It is per install, and there is no recovery

Same trade as the message keys, for the same reason: the secret is generated on
the device and never leaves it. Consequences:

- **Reinstalling gives you a different identifier.** The old one stays on the
  account until the new one replaces it. Signing out does not: the key is
  kept on the phone under the account's id, so signing back in keeps the same
  identifier, and another account signing in there gets its own. (It used to
  be deleted on sign-out, so every sign-in claimed a new one.) Deleting the
  account erases it.
- **A second device does not share it.** Signing in on a tablet makes a second
  key and claims a second identifier.
- **Losing the device loses the identifier.** There is no backup and no way to
  prove you were the person who held it.

That last one is the gap that would matter most for anything calling itself
portable: an identity you cannot carry to a new device is not one you can carry
to a new server either. The fix is a recovery phrase the holder writes down,
which is the same fix the encryption chapter needs. It is not built, and with
portability off the table it is the encryption chapter's to justify, not this
one's.

### Nothing signs anything else

The key proves the identifier and then goes back in the drawer. Posts are not
signed, so nothing about your content is verifiable away from Kyron's database.
A signed export would be the first thing that made "portable" literally true,
and is the first thing to build if this is ever reopened.

### No key rotation

Claiming a new identifier replaces the old one on the account, and nothing
records that the two were ever the same person. A real method handles this —
`did:plc` keeps a signed history of key changes precisely so an identity can
survive one.

## If it is ever reopened

Kept because the analysis is right even though the work is not planned. Each
gap, and what closing it would take:

| Gap | What it needs |
|:--|:--|
| Not portable | A signed export, and something on the other end that reads it |
| No recovery | A recovery phrase, encrypting the secret half |
| One device | Either the same recovery phrase, or a method with a key list |
| Nothing signed | Sign posts at composition; publish the key alongside |
| No rotation | A signed history of key changes — this is what `did:plc` is |

## Why `did:key` and not `did:plc` or `did:web`

`did:plc` needs a PLC directory to exist and be run by somebody. `did:web`
needs a domain you control, serving JSON at a well-known path, and the identity
dies with the domain. `did:key` needs nothing at all — which is why it could be
built now rather than described in a roadmap, and it is a real W3C method, not
a placeholder.

It is also the method with the least in it. That is the trade: everything in
the section above is a consequence of the identifier being nothing but a key.

## Honestly

What exists is a genuine decentralised identifier with a genuine proof of
control, replacing a nullable column and a hardcoded `did:plc:abc…` that Settings
copied to the clipboard — the same invented string for every account.

It is **not** portable identity, and nothing should say it is. It was built
as the first piece of that; it is kept as what it turned out to be — a
fingerprint anybody can verify without asking Kyron, which is useful in its own
right and makes no promise it cannot keep.

## Also fixed here

`POST /identity/users` and `GET /identity/users/:id` were on the open internet:
the first created a `User` row for anyone who asked, the second answered with
that user's email address. Nothing in the app called either — accounts come
from Supabase and the auth guard provisions the local row. They are deleted
rather than guarded, because a way to create accounts outside the identity
provider should not exist at all.
