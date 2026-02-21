import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class MediaSelector {
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _MediaSelectorSheet(),
    );
  }
}

class _MediaSelectorSheet extends StatelessWidget {
  const _MediaSelectorSheet();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const options = [
      _MediaOption(icon: Icons.camera_alt, label: 'Camera', value: 'camera'),
      _MediaOption(icon: Icons.photo_library, label: 'Gallery', value: 'gallery'),
      _MediaOption(icon: Icons.view_in_ar, label: 'AR Lens', value: 'ar_lens'),
      _MediaOption(icon: Icons.poll, label: 'Poll', value: 'poll'),
      _MediaOption(icon: Icons.mic, label: 'Audio', value: 'audio_space'),
      _MediaOption(icon: Icons.attach_file, label: 'File', value: 'file'),
      _MediaOption(icon: Icons.location_on, label: 'Location', value: 'location'),
      _MediaOption(icon: Icons.contact_phone, label: 'Contact', value: 'contact'),
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.75,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surface : AppTheme.lightSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              
              // Title row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Add Media',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: scheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Grid
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return _MediaGridItem(
                      option: option,
                      onTap: (value) {
                        HapticFeedback.selectionClick();
                        Navigator.pop(context, value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MediaOption {
  final IconData icon;
  final String label;
  final String value;
  
  const _MediaOption({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _MediaGridItem extends StatelessWidget {
  final _MediaOption option;
  final ValueChanged<String> onTap;

  const _MediaGridItem({
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(option.value),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle with icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                option.icon,
                size: 28,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            // Label
            Text(
              option.label,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}