import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import 'long_press_sheet.dart';

class CreateFab extends StatelessWidget {
  const CreateFab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient aura
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  scheme.primary.withOpacity(0.3),
                  scheme.secondary.withOpacity(0.3),
                  (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // CIRCLE FAB
          FloatingActionButton(
            heroTag: 'create',
            onPressed: () => _showMenu(context),
            backgroundColor: isDark ? Colors.white : Colors.black,
            elevation: 2,
            shape: const CircleBorder(),
            child: Icon(Iconsax.add_copy, size: 24, color: isDark ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext ctx) async {
    final items = <String, IconData>{
      'AR Lens': Iconsax.camera,
      'Text Post': Iconsax.note_text,
      'Poll': Iconsax.chart,
      'Space (audio)': Iconsax.microphone,
    };
    final result = await showModalBottomSheet<String>(context: ctx, backgroundColor: Colors.transparent, builder: (_) => LongPressSheet(items: items));
    if (result == 'Text Post') Navigator.pushNamed(ctx, Routes.composer);
  }
}