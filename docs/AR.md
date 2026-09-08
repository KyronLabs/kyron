# AR lenses

The create menu has had an **AR Lens** entry since the beginning. Until now it
opened a screen that said lenses were not built and kept the camera closed —
honest, and empty.

There is a camera behind it now. This document says exactly what a "lens" is
here, because the phrase promises more than what is built.

## What it is

A lens is a **colour transform**. Each is a 4×5 colour matrix, applied to the
live preview and baked into the file that gets attached to the post.

Seven ship with the app -- None, Mono, Warm, Cool, Faded, Punch, Noir -- and the
camera adds whatever else the published catalogue carries. A lens is twenty
numbers, so a new one is a line of JSON rather than a release:
[LENS_FORMAT.md](LENS_FORMAT.md). The bundled seven cannot be replaced or
removed by a published file, and every failure to load one ends with those
seven still working.

Both come from the same `Lens.matrix`. That is the point of the design rather
than an implementation detail: a lens that looks one way in the viewfinder and
another in the saved photograph is the obvious way for this to be wrong, and
one definition of what a lens is makes it impossible.

The screen does the ordinary camera things too — front and back, a shutter, and
it lets the camera go when the app is backgrounded, because a camera held in
the background is one another app cannot open and a green dot on the status bar
for a screen nobody is looking at.

## And there is tracking now

A lens can also hang a picture on a face. MediaPipe's face mesh runs on the
device and returns 478 landmarks; a lens says *what* to hang, *where*, and
*how big*, and the app works out the rest.

Size is stated in pupil-gaps rather than pixels — `2.6` means 2.6 times the
distance between the irises. That distance is the one measurement that keeps
meaning the same thing as a head turns, so a lens written once is right at any
distance from the camera, on any face, at any resolution.

Tracking runs only while a lens actually needs it. Inference on every frame for
a lens that ignores the answer is somebody's battery spent on nothing.

## And the face itself can change

Schema 3 does something a sprite cannot: it changes what is already in the
picture. Two effects, and they are the same mechanism underneath -- **a masked
blur of what is there, with a colour over it**.

`fill` covers a region with skin sampled off that same face, which is what
takes somebody's nose and mouth out of a photograph. `frost` etches the whole
frame and leaves one region sharp, which is glass with a slot at the eyes.

The blur is the part that matters and it was arrived at the hard way: letting
the sharp original through at partial opacity does *not* erase a nose. At the
shading level that looked right it changed 31,927 pixels and still read as an
unmodified face, nostrils and lips plainly visible. Blurring what shows through
keeps the shape of a face without keeping its features.

A fill has no colour in it. A skin tone written into a lens belongs to one
person and is a sticker on everybody else, so `SkinSampler` measures it --
forehead and cheekbones, in pupil-gaps from the anchor, middle half by
brightness averaged so a fringe or a highlight does not drag it. No reading
means the fill draws nothing, rather than guessing at somebody's skin.

## What it is still not

**Flat pictures, not objects.** An attachment is a sprite placed and rotated in
two dimensions. A head turning to the side is exactly where that stops being
convincing, and where a real mesh becomes necessary.

**No expression.** The tracker reports 52 blendshapes — `jawOpen`,
`mouthSmileLeft` — and nothing consumes them yet.

**No occlusion.** Glasses arms draw over the head rather than disappearing
behind it, which is the single biggest difference between "stuck on" and
"there".

**No planes or markers.** Nothing is placed in the room. This is face tracking,
not world tracking.

**No video.** Stills only. The shutter takes a photograph; there is no record
button.

**No warping.** Nothing moves a pixel to a different place -- no bulge, no
stretch, no swapped faces. Schema 3 brought blur, but as two named effects over
a region from a list of three, not as something a lens describes for itself. A
lens that could describe its own would be a fragment shader, which is a
stranger's program running on somebody's phone. See
[LENS_FORMAT.md](LENS_FORMAT.md).

## What is checked, and what is not

Worth being precise about, because the environment this was built in has no
camera and no phone attached to it.

