from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
L10N = ROOT / 'app' / 'lib' / 'l10n'

entries = {
    'create_text_post': {'en': 'Text post', 'es': 'Publicación de texto', 'zh': '文字帖'},
    'create_voice_post': {'en': 'Voice post', 'es': 'Publicación de voz', 'zh': '语音帖'},
    'create_ar_lens': {'en': 'AR Lens', 'es': 'Lente de RA', 'zh': 'AR 镜头'},
    'create_go_live': {'en': 'Go live', 'es': 'Transmitir en vivo', 'zh': '开始直播'},
    'voice_record_post': {'en': 'Record a voice post', 'es': 'Grabar una publicación de voz', 'zh': '录制语音帖'},
    'voice_recording': {'en': 'Recording…', 'es': 'Grabando…', 'zh': '录音中…'},
    'voice_ready_attach': {'en': 'Ready to attach', 'es': 'Listo para adjuntar', 'zh': '准备附加'},
    'voice_stop': {'en': 'Stop', 'es': 'Detener', 'zh': '停止'},
    'voice_attach': {'en': 'Attach', 'es': 'Adjuntar', 'zh': '附加'},
    'draft_close_composer_detail': {
        'en': 'Close the composer with something written and you will be offered a draft.',
        'es': 'Cierra el editor con algo escrito y se te ofrecerá un borrador.',
        'zh': '在编辑器中写下内容后关闭，就会为你提供草稿。',
    },
    'draft_poll_empty': {'en': 'A poll, with no question yet', 'es': 'Una encuesta sin pregunta todavía', 'zh': '尚未填写问题的投票'},
    'draft_quote_empty': {'en': 'A quote, with nothing written yet', 'es': 'Una cita sin texto todavía', 'zh': '尚未填写内容的引用'},
    'draft_nothing_empty': {'en': 'Nothing written yet', 'es': 'Todavía no hay nada escrito', 'zh': '还没有内容'},
    'draft_just_now': {'en': 'Just now', 'es': 'Ahora mismo', 'zh': '刚刚'},
    'draft_minutes_ago': {'en': '{minutes} minutes ago', 'es': 'Hace {minutes} minutos', 'zh': '{minutes} 分钟前'},
    'draft_hours_ago': {'en': '{hours} hours ago', 'es': 'Hace {hours} horas', 'zh': '{hours} 小时前'},
    'draft_days_ago': {'en': '{days} days ago', 'es': 'Hace {days} días', 'zh': '{days} 天前'},
}

# Add the source values to the three catalogs. The ui() helper uses these keys
# directly, so no new generated accessor is required.
for locale in ('en', 'es', 'zh'):
    path = L10N / f'app_{locale}.arb'
    data = json.loads(path.read_text())
    for key, translations in entries.items():
        data[key] = translations[locale]
    data['@@last_modified'] = '2026-09-19T21:00:00Z'
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

# Localize the create menu while retaining stable internal route keys.
path = ROOT / 'app' / 'lib' / 'widgets' / 'create_fab.dart'
text = path.read_text()
old = """    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => LongPressSheet(
        items: {
          for (final entry in _options.entries) entry.key: entry.value.icon,
        },
      ),
    );
    final route = _options[chosen]?.route;
"""
new = """    final l10n = AppLocalizations.of(context);
    final labels = <String, String>{
      'Text post': l10n.ui('create_text_post', 'Text post'),
      'Voice post': l10n.ui('create_voice_post', 'Voice post'),
      'AR Lens': l10n.ui('create_ar_lens', 'AR Lens'),
      'Go live': l10n.ui('create_go_live', 'Go live'),
    };
    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => LongPressSheet(
        items: {
          for (final entry in _options.entries)
            labels[entry.key]!: entry.value.icon,
        },
      ),
    );
    final route = _options.entries
        .where((entry) => labels[entry.key] == chosen)
        .map((entry) => entry.value.route)
        .firstOrNull;
"""
if old not in text:
    raise SystemExit('create_fab block not found')
path.write_text(text.replace(old, new))

path = ROOT / 'app' / 'lib' / 'widgets' / 'create_post' / 'voice_recorder_sheet.dart'
text = path.read_text()
old = """                    switch (_stage) {
                      _Stage.idle => 'Record a voice post',
                      _Stage.recording => 'Recording…',
                      _Stage.recorded => 'Ready to attach',
                    },
"""
new = """                    switch (_stage) {
                      _Stage.idle => AppLocalizations.of(context)
                          .ui('voice_record_post', 'Record a voice post'),
                      _Stage.recording => AppLocalizations.of(context)
                          .ui('voice_recording', 'Recording…'),
                      _Stage.recorded => AppLocalizations.of(context)
                          .ui('voice_ready_attach', 'Ready to attach'),
                    },
"""
if old not in text:
    raise SystemExit('voice title block not found')
text = text.replace(old, new)
text = text.replace("label: 'Stop',", "label: AppLocalizations.of(context).ui('voice_stop', 'Stop'),")
text = text.replace("label: 'Attach',", "label: AppLocalizations.of(context).ui('voice_attach', 'Attach'),")
path.write_text(text)

path = ROOT / 'app' / 'lib' / 'screens' / 'drafts_screen.dart'
text = path.read_text()
text = text.replace("detail: 'Close the composer with something written and you '\n                      'will be offered a draft.',", "detail: AppLocalizations.of(context).ui(\n                    'draft_close_composer_detail',\n                    'Close the composer with something written and you will be offered a draft.',\n                  ),")
text = text.replace("  static String _summary(ComposerDraft draft) {", "  String _summary(ComposerDraft draft) {")
text = text.replace("if (draft.poll != null) return 'A poll, with no question yet';", "if (draft.poll != null) return AppLocalizations.of(context).ui('draft_poll_empty', 'A poll, with no question yet');")
text = text.replace("if (draft.quoting != null) return 'A quote, with nothing written yet';", "if (draft.quoting != null) return AppLocalizations.of(context).ui('draft_quote_empty', 'A quote, with nothing written yet');")
text = text.replace("return 'Nothing written yet';", "return AppLocalizations.of(context).ui('draft_nothing_empty', 'Nothing written yet');")
text = text.replace("  static String _when(DateTime at) {", "  String _when(DateTime at) {")
text = text.replace("if (d.inMinutes < 1) return 'Just now';", "if (d.inMinutes < 1) return AppLocalizations.of(context).ui('draft_just_now', 'Just now');")
text = text.replace("if (d.inHours < 1) return '${d.inMinutes} minutes ago';", "if (d.inHours < 1) return AppLocalizations.of(context).ui('draft_minutes_ago', '{minutes} minutes ago').replaceFirst('{minutes}', '${d.inMinutes}');")
text = text.replace("if (d.inDays < 1) return '${d.inHours} hours ago';", "if (d.inDays < 1) return AppLocalizations.of(context).ui('draft_hours_ago', '{hours} hours ago').replaceFirst('{hours}', '${d.inHours}');")
text = text.replace("return '${d.inDays} days ago';", "return AppLocalizations.of(context).ui('draft_days_ago', '{days} days ago').replaceFirst('{days}', '${d.inDays}');")
path.write_text(text)
print('Updated composer, voice recorder, and drafts catalogs/source.')
