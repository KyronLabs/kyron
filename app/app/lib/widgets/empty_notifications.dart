import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pulsing gradient circle
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [scheme.primary, scheme.secondary],
                    ),
                  ),
                  child: Icon(
                    Iconsax.notification,
                    size: 60,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Your notifications will appear here.',
            style: TextStyle(
              fontSize: 15,
              color: scheme.onSurface.withOpacity(0.6),
              fontFamily: 'SF Pro Rounded',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/explore'),
            icon: const Icon(Iconsax.search_normal),
            label: const Text('Explore'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(160, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}