# Lenses, from the app's side

The format is in the repository where lenses are written:
[KyronLabs/kyron-lenses](https://github.com/KyronLabs/kyron-lenses) --
`docs/FORMAT.md` there is the rules, the tool, and how to publish. There is no
copy here on purpose: two documents about one format is how they end up
disagreeing.

This is the half that is about *this* app.

## Three kinds of lens

A **colour lens** is twenty numbers applied to every pixel. A **face lens**
hangs pictures on a tracked face (`"schema": 2`). An **effect lens** changes
the face itself (`"schema": 3`) -- a region filled with skin sampled off that
same face, or everything frosted except a slot across the eyes. A lens may be
all three at once, and the schema number is what stops a build that cannot
draw one from showing a chip that does nothing.

`Lens.needsFace` is what the screen reads to decide whether to run the tracker
at all -- inference on every frame for a lens that ignores the answer is
somebody's battery spent on nothing. It counts effects as well as attachments.

### The pieces here

| | |
|:--|:--|
| `models/lens_effect.dart` | What an effect is, and what the app refuses. |
| `models/face_region.dart` | A named region as a `Path`, from the mesh. |
| `widgets/lens_effect_layer.dart` | Drawing it: `LensEffectLayer` over the live preview, `LensEffectBaker` into the saved file. |
| `services/skin_sampler.dart` | The colour a fill uses, read off the face in front of the camera. |

Two implementations of the drawing, which is a cost worth naming. The preview
leans on `BackdropFilter` to read the camera underneath it; a `PictureRecorder`
has no backdrop to filter, so the still redraws the photograph blurred instead.
They are kept in step by both taking every number from the same `LensEffect`,
and only the baker can be checked here -- `RepaintBoundary.toImage` does not
run a `BackdropFilter`, so the live path is verified on a device or not at all.

### The colour is measured, never written down

A `fill` has no colour field. A skin tone in a lens file is one person's, and a
sticker on everybody else -- so `SkinSampler` reads it from five squares on the
forehead and cheekbones, placed in pupil-gaps from the anchor rather than at
remembered landmark indices. The middle half by brightness is averaged, which
drops a fringe across the forehead and a highlight on a cheekbone in the same
step. Between frames the reading is eased a quarter of the way so
auto-exposure does not make the fill flicker, and it is dropped when the face
is: the next person through the viewfinder is not this one.

If it cannot read a colour, the fill **draws nothing**. A guessed tone is worse
than an effect that visibly did not happen.

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

`test/format-vectors.json` is what keeps them honest. 106 cases -- 28 that
must be accepted, 78 that must be refused -- run by **both**
implementations. `test/lens_format_vectors_test.dart` runs them here;
`lens.py vectors` runs the same file over there.

It is canonical in kyron-lenses and vendored here, and CI compares this copy
against the published one, failing if the spec moved on without us. So a rule
added there breaks the build here until somebody confirms `Lens.tryParse`
agrees -- which is the point.

**Adding a rule means adding a case**, in the same commit.

The spec was checked against a deliberately broken implementation before being
trusted, and again when schema 3 was added: raising the effect limit on one
side alone failed `fx-too-many-effects`, and miscasing a region name failed
three cases, each naming exactly what disagreed. One thing it cannot cover is NaN, which JSON has no way
to write -- that stays in `test/lens_catalogue_test.dart`. What JSON *can*
carry is `1e400`, which overflows to infinity in both languages, and that is a
case.

## Why a lens is safe to download at all

Everything it can ask for is something this app already knows how to do: a
matrix, an anchor from a list of five, a region from a list of three, an effect
from a list of two. There is no shader to compile and nothing to execute, so
the worst a hostile file can do is look wrong. That is a property of the format,
not of any checking done here -- which is why the validation is about catching
nonsense rather than preventing harm.

It survived schema 3 on purpose. Blur is exactly the kind of thing a fragment
shader is for, and a downloadable shader is a stranger's program running on
somebody's phone. So the effects are **named** rather than described: a lens
picks `frost` and says how strong, it does not get to say what a blur is. The
day a lens can describe its own -- or warp a pixel to a different place -- the
whole question of downloading one has to be asked again. See [AR.md](AR.md).

An image asset is the one place a lens brings its own bytes, and a decoder is
real attack surface where a colour matrix was none. Hence HTTPS only, and the
4 MB ceiling on fetching one.
