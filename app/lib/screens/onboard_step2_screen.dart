import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/gradient_scaffold.dart';
import '../services/profile_service.dart';

class OnboardStep2Screen extends StatefulWidget {
  final OnboardingModel model;
  const OnboardStep2Screen({super.key, required this.model});

  @override
  State<OnboardStep2Screen> createState() => _OnboardStep2ScreenState();
}

class _OnboardStep2ScreenState extends State<OnboardStep2Screen> {
  final _profileService = ProfileService();
  final List<String> _allInterests = [
    'Technology','Sports','Music','Art','Travel','Food',
    'Fashion','Science','Gaming','Photography','Fitness','Books'
  ];
  
  bool _isLoading = false;

  void _toggle(String interest) {
    setState(() {
      if (widget.model.interests.contains(interest)) {
        widget.model.interests.remove(interest);
      } else {
        widget.model.interests.add(interest);
      }
    });
  }

  Future<void> _handleNavigation(
    BuildContext context,
    String routeName,
    Object? arguments,
  ) async {
    setState(() => _isLoading = true);
    
    try {
      if (widget.model.interests.isNotEmpty) {
        await _profileService.saveInterests(widget.model.interests);
      }
      
      // Pass arguments to the route
      if (mounted) {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      }
    } catch (e) {
      debugPrint('NAVIGATION ERROR: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _next() async {
    await _handleNavigation(context, Routes.onboardStep3, widget.model);
  }

  Future<void> _skip() async {
    await _handleNavigation(context, Routes.home, null);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return GradientScaffold(
      appBar: AppBar(
        title: const Text('Pick your interests'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _skip,
            child: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('What do you love?', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 8),
            Text('Select a few topics to personalise your feed.', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _allInterests.map((interest) {
                    final selected = widget.model.interests.contains(interest);
                    return _buildTag(interest, selected, scheme, isDark);
                  }).toList(),
                ),
              ),
            ),

            AppButton(
              label: 'Next',
              onTap: _next,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, bool selected, ColorScheme scheme, bool isDark) {
    final bg = selected
        ? scheme.primary.withValues(alpha: .12)
        : (isDark ? AppTheme.surface : AppTheme.lightSurface);
    final fg = selected ? scheme.primary : scheme.onSurface;

    return GestureDetector(
      onTap: _isLoading ? null : () => _toggle(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? scheme.primary.withValues(alpha: .35)
                : (isDark ? Colors.transparent : scheme.onSurface.withValues(alpha: .12)),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}