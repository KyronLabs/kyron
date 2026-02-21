import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A camera-icon button that reveals a 2-option tooltip menu.
/// [onGallery]  – required callback for “Gallery” pick
/// [onSecondary] – required callback for second option (AI / Randomise)
/// [secondaryLabel] – text for second option (default “AI”)
/// [secondaryIcon]  – icon for second option (default Icons.auto_awesome)
class CameraTooltipMenu extends StatefulWidget {
  final VoidCallback onGallery;
  final VoidCallback onSecondary;
  final String secondaryLabel;
  final IconData secondaryIcon;

  const CameraTooltipMenu({
    super.key,
    required this.onGallery,
    required this.onSecondary,
    this.secondaryLabel = 'AI',
    this.secondaryIcon = Icons.auto_awesome,
  });

  @override
  State<CameraTooltipMenu> createState() => _CameraTooltipMenuState();
}

class _CameraTooltipMenuState extends State<CameraTooltipMenu> {
  OverlayEntry? _overlay;

  void _show() {
    _hide(); // remove any existing instance
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final overlay = Overlay.of(context);
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlay = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _hide, // tap outside closes menu
        child: Stack(
          children: [
            // translucent scrim (optional)
            Container(color: Colors.black12),

            /* ---------- actual menu ---------- */
            Positioned(
              top: offset.dy + size.height + 6,
              left: offset.dx - 86, // centre under camera icon
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.surface
                    : AppTheme.lightSurface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _menuItem(Icons.photo_library, 'Gallery', widget.onGallery),
                      _menuItem(widget.secondaryIcon, widget.secondaryLabel,
                          widget.onSecondary),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlay!);
  }

  void _hide() {
    _overlay?.remove();
    _overlay = null;
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        _hide();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: scheme.onSurface.withValues(alpha: .75)),
            const SizedBox(width: 10),
            Text(label,
                style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: .9), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _show,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
      ),
    );
  }
}
