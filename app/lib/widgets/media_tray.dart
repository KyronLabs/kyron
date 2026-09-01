import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/post_media.dart';

/// The attachments on something being written, before it is sent.
///
/// Each tile shows its own upload state: a spinner while it is going up, a
/// retry when it failed, and an ALT badge once described. A tray that showed
/// only thumbnails would let someone press Post while an upload was still in
/// flight or had already failed.
class MediaTray extends ConsumerWidget {
  final List<PendingMedia> media;
  final void Function(String path) onRemove;
  final void Function(String path) onRetry;
  final void Function(PendingMedia item) onDescribe;

  /// Smaller inside a comment box than under the composer.
  final double height;

  const MediaTray({
    super.key,
    required this.media,
    required this.onRemove,
    required this.onRetry,
    required this.onDescribe,
    this.height = 108,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (media.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space4),
        itemCount: media.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: SpacingTokens.space8),
        itemBuilder: (context, index) => _Tile(
          item: media[index],
          onRemove: () => onRemove(media[index].path),
          onRetry: () => onRetry(media[index].path),
          onDescribe: () => onDescribe(media[index]),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final PendingMedia item;
  final VoidCallback onRemove;
  final VoidCallback onRetry;
  final VoidCallback onDescribe;

  const _Tile({
    required this.item,
    required this.onRemove,
    required this.onRetry,
    required this.onDescribe,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
            child: item.kind == MediaKind.video
                ? ColoredBox(
                    color: scheme.surfaceContainerHighest,
                    child: Icon(
                      Iconsax.video_copy,
                      color: scheme.onSurface.withValues(alpha: .5),
                    ),
                  )
                : Image.file(
                    File(item.path),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        ColoredBox(color: scheme.surfaceContainerHighest),
                  ),
          ),
          if (item.isUploading)
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
              ),
              child: const Center(
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (item.error != null)
            GestureDetector(
              onTap: onRetry,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.error.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.refresh_copy, color: Colors.white, size: 18),
                      SizedBox(height: 2),
                      Text(
                        'Retry',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 2,
            right: 2,
            child: _Chip(
              icon: Iconsax.close_circle_copy,
              tooltip: 'Remove',
              onTap: onRemove,
            ),
          ),
          if (item.isReady)
            Positioned(
              left: 2,
              bottom: 2,
              child: GestureDetector(
                onTap: onDescribe,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(RadiusTokens.radius4),
                  ),
                  child: Text(
                    item.alt == null || item.alt!.trim().isEmpty
                        ? '+ ALT'
                        : 'ALT',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _Chip({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 15, color: Colors.white),
        ),
      ),
    );
  }
}

/// Asks for an attachment's description.
Future<String?> askForAltText(BuildContext context, String? current) {
  final controller = TextEditingController(text: current ?? '');

  return showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Describe this attachment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Read out by a screen reader, and shown when the image cannot '
            'load.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: SpacingTokens.space12),
          TextField(
            controller: controller,
            maxLines: 3,
            maxLength: 400,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'What is in this picture?',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
