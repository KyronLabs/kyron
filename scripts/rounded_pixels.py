#!/usr/bin/env python3
"""Turn a picture into rounded-pixel art like the rooster on the welcome screen.

    python3 scripts/rounded_pixels.py subject.png out.webp --columns 20

The method, and every choice in it, is written up in docs/ROUNDED_PIXEL_ART.md.
In short:

1. The subject, cut out. A PNG with transparency is best -- from any
   background remover. Without one, the background is guessed from the
   picture's border (a plain backdrop works; a busy one does not).
2. Laid on the ground colour, then averaged into a grid of squares: each
   square is the mean of what it covers, so squares on the edge of the
   subject come out as pale tints of it, which is the soft halo the rooster
   has.
3. Squares the subject barely touches are dropped to the ground.
4. Drawn as rounded tiles. Where four tiles meet, the little gap between
   their rounded corners is filled with the mean of the four -- so tiles of
   one colour fuse into a blob and tiles of different colours round off
   against each other, which is the look.
5. Drawn four times over and scaled down, then softened a touch, so the
   edges are smooth at any size the app draws it.

Alongside the picture it writes `<out>.json`: the grid (pitch and origin in
the picture's own pixels), which squares hold the subject, and a suggested
focal square (the darkest in the upper half -- the rooster's eye). Those are
the constants RoosterArt needs to animate the arrival.

Needs Pillow and numpy:  pip install pillow numpy
"""

import argparse
import json
import math
import sys

import numpy as np
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter

GROUND = (0xF6, 0xF7, 0xF4)


def hex_colour(value):
    value = value.lstrip('#')
    if len(value) != 6:
        raise argparse.ArgumentTypeError('a colour is six hex digits')
    return tuple(int(value[i:i + 2], 16) for i in (0, 2, 4))


