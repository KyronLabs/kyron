#!/usr/bin/env python3
"""Cut a photograph out of its sheet without leaving a halo behind it.

    scripts/cutout.py <keyed.png> ... --out app/lib/assets/nature

Input is a PNG that has already been keyed -- subject opaque, sheet
transparent -- which is where most tools stop and where the trouble starts.
Three separate things put a white rim around a cut-out, and fixing one without
the others leaves the rim:

  1. **The rim pixels are contaminated.** A pixel that is 40% leaf and 60%
     sheet is stored as the blend, so at alpha 0.4 over anything dark it shows
     the sheet.
  2. **Resizing RGBA averages the four channels independently**, so a
     transparent white pixel next to an opaque leaf pushes its white into the
     leaf whatever the alpha says.
  3. **Lossy WebP codes RGB in blocks with no idea where the alpha boundary
     is**, so bright sheet next to a leaf bleeds across it, and by default the
     encoder also rewrites the RGB under transparent pixels to whatever
     compresses best.

So: unmix the sheet out of the rim, flood the subject's own colour outward
through the whole transparent region, resize, and encode with the alpha
lossless and `exact` set so the encoder leaves the flood alone.

The photographs these were cut from are not in the repository -- they were
supplied, and the keyed PNGs are the masters. What is here is the part that is
hard to get right twice.

Needs Pillow and numpy. Nothing else.
"""
import argparse
import os
import sys

import numpy as np
from PIL import Image

def paper_field(rgb, transparent, block=24):
    """A coarse, local estimate of the paper colour behind each pixel.

    The sheets are not one flat colour -- they vignette, and two of them are
    cream rather than white -- so unmixing against a single sampled corner
    leaves a rim wherever the paper drifted from it.
    """
    h, w, _ = rgb.shape
    gh, gw = (h + block - 1) // block, (w + block - 1) // block
    grid = np.full((gh, gw, 3), np.nan, np.float32)
    for j in range(gh):
        for i in range(gw):
            sl = (slice(j * block, (j + 1) * block), slice(i * block, (i + 1) * block))
            m = transparent[sl]
            if m.sum() >= 8:
                grid[j, i] = np.median(rgb[sl][m], axis=0)

    # Blocks that are entirely subject have no paper to sample, so take it
    # from whichever neighbours do, spreading until every cell is filled.
    for _ in range(max(gh, gw)):
        holes = np.isnan(grid[:, :, 0])
        if not holes.any():
            break
        filled = np.where(np.isnan(grid), 0.0, grid)
        known = (~np.isnan(grid[:, :, 0])).astype(np.float32)[:, :, None]
        acc = np.zeros_like(filled)
        cnt = np.zeros_like(known)
        for dy, dx in ((-1, 0), (1, 0), (0, -1), (0, 1)):
            acc += np.roll(np.roll(filled, dy, 0), dx, 1)
            cnt += np.roll(np.roll(known, dy, 0), dx, 1)
        avg = acc / np.maximum(cnt, 1e-6)
        grid[holes] = avg[holes]
    grid = np.where(np.isnan(grid), 255.0, grid)

    return np.asarray(
        Image.fromarray(np.clip(grid, 0, 255).astype(np.uint8)).resize((w, h), Image.BILINEAR),
        np.float32,
    )


def erode(mask, steps):
    """Pull a mask in by `steps` pixels, eight-connected."""
    out = mask.copy()
    for _ in range(steps):
        keep = out.copy()
        for dy, dx in ((-1, 0), (1, 0), (0, -1), (0, 1),
                       (-1, -1), (-1, 1), (1, -1), (1, 1)):
            keep &= np.roll(np.roll(out, dy, 0), dx, 1)
        out = keep
    return out


def dilate(mask, steps):
    """Push a mask out by `steps` pixels, eight-connected."""
    return ~erode(~mask, steps)


def defringe(rgb, alpha, depth=3):
    """Throw away the rim and repaint it from the colour just inside it.

    Two of these photographs were cut out by somebody else before they were
    cut out here, and they still carry that cut: a pale line traced exactly
    along the wing, invisible on the white sheet it was keyed against and
    perfectly obvious the moment anything dark goes behind it. No alpha
    correction reaches it, because the line is inside the matte -- the
    tracker is right that those pixels are butterfly.

    So take the colour from `depth` pixels further in, where the photograph
    is still itself, and flood it back out to the edge. A wing loses three
    pixels of its own gradient and stops being outlined in white.
    """
    return bleed(rgb, alpha, known=erode(alpha >= 0.9, depth))


