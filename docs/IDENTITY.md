# Portable identity

Every account can hold a `did:key` — a decentralised identifier that it has
proved, cryptographically, that it controls.

This document is mostly about what that does **not** yet give you, because the
README has sold portable identity as the reason Kyron exists and the honest
position is narrower than that.

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

### It is not portable yet

This is the honest headline. The identifier is yours and provable, and that is
the foundation — but nothing consumes it. There is no export, no federation, no
second server that would recognise it, and no protocol that would carry your
posts to one. **Today it identifies you to Kyron and to anybody you show it
to, and that is all.**

### It is per install, and there is no recovery

Same trade as the message keys, for the same reason: the secret is generated on
the device and never leaves it. Consequences:

- **Reinstalling gives you a different identifier.** The old one stays on the
  account until the new one replaces it.
- **A second device does not share it.** Signing in on a tablet makes a second
  key and claims a second identifier.
- **Losing the device loses the identifier.** There is no backup and no way to
  prove you were the person who held it.

That last one is the gap that matters most for anything calling itself
portable: an identity you cannot carry to a new device is not one you can carry
to a new server either. The fix is a recovery phrase the holder writes down,
which is the same fix the encryption chapter needs and is not built in either.

### Nothing signs anything else

The key proves the identifier and then goes back in the drawer. Posts are not
signed, so nothing about your content is verifiable away from Kyron's database.
A signed export is the obvious next step and would be the first thing that made
"portable" literally true.

### No key rotation

Claiming a new identifier replaces the old one on the account, and nothing
records that the two were ever the same person. A real method handles this —
`did:plc` keeps a signed history of key changes precisely so an identity can
survive one.

## What would close each gap

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

It is **not** portable identity, and the README should not say it is until
something can actually carry an account somewhere else. It is the first piece
of that, and the smallest piece that is honestly true.

## Also fixed here

`POST /identity/users` and `GET /identity/users/:id` were on the open internet:
the first created a `User` row for anyone who asked, the second answered with
that user's email address. Nothing in the app called either — accounts come
from Supabase and the auth guard provisions the local row. They are deleted
rather than guarded, because a way to create accounts outside the identity
provider should not exist at all.
