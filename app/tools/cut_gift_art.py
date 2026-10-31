#!/usr/bin/env python3
"""Cut the gift artwork out of its white plate, for app/assets/gifts/.

The renders arrive as a glossy object on a flat white background. A gift
sits on the sheet's own surface -- light or dark -- so the plate has to go,
and three things decide whether that looks right:

- **Only the white that touches the border goes.** A colour key would punch
  out every specular highlight too: the white glint on a gem is the same
  white as the plate behind it. So the plate is what is reachable from the
  edge through near-white pixels, and a highlight inside the object is not.
- **The edge is soft.** Alpha follows how far each edge pixel is from white,
  so the outline is antialiased rather than cut with scissors.
- **No white halo.** An edge pixel half way between the object and the
  plate is half plate, and drawn on a dark sheet that half shows as a pale
  rim. Its colour is solved for what it would be without the white behind
  it ("decontaminated") before its alpha is applied.

Then it is cropped to the object, centred on a square with a little room,
and written at 256px: the sheet draws a gift at 48 logical pixels, and at
112 as it is sent, so this is enough for a 4x screen at tile size and small
enough to ship nine of.

Usage:
    python3 tools/cut_gift_art.py SOURCE.png OUT.png [--size 256]
"""

from __future__ import annotations

import argparse

import numpy as np
from PIL import Image

# How far from white (0-255, worst channel) still counts as plate when
# finding what touches the border, and where the soft edge starts and ends.
PLATE = 28
EDGE_FROM = 6
EDGE_TO = 48

# Room left around the object, as a share of the square.
MARGIN = 0.06


def plate_mask(distance: np.ndarray) -> np.ndarray:
    """Near-white pixels connected to the border."""
    near_white = distance < PLATE
    reached = np.zeros_like(near_white)
    reached[0, :] = near_white[0, :]
    reached[-1, :] = near_white[-1, :]
    reached[:, 0] = near_white[:, 0]
    reached[:, -1] = near_white[:, -1]
    while True:
        grown = reached.copy()
        grown[1:, :] |= reached[:-1, :]
        grown[:-1, :] |= reached[1:, :]
        grown[:, 1:] |= reached[:, :-1]
        grown[:, :-1] |= reached[:, 1:]
        grown &= near_white
        if (grown == reached).all():
            return reached
        reached = grown


def dilate(mask: np.ndarray, steps: int) -> np.ndarray:
    out = mask.copy()
    for _ in range(steps):
        grown = out.copy()
        grown[1:, :] |= out[:-1, :]
        grown[:-1, :] |= out[1:, :]
        grown[:, 1:] |= out[:, :-1]
        grown[:, :-1] |= out[:, 1:]
        out = grown
    return out


def cut(source: Image.Image, size: int) -> Image.Image:
    rgb = np.asarray(source.convert("RGB")).astype(np.float64)
    distance = (255.0 - rgb).max(axis=2)

    plate = plate_mask(distance)
    # The soft edge lives where the plate meets the object: a few pixels
    # either side of the plate's boundary. Everywhere else is fully one or
    # the other.
    edge_zone = dilate(plate, 3)

    alpha = np.ones(distance.shape)
    ramp = np.clip((distance - EDGE_FROM) / (EDGE_TO - EDGE_FROM), 0.0, 1.0)
    alpha[edge_zone] = ramp[edge_zone]
    alpha[plate & (distance < EDGE_FROM)] = 0.0

    # Solve each partly transparent pixel for its colour without the white
    # behind it: observed = a * colour + (1 - a) * 255.
    safe = np.maximum(alpha, 1e-3)[..., None]
    colour = (rgb - (1.0 - alpha[..., None]) * 255.0) / safe
    colour = np.clip(colour, 0, 255)
    colour[alpha == 0] = 0

    rgba = np.dstack([colour, alpha * 255.0]).round().astype(np.uint8)
    image = Image.fromarray(rgba, "RGBA")

    box = image.getchannel("A").point(lambda a: 255 if a > 8 else 0).getbbox()
    if box is None:
        raise SystemExit("Nothing left after cutting: is the plate the whole image?")
    image = image.crop(box)

    side = round(max(image.size) / (1 - 2 * MARGIN))
    square = Image.new("RGBA", (side, side), (0, 0, 0, 0))
    square.paste(image, ((side - image.width) // 2, (side - image.height) // 2))
    return square.resize((size, size), Image.LANCZOS)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("source")
    parser.add_argument("out")
    parser.add_argument("--size", type=int, default=256)
    args = parser.parse_args()
    cut(Image.open(args.source), args.size).save(args.out, optimize=True)


if __name__ == "__main__":
    main()
