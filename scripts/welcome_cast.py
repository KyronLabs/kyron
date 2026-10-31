#!/usr/bin/env python3
"""Render the welcome screen's cast on the rooster's own grid.

    python3 scripts/welcome_cast.py SOURCE_DIR app/lib/assets/cast

The welcome picture is a rooster in rounded pixels (docs/ROUNDED_PIXEL_ART.md)
that hands over, tile by tile, to the others in the cast. A tile can only flip
from one subject to the next if both have a square in the same place, so every
subject here is drawn on exactly the rooster's grid -- 20 x 25 squares of 56.2
x 55.7 pixels starting at (-10.04, 14.9), in a 1121 x 1403 canvas -- rather
than on a grid of its own the way scripts/rounded_pixels.py would draw it.

SOURCE_DIR holds one photograph per subject, NAME.png, on a plain white
backdrop. CAST below says where on the grid each one sits. For each it writes
NAME.webp (lossless, the rooster's size) and prints the Dart for WelcomeCast:
which squares hold the subject and where its flip starts.

Needs Pillow and numpy, and scripts/rounded_pixels.py beside this file.
"""

import math
import os
import sys

import numpy as np
from PIL import Image, ImageEnhance

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rounded_pixels import (  # noqa: E402
    GROUND,
    crop_to_subject,
    cut_out,
    focal_square,
    render,
)

# The rooster's grid, measured from app/lib/assets/rooster.webp. Changing any
# of these breaks the flip: a tile would turn over into a different square.
CANVAS = (1121, 1403)
PITCH = (56.2, 55.7)
ORIGIN = (-10.04, 14.9)
COLUMNS, ROWS = 20, 25

# Where each subject goes, in squares: its width, the column its centre is on
# (or its right edge, for the animals, which are cropped by the frame like the
# rooster), and the row its top is on. Every one stays inside the first 18
# rows, which is as much of the picture as a phone always shows.
#
# Not here: a pile of apples with one cut open. The cut flesh is as pale as
# the ground, so in squares it came out as a red smudge with a hole in it --
# the single apple says the same thing and reads at a glance.
#
# focus: where its flip starts. 'dark' is the darkest square in the upper
# half, which finds an eye; 'centre' is the middle of the subject, for things
# without one.
CAST = [
    dict(name='cat', width=15.5, right=20.3, top=0.6, cropped='bottom',
         focus='dark', vivid=1.35),
    dict(name='watermelon', width=11.5, centre=12.2, top=3.0, focus='centre',
         vivid=1.1),
    dict(name='butterfly', width=19.5, centre=10.6, top=2.6, focus='centre',
         vivid=1.1),
    dict(name='strawberry', width=11.0, centre=12.0, top=2.4, focus='centre',
         vivid=1.05),
    dict(name='fawn', width=15.0, right=20.0, top=0.4, cropped='bottom',
         focus='dark', vivid=1.1),
    dict(name='mushroom', width=10.5, centre=12.0, top=2.6, focus='centre',
         vivid=1.15),
    dict(name='coconut', width=14.0, centre=11.5, top=4.2, focus='centre',
         vivid=1.1),
    dict(name='apple', width=11.0, centre=12.0, top=2.2, focus='centre',
         vivid=1.05),
    dict(name='broccoli', width=12.0, centre=12.0, top=2.6, focus='centre',
         vivid=1.15),
]

# Fine enough that a square's average is a fair one: each square is worked
# out from SUB x SUB pixels of the placed subject.
SUB = 32
COVER = 0.18
ROUNDNESS = 0.36
SOFTNESS = 0.035


