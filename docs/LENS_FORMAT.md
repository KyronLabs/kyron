# Lenses, from the app's side

The format is in the repository where lenses are written:
[KyronLabs/kyron-lenses](https://github.com/KyronLabs/kyron-lenses) --
`docs/FORMAT.md` there is the rules, the tool, and how to publish. There is no
copy here on purpose: two documents about one format is how they end up
disagreeing.

This is the half that is about *this* app.

## Where the lenses come from

Seven are compiled in, in `Lens.builtIn`. The rest are fetched from the
published catalogue:

    https://kyronlabs.github.io/kyron-lenses/lenses.json

`LensCatalogue.catalogueUrl`, overridable at build time with
`--dart-define=KYRON_LENS_CATALOGUE=...` so a staging build can point
elsewhere. Empty disables fetching and leaves the built-ins.

The published file carries only what the app does *not* already bundle.

## What the app guarantees, whatever is published

1. **Built-ins always win.** They cannot be replaced or removed by a published
   file. A catalogue that redefined `mono` would change what somebody's
   already-taken photographs look like; one that shipped an empty list would
   empty the strip.
2. **Cache before network.** The strip draws from disk immediately and the
   fetch refreshes it for next time. A camera that waits on a request before
   showing a lens is a slow camera.
3. **Every failure ends at the built-ins.** No network, bad JSON, a 500, a file
   over 512 KB -- all of them leave seven working lenses. One unreadable entry
   costs one lens, not the catalogue.

So a mistake in the catalogue degrades; it does not break a camera. That is
what makes publishing one safe enough to do without a release.

## Two implementations of one set of rules

`Lens.tryParse` here, and `lens.py` in the other repository, apply the same
validation. They have to agree: a lens that passes the tool, gets published,
and is then dropped by the app leaves its explanation in a log line on a
stranger's phone.

Each side is tested against its own rules -- 23 tests here in
`test/lens_catalogue_test.dart`, `lens.py check` in that repository's CI -- but
nothing automatically compares the two across the repository boundary. **When
you change one, change the other.** That is a discipline rather than a
guarantee, and it is worth knowing which it is.

## Why a lens is safe to download at all

It is twenty numbers. There is no shader to compile and nothing to execute, so
the worst a hostile file can do is look ugly. That is a property of the format
being a colour matrix, not of any checking done here -- and it is why the
validation is about catching nonsense rather than preventing harm.

The moment a lens can do something a colour matrix cannot -- blur, warp,
tracking, an overlay image -- that stops being true and the whole question of
downloading one has to be asked again. See [AR.md](AR.md).
