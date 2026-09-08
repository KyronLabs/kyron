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

## What it is not

**There is no tracking.** Nothing detects a face, a plane or a marker. Nothing
is placed in the scene. Every lens is a function of colour, applied to the whole
frame — so it will not put a hat on you, and calling it "AR" is generous.

The name is on the create menu already and the entry now does something rather
than nothing, which is better than it was. But this is a camera with filters,
and it should be described that way.

**No video.** Stills only. The shutter takes a photograph; there is no record
button.

**No shader effects.** A colour matrix cannot blur, warp, or do anything that
depends on neighbouring pixels. Those need a fragment shader, which Flutter
supports and this does not use.

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

**Not checked, because it needs hardware:**

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
