# The meadow

The pictures on the get-started screen, cut out of the sheets they were
photographed on by `scripts/cutout.py`. That script's header explains why the
cutting is three steps rather than one; this file records the invocations, so
the six files here can be rebuilt from the keyed masters and come out
byte-identical.

```bash
S=path/to/keyed        # the masters; supplied, and not in this repository
O=app/lib/assets/nature

python3 scripts/cutout.py $S/palm.png            --out $O --width 560 --height 680 --shrink 0.10 --reach 3 --mirror
python3 scripts/cutout.py $S/grass.png           --out $O --width 900 --height 580 --shrink 0.06
python3 scripts/cutout.py $S/lavender.png        --out $O --width 240 --height 371 --shrink 0.10 --depth 2
python3 scripts/cutout.py $S/tulip.png           --out $O --width 140 --height 282 --shrink 0.10 --depth 2
python3 scripts/cutout.py $S/butterfly-red.png   --out $O --width 260 --height 255 --shrink 0.14 --depth 3
python3 scripts/cutout.py $S/butterfly-green.png --out $O --width 420 --height 342 --shrink 0.14 --depth 3
```

Three of the settings are not obvious:

**`--mirror` on the palm.** The photograph was cropped through its own fronds,
so one edge of it is a straight cut rather than a plant. Mirrored, that edge is
the left one, and `GetStartedArt` runs it off the side of the screen where
nobody sees it.

**`--reach 3` on the palm and nowhere else.** It unmixes the sheet out of
anything thin enough to be half sheet, which every frond is. The meadow needs
it far more — every blade of grass is half sheet — and it is the one
photograph it cannot be trusted on: a white daisy is the same colour as the
sheet behind it, and the correction punched holes straight through them. The
meadow is handled the other way instead, in `_Ground`: the screen it lands on
is paper coloured in both themes, so what is still mixed into it does not show.

**`--depth` on the butterflies.** Two of these were cut out by somebody else
before they were cut out here, and still carried that cut as a pale line traced
along the wing — invisible on white, obvious over anything dark. `--depth`
throws the rim away and repaints it from the colour just inside it.

Do not edit these files by hand. If one is replaced, run
`flutter test test/get_started_test.dart` — it checks that every specimen the
picture draws is a file that is really here and really declared in
`pubspec.yaml`, which is the one failure mode that is otherwise silent.