def cut_out(image, tolerance, cropped=()):
    """The subject's mask: the picture's own alpha, or a guess from its border.

    The guess floods in from the edge of the picture through anything close
    to the backdrop's colour, so a light face inside a dark beard is not
    taken for backdrop just because it is pale. It only works on a plain
    backdrop; for anything else, cut the subject out first.
    """
    if image.mode in ('RGBA', 'LA') or 'transparency' in image.info:
        alpha = np.asarray(image.convert('RGBA'))[..., 3].astype(np.float32) / 255
        if alpha.min() < 0.99:
            return alpha

    full = image.convert('RGB')
    # Worked out small and scaled back up: a flood fill over twelve million
    # pixels is slow, and the edge is softened afterwards anyway.
    small = full.copy()
    small.thumbnail((640, 640))
    small = small.filter(ImageFilter.MedianFilter(5))
    marked = small.copy()
    w, h = marked.size
    marker = (255, 0, 255)
    step = max(1, min(w, h) // 40)
    # Not from an edge the subject runs off: a bust cropped at the shoulder
    # meets the bottom of the frame, and flooding in from there eats it.
    seeds = []
    if 'top' not in cropped:
        seeds += [(x, 0) for x in range(0, w, step)]
    if 'bottom' not in cropped:
        seeds += [(x, h - 1) for x in range(0, w, step)]
    if 'left' not in cropped:
        seeds += [(0, y) for y in range(0, h, step)]
    if 'right' not in cropped:
        seeds += [(w - 1, y) for y in range(0, h, step)]
    for seed in seeds:
        if marked.getpixel(seed) != marker:
            ImageDraw.floodfill(marked, seed, marker, thresh=tolerance)
    backdrop = np.all(np.asarray(marked) == marker, axis=2)
    mask = Image.fromarray(((~backdrop) * 255).astype(np.uint8))
    mask = mask.filter(ImageFilter.GaussianBlur(1.2)).resize(full.size,
                                                             Image.BILINEAR)
    return np.asarray(mask).astype(np.float32) / 255


def crop_to_subject(rgb, alpha, margin):
    ys, xs = np.nonzero(alpha > 0.5)
    if len(xs) == 0:
        sys.exit('No subject found. Try a cut-out PNG, or --tolerance.')
    pad = int(margin * max(np.ptp(xs), np.ptp(ys)))
    x0, x1 = max(0, xs.min() - pad), min(alpha.shape[1], xs.max() + pad + 1)
    y0, y1 = max(0, ys.min() - pad), min(alpha.shape[0], ys.max() + pad + 1)
    return rgb[y0:y1, x0:x1], alpha[y0:y1, x0:x1]


def to_cells(rgb, alpha, columns, ground):
    """Each square's colour and how much of it is subject."""
    h, w = alpha.shape
    pitch = w / columns
    rows = math.ceil(h / pitch)
    # Pad to whole rows with ground, so the last row is a full square.
    full_h = int(round(rows * pitch))
    if full_h > h:
        pad_rgb = np.empty((full_h - h, w, 3), np.float32)
        pad_rgb[:] = ground
        rgb = np.concatenate([rgb, pad_rgb])
        alpha = np.concatenate([alpha, np.zeros((full_h - h, w), np.float32)])

    composite = rgb * alpha[..., None] + np.asarray(ground, np.float32) * (
        1 - alpha[..., None])
    # Box averaging is exactly "the mean of what the square covers".
    colour = np.asarray(
        Image.fromarray(composite.clip(0, 255).astype(np.uint8)).resize(
            (columns, rows), Image.BOX)).astype(np.float32)
    cover = np.asarray(
        Image.fromarray((alpha * 255).astype(np.uint8)).resize(
            (columns, rows), Image.BOX)).astype(np.float32) / 255
    return colour, cover, pitch, rows


def render(colour, filled, pitch_px, ground, roundness, softness, scale=4):
    """Rounded tiles, corner gaps filled with the mean of the four around."""
    rows, columns = filled.shape
    p = pitch_px * scale
    w, h = int(round(columns * p)), int(round(rows * p))
    canvas = Image.new('RGB', (w, h), ground)
    draw = ImageDraw.Draw(canvas)

    def cell(r, c):
        if 0 <= r < rows and 0 <= c < columns and filled[r, c]:
            return colour[r, c]
        return np.asarray(ground, np.float32)

    # The gaps first: a square on every grid corner inside the subject, in
    # the mean of the squares around it. Only where three or four squares
    # meet: that is a corner inside the shape, and filling it is what fuses
    # neighbours. Where one or two meet it is a corner of the outline, and
    # leaving it to the ground is what rounds the outline off -- filling it
    # put a pale cross on every bump of the silhouette.
    gap = p * roundness
    for r in range(rows + 1):
        for c in range(columns + 1):
            around = [(r - 1, c - 1), (r - 1, c), (r, c - 1), (r, c)]
            inside = [(y, x) for y, x in around
                      if 0 <= y < rows and 0 <= x < columns and filled[y, x]]
            if len(inside) < 3:
                continue
            mean = np.mean([cell(y, x) for y, x in inside], axis=0)
            cx, cy = c * p, r * p
            draw.rectangle([cx - gap, cy - gap, cx + gap, cy + gap],
                           fill=tuple(int(v) for v in mean))

    # Then the tiles over them.
    radius = p * roundness
    for r in range(rows):
        for c in range(columns):
            if not filled[r, c]:
                continue
            x0, y0 = c * p, r * p
            draw.rounded_rectangle([x0, y0, x0 + p - 1, y0 + p - 1],
                                   radius=radius,
                                   fill=tuple(int(v) for v in colour[r, c]))

    out = canvas.resize((w // scale, h // scale), Image.LANCZOS)
    if softness > 0:
        out = out.filter(ImageFilter.GaussianBlur(softness * pitch_px))
    return out


def write_stages(args, rgb, alpha, colour, filled, picture):
    """Each step of the method, for whoever is learning it or tuning it."""
    import os
    os.makedirs(args.stages, exist_ok=True)
    w, h = picture.size
    ground = np.asarray(args.ground, np.float32)

    cut = rgb * alpha[..., None] + ground * (1 - alpha[..., None])
    Image.fromarray(cut.clip(0, 255).astype(np.uint8)).save(
        os.path.join(args.stages, '1-cut-out.png'))

    rows, columns = filled.shape
    flat = np.where(filled[..., None], colour, ground).astype(np.uint8)
    Image.fromarray(flat).resize((w, h), Image.NEAREST).save(
        os.path.join(args.stages, '2-squares.png'))

    render(colour, filled, args.pitch, args.ground, args.roundness, 0).save(
        os.path.join(args.stages, '3-rounded.png'))
    picture.save(os.path.join(args.stages, '4-softened.png'))


def focal_square(colour, filled):
    """The darkest square in the upper half: where the eye usually is."""
    rows = filled.shape[0]
    luma = colour @ np.array([0.2126, 0.7152, 0.0722], np.float32)
    best, where = 1e9, (0, 0)
    for r in range(max(1, rows // 2)):
        for c in range(filled.shape[1]):
            if filled[r, c] and luma[r, c] < best:
                best, where = luma[r, c], (r, c)
    return where


def main():
    parser = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    parser.add_argument('source')
    parser.add_argument('out', help='.webp (lossless) or .png')
    parser.add_argument('--columns', type=int, default=20,
                        help='squares across (the rooster has 20)')
    parser.add_argument('--pitch', type=float, default=56.2,
                        help="a square's size in the output, in pixels")
    parser.add_argument('--ground', type=hex_colour, default=GROUND,
                        help='the colour it is painted on (default F6F7F4)')
    parser.add_argument('--cover', type=float, default=0.18,
                        help='least share of a square the subject must cover')
    parser.add_argument('--roundness', type=float, default=0.36,
                        help="corner radius as a share of a square (0-0.5)")
    parser.add_argument('--softness', type=float, default=0.035,
                        help='blur as a share of a square')
    parser.add_argument('--margin', type=float, default=0.04,
                        help='room around the subject, as a share of its size')
    parser.add_argument('--vivid', type=float, default=1.0,
                        help='saturation before averaging; 1.2 or so for '
                        'photographs, which averaging greys out')
    parser.add_argument('--stages', metavar='DIR',
                        help='also write each step of the method as a PNG')
    parser.add_argument('--cropped', default='',
                        help='edges the subject runs off, comma-separated '
                        '(e.g. bottom,right): the backdrop is not looked for '
                        'there')
    parser.add_argument('--tolerance', type=float, default=42,
                        help='how different from the backdrop counts as '
                        'subject, when there is no cut-out')
    args = parser.parse_args()

    image = Image.open(args.source)
    cropped = tuple(e.strip() for e in args.cropped.split(',') if e.strip())
    alpha = cut_out(image, args.tolerance, cropped)
    base = image.convert('RGB')
    if args.vivid != 1.0:
        base = ImageEnhance.Color(base).enhance(args.vivid)
    rgb = np.asarray(base).astype(np.float32)
    rgb, alpha = crop_to_subject(rgb, alpha, args.margin)

    colour, cover, _, rows = to_cells(rgb, alpha, args.columns, args.ground)
    filled = cover >= args.cover
    picture = render(colour, filled, args.pitch, args.ground, args.roundness,
                     args.softness)

    if args.stages:
        write_stages(args, rgb, alpha, colour, filled, picture)

    if args.out.lower().endswith('.webp'):
        picture.save(args.out, lossless=True, quality=100, method=6)
    else:
        picture.save(args.out)

    eye = focal_square(colour, filled)
    grid = {
        'imageSize': list(picture.size),
        'pitch': [args.pitch, args.pitch],
        'gridOrigin': [0, 0],
        'ground': '#%02X%02X%02X' % tuple(args.ground),
        'squares': [''.join('#' if f else '.' for f in row) for row in filled],
        'eye': {'row': int(eye[0]), 'column': int(eye[1])},
    }
    with open(args.out.rsplit('.', 1)[0] + '.json', 'w') as handle:
        json.dump(grid, handle, indent=2)
    print(f'{args.out}: {picture.size[0]}x{picture.size[1]}, '
          f'{args.columns}x{rows} squares, {int(filled.sum())} filled, '
          f'eye at row {eye[0]} column {eye[1]}')


if __name__ == '__main__':
    main()
