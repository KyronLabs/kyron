# AR lenses

The create menu has had an **AR Lens** entry since the beginning. Until now it
opened a screen that said lenses were not built and kept the camera closed —
honest, and empty.

There is a camera behind it now. This document says exactly what a "lens" is
here, because the phrase promises more than what is built.

## What it is

A lens is a **colour transform**. Each is a 4×5 colour matrix, applied to the
live preview and baked into the file that gets attached to the post.

Seven colour lenses ship with the app -- None, Mono, Warm, Cool, Faded, Punch,
Noir -- alongside four pairs of 3D glasses (below), and the
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

## Whether the detector is fair, and whether it is the best one

Asked directly: *"is that face detection thingy really working or is it just
outright racist? I'm a person of colour and it's not capturing my face well."*

The honest answer has three parts.

### The model is measurably worse on dark skin, and that is real

MediaPipe's face detector (BlazeFace, which finds the face the mesh is then
fitted to) does not perform equally across skin tones. Google's own model card
says accuracy varies by skin tone and reports it as a known limitation. This is
not unique to MediaPipe — it is the normal state of face detection, and it
comes from training data that is not evenly distributed. Nothing in this
repository fixes that, and pretending otherwise would be worse than saying it.

### But on a phone, most of the gap arrives before the model does

A phone's automatic exposure meters the whole scene and brings its average to
mid grey. Put anything bright behind a face — a window, a lamp, a pale wall —
and the meter brings the exposure down, and the face with it.

On light skin the face still lands in the middle of the sensor's range with
contrast to spare. On dark skin the same scene puts it in the bottom stop or
two, where there is very little contrast left and a good part of what remains
is sensor noise. The detector is then being asked to find a face in a
near-black, noisy patch. It does worse — and it would do worse on *anybody's*
face given that patch.

So the experience of "it doesn't see my face" is the model's bias and the
camera's metering compounding, and the metering part is the larger and the
fixable one. `ExposureMeter` fixes it:

- The exposure and focus points are set to the middle of the frame the moment
  the camera opens, which is where a head is when somebody holds a phone up.
- Every frame, the light **on the face** is measured — inside the face, not on
  a box that takes in the wall behind it — and the camera is asked for the
  exposure compensation that would put it where a face belongs.
- Before a face has been found it meters the middle of the frame anyway,
  because an underexposed face is the likeliest reason there is no face and
  waiting for a detection first would wait forever.
- Corrections are in stops, not fractions: a face at 0.12 is nearly two stops
  under, and a linear correction would offer it a third of one.

The three confidence thresholds were also left at their 0.5 defaults, and are
now 0.3 / 0.25 / 0.3. A poorly-exposed face scores in the thirties and forties
on frames where a well-lit one scores over 0.9, and at 0.5 every one of those
frames was thrown away. What 0.5 bought was fewer false positives, and a false
positive here is a pair of sunglasses briefly landing on a door handle.

### Is it the best detector available?

For what this app needs — 478 three-dimensional landmarks including irises, on
device, in real time, on both platforms, with no per-user licence — MediaPipe
Face Mesh is the standard choice and close to the best of them. The
alternatives, and what each would actually buy:

| | What it would give | What it would cost |
|:--|:--|:--|
| **ARKit `ARFaceAnchor`** | Genuinely better, and much better in poor light: it uses the TrueDepth projector rather than the image, so skin tone stops mattering almost entirely. | iOS only, and only on phones with TrueDepth. Nothing for Android. |
| **Apple Vision** | Better detection on iOS than BlazeFace, helped by the ISP's own face metadata. | iOS only, 76 two-dimensional landmarks — fewer than this needs, and no irises. |
| **ARCore Augmented Faces** | 468 points, essentially this same mesh. | Android only. Strictly less than what is here, on one platform. |
| **ML Kit face detection** | The same BlazeFace detector. | 133 contour points, no irises. Strictly less. |
| **Snap Camera Kit, Banuba, DeepAR** | Better. This is what Snapchat itself runs, and it is better in low light and at extreme angles. | Commercial licence, a signed developer agreement, and tens of megabytes in the binary. |

The one that would genuinely beat it is ARKit's depth path on iPhones that have
it — worth adding as a platform-specific route later, with MediaPipe as the
fallback everywhere else. That is a real piece of work and it is not done.

