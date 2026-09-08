# Kyron lenses

The lens catalogue: the definitions themselves, and the tool for making them.

Kept apart from the app because these have three consumers rather than one —
the camera that renders them, the tool that authors them, and whatever serves
them — and because a lens should ship without an app release.

| | |
|:--|:--|
| `lenses.json` | The published catalogue. Source of truth. |
| `tools/lens.py` | Check a catalogue, and see what it looks like. |
| `tools/flutter-probe.json` | Real output captured from Flutter, so the tool can prove it renders identically. |

The format, the rules, and how to publish are in
[`docs/LENS_FORMAT.md`](../docs/LENS_FORMAT.md).

```
python3 tools/lens.py check   lenses.json
python3 tools/lens.py preview lenses.json photo.jpg -o sheet.png
python3 tools/lens.py verify  tools/flutter-probe.json
```

This directory is self-contained on purpose: it needs nothing from `app/` or
`api/`, so it can move to its own repository whenever lenses are worth one.
