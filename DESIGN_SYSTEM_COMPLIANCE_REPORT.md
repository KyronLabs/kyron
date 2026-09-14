# Kyron app against the Kyron design system

Measured on the app's `lib/` — 235 Dart files — against
[`KyronLabs/design-system`](https://github.com/KyronLabs/design-system),
specifically `frontend/philosophy.md`, `frontend/components/buttons.md` and
the four files under `design-tokens/`.

Every number below came from counting the source. Nothing here is an
estimate, and nothing is marked done that a test does not hold in place.

## What the previous version of this file said

It opened with **"Compliance Status: ✅ FULLY COMPLIANT"** and listed, among
its fixes, `#4C8FFF → #006AFF ✅ Fixed`.

That was false, and measurably so. At the time it was written the accent
shipping in every one of the app's accent-coloured controls was `#4C8FFF`.
`primary_500` — the token the design system names as the accent, `#006AFF`,
labelled `DEFAULT ACCENT` in the ramp — was referenced zero times. The two
differ enough to matter: on white, `#4C8FFF` measures **3.14:1** and
`#006AFF` measures **4.66:1**, so the accent that shipped failed WCAG AA for
text and the documented one passes.

The file also described changes to an `app_theme.dart` that the app no
longer has; the themes moved into the design system package.

A compliance report that says "fully compliant" and is wrong is worse than
no report, because it stops anybody looking. This version states what is
measured, what is not done, and what is deliberately excepted.

## Status

| Rule | Source | Measured | Held by |
|---|---|---|---|
| Type comes from the modular scale | `design-tokens/typography.md` | **0** raw `fontSize:` literals, 249 token uses | `app/test/design_system_test.dart` |
| Icons are Iconsax, not Material | `philosophy.md` don't #8 | **0** `Icons.*`, 419 `Iconsax.*` | `app/test/design_system_test.dart` |
| The accent is `primary_500` | `color-usage.md` | `#006AFF` in all three themes | design-system `theme_test.dart` |
| No Material ink ripples | `philosophy.md` don't #7 | `NoSplash` on all three `ThemeData` | design-system `theme_test.dart` |
| A container states its own foreground | Material 3 | FAB and `primaryContainer` pairs ≥ 4.5:1 | design-system `theme_test.dart` |
| Motion comes from the scale | `philosophy.md` | 9 of 9 UI transitions on 90/180/260/420 | not guarded — see below |
| Touch targets ≥ 44×44 | `guidelines/accessibility.md` | fixed where found; not swept | `interest_tabs_test.dart` for the tab strip |
| Spacing from the 2…40 scale | `design-tokens/spacing.md` | swept in the widgets touched; not app-wide | not guarded |

## Not done

**Touch targets have not been swept.** Three were found by looking and
fixed — the interest strip's add button (40×32), its tab pills (36 tall in a
44 strip, with the band around them dead to the finger), and the community
page's banner controls (40). There is no measurement of the rest. Doing it
properly means rendering each screen and measuring every gesture target,
which is a real piece of work and has not been done.

**Spacing is not guarded.** The widgets touched in this round are on the
scale. The rest of the app has not been counted, and unlike `fontSize:`
there is no syntax that reliably distinguishes a spacing value from a
width, a height, a fraction or an offset, so a source-level guard would
mostly produce false positives.

**Motion is not guarded**, for the same reason: `Duration` is used for
animations, debounces, sampling loops, retry backoff and how long a toast
stays up, and only the first belongs on the motion scale.

## Deliberate exceptions

These are off-token on purpose. Each was read before being left alone.

| Where | Value | Why |
|---|---|---|
| `post_actions_row.dart` | 620ms | The like burst. Its own comment: long enough for the sparks to travel and go, short enough that a second tap never waits on the first. The scale's slowest step is 420. |
| `skeleton.dart` | 1400ms | The shimmer cycle — ambient, not a transition. |
| `toast.dart` | 2600ms | How long a toast stays up, not how it moves. Its motion is `MotionTokens.fast`. |
| `mention_picker_sheet.dart`, `search_provider.dart`, `gif_picker_sheet.dart` | 250 / 300 / 350ms | Search debounces. `philosophy.md` itself specifies 350ms for coalesced writes. |
| `voice_recorder_sheet.dart` | 100ms | Loudness sampling — ten readings a second. |
| `inline_video.dart` | 220 / 450ms | A decoder settle threshold and a retry backoff. |
| `google_button.dart` | 6 hex literals | Google's sign-in branding, which may not be themed. |
| `post_action_colors.dart` | 4 hex literals | Like, repost, save, highlight. Semantic action colours with no home in the ramps yet; centralised in one file so they can move when the design system grows one. |
| `browser_palette.dart` | 12 hex literals | Documented in the file: several `colorScheme` roles this chrome needs are not distinct in these themes, so reading them gives an invisible interface. Every value is a token or derived from one. |
| `ar_lens_screen.dart` | 5 hex literals | A skin-tone-to-sky gradient in the lens preview. A picture, not an interface colour. |

## What changed to get here

In the app:

- 175 font sizes moved onto the scale across 64 files. 150 of them were not
  on it at all — 10, 12, 14, 17, 18, 22 — so text across the app sat a
  point or two off everything around it.
- 20 Material icons across 14 files swapped for Iconsax, each mapped to the
  glyph the app already uses for that meaning.
- 9 UI transitions moved onto 90/180/260/420. The 19 remaining `Duration`
  literals are the exceptions above.
- The home screen's interest strip was rebuilt. It never imported the design
  system: every colour was a hex literal written twice, once per brightness,
  nine of them the old accent. It also offered twelve hashtags written into
  the file — `#SnowLeopard`, `#MemeEconomy`, `#HotTakes` — none of which had
  to exist, so adding one could hand the reader a tab with nothing behind
  it. It reads `feed/trending/tags` now.
- `ThreadGeometry.gutter` replaced a bare `10` that appeared twice: once in
  the thread row and once in the skeleton standing in for it.

In the design system:

- `accent` and `primary[500]` are one named constant. They were two literals
  that had drifted, because a map lookup is not a constant expression and so
  the two could not reference each other.
- `splashFactory: NoSplash` moved onto `ThemeData`. It had been set on four
  button themes only, so every bare `InkWell` fell through to Material 3's
  default and spread an ink ring on press.

## Reproducing the measurements

```
cd app && flutter test test/design_system_test.dart   # type and icons
cd flutter && flutter test                            # design-system tokens
```

The two source rules are also checked by reverting them: putting one
`fontSize: 15` or one `Icons.favorite_border` back fails the suite and names
the file and line.