Until then: the model is what it is, the exposure is fixed, and the thresholds
are set for recall rather than for a false-positive rate that does not matter
in a camera toy.

## Glasses in three dimensions

The built-in Specs, Aviator, Shades and Cat-eye are not pictures. Each is a
frame described by a style and three colours (`GlassesModel`), built as
geometry in pupil-gaps and drawn by `GlassesPainter` against the head's full
pose: yaw, pitch and roll.

The pose (`HeadPose`) comes from the landmarks' own depth. MediaPipe reports a
`z` for every point. Outer eye corners give the axis across the face, brow to
chin gives the axis down it, and their cross product gives the direction the
face points. It is plain arithmetic, so it is tested against the real detection
in `test/face-detection.json`, turned ±40° in code. The tracker's native
`estimateGeometry` would do the same job, but it could only be checked on a
phone.

What makes a pair read as worn rather than stuck on:

- a soft shadow on the face under the frame;
- perspective, so the near lens is larger than the far one;
- a reflection band that slides across the lenses as the head turns;
- shaded rims (a lit edge on acetate, a brushed gradient on metal);
- arms that run back to the ears, **depth-tested point by point** against the
  face mesh. The near arm shows along the side of a turned head; the far one
  goes behind it. Clipping to the face's outline was tried first. It hid the
  near arm exactly where it should show.

They are built-in only. The wire format does not carry a model yet:
`format-vectors.json`, which the app and the catalogue both run, refuses
schema 4, and that is a format decision for kyron-lenses rather than one to
slip in here. `specs` shares its id with the flat catalogue lens. The app
prefers its own copy, so new builds draw the 3D pair and older ones keep the
picture.

## Where things land, and why it used to be off

On Android the camera streams landscape frames from a sensor mounted on its
side. The tracker is told the rotation and returns landmarks normalised to the
**upright** picture. The screen multiplied those by the **raw** landscape size,
which stretched x by the long side and y by the short one. The result:

- the head's tilt came out about half what it was;
- the pupil gap grew as the head leaned;
- frost and fill were drawn as skewed boxes near the face rather than on it;
- the preview and the saved photo disagreed, because the photo is portrait and
  was right.

`SkinSampler.uprightSize` and `SkinSampler.upright` fix both halves: the size
everything is normalised to, and reading raw pixels at upright coordinates for
the exposure meter and skin sampling.

## The screen

Laid out the way Snapchat, TikTok and RedNote lay out a camera, because that is
the layout people already know. There is no title bar. The picture is a card
with rounded corners and the controls float on it; the shutter and the strip
sit on a black floor underneath, as tight as they go.

- **The lenses run through the shutter**, on both sides of it. Swiping changes
  lens as it goes, every tile snaps to the middle, and tapping a tile slides it
  there. **The shutter is drawn, not a button.** Every touch goes to the strip,
  and the strip's middle tile is the button. That is what lets a swipe that
  starts on the shutter move the strip. When it was a button laid on top, the
  strip never saw a finger that landed on it.
- **The ring is the selection.** It sits a hairline outside the middle tile:
  white for photo, red for video, with a red arc running round it while
  recording.
- **The front camera opens first.** Double-tap the picture to flip. The flash
  button appears on the back camera.
- **Photo and Video** sit under the shutter. In Video, tap to start and stop or
  hold to record. Recordings stop at 60 seconds, and the strip is locked while
  recording so each clip has one lens.
- **Capture opens the composer** with the photo or video attached.
- **What is saved is what was on screen.** It is cropped to the part of the
  frame the card showed. On Android, front-camera photos and videos are also
  mirrored back, because the platform returns them the way the sensor saw them.

## Lenses on video

The camera records the picture as it is. The lens is put in afterwards,
from the poses recorded alongside the clip:

1. While recording, the frames that track the face come from the recording
   itself (`startVideoRecording(onAvailable:)`). Each one adds the
   landmarks, and the skin reading for a fill, to a `LensVideoTimeline`.
   That is about 15 samples a second, plus every moment a face arrives or
   leaves.
2. When the clip stops, `LensVideoBaker` draws each sample as a transparent
   PNG with the preview's own painters: glasses, pictures, a fill's skin.
   Effects also get a mask, white wherever the picture is blurred.
