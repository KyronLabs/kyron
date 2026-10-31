#!/usr/bin/env python3
"""Render the welcome screen's cast on the rooster's own grid.

    python3 scripts/welcome_cast.py SOURCE_DIR app/lib/assets/cast

The welcome picture is a rooster in rounded pixels (docs/ROUNDED_PIXEL_ART.md)
that hands over, tile by tile, to the others in the cast. A tile can only flip
from one subject to the next if both have a square in the same place, so every
subject here is drawn on exactly the rooster's grid -- 20 x 25 squares of 56.2
x 55.7 pixels starting at (-10.04, 14.9), in a 1121 x 1403 canvas -- rather
than on a grid of its own the way scripts/rounded_pixels.py would draw it.

How the rooster is drawn, measured rather than guessed: its own square
colours, laid out as a mosaic and run through a median filter about 0.6 of a
square wide, rebuild it almost exactly (scripts/welcome_cast.py --check prints
how closely). A median is what makes the style -- similar neighbours fuse
into one soft shape, a square's free corners round off, and where four meet
the colour most of them share wins the corner. Drawing each square as its own
rounded tile, the first way this script tried, gave a grid of separate
buttons instead.

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
from PIL import Image, ImageFilter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rounded_pixels import (  # noqa: E402
    GROUND,
    crop_to_subject,
    cut_out,
    focal_square,
)

# The rooster's grid, measured from app/lib/assets/rooster.webp. Changing any
# of these breaks the flip: a tile would turn over into a different square.
CANVAS = (1121, 1403)
PITCH = (56.2, 55.7)
ORIGIN = (-10.04, 14.9)
COLUMNS, ROWS = 20, 25

# Where each subject goes, in squares: its width, the column its centre is on,
# and the row its top is on. Every one stays inside the first 18 rows, which
# is as much of the picture as a phone always shows.
#
# portrait: an animal cropped by the frame like the rooster -- facing into
# the left, its right edge at `right`, `width` squares across, and running
# off the foot of the grid. Where its photograph is taller than that, the
# frame cuts it at the shoulders, as the rooster's does; where it is shorter,
# it is drawn larger until it reaches. Never stretched or padded: a bust that
# stops in mid-air, or a smear carried down to the bottom, is the first thing
# anybody sees on a tall screen.
#
# Not here: a pile of apples with one cut open. The cut flesh is as pale as
# the ground, so in squares it came out as a red smudge with a hole in it --
# the single apple says the same thing and reads at a glance.
#
# focus: where its flip starts. 'dark' is the darkest square in the upper
# half, which finds an eye; 'centre' is the middle of the subject, for things
# without one.
CAST = [
    dict(name='cat', portrait=True, width=17.0, right=20.0, top=1.0,
         focus='dark'),
    dict(name='watermelon', width=11.5, centre=12.2, top=3.0, focus='centre'),
    dict(name='butterfly', width=17.0, centre=10.3, top=3.0, focus='centre'),
    dict(name='strawberry', width=11.0, centre=12.0, top=2.4, focus='centre'),
    dict(name='fawn', portrait=True, width=13.5, right=18.6, top=0.8,
         focus='dark'),
    dict(name='mushroom', width=10.5, centre=12.0, top=2.6, focus='centre'),
    dict(name='coconut', width=14.0, centre=11.5, top=4.2, focus='centre'),
    dict(name='apple', width=11.0, centre=12.0, top=2.2, focus='centre'),
    dict(name='broccoli', width=12.0, centre=12.0, top=2.6, focus='centre'),
]

# Fine enough that a square's average is a fair one: each square is worked
# out from SUB x SUB pixels of the placed subject.
SUB = 32
COVER = 0.18

# The median, as a share of a square: fitted to the rooster (see --check).
MEDIAN = 0.6

# The rooster's colour, measured from its squares: three quarters saturated
# on average, its darkest twentieth at 15% brightness. Photographs lit for a
# catalogue come out greyer and flatter than that once averaged into
# squares, so each subject is brought towards these before it is drawn.
TARGET_SATURATION = 0.70
TARGET_DARK = 0.15

# How far towards those a subject is moved: all the way crushed a tabby's
# stripes and a leaf's shadow to black blots. Half is enough to lift a flat
# photograph without inventing darks it does not have.
GRADE = 0.5


def place(entry, source_dir):
    """The subject's colour and coverage, square by square, on the grid."""
    image = Image.open(os.path.join(source_dir, entry['name'] + '.png'))
    portrait = entry.get('portrait', False)
    alpha = cut_out(image, 42, ('bottom',) if portrait else ())
    rgb, alpha = crop_to_subject(
        np.asarray(image.convert('RGB')).astype(np.float32), alpha, 0.0)

    h, w = alpha.shape
    top = entry['top'] * SUB
    if portrait:
        # A little past the foot, so the bottom row is all subject.
        reach = ROWS * SUB - top + SUB * 0.5
        width = max(entry['width'] * SUB, reach * w / h)
        height = width * h / w
        left = entry['right'] * SUB - width
    else:
        width = entry['width'] * SUB
        height = width * h / w
        left = entry['centre'] * SUB - width / 2

    size = (int(round(width)), int(round(height)))
    subject = Image.fromarray(rgb.clip(0, 255).astype(np.uint8)).resize(
        size, Image.LANCZOS)
    mask = Image.fromarray((alpha * 255).astype(np.uint8)).resize(
        size, Image.LANCZOS)

    board = Image.new('RGB', (COLUMNS * SUB, ROWS * SUB), GROUND)
    cover = Image.new('L', board.size, 0)
    at = (int(round(left)), int(round(top)))
    board.paste(subject, at, mask)
    cover.paste(mask, at)

    colour = np.asarray(board.resize((COLUMNS, ROWS), Image.BOX)).astype(
        np.float32)
    covered = np.asarray(cover.resize((COLUMNS, ROWS), Image.BOX)).astype(
        np.float32) / 255
    filled = covered >= COVER
    return grade(colour, filled, covered), filled