def bleed(rgb, alpha, rounds=28, known=None):
    """Push the subject's colour out through the transparent region.

    Nothing draws these pixels -- alpha is zero -- but the resize kernel and
    the WebP encoder both read them, so what is stored there decides whether
    an edge gains a halo. Filled with the paper it was cut from, it does.
    """
    out = rgb.copy()
    if known is None:
        known = alpha > 0.35
    known = known.astype(np.float32)
    out *= known[:, :, None]
    for _ in range(rounds):
        if known.min() > 0.5:
            break
        acc = np.zeros_like(out)
        cnt = np.zeros_like(known)
        for dy, dx in ((-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)):
            acc += np.roll(np.roll(out, dy, 0), dx, 1)
            cnt += np.roll(np.roll(known, dy, 0), dx, 1)
        fill = acc / np.maximum(cnt, 1e-6)[:, :, None]
        take = (known < 0.5) & (cnt > 0)
        out[take] = fill[take]
        known[take] = 1.0
    return out


def refine(src, shrink=0.10, depth=0):
    im = Image.open(src).convert('RGBA')
    a = np.asarray(im).astype(np.float32)
    rgb, alpha = a[:, :, :3], a[:, :, 3] / 255.0

    # Trim the faint contaminated rim. Anything the key was under 10% sure
    # about was paper it could not quite let go of.
    alpha = np.clip((alpha - shrink) / (1.0 - shrink), 0.0, 1.0)

    paper = paper_field(rgb, alpha <= 0.0)

    # Unmix: observed = alpha*subject + (1-alpha)*paper, solved for subject.
    # Only where there is enough alpha to divide by without amplifying noise.
    edge = (alpha > 0.02) & (alpha < 0.98)
    safe = np.maximum(alpha, 0.25)[:, :, None]
    unmixed = (rgb - (1.0 - alpha)[:, :, None] * paper) / safe
    rgb = np.where(edge[:, :, None], np.clip(unmixed, 0, 255), rgb)

    if depth:
        rgb = defringe(rgb, alpha, depth)
    else:
        rgb = bleed(rgb, alpha)
    return rgb, alpha


def shrink_to(rgb, alpha, size):
    """Resize after the bleed, which is what makes this safe.

    Pillow resizes the four channels independently, so ordinarily a
    transparent white pixel next to an opaque leaf pushes its white into the
    leaf. After [bleed] there is no paper left anywhere in the image to push,
    so the straight resize and a premultiplied one agree -- and the result
    still has subject colour under the transparent pixels, which a
    premultiplied round trip would have flattened to black.
    """
    small_rgb = np.asarray(
        Image.fromarray(np.clip(rgb, 0, 255).astype(np.uint8)).resize(size, Image.LANCZOS),
        np.float32,
    )
    small_a = np.asarray(
        Image.fromarray(np.clip(alpha * 255.0, 0, 255).astype(np.uint8), 'L').resize(
            size, Image.LANCZOS
        ),
        np.float32,
    ) / 255.0
    return small_rgb, np.clip(small_a, 0.0, 1.0)


def save(path, rgb, alpha, quality=86):
    """Lossless alpha, and `exact` so the encoder leaves the bleed alone.

    Without `exact`, cwebp rewrites the RGB under transparent pixels to
    whatever compresses best, which undoes the bleed and puts the halo back
    at the first 16-pixel block boundary that straddles an edge.
    """
    out = np.concatenate(
        [np.clip(rgb, 0, 255), np.clip(alpha * 255.0, 0, 255)[:, :, None]], axis=2
    ).astype(np.uint8)
    Image.fromarray(out, 'RGBA').save(
        path, 'WEBP', quality=quality, alpha_quality=100, method=6, exact=True
    )


def crop_to_subject(rgb, alpha, keep=0.004):
    """Throw away the empty sheet around the plant.

    The photographs were not framed on their subjects -- the wildflower bank
    sits inside a wide margin of nothing -- and a layout that positions the
    file rather than the plant leaves a visible gap at the screen edge where
    the bank was supposed to run off it. Cropping here means every distance in
    the layout is a distance to something you can see.
    """
    cols = np.where(alpha.max(axis=0) > keep)[0]
    rows = np.where(alpha.max(axis=1) > keep)[0]
    if not len(cols) or not len(rows):
        return rgb, alpha
    y0, y1 = rows[0], rows[-1] + 1
    x0, x1 = cols[0], cols[-1] + 1
    return rgb[y0:y1, x0:x1], alpha[y0:y1, x0:x1]