**Checked, by running it:**

- Every lens matrix, applied to known pixels and read back. Mono weights
  luminance the way an eye does rather than averaging the channels; Warm and
  Cool move a neutral grey in opposite directions; Faded lifts black off the
  floor; Punch increases channel separation without clipping. In
  `test/lens_test.dart`.
- Encoding the result to PNG bytes the composer accepts, by its file signature.
- The screen with no camera available: it says so, offers Try again, keeps the
  shutter inert, and hides the switch-camera button. In
  `test/ar_lens_screen_test.dart`.
- The rendered frame, looked at. That is what caught the failure state being
  invisible — the viewfinder is black in either theme, and the empty state took
  its colours from the app theme, so on a light-themed phone the message was
  dark grey on black.
- That it compiles into an Android APK with the camera plugin in it.
- The placement arithmetic, against a real detection: 478 landmarks from
  MediaPipe's own test portrait, run through `FaceAnchor` and checked against a
  separate implementation in Python to within a tenth of a pixel. Then
  rendered, and looked at -- the glasses land on the eyes and stay there
  through a 60-degree sweep of head roll.
- **The effects, measured rather than eyeballed.** Detail is the variance of
  the Laplacian over a region; a fill takes the mouth from 2215 to 2 while
  leaving the eyes above 2100, and frost takes the mouth to 2 while the eyes
  stay at 2378 of 2383. In `test/lens_effect_test.dart`, against a drawn face
  so no photograph is checked in. The published catalogue was then baked onto
  the real portrait and looked at, which is how the two shipped lenses were
  confirmed to be what was asked for.
- **The skin sampler**, including that it ignores hair across the forehead and
  a blown-out highlight on a cheekbone, follows a tilted head, and refuses
  rather than guesses when the face is half out of frame. Both camera plane
  layouts are decoded from hand-built buffers. In `test/skin_sampler_test.dart`.

**Not checked, because it needs hardware:**

- **Any of the tracking, live.** Frame rate, jitter, how far the overlay lags
  the preview, and whether dropping frames while inference is busy keeps it in
  step. All of it is written to fail safely -- no face means nothing drawn --
  but none of it has been seen running.
- **The live effects.** `LensEffectLayer` leans on `BackdropFilter` to read the
  camera underneath it, and `RepaintBoundary.toImage` does not run one -- so
  the preview path cannot be rendered here at all. Only the baker, which draws
  the same effect from the same numbers into the saved file, is checked.
- **Yaw and pitch.** Rotating a photograph only produces roll.
- More than one face, or one in bad light.
- That the preview shows anything.
- That the shutter produces a file.
- Whether the permission prompt appears at the right moment and reads well.
- Frame rate with a filter on the preview.
- The front camera's mirroring.

Those need somebody to run it on a phone. Nothing below the plumbing is
guessed — the lens maths is exercised — but the camera itself has only been
compiled, not seen.

## If a lens looks wrong

`Lens.builtIn` in `app/lib/models/lens.dart` is the bundled set, and each
matrix has a comment saying what it is meant to do. Changing one changes the
preview and the saved file together. `test/lens_test.dart` asserts the
*intent* — that Warm goes warm — rather than exact pixel values, so a matrix
can be tuned without rewriting the tests, and a matrix that stops doing what
its name says will fail.

To see a change rather than guess at it, put it through the authoring tool
in [kyron-lenses](https://github.com/KyronLabs/kyron-lenses):

    python3 tools/lens.py preview lenses.json sample.png -o sheet.png

That renders identically to the app, which is checked rather than asserted --
48 of 48 probe pixels, against output captured from Flutter itself.

## Permissions

Android asks at the moment the screen opens, not at launch, so somebody who
never opens it is never asked. The camera is declared `required="false"` so the
app still installs on a device without one — where the screen reports it
plainly instead of the Play Store hiding Kyron from that device.

iOS carries `NSCameraUsageDescription`; a build that touches the camera without
one is rejected.