3. On Android, `LensVideo.kt` hands the clip to **Media3 Transformer** with a
   single shader. The shader applies the colour matrix, blurs and washes
   wherever the mask is white, and lays the drawing over the top. Media3's
   own `Crop` and a mirror follow. Audio passes through untouched. The
   whole job runs on the GPU and the phone's own H.264 encoder.

**Why not FFmpeg.** An earlier version used FFmpegKit, the LGPL "min" build.
It worked, but it added about 15 MB to every APK and failed the size budget
in `scripts/check-apks.sh`. Media3 is AndroidX, and the app already ships
1.9.2 for `video_player`; Transformer and the effect library add little on
top. The shader is the only new code that runs.

**What is checked, and how:**

- `test/lens_video_test.dart` checks the job the camera sends: that the
  pictures land on the eyes, that they are blank when the face is gone, the
  frost mask, the blur and wash numbers, crop and mirror, and that a lens
  which changes nothing skips the bake.
- `tools/lens_shader_check.mjs` runs the shader from `LensVideo.kt`,
  unchanged, in headless Chromium's WebGL. WebGL 1 is the same GLSL ES 1.00.
  It runs against those jobs and reads the pixels back: glasses darken the
  eye, the frame is not flipped, frost smears the edges but leaves the eyes
  sharp and lifts the tone, and mono matches Flutter's grey.

  The check reproduces Media3's texture conventions: frames have their
  origin at the bottom left, and bitmaps are uploaded with their first row
  at the bottom and alpha premultiplied, the same flip Media3's own
  `BitmapOverlay` applies.

**What is not checked here:** that Media3 drives the program as described,
and the encoder on any given phone. Those need a device.

**If a bake fails,** the clip is posted as filmed, with a note saying the
lens could not be added. Losing the recording would be the worse failure.
iOS has no implementation yet. It keeps the plain clip and says so; the
same job maps onto AVFoundation with Core Image filters.

**Cost.** Putting a lens in takes time after a clip stops. Pictures are drawn
at three-quarters of the frame and masks at three-eighths, and then the
whole clip is re-encoded. How long that takes on a real phone has not been
measured yet. An "Adding your lens…"
overlay covers the wait.

## What it is still not

**Glasses from the catalogue.** See above: a format decision first.

**No expression.** The tracker reports 52 blendshapes — `jawOpen`,
`mouthSmileLeft` — and nothing consumes them yet.

**Occlusion by the face mesh only.** The arms hide behind the face and the
far side of the head. Hair and ears are not in the mesh, so the hook behind
the ear is simply never drawn.

**No planes or markers.** Nothing is placed in the room. This is face tracking,
not world tracking.

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

**Seen on a phone, in closed testing (October 2026):**

- **Tracking runs live.** A face lens finds the face and hangs its pictures on
  it. It still needs work; how much, and where, is for the testers to say.
- **And it found a bug nothing here could have.** A face lens could track
  nothing until a colour lens had been picked and the face lens picked again.
  Tracking started only when a lens was picked, and the flag saying frames
  were streaming outlived the camera they streamed from: the camera is let go
  whenever the app steps back -- a notification shade pulled down, a call --
  and replaced when the lens is flipped, and the
  replacement came back with the flag still set and no frames. A face lens
  picked before the camera had opened started nothing at all. Picking a
  colour lens was the one path that cleared the flag. Now the flag goes with
  the camera, and a camera that opens with a face lens chosen starts tracking
  it.
- **Found beside it, by reading rather than on a phone:** coming back to the
  app never reopened the camera it had let go. The handler returned early
  whenever there was no camera -- and having let it go, there never was -- so
  the viewfinder would spin until the screen was left. It reopens now. Worth
  confirming on a phone: pull the shade down over a lens and let it go.

**Not checked on a phone yet:**

- Frame rate, jitter, how far the overlay lags the preview, and whether
  dropping frames while inference is busy keeps it in step. All of it is
  written to fail safely -- no face means nothing drawn.
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

Those need somebody to look for them on a phone. Nothing below the plumbing
is guessed — the lens maths is exercised — and the camera has now been seen,
but only the tracking and the bug above were reported back from it.

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

The microphone is asked for only on switching to Video. A photo never needs
it, so the camera opens without audio until a recording is wanted.
