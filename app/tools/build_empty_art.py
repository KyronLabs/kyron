#!/usr/bin/env python3
"""Cut the empty-state artwork out of the source renders.

The art arrives as two contact sheets of 3D icons on a dark ground. This lifts
each icon off that ground, squares it up so every empty state can draw one box
whatever shape the icon is, and writes the three densities Flutter asks for.

    pip install Pillow numpy
    python3 tools/build_empty_art.py <neon.jpg> <candy.jpg>

Rerun it when the artwork changes; the output is committed, so a normal build
never needs it.
"""
import sys
from collections import deque

import numpy as np
from PIL import Image, ImageFilter

OUT = "lib/assets/empty"

# What an empty state draws the art at, in logical pixels. The 3x asset is
# about twice the source icon, which soft 3D renders take and line art would
# not; going bigger would be inventing detail the artwork does not have.
SIZE = 108
# Scale each icon so its geometric mean is this much of the box. Icons differ
# wildly in shape -- crossed swords are tall, a spilled salt tin is wide -- and
# fitting by height alone would make one tower over the other.
MASS = 0.80
# The same again by ink rather than outline, blended with it. Party poppers
# throw confetti to the corners: measured by outline alone the cones shrink to
# nothing, and measured by ink alone thin crossed swords tower over everything.
INK = 0.68
# ...but never let a long icon run to the very edge.
BOUND = 0.96

# Which blob is which, in reading order. Left out on purpose: a gravestone, a
# spiked ball, cat-ear headphones, a burger, a TNT barrel and a fidget spinner,
# none of which says anything about a screen with nothing on it.
NEON = [
    "slushie", "spinner", "popcorn", "bubble", "gravestone",
    "spikeball", "swords", "mushroom", "trophy", "live",
    "ufo", "headphones", "burger", "salt", "palette",
    "shades", "creature", "monitor", "tnt", "fkey",
]
KEEP = {
    "slushie", "popcorn", "bubble", "spikeball", "swords", "mushroom",
    "trophy", "live", "ufo", "salt", "palette", "shades", "creature",
    "monitor", "fkey",
}
CANDY = ["donut", "lollipop", "poppers"]


def flood(lum, travel):
    """Which pixels the background can reach, walking only through the dark."""
    h, w = lum.shape
    seen = np.zeros((h, w), bool)
    q = deque()
    edge = [(y, x) for x in range(w) for y in (0, h - 1)]
    edge += [(y, x) for y in range(h) for x in (0, w - 1)]
    for y, x in edge:
        if lum[y, x] < travel and not seen[y, x]:
            seen[y, x] = True
            q.append((y, x))
    while q:
        y, x = q.popleft()
        for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            ny, nx = y + dy, x + dx
            if 0 <= ny < h and 0 <= nx < w and not seen[ny, nx] \
                    and lum[ny, nx] < travel:
                seen[ny, nx] = True
                q.append((ny, nx))
    return seen


def cut(rgb, ground=None, travel=110, floor=6):
    """Lift the icons off their ground.

    They were rendered as light on a dark field, so outside the body a pixel's
    own brightness is its opacity: a glow stays a glow instead of turning into
    a solid disc. Inside the body everything is kept, because a black outline
    there is part of the drawing and keying it out would punch holes in it.
    """
    lit = np.clip(rgb - ground, 0, 255) if ground is not None else rgb
    lum = lit.max(axis=2)
    outside = flood(lum, travel)
    additive = np.clip((lum - floor) * 255 / (255 - floor), 0, 255)
    # The body is kept solid, but not right up to its own outline. The source
    # is a JPEG, and JPEG ringing along a hard edge overshoots: a stray dark
    # pixel there reads as bright enough to be body, and shipping it opaque
    # stitched a dotted black seam around every icon. Pulling the solid part
    # in by a couple of pixels hands that band back to the brightness rule,
    # which fades ringing out instead of drawing it.
    solid = shrink(~outside, 2)
    alpha = np.where(solid, 255, additive)

    out = np.dstack([rgb, alpha]).astype(np.uint8)
    # Undo the ground's contribution everywhere the brightness rule decided
    # the opacity -- which is the rim as well as the glow, not just the glow.
    # Leaving the rim premultiplied kept its colour mixed with the black it
    # was rendered on, and that grey is what drew the seam.
    a = np.maximum(alpha / 255.0, 0.02)
    soft = (~solid) & (alpha > 0)
    for c in range(3):
        ch = out[:, :, c].astype(np.float32)
        ch[soft] = np.clip(lit[:, :, c][soft] / a[soft], 0, 255)
        out[:, :, c] = ch.astype(np.uint8)
    return out


def shrink(mask, by):
    """The mask minus a border [by] pixels deep."""
    out = mask.copy()
    for _ in range(by):
        eaten = out.copy()
        eaten[1:] &= out[:-1]
        eaten[:-1] &= out[1:]
        eaten[:, 1:] &= out[:, :-1]
        eaten[:, :-1] &= out[:, 1:]
        out = eaten
    return out


