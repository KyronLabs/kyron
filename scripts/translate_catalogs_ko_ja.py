from __future__ import annotations
import concurrent.futures
import json
import os
import re
from pathlib import Path
from openai import OpenAI

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / 'app' / 'lib' / 'l10n'
SOURCE = json.loads((L10N / 'app_en.arb').read_text())
KEYS = [k for k in SOURCE if not k.startswith('@')]
PLACEHOLDER = re.compile(r'\$\{[^}]+\}|\{(?:minutes|hours|days)\}|\$[A-Za-z_][A-Za-z0-9_]*')

client = OpenAI()


def translate_batch(locale_name: str, items: list[tuple[str, str]]) -> dict[str, str]:
    payload = json.dumps(dict(items), ensure_ascii=False)
    prompt = f'''Translate the following Kyron mobile app UI catalog values into {locale_name}.
Return ONLY a valid JSON object with exactly the same keys and one translated string value per key.
Translate natural user-facing text, including short labels and longer help text. Keep product names,
URLs, email addresses, protocol/code fragments, hashtags, and symbols unchanged when appropriate.
Every placeholder token must be copied exactly, including $author, $policy, ${{what}}, ${{tab}},
$ {{normalised}} (without the space), and {{minutes}}/{{hours}}/{{days}}. Do not add commentary.

CATALOG:
{payload}'''.replace('$ {{normalised}}', '${normalised}')
    response = client.chat.completions.create(
        model='gpt-5-mini',
        messages=[
            {'role': 'system', 'content': 'You are a professional software localization translator. Output JSON only.'},
            {'role': 'user', 'content': prompt},
        ],
        max_completion_tokens=10000,
    )
    text = response.choices[0].message.content or ''
    text = text.strip()
    if text.startswith('```'):
        text = re.sub(r'^```(?:json)?\s*|\s*```$', '', text, flags=re.S).strip()
    data = json.loads(text)
    if set(data) != {k for k, _ in items}:
        raise ValueError(f'{locale_name}: key mismatch')
    for key, source in items:
        if not isinstance(data[key], str):
            raise ValueError(f'{locale_name}/{key}: not a string')
        if sorted(PLACEHOLDER.findall(source)) != sorted(PLACEHOLDER.findall(data[key])):
            raise ValueError(f'{locale_name}/{key}: placeholder mismatch: {source!r} -> {data[key]!r}')
    return data


def build(locale: str, name: str) -> None:
    batch_size = 55
    batches = [list((key, SOURCE[key]) for key in KEYS[i:i + batch_size]) for i in range(0, len(KEYS), batch_size)]
    result: dict[str, str] = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        futures = [pool.submit(translate_batch, name, batch) for batch in batches]
        for index, future in enumerate(futures):
            error = None
            for attempt in range(3):
                try:
                    result.update(
                        future.result()
                        if attempt == 0
                        else translate_batch(name, batches[index])
                    )
                    error = None
                    break
                except Exception as exc:
                    error = exc
            if error is not None:
                raise error
    output = {'@@locale': locale, '@@last_modified': '2026-09-19T21:30:00Z'}
    output.update(result)
    (L10N / f'app_{locale}.arb').write_text(json.dumps(output, ensure_ascii=False, indent=2) + '\n')
    print(f'{locale}: translated {len(result)} strings')


if __name__ == '__main__':
    build('ja', 'Japanese')