def unmix_backdrop(rgb, alpha, reach=3, quantile=10, backdrop=255.0):
    """Take the white sheet back out of everything thin enough to be half-sheet.

    A blade of grass in this photograph is three pixels wide, so nearly every
    pixel of it is part blade and part paper -- and a key that answers only
    "subject or not" calls the whole blade subject and keeps the paper mixed
    into it. Against white, where it was shot, that is invisible. Against the
    app's night theme every blade is drawn with a white line down both sides
    and the gaps between them fill with white speckle.

    So solve it as the mixture it is. `O = a*F + (1-a)*255` has two unknowns
    per pixel, and what closes it is the darkest channel: a blade at full
    strength bottoms out at a value measured from the thick part of the same
    plant, so how far a pixel falls short of that says how much of it is
    paper. That gives `a`, and `a` gives `F`.

    `reach` keeps this off the middle of anything solid. A daisy is white too,
    and judged on its colour alone it is indistinguishable from the sheet
    behind it -- but it is twenty pixels across, and paper contamination never
    is. Only pixels within `reach` of the matte's edge are touched.
    """
    inside = erode(alpha > 0.5, reach + 1)
    if inside.sum() < 200:
        return rgb, alpha
    floor = float(np.percentile(rgb.min(axis=2)[inside], quantile))
    thin = (alpha > 0.02) & ~erode(alpha > 0.5, reach)

    # Protect anything white that is genuinely wide. `reach` alone is not
    # enough: the meadow has small gaps of sheet showing *inside* the flower
    # heads, so parts of a petal are within three pixels of the matte's edge,
    # and judged on brightness a petal is sheet -- the first version punched
    # holes clean through the daisies. A blade three pixels across does not
    # survive being pulled in by two; a petal twenty across does, and is then
    # pushed back out to cover its own soft edge.
    span = rgb.max(axis=2) - rgb.min(axis=2)
    petal = dilate(erode((rgb.min(axis=2) > 170) & (span < 45), 2), 3)
    thin &= ~petal

    a_est = np.clip(
        (backdrop - rgb.min(axis=2)) / max(backdrop - floor, 1.0), 0.0, 1.0
    )
    new_a = np.where(thin, np.minimum(alpha, a_est), alpha)
    safe = np.maximum(new_a, 0.18)[:, :, None]
    unmixed = (rgb - (1.0 - new_a)[:, :, None] * backdrop) / safe
    return np.where(thin[:, :, None], np.clip(unmixed, 0, 255), rgb), new_a


def cut(src, out_dir, width, height, shrink=0.10, depth=0, reach=0,
        mirror=False, quality=86):
    """One photograph, from keyed PNG to shipped WebP."""
    rgb, alpha = refine(src, shrink=shrink, depth=depth)
    if reach:
        rgb, alpha = unmix_backdrop(rgb, alpha, reach=reach)
    rgb, alpha = crop_to_subject(rgb, alpha)
    h, w = alpha.shape
    fit = min(width / w, height / h)
    rgb, alpha = shrink_to(
        rgb, alpha, (max(1, round(w * fit)), max(1, round(h * fit)))
    )
    if mirror:
        rgb, alpha = rgb[:, ::-1], alpha[:, ::-1]
    name = os.path.splitext(os.path.basename(src))[0]
    path = os.path.join(out_dir, f'{name}.webp')
    save(path, rgb, alpha, quality=quality)
    return path, alpha.shape[1], alpha.shape[0], os.path.getsize(path)


def main(argv):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('sources', nargs='+', help='keyed PNGs')
    ap.add_argument('--out', required=True)
    ap.add_argument('--width', type=int, default=900,
                    help='largest width the asset is ever drawn at, doubled')
    ap.add_argument('--height', type=int, default=900)
    ap.add_argument('--shrink', type=float, default=0.10,
                    help='how much of the rim to distrust, 0 to 1')
    ap.add_argument('--depth', type=int, default=0,
                    help='repaint this many pixels of rim from just inside it')
    ap.add_argument('--reach', type=int, default=0,
                    help='unmix the sheet this far in; for fine structure')
    ap.add_argument('--mirror', action='store_true')
    ap.add_argument('--quality', type=int, default=86)
    args = ap.parse_args(argv)

    os.makedirs(args.out, exist_ok=True)
    for src in args.sources:
        path, w, h, size = cut(
            src, args.out, args.width, args.height,
            shrink=args.shrink, depth=args.depth, reach=args.reach,
            mirror=args.mirror, quality=args.quality,
        )
        print(f'{path}  {w}x{h}  {size // 1024} KB')
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