def grade(colour, filled, covered):
    """Brought towards the rooster's saturation and depth.

    Only the subject's own share of each square is graded: an outline square
    is part ground, and grading the ground in it would tint the halo.
    """
    ground = np.asarray(GROUND, np.float32)
    share = np.clip(covered, 1e-3, 1)[..., None]
    own = (colour - ground * (1 - share)) / share
    hsv = np.asarray(Image.fromarray(own.clip(0, 255).astype(np.uint8))
                     .convert('HSV')).astype(np.float32) / 255
    inside = filled & (covered > 0.6)
    if inside.any():
        sat = hsv[..., 1][inside].mean()
        boost = min(1.4, max(1.0, TARGET_SATURATION / max(sat, 1e-3)))
        hsv[..., 1] = np.clip(hsv[..., 1] * (1 + (boost - 1) * GRADE), 0, 1)
        dark = np.percentile(hsv[..., 2][inside], 5)
        if dark > TARGET_DARK:
            # Darks towards the rooster's, lights left where they were.
            goal = dark + (TARGET_DARK - dark) * GRADE
            v = hsv[..., 2]
            hsv[..., 2] = np.clip((v - dark) / (1 - dark) * (1 - goal) + goal,
                                  0, 1)
    graded = np.asarray(Image.fromarray((hsv * 255).astype(np.uint8), 'HSV')
                        .convert('RGB')).astype(np.float32)
    return graded * share + ground * (1 - share)


def draw(colour, filled, scale=0.5):
    """The squares as a mosaic on the rooster's canvas, through the median.

    Worked at half size, where the median is quick, and scaled back up: the
    rooster has the same slight softness, and the fit is no worse for it.
    """
    w, h = int(CANVAS[0] * scale), int(CANVAS[1] * scale)
    ys = (np.arange(h) / scale - ORIGIN[1]) / PITCH[1]
    xs = (np.arange(w) / scale - ORIGIN[0]) / PITCH[0]
    rows = np.clip(np.floor(ys).astype(int), 0, ROWS - 1)
    columns = np.clip(np.floor(xs).astype(int), 0, COLUMNS - 1)
    picture = colour[rows[:, None], columns[None, :]].copy()
    picture[~filled[rows[:, None], columns[None, :]]] = GROUND
    size = int(round(MEDIAN * PITCH[0] * scale)) | 1
    small = Image.fromarray(picture.clip(0, 255).astype(np.uint8)).filter(
        ImageFilter.MedianFilter(size))
    return small.resize(CANVAS, Image.LANCZOS)


def check():
    """How closely the method rebuilds the rooster from its own squares."""
    rooster = Image.open(os.path.join(
        os.path.dirname(os.path.abspath(__file__)), '..', 'app', 'lib',
        'assets', 'rooster.webp')).convert('RGB')
    pixels = np.asarray(rooster).astype(np.float32)
    colour = np.zeros((ROWS, COLUMNS, 3), np.float32)
    for r in range(ROWS):
        for c in range(COLUMNS):
            x = ORIGIN[0] + (c + 0.5) * PITCH[0]
            y = ORIGIN[1] + (r + 0.5) * PITCH[1]
            x0, x1 = int(max(0, x - 8)), int(min(CANVAS[0], x + 8))
            y0, y1 = int(max(0, y - 8)), int(min(CANVAS[1], y + 8))
            if x1 > x0 and y1 > y0:
                colour[r, c] = np.median(
                    pixels[y0:y1, x0:x1].reshape(-1, 3), axis=0)
    filled = np.abs(colour - np.asarray(GROUND, np.float32)).max(axis=2) > 6
    rebuilt = np.asarray(draw(colour, filled)).astype(np.float32)
    error = np.abs(rebuilt - pixels).mean()
    print(f'the rooster, rebuilt from its own squares: mean error '
          f'{error:.2f} of 255 per channel')
    return error


def centre_square(filled):
    rows, columns = np.nonzero(filled)
    r, c = rows.mean(), columns.mean()
    best = min(zip(rows, columns), key=lambda rc: (rc[0] - r) ** 2 +
               (rc[1] - c) ** 2)
    return int(best[0]), int(best[1])


def main():
    if sys.argv[1:] == ['--check']:
        sys.exit(0 if check() < 4 else 1)
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    source_dir, out_dir = sys.argv[1:]
    os.makedirs(out_dir, exist_ok=True)

    for entry in CAST:
        colour, filled = place(entry, source_dir)
        if filled[18:].any() and not entry.get('portrait'):
            sys.exit(f"{entry['name']}: runs below row 18, where a phone "
                     'may cut it off')
        picture = draw(colour, filled)
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