def place(entry, source_dir):
    """The subject's colour and coverage, square by square, on the grid."""
    image = Image.open(os.path.join(source_dir, entry['name'] + '.png'))
    cropped = tuple(e for e in entry.get('cropped', '').split(',') if e)
    alpha = cut_out(image, 42, cropped)
    base = ImageEnhance.Color(image.convert('RGB')).enhance(entry['vivid'])
    rgb, alpha = crop_to_subject(np.asarray(base).astype(np.float32), alpha,
                                 0.0)

    h, w = alpha.shape
    width = entry['width'] * SUB
    height = width * h / w
    if 'right' in entry:
        left = entry['right'] * SUB - width
    else:
        left = entry['centre'] * SUB - width / 2
    top = entry['top'] * SUB

    size = (int(round(width)), int(round(height)))
    subject = Image.fromarray(rgb.clip(0, 255).astype(np.uint8)).resize(
        size, Image.LANCZOS)
    mask = Image.fromarray((alpha * 255).astype(np.uint8)).resize(
        size, Image.LANCZOS)

    # A subject cropped at the bottom of its photograph is cropped by the
    # bottom of the frame, like the rooster: never a bust that stops in mid
    # air on a screen tall enough to show it. Its last rows of pixels carry
    # on down to the foot of the grid.
    short = ROWS * SUB - (int(round(top)) + size[1])
    if 'bottom' in cropped and short > 0:
        rgb_px = np.pad(np.asarray(subject), ((0, short), (0, 0), (0, 0)),
                        mode='edge')
        mask_px = np.pad(np.asarray(mask), ((0, short), (0, 0)), mode='edge')
        subject = Image.fromarray(rgb_px)
        mask = Image.fromarray(mask_px)

    board = Image.new('RGB', (COLUMNS * SUB, ROWS * SUB), GROUND)
    cover = Image.new('L', board.size, 0)
    at = (int(round(left)), int(round(top)))
    board.paste(subject, at, mask)
    cover.paste(mask, at)

    colour = np.asarray(board.resize((COLUMNS, ROWS), Image.BOX)).astype(
        np.float32)
    covered = np.asarray(cover.resize((COLUMNS, ROWS), Image.BOX)).astype(
        np.float32) / 255
    return colour, covered >= COVER


def on_rooster_canvas(picture):
    """The rendered squares moved onto the rooster's canvas, cell for cell."""
    sx = PITCH[0] / (picture.width / COLUMNS)
    sy = PITCH[1] / (picture.height / ROWS)
    # Output pixel (x, y) shows input pixel ((x - ox) / sx, (y - oy) / sy).
    return picture.transform(
        CANVAS, Image.AFFINE,
        (1 / sx, 0, -ORIGIN[0] / sx, 0, 1 / sy, -ORIGIN[1] / sy),
        resample=Image.BICUBIC, fillcolor=GROUND)


def centre_square(filled):
    rows, columns = np.nonzero(filled)
    r, c = rows.mean(), columns.mean()
    best = min(zip(rows, columns), key=lambda rc: (rc[0] - r) ** 2 +
               (rc[1] - c) ** 2)
    return int(best[0]), int(best[1])


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    source_dir, out_dir = sys.argv[1:]
    os.makedirs(out_dir, exist_ok=True)

    for entry in CAST:
        colour, filled = place(entry, source_dir)
        if filled[18:].any() and 'cropped' not in entry:
            sys.exit(f"{entry['name']}: runs below row 18, where a phone "
                     'may cut it off')
        picture = render(colour, filled, PITCH[0], GROUND, ROUNDNESS, SOFTNESS)
        picture = on_rooster_canvas(picture)
        out = os.path.join(out_dir, entry['name'] + '.webp')
        picture.save(out, lossless=True, quality=100, method=6)

        if entry['focus'] == 'dark':
            # The eye, among the top rows of the subject rather than the
            # whole upper half of the grid.
            eye = focal_square(colour, filled)
        else:
            eye = centre_square(filled)
        rows = [''.join('#' if f else '.' for f in row) for row in filled]
        size = os.path.getsize(out) // 1024
        print(f"  // {entry['name']}: {int(filled.sum())} squares, {size} KB")
        print(f"  CastMember(")
        print(f"    name: '{entry['name']}',")
        print(f"    asset: 'lib/assets/cast/{entry['name']}.webp',")
        print(f"    eye: (row: {eye[0]}, column: {eye[1]}),")
        print('    squares: [')
        for row in rows:
            print(f"      '{row}',")
        print('    ],')
        print('  ),')


if __name__ == '__main__':
    main()
