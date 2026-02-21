import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../theme/app_theme.dart';

class EmojiPickerSheet {
  static Future<Emoji?> show(BuildContext context) async {
    Emoji? selectedEmoji;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _EmojiPickerWidget(
        onEmojiSelected: (emoji) {
          selectedEmoji = emoji;
          Navigator.pop(context);
        },
      ),
    );

    return selectedEmoji;
  }
}

class _EmojiPickerWidget extends StatefulWidget {
  final Function(Emoji emoji) onEmojiSelected;

  const _EmojiPickerWidget({required this.onEmojiSelected});

  @override
  State<_EmojiPickerWidget> createState() => __EmojiPickerWidgetState();
}

class __EmojiPickerWidgetState extends State<_EmojiPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surface : AppTheme.lightSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                height: 24,
                alignment: Alignment.center,
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: scheme.outline.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Emoji Picker
              Expanded(
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    HapticFeedback.lightImpact();
                    widget.onEmojiSelected(emoji);
                  },
                  //
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