def boxes(alpha, grow=7, floor=28, smallest=900):
    """One bounding box per icon, ignoring speckle."""
    solid = alpha > floor
    near = solid.copy()
    for _ in range(grow):                # join a spilled tin to its own salt
        near[1:] |= near[:-1].copy()
        near[:-1] |= near[1:].copy()
        near[:, 1:] |= near[:, :-1].copy()
        near[:, :-1] |= near[:, 1:].copy()

    h, w = near.shape
    seen = np.zeros((h, w), bool)
    found = []
    for sy in range(h):
        for sx in range(w):
            if not near[sy, sx] or seen[sy, sx]:
                continue
            seen[sy, sx] = True
            q, ys, xs = deque([(sy, sx)]), [], []
            while q:
                y, x = q.popleft()
                if solid[y, x]:
                    ys.append(y)
                    xs.append(x)
                for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                    ny, nx = y + dy, x + dx
                    if 0 <= ny < h and 0 <= nx < w and near[ny, nx] \
                            and not seen[ny, nx]:
                        seen[ny, nx] = True
                        q.append((ny, nx))
            if len(ys) >= smallest:
                found.append((min(xs), min(ys), max(xs) + 1, max(ys) + 1))
    return found


def square(icon, side):
    """The icon centred in a transparent box of one fixed size."""
    w, h = icon.size
    ink = (np.asarray(icon)[:, :, 3].sum() / 255.0) ** 0.5
    scale = (MASS * side / (w * h) ** 0.5 * INK * side / max(ink, 1)) ** 0.5
    scale = min(scale, BOUND * side / max(w, h))
    size = (max(1, round(w * scale)), max(1, round(h * scale)))
    art = icon.resize(size, Image.LANCZOS)
    if scale > 1.2:
        # Lanczos leaves an upscale soft. A light unsharp puts the edge back
        # without the halo a heavier one would ring around the glow -- on the
        # colour only. Sharpening the transparency as well hardens the
        # anti-aliased rim into a bitten, dotted outline.
        bands = art.split()
        sharp = Image.merge('RGB', bands[:3]).filter(
            ImageFilter.UnsharpMask(radius=1.6, percent=55))
        art = Image.merge('RGBA', (*sharp.split(), bands[3]))
    box = Image.new("RGBA", (side, side), (0, 0, 0, 0))
    box.alpha_composite(art, ((side - art.width) // 2, (side - art.height) // 2))
    return box


def rows(found, bands):
    return sorted(found, key=lambda b: (
        next(i for i, (a, z) in enumerate(bands) if a <= b[1] < z), b[0]))


def main(neon_path, candy_path):
    import os
    named = []

    sheet = Image.open(neon_path).convert("RGB")
    art = cut(np.asarray(sheet).astype(np.float32))
    found = rows(boxes(art[:, :, 3]),
                 [(65, 205), (225, 370), (385, 530), (560, 690), (715, 860)])
    if len(found) != len(NEON):
        raise SystemExit(f"expected {len(NEON)} icons, found {len(found)}")
    page = Image.fromarray(art, "RGBA")
    named += [(n, page.crop(b)) for n, b in zip(NEON, found) if n in KEEP]

    # The second sheet is lit from below rather than flat black, and carries
    # the artist's watermark in the corner. Crop that off, then model the
    # ground by erasing anything icon-sized and keep what is left over.
    sheet = Image.open(candy_path).convert("RGB").crop((0, 0, 736, 700))
    small = (sheet.resize((92, 88), Image.BOX)
             .filter(ImageFilter.MinFilter(9))
             .filter(ImageFilter.GaussianBlur(6)))
    ground = np.asarray(small.resize(sheet.size, Image.BICUBIC))
    art = cut(np.asarray(sheet).astype(np.float32),
              # A modelled ground leaves a wash the flat one does not, so the
              # cut has to start higher up or every icon ships in a faint box.
              ground.astype(np.float32), travel=70, floor=45)
    found = rows(boxes(art[:, :, 3], grow=9, smallest=3000),
                 [(0, 380), (380, 700)])[:len(CANDY)]
    page = Image.fromarray(art, "RGBA")
    named += list(zip(CANDY, (page.crop(b) for b in found)))

    for folder, side in (("", SIZE), ("2.0x", SIZE * 2), ("3.0x", SIZE * 3)):
        os.makedirs(os.path.join(OUT, folder), exist_ok=True)
        for name, icon in named:
            square(icon, side).save(
                os.path.join(OUT, folder, f"{name}.png"), optimize=True)
    print(f"{len(named)} icons at {SIZE}px, 2x and 3x -> {OUT}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit(__doc__)
    main(sys.argv[1], sys.argv[2])
