#!/usr/bin/env python3
"""Takes the emoji Inter draws in black and white out of its character map.

Inter carries its own monochrome glyphs for a few characters that people send
as emoji -- the red heart above all. The text engine takes a character from
the app's font whenever that font has it, and only falls back to the phone's
colour emoji font when it does not; so a ❤️ came out as Inter's flat black
heart in posts, comments and every text box. Removing those characters from
the character map (the glyphs stay, unreferenced) hands them to the emoji
font. Characters that are text first -- digits, # and *, ©, ®, ™, ‼, the
arrows and play triangles -- stay Inter's, so they match the words around
them.

    python3 scripts/inter_emoji_free.py app/assets/fonts/Inter-*.ttf

Idempotent: a font already without them is left as it is.
"""
import sys

from fontTools.ttLib import TTFont

# Emoji-first characters Inter maps: red heart, heart suit, sun, warning,
# white square, circled M, eject.
EMOJI_FIRST = {0x2764, 0x2665, 0x2600, 0x26A0, 0x2B1C, 0x24C2, 0x23CF}


def strip(path: str) -> int:
    font = TTFont(path)
    removed = 0
    for table in font["cmap"].tables:
        for cp in EMOJI_FIRST:
            if cp in table.cmap:
                del table.cmap[cp]
                removed += 1
    if removed:
        font.save(path)
    return removed


if __name__ == "__main__":
    for arg in sys.argv[1:]:
        print(f"{arg}: {strip(arg)} mappings removed")
