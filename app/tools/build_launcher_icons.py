#!/usr/bin/env python3
"""Renders the app's launcher icons from the one SVG the rest of the app uses.

    python3 tools/build_launcher_icons.py

Run from `app/`. Reads `lib/assets/logo.svg` -- the same file the in-app logo
comes from, so the icon on the home screen and the mark inside the app cannot
drift apart, which is exactly what had happened: the app was replaced with a
maple leaf while every launcher icon stayed a squirrel.

Writes both shapes Android needs:

  * The legacy mipmaps, which are a full picture: the dark rounded square with
    the mark on it, one per density.
  * The adaptive foreground, which is not. Android composes it over the
    background colour and then crops it to whatever shape the launcher likes,
    so the mark has to sit inside the middle 72dp of a 108dp canvas or a round
    launcher will clip it.

Everything else about the icon -- the background colour, the manifest entries,
the round variant -- already exists and is left alone.
"""
import io
import os

import cairosvg
from PIL import Image, ImageDraw

# The background the icon has always had. Declared once in Android resources
# and mirrored here; see res/values/ic_launcher_background.xml.
BACKGROUND = (0x35, 0x35, 0x35, 0xFF)

# Density buckets, and the size of a legacy launcher icon in each.
LEGACY = {'mdpi': 48, 'hdpi': 72, 'xhdpi': 96, 'xxhdpi': 144, 'xxxhdpi': 192}

# The same buckets for the adaptive foreground, which is 108dp rather than 48.
ADAPTIVE = {'mdpi': 108, 'hdpi': 162, 'xhdpi': 216, 'xxhdpi': 324,
            'xxxhdpi': 432}

# How much of the legacy icon the dark square occupies, and how much of the
# square the mark does. Measured off the icon this replaces, so the leaf lands
# at the weight the squirrel had rather than at a new one.
SQUARE_INSET = 0.094
MARK_SCALE = 0.62

# The adaptive safe zone: the middle 72 of 108, minus a little breathing room.
ADAPTIVE_MARK = 72 / 108 * 0.86

SOURCE = 'lib/assets/logo.svg'
RES = 'android/app/src/main/res'


def mark(size: int) -> Image.Image:
    """The logo alone, on transparency, at [size] square."""
    png = cairosvg.svg2png(url=SOURCE, output_width=size, output_height=size)
    return Image.open(io.BytesIO(png)).convert('RGBA')


def rounded(size: int, radius: float) -> Image.Image:
    """The dark square the mark sits on."""
    tile = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    ImageDraw.Draw(tile).rounded_rectangle(
        [(0, 0), (size - 1, size - 1)], radius=radius, fill=BACKGROUND,
    )
    return tile


def circle(size: int) -> Image.Image:
    tile = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    ImageDraw.Draw(tile).ellipse([(0, 0), (size - 1, size - 1)],
                                 fill=BACKGROUND)
    return tile


def compose(canvas: Image.Image, logo: Image.Image) -> Image.Image:
    x = (canvas.width - logo.width) // 2
    y = (canvas.height - logo.height) // 2
    canvas.paste(logo, (x, y), logo)
    return canvas


def main() -> None:
    if not os.path.exists(SOURCE):
        raise SystemExit(f'{SOURCE} is missing. Run this from app/.')

    for density, size in LEGACY.items():
        inset = round(size * SQUARE_INSET)
        side = size - inset * 2
        logo = mark(max(1, round(side * MARK_SCALE)))

        square = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        square.paste(compose(rounded(side, side * 0.22), logo), (inset, inset))

        round_ = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        round_.paste(compose(circle(side), logo), (inset, inset))

        out = f'{RES}/mipmap-{density}'
        square.save(f'{out}/ic_launcher.webp', 'WEBP', lossless=True)
        round_.save(f'{out}/ic_launcher_round.webp', 'WEBP', lossless=True)
        print(f'  mipmap-{density}: {size}px')

    for density, size in ADAPTIVE.items():
        canvas = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        compose(canvas, mark(max(1, round(size * ADAPTIVE_MARK))))
        out = f'{RES}/drawable-{density}'
        os.makedirs(out, exist_ok=True)
        canvas.save(f'{out}/ic_launcher_foreground.png')
        print(f'  drawable-{density}: {size}px foreground')


if __name__ == '__main__':
    main()
