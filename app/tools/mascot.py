"""Emits the Kyron mascot as an SVG.

Written rather than drawn because the fluff is a ring of forty-odd petals:
placing those by hand gives forty slightly different shapes, and the one thing
the silhouette has to do is read as a single soft mass.
"""
import math

YELLOW = '#F2B32C'
YELLOW_DEEP = '#C98A0E'
INK = '#2B2B31'
CREAM = '#F8EFDA'

W = H = 240

# The body the fluff is arranged around.
CX, CY = 120.0, 146.0
RX, RY = 66.0, 66.0


def pt(a, b):
    return f'{a:.1f} {b:.1f}'


def leaf(px, py, dx, dy, length, half):
    """A leaf rooted at (px, py), pointing along (dx, dy)."""
    nx, ny = -dy, dx
    bl = (px - nx * half, py - ny * half)
    br = (px + nx * half, py + ny * half)
    tip = (px + dx * length, py + dy * length)
    c1 = (px + dx * length * 0.5 - nx * half * 1.05,
          py + dy * length * 0.5 - ny * half * 1.05)
    c2 = (px + dx * length * 0.5 + nx * half * 1.05,
          py + dy * length * 0.5 + ny * half * 1.05)
    return f'M {pt(*bl)} Q {pt(*c1)} {pt(*tip)} Q {pt(*c2)} {pt(*br)} Z'


def ring():
    """The fluff, clockwise from due north.

    Dark down the flanks, yellow across the top and along the bottom edge. The
    silhouette has one job: a yellow face inside a darker ruff.
    """
    out = []
    n = 44
    for i in range(n):
        a = -math.pi / 2 + (2 * math.pi * i / n)
        px = CX + math.cos(a) * RX * 0.93
        py = CY + math.sin(a) * RY * 0.93
        # Outward normal of the ellipse, not of a circle.
        dx, dy = math.cos(a) / RX, math.sin(a) / RY
        m = math.hypot(dx, dy)
        dx, dy = dx / m, dy / m

        # How far round from the top this petal sits: 0 at the crown, 1 at the
        # foot.
        turn = abs(((i / n) + 0.5) % 1.0 - 0.5) * 2

        dark = 0.36 < turn < 0.84
        # The dark ruff sits behind the body, so only its tips show. Longer,
        # or it does not read at all.
        length = (19 + 7 * math.sin(i * 1.7)) * (1.3 if dark else 1.0)
        half = 8 + 1.4 * math.cos(i * 2.3)
        out.append((leaf(px, py, dx, dy, length, half),
                    INK if dark else YELLOW))
    return out


def chest():
    """Two rounded bumps, then two rows of leaves down the front."""
    out = [
        f'<ellipse cx="96" cy="183" rx="19" ry="15" fill="{YELLOW}"'
        f' stroke="{YELLOW_DEEP}" stroke-width="2.4"/>',
        f'<ellipse cx="144" cy="183" rx="19" ry="15" fill="{YELLOW}"'
        f' stroke="{YELLOW_DEEP}" stroke-width="2.4"/>',
    ]
    for cy, xs, size in [(184, [98, 120, 142], 14), (200, [109, 131], 13)]:
        for x in xs:
            out.append(
                f'<path d="{leaf(x, cy, 0, 1, size * 1.5, size * 0.72)}"'
                f' fill="{YELLOW}" stroke="{YELLOW_DEEP}" stroke-width="2.4"'
                ' stroke-linejoin="round"/>')
    return out


def antenna(x_base, tilt):
    """A stem out of the head, with a leaf growing off the end of it.

    Near enough vertical. Leant out any further and it stops reading as an
    antenna at the size an empty state shows this: it reads as a horn.
    """
    tip_x, tip_y = x_base + tilt * 8, 42.0
    dx, dy = tilt * 0.28, -0.96
    m = math.hypot(dx, dy)
    dx, dy = dx / m, dy / m
    return (
        f'<path d="M {pt(x_base, 104)} Q {pt(x_base + tilt * 3, 72)}'
        f' {pt(tip_x, tip_y)}" fill="none" stroke="{INK}" stroke-width="7"'
        ' stroke-linecap="round"/>'
        f'<path d="{leaf(tip_x, tip_y, dx, dy, 32, 12)}" fill="{YELLOW}"'
        f' stroke="{YELLOW_DEEP}" stroke-width="2" stroke-linejoin="round"/>'
        # The stem carries on into the base of the leaf, as in the drawing.
        f'<path d="{leaf(tip_x, tip_y, dx, dy, 14, 7)}" fill="{INK}"/>')


parts = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}"'
    f' width="{W}" height="{H}" fill="none">',
    antenna(104, -1),
    antenna(136, 1),
]

# Dark petals first, so the yellow ones sit in front of them rather than under.
ring_parts = ring()
parts += [f'<path d="{d}" fill="{INK}"/>' for d, c in ring_parts if c == INK]
parts.append(
    f'<ellipse cx="{CX}" cy="{CY}" rx="{RX}" ry="{RY}" fill="{YELLOW}"/>')
parts += [f'<path d="{d}" fill="{YELLOW}"/>' for d, c in ring_parts if c != INK]

# The face: a wide mask, dipped in the middle of the brow the way an owl's is.
parts.append(
    f'<path d="M 120 112 L 106 98 C 92 94 70 104 70 130 C 70 157 93 171 120 171'
    f' C 147 171 170 157 170 130 C 170 104 148 94 134 98 Z"'
    f' fill="{CREAM}" stroke="{YELLOW_DEEP}" stroke-width="2.4"'
    ' stroke-linejoin="round"/>')
parts.append(f'<ellipse cx="99" cy="133" rx="14" ry="18" fill="{INK}"/>')
parts.append(f'<ellipse cx="141" cy="133" rx="14" ry="18" fill="{INK}"/>')
parts += chest()
parts.append('</svg>')

print('\n'.join(parts))
