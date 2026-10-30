# Gift artwork

The pictures the gift sheet shows for each gift, and the coin beside every
price. One PNG per gift, named for its `type` in the API's catalogue
(`api/src/modules/gifts/gift-catalogue.ts`). A gift with no file here falls
back to its emoji, so a gift added on the server shows something on an app
that predates it.

## Where they came from

Every image here was **generated for Kyron**: none was drawn from, traced
from, or edited out of somebody else's work. They were made on 30 October
2026 with Figma's image generation (`generate_image`, model
`gpt-image-2.5-flare`), in the file "Kyron gifts — artwork" on Kyron's own
Figma team, and are used under Figma's terms for what its AI generates.

What that does not give Kyron: exclusive rights. In the US, and in other
places, an image a model made without enough human authorship may not be
protected by copyright at all. Kyron can use these freely; it may not be able
to stop somebody else using them. If that matters -- a gift that becomes part
of the brand, say -- have an illustrator redraw it, and record that here.

Screenshots of other apps' gift catalogues were shown as a mood board --
glossy, soft 3D, iridescent -- and deliberately not used as sources: those are
other people's illustrations. That distinction is the point of this file. An
asset whose origin nobody wrote down is one that nobody can later defend
(see the Rawpixel image found in kyron-artwork's `sources/`, which is the
reason this README exists).

Every prompt shared one style, so the set reads as one:

> A single cute glossy 3D app icon of **[subject]**, soft clay-like 3D
> rendering, **[colours]**, glossy highlights, soft studio lighting,
> **[view]**, centred, isolated on a plain flat pure white background, no
> shadow, no text, no border.

| File | Subject |
|:--|:--|
| `coin.png` | a round gold coin with an embossed four-point sparkle |
| `spark.png` | a four-point sparkle star with two small sparkles |
| `rose.png` | one rose in bloom on a short stem with a leaf |
| `fire.png` | a stylised bubbly flame |
| `star.png` | a puffy five-point star with an orbiting ring, no face |
| `gem.png` | a brilliant-cut gemstone |
| `cake.png` | a two-tier cake with a cherry and one candle |
| `crown.png` | a crown with pearl points and gems on its band |
| `rocket.png` | a toy rocket with a porthole and a puffy flame, its body coloured rather than white |

The rocket was made twice. The first had a white body, and cutting the white
plate away took part of the rocket with it. A white object on a white plate
cannot be separated reliably, so the second was asked for in colour.

## How they were cut

    python3 tools/cut_gift_art.py SOURCE.png assets/gifts/NAME.png

It removes the white plate (only the white connected to the border, so
highlights survive), softens the edge, removes the white halo an edge pixel
would otherwise carry onto a dark sheet, crops, centres and writes 256px. The
1024px sources are in the Figma file above.
