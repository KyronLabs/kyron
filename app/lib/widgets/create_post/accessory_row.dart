import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/composer_provider.dart';
import 'emoji_picker_sheet.dart';

class AccessoryRow extends ConsumerWidget {
  const AccessoryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    // --- real outline icons --------------------------------------------------
    final chips = [
      _Chip('Hashtag', Icons.tag_outlined, () => _insertTag(ref)),
      _Chip('Mention', Icons.alternate_email_outlined, () => _insertMention(ref)),
      _Chip('Emoji', Icons.emoji_emotions_outlined, () => _openEmoji(context, ref)),
      _Chip('Voice', Icons.keyboard_voice_outlined, () => _toggleVoice(ref)),
      _Chip('Assist', Icons.auto_awesome_outlined, () => _showAssist(context)),
    ];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: scheme.outline.withValues(alpha: .15), width: .5),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = chips[i];
          return _buildChip(context, c.label, c.icon, c.onTap);
        },
      ),
    );
  }

  /* ---------------- helpers ---------------- */
  Widget _buildChip(BuildContext c, String label, IconData icon, VoidCallback onTap) {
    final scheme = Theme.of(c).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 18, color: scheme.onSurface.withValues(alpha: .75)),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12, color: scheme.onSurface.withValues(alpha: .8))),
        ]),
      ),
    );
  }

  void _insertTag(WidgetRef ref) {
    HapticFeedback.lightImpact();
    // TODO: insert '#' + open hashtag sheet
  }

  void _insertMention(WidgetRef ref) {
    HapticFeedback.lightImpact();
    // TODO: insert '@' + open mention sheet
  }

  Future<void> _openEmoji(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();
    final emoji = await EmojiPickerSheet.show(context);
    if (emoji != null) {
      // TODO: append emoji to controller
    }
  }

  void _toggleVoice(WidgetRef ref) {
    HapticFeedback.lightImpact();
    // TODO: switch to voice-note mode
  }

  void _showAssist(BuildContext context) {
    HapticFeedback.lightImpact();
    // TODO: open AI-assist bottom sheet
  }
}

/* --------------- data class --------------- */
class _Chip {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  _Chip(this.label, this.icon, this.onTap);
}
